Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBA7B2ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjI2JDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2JDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:03:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E31B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695978191; x=1727514191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JtSNJh/6iFRzjvSsEmFDTl3PNN/JVLrNJbMF8kuGwZk=;
  b=jaQ1hdGO0nSLmwTH3Awme9rjBJRecao/hBMiauauGcSDRufdrMHl3h9A
   qOvkN+VEuL9tLnjAQ4BPlTvsp1yl1B9wCF60xNi0mMvWU3vyUhoVR/JsT
   SZrUXOJB1oqyFdWxKFfLNH/6nbH4+yfV9+rzL2LSXtpBj35oznaVgFmkd
   f8oPnBWn6wys5i28/BE6hBYz1ecp3dABnPxVoYRMzIYcG5oWh6a5W37e0
   9vkD5Apwl4EfhQWK/mMkyc+WbmG2G65RRc41+glEUNl88eNDZIqPyBUeF
   ceGZbKNqfUGsQnrhVzPKu4+EQdILV7fWYuujVQ//3pzFIKAMioaeUlbKf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="385078591"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="385078591"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749904545"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="749904545"
Received: from tzebrows-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.26.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:03:03 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Newman <peternewman@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] x86/resctrl: Add sparse_masks file in info
Date:   Fri, 29 Sep 2023 11:02:17 +0200
Message-ID: <46d7aa4948b4e669d35dc5b2b0b6b0167ec9c8d7.1695977733.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Add the interface in resctrl FS to show if sparse cache allocation
bit masks are supported on the platform. Reading the file returns
either a "1" if non-contiguous 1s are supported and "0" otherwise.
The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
{resource} can be either "L2" or "L3".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Add Peter's tested-by and reviewed-by tags.
- Reword patch message slightly. (Reinette)

Changelog v2:
- Change bitmap naming convention to bit mask. (Reinette)
- Change file name to "sparse_masks". (Reinette)

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..945801898a4d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -895,6 +895,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
+					struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+
+	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
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
+		.seq_show	= rdt_has_sparse_bitmasks_show,
+		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
 
 };
 
-- 
2.42.0

