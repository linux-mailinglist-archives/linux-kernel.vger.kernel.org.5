Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E97F532E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbjKVWSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKVWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0990D4F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89133C433C7;
        Wed, 22 Nov 2023 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691492;
        bh=pXFt8KxeskxjDuI8ULnmxTHFdpsi5bDQYyGvBUP0idU=;
        h=From:To:Cc:Subject:Date:From;
        b=glKHthNQb4E6cjtC2SuFlrOYnN7It85p9TOtJ0JMC6aWadKlgzcoRO06Dmw/whaTC
         NbwX1bwg/a0Uim3ArNlImVetSYLA4oxmr7C5q+rmkWxGtdntO99QZfFdqiH2f78VeE
         dlNw3RHFZB2gNP/Ap1/dz5HFByoKjRdqhhXO9y5/vtI2DZtqFnvdbbhFxu+CAoGjpB
         1StCDTO9rSvyrhd2NgieezOF5gCXCQwnd2CtDUxzx+NGI6TQsOWPcC+UzUWYJ8HqYW
         am9ZpkKIN4LimfObGivje5pIysb5yeR7pgqfqcQppqIC1fxo4hYGwEbK5Aq3LfE2TU
         5u5dqCrUP4JkQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Pauli Virtanen <pav@iki.fi>, Jakub Kicinski <kuba@kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Claudia Draghicescu <claudia.rosu@nxp.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: shut up a false-positive warning
Date:   Wed, 22 Nov 2023 23:17:44 +0100
Message-Id: <20231122221805.3139482-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Turning on -Wstringop-overflow globally exposed a misleading compiler
warning in bluetooth:

net/bluetooth/hci_event.c: In function 'hci_cc_read_class_of_dev':
net/bluetooth/hci_event.c:524:9: error: 'memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]
  524 |         memcpy(hdev->dev_class, rp->dev_class, 3);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem here is the check for hdev being NULL in bt_dev_dbg() that
leads the compiler to conclude that hdev->dev_class might be an invalid
pointer access.

Add another explicit check for the same condition to make sure gcc sees
this cannot happen.

Fixes: a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Fixes: 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5b6fd625fc09..5651e96e78da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -516,6 +516,9 @@ static u8 hci_cc_read_class_of_dev(struct hci_dev *hdev, void *data,
 {
 	struct hci_rp_read_class_of_dev *rp = data;
 
+	if (WARN_ON(!hdev))
+		return -ENXIO;
+
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
-- 
2.39.2

