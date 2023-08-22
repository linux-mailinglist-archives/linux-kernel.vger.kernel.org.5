Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D56783AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjHVH16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjHVH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:27:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CEE133;
        Tue, 22 Aug 2023 00:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689264; x=1724225264;
  h=from:to:cc:subject:date:message-id;
  bh=bpf4SKdwRPcbz0UwMeMNuyan9Jo3cwQxDYxRkC1tqhw=;
  b=ZSheP9o2vWNqvKNofX+5fjN4fn1+RRAyxyGx6X8Fns8c6Wq0nGgdDlpz
   oc6AfJlAidYtiOS8I1rJ70OfJ4wT2X7bidfYWqA5KBEoer2ACmLbCKTqM
   YUAjU3CYHd75VRPu+rxvTiZQx6JCsrvHa5F37X2lNV6MoEID5onrbGf8G
   quu8C03r2xtKjj7odMvODI1ljWaTiJnm5BobLMPlbzTrnbrWyMuo62mXe
   0LjLWbVgSVJz1VyNZkHfayA/FLjVzjag+mQTA3SbVM5LEdu0E5y0Mc8nT
   uLSYBLZpkm4tgO9FPOP1ECuSyh7wKoZbZhtGLIZODfKIbRjahEPATeyRA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376538405"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="376538405"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685941229"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="685941229"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2023 00:24:04 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>, stable@vger.kernel.org
Subject: [PATCH v2] pinctrl: cherryview: fix address_space_handler() argument
Date:   Tue, 22 Aug 2023 12:53:40 +0530
Message-Id: <20230822072340.8783-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First argument of acpi_*_address_space_handler() APIs is acpi_handle of
the device, which is incorrectly passed in driver ->remove() path here.
Fix it by passing the appropriate argument and while at it, make both
API calls consistent using ACPI_HANDLE().

Fixes: a0b028597d59 ("pinctrl: cherryview: Add support for GMMR GPIO opregion")
Cc: stable@vger.kernel.org
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
Changes since v1:
- Update subject and commit message

 drivers/pinctrl/intel/pinctrl-cherryview.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 7ffe4dafeebb..2bb574cf01d9 100644
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

