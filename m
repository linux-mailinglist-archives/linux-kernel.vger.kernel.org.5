Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD77E7CDF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbjJROS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjJROSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:18:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2AD4239;
        Wed, 18 Oct 2023 07:15:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3BAC433D9;
        Wed, 18 Oct 2023 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638528;
        bh=hCfW1Ccl0vO+0jlKPEX+ObDjGt0fVguS+N2GWXh1SaM=;
        h=From:To:Cc:Subject:Date:From;
        b=jQquxvbw2Skcnl887FzQoVLju5YdPx2+yz+7z6BA3WFzNV1kQI8NF/ENy8ojOgDpg
         nUwoGzNKbpHy+mqNj8gCpQBLw3qyhkkMMI9/5lCj/vSSv2Kc1P0KHJuniM4ZmQEYD6
         uiSUXqe6awtQBNFkC1owN1mG19tgpu+rgI3StVBR+qfuWhlyl3Fxk0p3rJ+XL4fL/R
         7GeeZx56FkyuWQ5LbNpQxZbGVdwBsnQUoNnRpOWgEXDJTimDvHJB/YDgmBe+wbSFR+
         CSG3530YX9pqRMTPxttXAX1DaYny1/ArzvfobiCb6AGF2+fdlBYfMjGWTaKfjhjLEn
         FUDQBBb1dIERA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Szilard Fabian <szfabian@bluemarch.art>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/7] Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table
Date:   Wed, 18 Oct 2023 10:15:17 -0400
Message-Id: <20231018141525.1335533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.258
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
 drivers/input/serio/i8042-x86ia64io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 700655741bf28..5df6eef18228d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
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

