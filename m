Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D030798EB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245513AbjIHTHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjIHTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:07:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794BE0;
        Fri,  8 Sep 2023 12:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B36C433D9;
        Fri,  8 Sep 2023 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197244;
        bh=1hdWCck4jn+KH3RcIdyPXBIfUoTUb1kDuxDPsoliRXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KP/curU+IK56O4u0Hcz/K96Dvvyb+aGYFqjBMHWUz0QJVSJYgKYXi+1vgUPnrpuJj
         NxuZtkwoSJCJKsT3XwIIOf1asqYs7A4F4Mbc11ilV07ZB09JiM3VmNIfW8QAv5r0Yo
         QgiGtGtmEP0Yu3Id3crab795UAg0e+XBPikEn4NgYqzUnspUiJk7ie8n0L7mKgODFq
         L1Kf/hIicgWjNSy0ZHVATHHM7CW/JT84LI8qvVq1r9cQzmn2W6emPWR5XyiX1eTRYn
         EHpJSK+CttlVmGrwvM1mhXnTpS9u+/W4kZYAEliI48vbVtYxTEDNWy5rHoldsDrB/a
         p8quNiHkS6+uQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/14] Bluetooth: btusb: Fix quirks table naming
Date:   Fri,  8 Sep 2023 14:20:01 -0400
Message-Id: <20230908182003.3460721-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit d831e3612111d385e8629104af5429808ef26e25 ]

The quirks table was named "blacklist_table" which isn't a good
description for that table as devices detected using it weren't ignored
by the driver.

Rename the table to match what it actually does.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 49d5375b04f40..139824637298a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -173,7 +173,7 @@ static const struct usb_device_id btusb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
-static const struct usb_device_id blacklist_table[] = {
+static const struct usb_device_id quirks_table[] = {
 	/* CSR BlueCore devices */
 	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
 
@@ -4004,7 +4004,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
 
-		match = usb_match_id(intf, blacklist_table);
+		match = usb_match_id(intf, quirks_table);
 		if (match)
 			id = match;
 	}
-- 
2.40.1

