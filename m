Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA147CDF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjJROXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjJROXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:23:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502023279;
        Wed, 18 Oct 2023 07:14:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF5AC433CA;
        Wed, 18 Oct 2023 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638463;
        bh=SVX78VUttKHt7sXiyKz8idDJFdd4dBX2HdmkwzSM5X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ak3Vo6+NBMUGPNql1MGayPPz+u2fJ6RDeqnYuLti0IIKTOZ1dpktezNvNddk0+aY3
         87EcTNnptJTC266xglDQqCLLNcoJeMiuSZGG6eYgcT4AuQ6JmjiQIlSbk2HvPP8Lqv
         UsL4ueihs/EY1NGQh5330Q3dx4TPfoCE/LOK6aoDgaWlIVPS55vlt8Dk2RJ66FnLxy
         pMVYL1thLgLopUXegsd+lJGr3qtRWdmGw9RpB4TzkUYKv40D4U2H/nhmXwYgupqdhq
         fUgGiS3WUpd/RF9t4AudPw3H//SD/ly1lSkYA7538KRPrUD0lNoRatosvD8b+bvbhQ
         ymZjdlBtuAZ0w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Szilard Fabian <szfabian@bluemarch.art>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, wse@tuxedocomputers.com,
        hdegoede@redhat.com, tiwai@suse.de, mkorpershoek@baylibre.com,
        jdenose@chromium.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/14] Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table
Date:   Wed, 18 Oct 2023 10:14:02 -0400
Message-Id: <20231018141416.1335165-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141416.1335165-1-sashal@kernel.org>
References: <20231018141416.1335165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.135
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szilard Fabian <szfabian@bluemarch.art>

[ Upstream commit 80f39e1c27ba9e5a1ea7e68e21c569c9d8e46062 ]

In the initial boot stage the integrated keyboard of Fujitsu Lifebook E5411
refuses to work and it's not possible to type for example a dm-crypt
passphrase without the help of an external keyboard.

i8042.nomux kernel parameter resolves this issue but using that a PS/2
mouse is detected. This input device is unused even when the i2c-hid-acpi
kernel module is blacklisted making the integrated ELAN touchpad
(04F3:308A) not working at all.

Since the integrated touchpad is managed by the i2c_designware input
driver in the Linux kernel and you can't find a PS/2 mouse port on the
computer I think it's safe to not use the PS/2 mouse port at all.

Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
Link: https://lore.kernel.org/r/20231004011749.101789-1-szfabian@bluemarch.art
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index a0d8528685fe3..3db87ee0b70c7 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -609,6 +609,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook E5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E5411"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
-- 
2.40.1

