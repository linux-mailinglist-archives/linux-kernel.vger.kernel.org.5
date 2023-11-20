Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392817F12D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjKTMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKTMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:09:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A5112;
        Mon, 20 Nov 2023 04:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482153; x=1732018153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/nqR+KlYfg0C+OhOQjsmRZyDysf3qyPk8ALUmLhgcv0=;
  b=B8NaFkU8l2OABLQLuN6DTAw0w0Z9HXWu3+/zdnow3OVrwXqDaVajioAi
   4wMZBjes0J6aTHODK+4BfB6dNEXVAMv1xw6HySJuct3zCsyWpqbj6kShJ
   9E/NzsiCIEVOG9gVGkwyCUAhomosdNFiLDYUJjzso5Wm3hr55MtJVS/7d
   qIbnWjYB5QKEdnggj74WgmiyLdfh8MuDsXFYtOQknLjYRYfCzLA9nQirF
   PPQJoKbunLj/cli87a7Q6ICwzdvUzBlENBqiDYsVAEEuBEJebF5Scire0
   m0vauqgBB7/DtZ2Rd2x64H+XdFo3gggcpaOkCaJCk/nwNxHmtZw5ZJI9F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455743"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455743"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878654"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878654"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:09:04 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/6] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Date:   Mon, 20 Nov 2023 17:38:35 +0530
Message-Id: <20231120120837.3002-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/acpi_lpss.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 875de44961bf..8b80ef7da21f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,8 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, 1))
 		return;
 
 	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
@@ -218,10 +216,8 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, 1))
 		return;
 
 	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
-- 
2.17.1

