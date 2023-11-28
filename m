Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506DA7FC86D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376375AbjK1VMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjK1VLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:11:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C979C2D7E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:09:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955EBC43215;
        Tue, 28 Nov 2023 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205742;
        bh=P4z7rikPkso0cyN9CrecQNkYXGTlwhd/rkk98EMyz1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpOxMiN1hTrXiPhdsjydQAwgszghxNV5gfo8nLuc8LYo30hG1LG8D2tWH9uf/Tfxh
         8MnlYkhLSRb4zae+NLlZIudWEZGJpdS9amNKDSXh3GZqyOztHtmurGyEsx/n3cpjkz
         mcKuhaEAXQmrX8dPC3qlDGroZNUFskHhUminrfsjvJJBpoNPsmWNNoKqtsTkgVib8v
         7bfJld2oZrj7c99TovoBmpICwJQ4xAN7gaxGL/mf1BKk4pd8B3DGBi5KU6+PgjQkO0
         XRkPiS2oN0Iyie8p8eH8hqiBnGhfX70VTFkGk+bpidHNIoSCFKbrVV1OoNE7ShVJO4
         COS16L0Z5opwA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Benato <benato.denis96@gmail.com>,
        "Luke D . Jones" <luke@ljones.dev>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/15] HID: hid-asus: reset the backlight brightness level on resume
Date:   Tue, 28 Nov 2023 16:08:33 -0500
Message-ID: <20231128210843.876493-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210843.876493-1-sashal@kernel.org>
References: <20231128210843.876493-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
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

From: Denis Benato <benato.denis96@gmail.com>

[ Upstream commit 546edbd26cff7ae990e480a59150e801a06f77b1 ]

Some devices managed by this driver automatically set brightness to 0
before entering a suspended state and reset it back to a default
brightness level after the resume:
this has the effect of having the kernel report wrong brightness
status after a sleep, and on some devices (like the Asus RC71L) that
brightness is the intensity of LEDs directly facing the user.

Fix the above issue by setting back brightness to the level it had
before entering a sleep state.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 16832e79f6a87..8c16995105043 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1014,6 +1014,24 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+static int __maybe_unused asus_resume(struct hid_device *hdev) {
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret = 0;
+
+	if (drvdata->kbd_backlight) {
+		const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4,
+				drvdata->kbd_backlight->cdev.brightness };
+		ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
+		if (ret < 0) {
+			hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
+			goto asus_resume_err;
+		}
+	}
+
+asus_resume_err:
+	return ret;
+}
+
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1305,6 +1323,7 @@ static struct hid_driver asus_driver = {
 	.input_configured       = asus_input_configured,
 #ifdef CONFIG_PM
 	.reset_resume           = asus_reset_resume,
+	.resume					= asus_resume,
 #endif
 	.event			= asus_event,
 	.raw_event		= asus_raw_event
-- 
2.42.0

