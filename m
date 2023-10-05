Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B27B9FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjJEOb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjJEO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A31BD8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513800; x=1728049800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RsEbDDQE5OYZlZy6VBAukZsVljHVFXdnty31uYM0gh0=;
  b=ByEtnrW5zzrBBsyY/z9L0ZlGTgPCSrIE3GyP9YUAvLks0Jt3kAECq5id
   WB2YdY6LVIUsCrMXwnKJKzyTjduHDfgPHQxE5EiedJLvLIFjR9wyHv+jd
   HcAS1lGpBd5noe0q4BEGs+or9ZMhfPQnZ3xFxUbDwk8Jqg+I6CvVokA3u
   B20ePqOUbPQvWkZPVqRRnodsZ+uGmIY5WS96RJ2VILkVe4S68w50B9pzJ
   Ao2+u2tjd+2HiQbZBl43SAFW0zyftJtUNcBGjH2nch/653FK9eZnyFMns
   aKgpElqpSA05U081/19/MvT68TlXRe/uWGBwVOQ9Dd/LDDOBy5WDkBp03
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383339446"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="383339446"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="875477034"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="875477034"
Received: from lpopiela-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.13.229])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:16:18 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Newman <peternewman@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] x86/resctrl: Add sparse_masks file in info
Date:   Thu,  5 Oct 2023 10:15:38 +0200
Message-ID: <684da427338d68b216c1f5636a4930bba06f7b60.1696493034.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
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
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v4:
- Add Ilpo's reviewed-by tag.
- Add Reinette's reviewed-by tag.

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

