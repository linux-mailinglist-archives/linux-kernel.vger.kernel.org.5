Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7247F2AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjKUKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjKUKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:39:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED1198;
        Tue, 21 Nov 2023 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563135; x=1732099135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=T+lHnAP5LZ0cCsv+uOEYyeyFPKszoxdDpc1va0QseKE=;
  b=l8vTUy2c1emPaJn9m03rbT2+3w3RUWlOt8C9EVHiTRB5gOFZhrsozf9U
   oN6SvfSjSyqe+jJAl0FDkbEjAM6JnHBxcjbXOsD7Q384Y+w4Xp2BtUpgZ
   M16Jl4hqkFqvrbH6ETOqxayKTWXOvXhHXcWX1bLTTyCj+NLnp9vk7GxMb
   XuryEcsXlg6qUep2elHh6++5YAvM8Y1ZPfuH+fk5cPH9g2GK7HQT6aQES
   oJmJxYsMvd1pE4xuzCTkKa5s/ZtYI2JFI8bYLxrJqLhSCsRKE1iPArqsd
   NRdTHJwAKn7N483cYyrc+VCf1sUkSugVvHS7y9EJ3GF+oVrM1dieER0Ik
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371986937"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371986937"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871948"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:51 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 4/6] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Date:   Tue, 21 Nov 2023 16:08:27 +0530
Message-Id: <20231121103829.10027-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/acpi_lpss.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 875de44961bf..79f4fc7d6871 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,13 +167,9 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
-		return;
-
-	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
+	if (acpi_dev_uid_match(pdata->adev, 1))
+		pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
 }
 
 #define LPSS_I2C_ENABLE			0x6c
@@ -218,13 +214,9 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
-		return;
-
-	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
+	if (acpi_dev_uid_match(pdata->adev, 1))
+		pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
 }
 
 static const struct property_entry lpt_spi_properties[] = {
-- 
2.17.1

