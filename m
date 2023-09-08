Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5482B798CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbjIHSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343806AbjIHSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72A2135;
        Fri,  8 Sep 2023 11:17:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21731C116D7;
        Fri,  8 Sep 2023 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196918;
        bh=mS2Y+2T2w7eJv6E5wy3SHuKWCL7kTFVfjOuvmi0a3uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t18mCsNgxCWgwCmMR+jnpZfG2SMuoX0VSGWubK7ChFFQkGRhJfdi7q1OyHaPqqayr
         eZYOkHFAJdB7+ADERgrvar2g5eJJXR+hzih0IV8EA3aeHm5HxakG0UiKn3fXGzJFWV
         dG1r3OabteOvJWR5FKlxdLnpB0PHghOkw0Qimr1l3PsjFXFCbyH77G5ebicQWXNg0a
         r4b27LLVD5nKJo52aWBO9hN2VDb9V1SBU9JZewHDNHpkGIONTb2RgxGkcSrqR+LSxS
         Qgnl04JziP7Pl8pouCQaWFkmwZDSxewYddUZIn3vY4I6tMOVq/2JAA0dQQ6UBPrfzN
         CV0+U0n2Z/1JA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 41/45] Bluetooth: btusb: Fix quirks table naming
Date:   Fri,  8 Sep 2023 14:13:22 -0400
Message-Id: <20230908181327.3459042-41-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index a38550df92b94..baf6762cf1f33 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -175,7 +175,7 @@ static const struct usb_device_id btusb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
-static const struct usb_device_id blacklist_table[] = {
+static const struct usb_device_id quirks_table[] = {
 	/* CSR BlueCore devices */
 	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
 
@@ -4128,7 +4128,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
 
-		match = usb_match_id(intf, blacklist_table);
+		match = usb_match_id(intf, quirks_table);
 		if (match)
 			id = match;
 	}
-- 
2.40.1

