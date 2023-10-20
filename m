Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB07D0AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbjJTIsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376520AbjJTIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:48:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B08D51;
        Fri, 20 Oct 2023 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791693; x=1729327693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yG6eK+7AGqw8L3P7iFJ1dEXh4HF5j+xoQ/khjB5EmKI=;
  b=mbY5GsTdFC0TmggcsJb0kFLlFkW6YcRx5dio91CcBjeRdsULsig6MtGv
   bJWAGudP8H1u4ZYqvNtbav4Uay5JdY1x37neorvIJx/jQtoooj0dmjG3c
   MeXON0N9S8Hlp+X6HIaDyO3xfAHDkVCha3bGg1vZHS9lQNdrqjz9B/PxH
   TX7o2wOEj3Z8n6r7KV2y1V8oC3fSWMXgRuk8WxMlC4mf5ZmC9eg8x3xmW
   4k2vJ5mDL/h8zPvhrVkVvbSg36LINp5cC4C25TNvVLMO0A3s+H1gqJ2oq
   Y7q1FvOJ7VcrpimW1sTigj5w2Iw5BcLgIUGKEkoyvwlFqS8Ll1V0Zdbox
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683522"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683522"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832166"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832166"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:47:52 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/8] pinctrl: intel: use acpi_dev_uid_match() for matching _UID
Date:   Fri, 20 Oct 2023 14:17:26 +0530
Message-Id: <20231020084732.17130-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3be04ab760d3..999f453344d2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1694,7 +1694,7 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 		unsigned int i;
 
 		for (i = 0; table[i]; i++) {
-			if (!strcmp(adev->pnp.unique_id, table[i]->uid)) {
+			if (acpi_dev_uid_match(adev, table[i]->uid)) {
 				data = table[i];
 				break;
 			}
-- 
2.17.1

