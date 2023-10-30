Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B7B7DBCF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjJ3PyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjJ3PyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:54:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C07C5;
        Mon, 30 Oct 2023 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681244; x=1730217244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yuuVEK/WCKgIgnUepz96+I9qXc9OXiBKs3MAo0tKBzs=;
  b=KQ8Veuxst/uEeG5+Y/CK/bkc/KSqeiNy7tVx9kkWZv+hd31JRRoe6Mc+
   7hw4YQBky3OiEgUKGe4wkN8JXdPVu4H6LIfAtSopOLOQBqAJPeOi5robO
   D+WBS2fln4/I3xKXveqj4BQBrnYa+Jmst5xuGkcG24i/G4dh/ywYizBQ3
   tEw3HSAEsDUN62iNnS3omSZ9V+Bo8CDnxkCpYelhqTZX252JoJDwqSyjN
   tDC7mMvq0g6w8au80MCpQ6f/SOFflmRyRZsVweuTHb55kDO1o3LqGuzA3
   uq53zR8KdE0b/7tOH/FLLM85hhyiAInKyPa2H1vhE1u5n45o/WUVAhWa4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="386986404"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="386986404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="736770579"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="736770579"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2023 08:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F6C72AB; Mon, 30 Oct 2023 17:53:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: tangier: Move default strength assignment to a switch-case
Date:   Mon, 30 Oct 2023 17:53:40 +0200
Message-Id: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iWhen ->pin_config_set() is called from the GPIO library (assumed
GpioIo() ACPI resource), the argument can be 1, when, for example,
PullDefault is provided. In such case we supply sane default in
the driver. Move that default assingment to a switch-case, so
it will be consolidated in one place.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-tangier.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
index 007bca1cf224..26e34ec0a972 100644
--- a/drivers/pinctrl/intel/pinctrl-tangier.c
+++ b/drivers/pinctrl/intel/pinctrl-tangier.c
@@ -368,14 +368,11 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		/* Set default strength value in case none is given */
-		if (arg == 1)
-			arg = 20000;
-
 		switch (arg) {
 		case 50000:
 			term = BUFCFG_PUPD_VAL_50K;
 			break;
+		case 1: /* Set default strength value in case none is given */
 		case 20000:
 			term = BUFCFG_PUPD_VAL_20K;
 			break;
@@ -394,14 +391,11 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		/* Set default strength value in case none is given */
-		if (arg == 1)
-			arg = 20000;
-
 		switch (arg) {
 		case 50000:
 			term = BUFCFG_PUPD_VAL_50K;
 			break;
+		case 1: /* Set default strength value in case none is given */
 		case 20000:
 			term = BUFCFG_PUPD_VAL_20K;
 			break;
-- 
2.40.0.1.gaa8946217a0b

