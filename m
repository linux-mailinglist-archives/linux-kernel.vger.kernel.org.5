Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF997823BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHUGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjHUGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:30:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06AA2;
        Sun, 20 Aug 2023 23:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692599432; x=1724135432;
  h=from:to:cc:subject:date:message-id;
  bh=5lzfZO+xFA5roDkaZTlGOhC+nKCTgnNKMEScm1jZJdk=;
  b=OWfJHTJxtMOLHi49wfsCNhL8NIZG9gYraPDxJB0Gpo5b+7+BIlidmjJc
   9zBR8Hthd1NLUpAIzE9fQqmfZ8LRTGNY2rF3B6Tj2ndSYfF6pfzek+go7
   ecLtOt1sCbOs2uF5hlj8k7t6jxO5NrTh4/5s4h11UH4zENh47WnaKl2u0
   bPN3ToghqZHHVhsKsM2cWfxak27R0a2sqgPl3+qXMSU8P/tHSrA5LmRSr
   fBW/XceK02EwAlYVVwXBv4SaT9aXW9/kD1gLpDzj++scOt+2Oy7WpQEsn
   AZ4yHiMlIFGPdvf27jE52KBd7tzCtbpnVTBGtCfoBc9RV+88tvY3PLgIH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="353824780"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353824780"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 23:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="729301350"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="729301350"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 20 Aug 2023 23:30:28 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: cherryview: use ACPI_HANDLE() to pass handle
Date:   Mon, 21 Aug 2023 12:00:02 +0530
Message-Id: <20230821063002.29807-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ACPI_HANDLE() to pass handle to acpi_*_address_space_handler() APIs.

Fixes: a0b028597d59 ("pinctrl: cherryview: Add support for GMMR GPIO opregion")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 2c619fcf93ca..5a50bee48873 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1650,7 +1650,6 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	struct intel_community_context *cctx;
 	struct intel_community *community;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct intel_pinctrl *pctrl;
 	acpi_status status;
 	unsigned int i;
@@ -1718,7 +1717,7 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	status = acpi_install_address_space_handler(adev->handle,
+	status = acpi_install_address_space_handler(ACPI_HANDLE(dev),
 					community->acpi_space_id,
 					chv_pinctrl_mmio_access_handler,
 					NULL, pctrl);
@@ -1735,7 +1734,7 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
 	const struct intel_community *community = &pctrl->communities[0];
 
-	acpi_remove_address_space_handler(ACPI_COMPANION(&pdev->dev),
+	acpi_remove_address_space_handler(ACPI_HANDLE(&pdev->dev),
 					  community->acpi_space_id,
 					  chv_pinctrl_mmio_access_handler);
 
-- 
2.17.1

