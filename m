Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30047BCD26
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjJHIF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:05:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC59C5;
        Sun,  8 Oct 2023 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696752353; x=1728288353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SNNpZq9DeJkCOqcsWszbC19a6ENGnr7eTy1pzxaaE98=;
  b=g7I8NfMYDBbLtuFdc43hckw4fRiOablrAPEZ8hyyX2fNfJSIoBSaK7Hi
   /PzNvkhxePjq1/G48qhthTQt/bfgcdrZYot7JBiLyItENSLZoCvdblyyP
   rwzafGPg0n+IKj0rNvK2vWxes7vb+1Cty0aJEjuaMlitxctglD9qNEkGS
   4OE4SC1pHDyHfnU1g66+Ggr4Gtnv+CEb8blwRajfI4vhVijJoAWPeGHAV
   3KZTu5sQHPSEf1408OQLY8tQvapEL1WiExxMBsDHFmdczBhX4LfjOkuxg
   R2oO8gadBK394prlLv5r+8XWPS17GmiQHckgLcYi0dZiBxQu+2S0P59zZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="383864087"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="383864087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="876474855"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="876474855"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:05:50 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Lili Li <lili.li@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] EDAC/device: Fix potential slab-use-after-free
Date:   Sun,  8 Oct 2023 16:02:30 +0800
Message-Id: <20231008080231.51917-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
References: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lili Li <lili.li@intel.com>

If the EDAC driver invokes edac_device_alloc_ctl_info() with pvt_sz=0,
the EDAC driver itself may manage 'pvt_info' and the EDAC core shouldn't
kfree it when unloading the EDAC driver. Otherwise it may lead to a
slab-use-after-free bug. Fix the potential bug by adding a flag to indicate
whether 'pvt_info' is managed by the EDAC core. The EDAC core will only
kfree 'pvt_info' when the flag is set to true.

Fixes: 9fb9ce392aae ("EDAC/device: Get rid of the silly one-shot memory allocation in edac_device_alloc_ctl_info()")
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
---
 drivers/edac/edac_device.c | 1 +
 drivers/edac/edac_device.h | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 0689e1510721..b990431df2eb 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -100,6 +100,7 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 			goto free;
 
 		dev_ctl->pvt_info = pvt;
+		dev_ctl->pvt_managed_by_edac_core = true;
 	}
 
 	dev_ctl->dev_idx	= device_index;
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 3f44e6b9d387..cc6a364a4b83 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -197,6 +197,11 @@ struct edac_device_ctl_info {
 	const char *dev_name;	/* pci/platform/etc... name */
 
 	void *pvt_info;		/* pointer to 'private driver' info */
+	/*
+	 * Indicate whether the resource pointed by pvt_info is managed by
+	 * the EDAC core.
+	 */
+	bool pvt_managed_by_edac_core;
 
 	unsigned long start_time;	/* edac_device load start time (jiffies) */
 
@@ -355,7 +360,8 @@ extern const char *edac_layer_name[];
 static inline void __edac_device_free_ctl_info(struct edac_device_ctl_info *ci)
 {
 	if (ci) {
-		kfree(ci->pvt_info);
+		if (ci->pvt_managed_by_edac_core)
+			kfree(ci->pvt_info);
 		kfree(ci->attribs);
 		kfree(ci->blocks);
 		kfree(ci->instances);
-- 
2.17.1

