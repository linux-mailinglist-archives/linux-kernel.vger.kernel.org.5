Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1477A7DBB80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjJ3OOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjJ3OOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:14:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11865C1;
        Mon, 30 Oct 2023 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698675249; x=1730211249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RbRt9CJjjdF4MIbpEP7sGvcVuzygZE5pqZR+8QLCnEA=;
  b=D0idpo8NTe+Cv6kdMGnIgcnmNSkUv5jzPnZh77sSzZtKdrHnHFgRK917
   4MzmcaaDtMFY013yxqpZmr5T70BrXVi6JlWwjeWzZPzMkn6D1BlUTFhd3
   TKT96YgrtPH0UOFrnuVVssEELH79O1MU0HCrZcJrXRZwFJW03Jxw5aSzb
   AgE0gL0mXcgn5ZGxRO++jGb9CPrJByujbNYeTaQ7EAC0qIQEEsvFNsRvn
   8tUkeLR4ryTR+BZAoiN/WkhUk4AEn3Nj5yiK7HlENDFzDorQzXRT37L2P
   fGU6AqwvBsUmuklh33Uiwd/cTCWrrMezgn6wqGuvI7NZeB2GswausTO6R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378447803"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378447803"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710104216"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710104216"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2023 07:14:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03883330; Mon, 30 Oct 2023 16:14:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: tangier: Enable 910 Ohm bias
Date:   Mon, 30 Oct 2023 16:14:04 +0200
Message-Id: <20231030141404.3242102-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 7 (I2C) supports special bias value, i.e. 910 Ohm.

Enable it for configuring pin.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-tangier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
index 40dd60c9e526..007bca1cf224 100644
--- a/drivers/pinctrl/intel/pinctrl-tangier.c
+++ b/drivers/pinctrl/intel/pinctrl-tangier.c
@@ -382,6 +382,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
 		case 2000:
 			term = BUFCFG_PUPD_VAL_2K;
 			break;
+		case 910:
+			term = BUFCFG_PUPD_VAL_910;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -405,6 +408,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
 		case 2000:
 			term = BUFCFG_PUPD_VAL_2K;
 			break;
+		case 910:
+			term = BUFCFG_PUPD_VAL_910;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.40.0.1.gaa8946217a0b

