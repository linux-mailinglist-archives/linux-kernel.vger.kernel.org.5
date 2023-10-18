Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248407CDF1F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbjJRORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbjJROQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:16:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5F44B3;
        Wed, 18 Oct 2023 07:15:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563E6C43395;
        Wed, 18 Oct 2023 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638555;
        bh=2bx54VwMF1iHDXV/okdrIoKe/RI6wVQn1kXD8jwkoBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDV8nORLOyUbU4bFgDo31HUYj0MoauwhIeC/iLB966NaxwGN59dvAYf0Ibx3b5ZiF
         M7fnm3JHPmSEvLX/kCsWszlZ+BqgqSZf8tJrn/RWE/KUG2oIEuEauduBOarqeNX681
         9CjMmNUJNLZCSCBNMEwCZX4HN8EI0KzQwNwlh3PbJ3p3Pa9UOTeiaAVxdy0mgu33fc
         mkyegBx1avnhYbCYrmsLRXAODAyI/7a/NuGV1TqrMH8Al0pe0gsRFTMo2V+PZZPbU4
         HLJzFIsGWRi7BDeOql9HzlcMUgvWhnWKAb/vO2ZTBmfxIgsvFgdl9jUlpcl8WINix4
         9p/GGjdWdiAWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Szilard Fabian <szfabian@bluemarch.art>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/7] Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table
Date:   Wed, 18 Oct 2023 10:15:41 -0400
Message-Id: <20231018141548.1335665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141548.1335665-1-sashal@kernel.org>
References: <20231018141548.1335665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.296
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
index 0cf9a37873261..2d4df82d65afe 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -613,6 +613,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
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

