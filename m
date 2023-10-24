Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C67D5711
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbjJXP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjJXP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:57:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD783
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163068; x=1729699068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGHK9hVViLLRXP1qkBxDzBZsDUdNwG2+XztuBNrzymU=;
  b=XufQ+EyHCJ7RTzgQxDCFm8rp/LMFZfQNhns4p5pRPMloydw0Wfpuukz5
   VnYTKtI2TWA7nrLRgl6Laghp4q1EaYeKnaU/k7HtRw6LKGoZ5bUlL2dZU
   6bP2Cd0uuc4YD/MjJe/bBx0TmJNa2/iv6qngPSLXmJXUTVw/J9sjug9/A
   PM0KrswE0jtF4WI1EKuv3uwp8MC9m36BsrG9pZGHMqjJpqJeA9UmSGCYV
   yFaTTQBVI1+lTu57NenzPy33MnhxZmlQp7au+O5apwNTAX/gQzDwljmT6
   1Jd2ErXdZ0wnaeC8MTqXe+xRYIqTKHGyuW3PLHYOyUQN00i+k7p5QZJdS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="8649780"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="8649780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902233850"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902233850"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 08:55:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 094E814F; Tue, 24 Oct 2023 18:57:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/7] drm/i915/dsi: Replace while(1) with one with clear exit condition
Date:   Tue, 24 Oct 2023 18:57:33 +0300
Message-Id: <20231024155739.3861342-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move existing condition to while(), so it will be clear on what
circumstances the loop is successfully finishing.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 24b2cbcfc1ef..a6a6f1814967 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -707,13 +707,10 @@ static void intel_dsi_vbt_exec(struct intel_dsi *intel_dsi,
 	if (connector->panel.vbt.dsi.seq_version >= 3)
 		data += 4;
 
-	while (1) {
+	while (*data != MIPI_SEQ_ELEM_END) {
 		u8 operation_byte = *data++;
 		u8 operation_size = 0;
 
-		if (operation_byte == MIPI_SEQ_ELEM_END)
-			break;
-
 		if (operation_byte < ARRAY_SIZE(exec_elem))
 			mipi_elem_exec = exec_elem[operation_byte];
 		else
-- 
2.40.0.1.gaa8946217a0b

