Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0478FA50
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbjIAI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348664AbjIAI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:56:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF910D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558602; x=1725094602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/D8+l4Mqu2fxn77jMbYJEecLUZHRiY1giSI4dGMx40=;
  b=hkMnpF1bxm+6CDykFT4GknxZ7yXJ3mGSPS3v/1X2Gjrk7JNESAmTUw5S
   BN9jXqdZuIirz8GytIybI78jEIE3wyrnL97NvFI1ffUIc/+0OSPlQoYoe
   LkVkHwYID1KDfwy8p9mHLXykaubSziKVsFBAAC+IStbr3Poe++Ua4dQ9g
   fnGBHXjYXM2r2qdPGKZcYfuvWeAf6txQi1Y/H1XWHzGrnTThzra8dNyPu
   /NKbvYlsb3nus+TUb+jQJTUKACeCxKnlIIsuuiyHrMj/F2jJ3pv3WLq4L
   XC4lgf/SuCfG7bGBQcGaAoQD00R6v5d8ukIa1mWUIDVdUphlSWkA8HEsz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440151908"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440151908"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769133618"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="769133618"
Received: from akoczor-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.14.236])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:56:38 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/resctrl: Add sparse_bitmaps file in info
Date:   Fri,  1 Sep 2023 10:55:38 +0200
Message-ID: <27fc083358bc215676354818ad5a7abebd00e332.1693557919.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Add the interface in resctrl FS to show if sparse CAT bitmaps are
supported on the platform. Reading the file returns either a "1" if
non-contiguous 1s are supported and "0" otherwise. The file path is
/sys/fs/resctrl/info/{resource}/sparse_bitmaps, where {resource} can be
either "L2" or "L3" depending on their support in the CAT feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..4d27354f3f30 100644
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
+		.name		= "sparse_bitmaps",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_has_sparse_bitmaps_show,
+		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
 
 };
 
-- 
2.42.0

