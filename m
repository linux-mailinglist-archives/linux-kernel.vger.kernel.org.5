Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321D37D613D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJYFiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYFit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:38:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C479C12A;
        Tue, 24 Oct 2023 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698212327; x=1729748327;
  h=from:to:cc:subject:date:message-id;
  bh=zkjMnmvGuvGDKzRPgyPhClkD5mU4/NkRV/n4i7OeNek=;
  b=GE0fIbM2r8xuUKnAElME65i5gfGxjeA1Dpb+leLT8nPZXZVHUz43La+w
   5Gwp/YkG9KqzIEXOUaUQFEaeh7iLAUQIdRSxUtP1AFZbEhXgUdNAlFjRs
   i/LBCxZ3ufpjCGw1Ny5DAUa9fk3ATtEf36hk/X9AHjSbyIkXsuagKgPi/
   TqBHfJzzEDgikYL585qHPHNF+qjpUaTRzIC3aE5+oMRO+PX/CT3T1VNHu
   rgp43i7gL+CbL+3O1xybJm+XABDGDl5ERq39CdFpzrL5r+i2cNQwwVeBh
   +NXhDX4cSvj9VSI89ibRkGnYn3R/l0zgnNQ9BpoLzvmhkfp/9HdT+dVT0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="390096231"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="390096231"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 22:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793753056"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="793753056"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2023 22:38:44 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Date:   Wed, 25 Oct 2023 11:08:33 +0530
Message-Id: <20231025053833.16014-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use acpi_dev_uid_match() for matching _UID instead of treating it
as an integer.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/acpi_lpss.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 875de44961bf..6aaa6b066510 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,8 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, "1"))
 		return;
 
 	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
@@ -218,10 +216,8 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, "1"))
 		return;
 
 	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));

base-commit: 72d54941cd56ac3fedca6f7ae00a300b33ead29e
-- 
2.17.1

