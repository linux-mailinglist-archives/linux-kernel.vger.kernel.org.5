Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F080FA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377812AbjLLWXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377804AbjLLWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:23:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BEA1;
        Tue, 12 Dec 2023 14:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702419817; x=1733955817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ozp3JOHCZkR8rjYbeX9k9xgnEnDFYEFFgWgRZ7ytBZk=;
  b=KSICwt3GnwIiqUgmtr/pYFf0phdUHXZ3smRgJ4nL9UjDBFMUNDhmCmmD
   2SDxQ7fKphsoE7bKvENIQlYIcf536dnMbf78/I9MKBj+LcNTWmodcj4yi
   Nwh/YFEbPxtb6eIEllAztlTSWSZvj3/9io2RD+/a+PLOsdgtylg619H2A
   QUhSUQR6LblPrNOKeA8OSyH6YAgE7FJS+ltrxtK8ZsGnwXl7XZwFkFWXu
   7/K8IEGdmn0bx9HEqPXKpofnxAb7anCrbi1ZqTILCIp1432HwLVtzG2s1
   l96z/E5G6j2w7bW4EkGtYOwRf+Phbc4XTJkpD0hFn4RDctRvg8zx7s30F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2049303"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2049303"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802631185"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="802631185"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 14:23:35 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] cacheinfo: Check for null last-level cache info
Date:   Tue, 12 Dec 2023 14:25:16 -0800
Message-Id: <20231212222519.12834-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
References: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before determining the validity of the last-level cache info, ensure that
it has been allocated. Simply checking for non-zero cache_leaves() is not
sufficient, as some architectures (e.g., Intel processors) have non-zero
cache_leaves() before allocation.

Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
This function iterates over all online CPUs. However, a CPU may have come
online recently, but its cacheinfo may not have been allocated yet.

Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Radu Rendec <rrendec@redhat.com>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Introduced this patch.

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---

The dereference of a NULL cacheinfo is not observed today because
cache_leaves(cpu) is zero until after init_cache_level() is called
(during the CPU hotplug callback). A subsequent changeset will set
the number of cache leaves earlier and the NULL-pointer dereference
will be observed.
---
 drivers/base/cacheinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f1e79263fe61..967c5cf3fb1d 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -61,6 +61,9 @@ bool last_level_cache_is_valid(unsigned int cpu)
 	if (!cache_leaves(cpu))
 		return false;
 
+	if (!per_cpu_cacheinfo(cpu))
+		return false;
+
 	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
 
 	return (llc->attributes & CACHE_ID) || !!llc->fw_token;
-- 
2.25.1

