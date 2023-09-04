Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D379161A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbjIDLPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjIDLPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:15:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB76E3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693826131; x=1725362131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nnvwoGm/BJ54eCLN5Pwc7J++DCqfffic+2zXJ1vq+cc=;
  b=krsIRD/AvObtBxxeAUEeQqmU94apToJRvARmufSGv98fGNkTFwwgwmSc
   MA3XE95o2YyAd97CEDH+sxACO9zDQszXJcAuHIohy0QHLhAyKmw78Olz4
   +eSm30KSsD9cSrq3wOu01U6KC4gwYhLidJ2XElR5dFTm+p09scjUjCwCr
   v84pIZSW8FSeDXPt+c7fGXHU8igsgTwnHEpDJuRRuouPpsfD7Xa2r2O1y
   fL+8I0AlcNa8engGoqGb3MdWChOa4AECeyp+9bLqji4t4HI/Ncx9WHr9n
   rjGiqZ9jJzDpnalQQGUxYjK23w3NhQD/8Q8vqc6rdwlP1OZ8zQyDEYFA2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380376536"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="380376536"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914477282"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914477282"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Sep 2023 04:15:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 79443919; Mon,  4 Sep 2023 14:15:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: soc.h: replace custom COUNT_ARGS() & CONCATENATE() implementations
Date:   Mon,  4 Sep 2023 14:15:24 +0300
Message-Id: <20230904111524.1740930-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom implementation of the macros from args.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/soc.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fa2337a3cf4c..509386ff5212 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_SND_SOC_H
 #define __LINUX_SND_SOC_H
 
+#include <linux/args.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
@@ -870,12 +871,8 @@ asoc_link_to_platform(struct snd_soc_dai_link *link, int n) {
 	.platforms	= platform,			\
 	.num_platforms	= ARRAY_SIZE(platform)
 
-#define SND_SOC_DAILINK_REGx(_1, _2, _3, func, ...) func
 #define SND_SOC_DAILINK_REG(...) \
-	SND_SOC_DAILINK_REGx(__VA_ARGS__,		\
-			SND_SOC_DAILINK_REG3,	\
-			SND_SOC_DAILINK_REG2,	\
-			SND_SOC_DAILINK_REG1)(__VA_ARGS__)
+	CONCATENATE(SND_SOC_DAILINK_REG, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
 #define SND_SOC_DAILINK_DEF(name, def...)		\
 	static struct snd_soc_dai_link_component name[]	= { def }
-- 
2.40.0.1.gaa8946217a0b

