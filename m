Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F507AAD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjIVItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjIVItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:49:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883BCF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695372551; x=1726908551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDKvI3tJnXXkmkhZ0zOyHlDa9Po0UfxOxHzEmvHSAtw=;
  b=d3EZUqbLgTbofp7NpOi7VLDrjmxBopVdD0JVRpN3MJAAVdCjfq3EVJaX
   uxTKScVc+a59MbM/aRyVR9vuFuRNT65g7RAfXCpsNq2OTzIoJGHefmc9f
   pDMwD+7HCkdl2n/BPOS7M0CGF1Tmz1hM+43W+uNmjRCCMmaxtJuGT0QF5
   fDLsQ21go8aYQ5nnpEPvMNUxzIgB84eieSQU0TWYqNRAA0e3tKtbj16fq
   RVqZUnilbpzPD4mF7JionBbIjTpf/OwWVQzzc1AkfHvF16R2RYCkHDAuK
   q6r9IAVNQXeifHyOgbKwiK69A5trN6pdvmTjuhUIuWBG8Gp9J2j8gWYi4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383524473"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383524473"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="750769505"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750769505"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:49:07 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] x86/resctrl: Add sparse_masks file in info
Date:   Fri, 22 Sep 2023 10:48:24 +0200
Message-ID: <3b7f8c61f0f443e303bc9c5075566b89ffdebe7f.1695371055.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Fenghua Yu <fenghua.yu@intel.com>

Add the interface in resctrl FS to show if sparse cache allocations
bit masks are supported on the platform. Reading the file returns
either a "1" if non-contiguous 1s are supported and "0" otherwise.
The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
{resource} can be either "L2" or "L3".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Change bitmap naming convention to bit mask. (Reinette)
- Change file name to "sparse_masks". (Reinette)

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..5383169ff982 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -895,6 +895,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_has_sparse_bitmaps_show(struct kernfs_open_file *of,
+				       struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+
+	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmaps);
+
+	return 0;
+}
+
 /**
  * rdt_bit_usage_show - Display current usage of resources
  *
@@ -1839,6 +1850,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_size_show,
 		.fflags		= RF_CTRL_BASE,
 	},
+	{
+		.name		= "sparse_masks",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_has_sparse_bitmaps_show,
+		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
 
 };
 
-- 
2.42.0

