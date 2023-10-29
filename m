Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC07DB064
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjJ2XGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjJ2XFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:05:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FFC4EDF;
        Sun, 29 Oct 2023 16:00:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22D8C116B6;
        Sun, 29 Oct 2023 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620324;
        bh=YFNScGxu+18uiY4iOdufLVHPjXSLXWg2Vyy0awY3L6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbAybc3FencUDTyd1nisdZZ+Goc5EONXrlyGI1uJ7GpCfnsYwxSiuKoC+Hg+XCdpw
         oB4rI/fbEZSZpqHSyKOrtPeMJi6Xv5prTbOPgNwlcoRnf9+9sjqTvJirdkD7oOp1Pe
         KU6txfZdJSCwrT/XWhbuo47CFHCmIhAmk3hNZXyJKN0aRL45tb3G1nzB46xfJr6joj
         HywuTATwl8/cQ32pzqXTYrnJ2wS1gDHoPOrVcVZbrxfCR4wzmq6QXzpTZRDEkoTPWB
         F65MbM0h79F2TpEb09Ki/9errFG9cuxPS8mY73638HbFGOU4nlnuNOCYxyOQ32uAiD
         EgF22h/x8fBDQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, James John <me@donjajo.com>,
        Sasha Levin <sashal@kernel.org>, corentin.chary@gmail.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 33/39] platform/x86: asus-wmi: Only map brightness codes when using asus-wmi backlight control
Date:   Sun, 29 Oct 2023 18:57:05 -0400
Message-ID: <20231029225740.790936-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a5b92be2482e5f9ef30be4e4cda12ed484381493 ]

Older Asus laptops change the backlight level themselves and then send
WMI events with different codes for different backlight levels.

The asus-wmi.c code maps the entire range of codes reported on
brightness down keypresses to an internal ASUS_WMI_BRN_DOWN code:

define NOTIFY_BRNUP_MIN                0x11
define NOTIFY_BRNUP_MAX                0x1f
define NOTIFY_BRNDOWN_MIN              0x20
define NOTIFY_BRNDOWN_MAX              0x2e

        if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
                code = ASUS_WMI_BRN_UP;
        else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
                code = ASUS_WMI_BRN_DOWN;

This mapping is causing issues on new laptop models which actually
send 0x2b events for printscreen presses and 0x2c events for
capslock presses, which get translated into spurious brightness-down
presses.

This mapping is really only necessary when asus-wmi has registered
a backlight-device for backlight control. In this case the mapping
was used to decide to filter out the keypresss since in this case
the firmware has already modified the brightness itself and instead
of reporting a keypress asus-wmi will just report the new brightness
value to userspace.

OTOH when the firmware does not adjust the brightness itself then
it seems to always report 0x2e for brightness-down presses and
0x2f for brightness up presses independent of the actual brightness
level. So in this case the mapping of the code is not necessary
and this translation actually leads to spurious brightness-down
presses being send to userspace when pressing printscreen or capslock.

Modify asus_wmi_handle_event_code() to only do the mapping
when using asus-wmi backlight control to fix the spurious
brightness-down presses.

Reported-by: James John <me@donjajo.com>
Closes: https://lore.kernel.org/platform-driver-x86/a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com/
Closes: https://bbs.archlinux.org/viewtopic.php?pid=2123716
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231017090725.38163-3-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 36effe04c6f33..49dd55b8e8faf 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3268,7 +3268,6 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 {
 	unsigned int key_value = 1;
 	bool autorelease = 1;
-	int orig_code = code;
 
 	if (asus->driver->key_filter) {
 		asus->driver->key_filter(asus->driver, &code, &key_value,
@@ -3277,16 +3276,10 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 			return;
 	}
 
-	if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
-		code = ASUS_WMI_BRN_UP;
-	else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
-		code = ASUS_WMI_BRN_DOWN;
-
-	if (code == ASUS_WMI_BRN_DOWN || code == ASUS_WMI_BRN_UP) {
-		if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
-			asus_wmi_backlight_notify(asus, orig_code);
-			return;
-		}
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor &&
+	    code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNDOWN_MAX) {
+		asus_wmi_backlight_notify(asus, code);
+		return;
 	}
 
 	if (code == NOTIFY_KBD_BRTUP) {
-- 
2.42.0

