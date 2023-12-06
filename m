Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B008068AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377019AbjLFHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjLFHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402110CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB38DC433CC;
        Wed,  6 Dec 2023 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848254;
        bh=ZOGqEODNjCD+oZi+Lzwv9yxa5ZK3n1WxOSTSeSIxzG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uP64B06hW1cXeR4KmqperTlv+8Cbhb+QPK9aJZWuILPhSXIp8I6g9YhCgDy3+Th3l
         kcy7sWXJL37DKi4EYGJNIRBEXef4eZOUAVu3MBvyN5B8/Q3kotIFl4Ww0l71gI1YfU
         PNSgW5ff7MMcHXgtrzEdKHtHLBQ4SGOfg+EF71eb0dSLRVf11D9dLEekhjMMxfwnyG
         7dMnZYMFI5xivBK04SjzC1fIJhDb58mvZQapm9QP1pnpATlhQ/ke3Pc0KlyiDlOXvb
         v3Ta+tNfBThvVkUSwa9F5J/eHCbIpnDAGpI6gmwgamZfIih3gmgs6vO2o+OjpuX6Eh
         AOVpKlwoSfi1Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/27] tty: bcm: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:36:52 +0100
Message-ID: <20231206073712.17776-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/bcm-vk/bcm_vk_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index 2bce835ca43e..59bab76ff0a9 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -64,9 +64,9 @@ static void bcm_vk_tty_wq_handler(struct work_struct *work)
 	struct bcm_vk_tty *vktty;
 	int card_status;
 	int count;
-	unsigned char c;
 	int i;
 	int wr;
+	u8 c;
 
 	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
 	if (BCM_VK_INTF_IS_DOWN(card_status))
@@ -192,7 +192,7 @@ static ssize_t bcm_vk_tty_write(struct tty_struct *tty, const u8 *buffer,
 	int index;
 	struct bcm_vk *vk;
 	struct bcm_vk_tty *vktty;
-	int i;
+	size_t i;
 
 	index = tty->index;
 	vk = dev_get_drvdata(tty->dev);
-- 
2.43.0

