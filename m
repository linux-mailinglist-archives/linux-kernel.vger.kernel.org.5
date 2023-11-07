Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D827E3C72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjKGMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjKGMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:15:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B82721;
        Tue,  7 Nov 2023 04:11:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69162C433CA;
        Tue,  7 Nov 2023 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359099;
        bh=4oOYIcnoxIxV6g1ChuQv7zCVzuFMdjbfN1SJdr13zis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKSKN3YxDp/Az4dvizf1bUI5LcaWkcThntW6OjPQJh+iO0UnVPRrUW4fHuwev2oMv
         aOkI98KWEj+bxSi8KASKfeC14T/NFEN3fmLtT3JK2Xnr5Om+WZaCr8hms5EOSUy39D
         TNA4Zeg63KahhTXEFsnFy9I3TxI3XJps5Ohn7ARJ3kwLaa/+mkjHtK1XPfCGsnv2NT
         tDTdiN7pwKfZiMHkIbDwC/YNmwxAj7DbcTBPk4pKz9A/Mf6yxrdKVaKjaLim2pbJxN
         Jd6s3/Iee8KGa+qaySUJUOkYfe0UrWwJ3EfcPCqWQfQfYbfyQ6ktiyxaKhSGLbYBj7
         R7k2mKEc0SBvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Denose <jdenose@chromium.org>,
        Jonathan Denose <jdenose@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/18] ACPI: EC: Add quirk for HP 250 G7 Notebook PC
Date:   Tue,  7 Nov 2023 07:10:45 -0500
Message-ID: <20231107121104.3757943-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121104.3757943-1-sashal@kernel.org>
References: <20231107121104.3757943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Denose <jdenose@chromium.org>

[ Upstream commit 891ddc03e2f4395e24795596e032f57d5ab37fe7 ]

Add GPE quirk entry for HP 250 G7 Notebook PC.

This change allows the lid switch to be identified as the lid switch
and not a keyboard button. With the lid switch properly identified, the
device triggers suspend correctly on lid close.

Signed-off-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8bb233d2d1e48..77d1f2cb89ef3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1897,6 +1897,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
 		},
 	},
+	{
+		/*
+		 * HP 250 G7 Notebook PC
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.42.0

