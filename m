Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354B7DAF1D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjJ2W42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjJ2Wzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F710F6;
        Sun, 29 Oct 2023 15:55:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9A5C433AB;
        Sun, 29 Oct 2023 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620117;
        bh=2zRB7aVuudlpgLM6tZDf0eCOeWYyJxXUdGN8m/51Z74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JlCXuifQ5LOkFPfRhp8NcNMnk/OuTUJCoIOtCIjSNrslT6rab0DxhiTgcOtDACj14
         pvJ70n/4Sg8o3mbxnHOxccXphYMsYKfhNkpL1UFmdOErGmtaPRDUt4pwv9pFyuQkUF
         CM3JgeHf4Xf8c6kDhhzFt5NOI6kMI8PjZIuCv1pnBc0UkzGCWyQ1reCuzSx3CVXzOI
         5kcj8Lny2js+o0Px10FVxWRBMlxnHv9QoCGGL1nPNHnvGsoK+6wts5YRMEqAgKG+GY
         bC2YRE1UwYvWTX5jUcFl4E2doG6Z8vXM0mMURJ+3az/kN5GJtcmx/KMAFKofpx1WXO
         7A6zPHuyAUBgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 23/52] Bluetooth: vhci: Fix race when opening vhci device
Date:   Sun, 29 Oct 2023 18:53:10 -0400
Message-ID: <20231029225441.789781-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>

[ Upstream commit 92d4abd66f7080075793970fc8f241239e58a9e7 ]

When the vhci device is opened in the two-step way, i.e.: open device
then write a vendor packet with requested controller type, the device
shall respond with a vendor packet which includes HCI index of created
interface.

When the virtual HCI is created, the host sends a reset request to the
controller. This request is processed by the vhci_send_frame() function.
However, this request is send by a different thread, so it might happen
that this HCI request will be received before the vendor response is
queued in the read queue. This results in the HCI vendor response and
HCI reset request inversion in the read queue which leads to improper
behavior of btvirt:

> dmesg
[1754256.640122] Bluetooth: MGMT ver 1.22
[1754263.023806] Bluetooth: MGMT ver 1.22
[1754265.043775] Bluetooth: hci1: Opcode 0x c03 failed: -110

In order to synchronize vhci two-step open/setup process with virtual
HCI initialization, this patch adds internal lock when queuing data in
the vhci_send_frame() function.

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_vhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 40e2b9fa11a26..f3892e9ce800f 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -74,7 +74,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
+	mutex_unlock(&data->open_mutex);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
-- 
2.42.0

