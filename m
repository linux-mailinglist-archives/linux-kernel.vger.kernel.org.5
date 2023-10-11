Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756637C4AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbjJKGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjJKGpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F590;
        Tue, 10 Oct 2023 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697006749; x=1728542749;
  h=from:to:cc:subject:date:message-id;
  bh=y4UC8gG1+gAZpQcXTEzxnRFZ4Z3jnxyMdDMevoJdM78=;
  b=Ktopex5LQg6hU5UohS0elDJsAzYKdsJVz6BpBjtGntlB99e6ySs4PYlQ
   Y+rNleyVmdTQPfi7EqO+n1kVQTQLFp+QyP7w1upC46dbGrFUY0YtE7EII
   v1p7Ho5yO0lRCd1DaWP1wemB5MW64su8ApLIbIcvZHNPcOaRzqlGNruRJ
   BSOisM5Ja/KDn4GudlIKuRYMYWQdhPRdukya1N3Ilyse+i0VPvKUxseLY
   IusUWGPCefOnn9wuLiaW2qZj6Y3WHOrSGlkkmENfbQKRHk9xf+1QrOf9h
   mxMx+T5DcLcsXt0qlDJQjzXmFl8SF7dux2nAaFK05/+1n3QV8XuYOyM6z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364877788"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364877788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753711804"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="753711804"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 10 Oct 2023 23:45:45 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: cherryview: reduce scope of PIN_CONFIG_BIAS_HIGH_IMPEDANCE case
Date:   Wed, 11 Oct 2023 12:15:33 +0530
Message-Id: <20231011064533.20549-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a couple of pinconfig cases inside the braces which are meant for
PIN_CONFIG_BIAS_HIGH_IMPEDANCE case. Although it is valid C, it makes the
code less readable and prone to misinterpretation. Limit the braces to
PIN_CONFIG_BIAS_HIGH_IMPEDANCE case to avoid this.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 5fde4fec59c1..b1d8f6136f99 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -894,6 +894,7 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 			return -EINVAL;
 
 		break;
+	}
 
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
 		if (ctrl1 & CHV_PADCTRL1_ODEN)
@@ -904,7 +905,6 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
 			return -EINVAL;
 		break;
-	}
 
 	default:
 		return -ENOTSUPP;

base-commit: 55176feaa4d8f7d07005c6199d7843bc2991773d
-- 
2.17.1

