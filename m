Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44EC7DBD54
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjJ3QCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJ3QCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:02:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5BF1;
        Mon, 30 Oct 2023 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681718; x=1730217718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JWSWeGFuQ2uKtzVehSq0/MF2kVkMz/a2iCsUEOeG8Ac=;
  b=lIDyueU+MQmDtvlycXtTjHX5LyA0Gtb956qJsZz5EiWtqeqGbthrjuAT
   8vEUn6S11jp1ViGc1/c7fhGZig2jcfRH+CYchaBuYPw7S5iQtdwf75T3h
   BTzNgiugNnxDje18IBR9/wImILoujR+TMiGa2XmxXLzIymbeFpAcCerip
   ODRb/PoJMe0hk5WWoNyRhFt4iP08XW2/cRpJedYipia0vLERNqk/06Ll+
   yKnlCNHHSIilKoX8nHEZxnbGvzsIugPluRryWk6FEDXV6Js2EaEjaZsqy
   pou6FqLrAGnj8PAIjfNqHFDS/u3Km2nTRtBox7ofYroq6tK/ZsrdYMUZP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="419216698"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="419216698"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="933810503"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="933810503"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2023 08:59:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E38032AA; Mon, 30 Oct 2023 17:59:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Refactor intel_pinctrl_get_soc_data()
Date:   Mon, 30 Oct 2023 17:59:06 +0200
Message-Id: <20231030155906.3492801-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor intel_pinctrl_get_soc_data() to drop initial assignment
of the data variable. It's only used in ACPI case and instead
we may always assign it there as the ACPI ID table has the terminator
entry that has driver data set to NULL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 9b78e112fe60..3e8010607d32 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1660,7 +1660,7 @@ EXPORT_SYMBOL_NS_GPL(intel_pinctrl_probe_by_uid, PINCTRL_INTEL);
 const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_device *pdev)
 {
 	const struct intel_pinctrl_soc_data * const *table;
-	const struct intel_pinctrl_soc_data *data = NULL;
+	const struct intel_pinctrl_soc_data *data;
 	struct device *dev = &pdev->dev;
 
 	table = device_get_match_data(dev);
@@ -1669,11 +1669,10 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 		unsigned int i;
 
 		for (i = 0; table[i]; i++) {
-			if (acpi_dev_uid_match(adev, table[i]->uid)) {
-				data = table[i];
+			if (acpi_dev_uid_match(adev, table[i]->uid))
 				break;
-			}
 		}
+		data = table[i];
 	} else {
 		const struct platform_device_id *id;
 
-- 
2.40.0.1.gaa8946217a0b

