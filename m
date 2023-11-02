Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDC47DF9E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377200AbjKBS2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKBS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:28:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F01134;
        Thu,  2 Nov 2023 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698949682; x=1730485682;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hEIpF+H2iWRMoZGPvwzbL8B1g/l212Q9ts7SomwLAKg=;
  b=Umo70XexyrMZ3c36W6zxadSEbzdxHaBJWBRaQyzMY5LpArx3brJhI4Vz
   89ulkM2NI7T13qs6wTTaZR5PkIW2Plew/e3iTv4lqrSxKWnEUOBouDMGQ
   KUHzothzzHMkjrA33K0LSudcjjPFlSWBGbvtbTLB8aqyrvxbXNpc7Qt7l
   4Buwvh2/+OgrWfRIoIulHsl1CdAtQY60uC8SXC7EKduJ/+Fyr4uXFdLCH
   pmNbE8cJA9zV51TdNeiFDoTIIuSEVtBYnuFpBGGyhi8NrbHZxFz9ghUSC
   /TerfiLBw2SYcrVydayOcrNY7lnzyAXgS5551yNTy7CBjDiGmcUjJo7+R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="7421163"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="7421163"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:28:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="761359766"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="761359766"
Received: from fmahinh-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.91.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:27:59 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 02 Nov 2023 12:27:13 -0600
Subject: [PATCH v9 1/3] mm/memory_hotplug: replace an open-coded kmemdup()
 in add_memory_resource()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231102-vv-kmem_memmap-v9-1-973d6b3a8f1a@intel.com>
References: <20231102-vv-kmem_memmap-v9-0-973d6b3a8f1a@intel.com>
In-Reply-To: <20231102-vv-kmem_memmap-v9-0-973d6b3a8f1a@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=hEIpF+H2iWRMoZGPvwzbL8B1g/l212Q9ts7SomwLAKg=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKnOr/SE+M5/Pnlbz3jL1YSMg7Nu7bl+5ORtPldBhUmGz
 ROWXhW53FHKwiDGxSArpsjyd89HxmNy2/N5AhMcYeawMoEMYeDiFICJXLrIyPCL1zjxRFvOwtmm
 jQ3Wxd8WuLmzzEqWf/DYJ1tS/camoDRGhmlrip4sCDs402uF3nl5XoumU5fU++aHhK2znla0dZK
 0KhMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A review of the memmap_on_memory modifications to add_memory_resource()
revealed an instance of an open-coded kmemdup(). Replace it with
kmemdup().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f8d3e7427e32..6be7de9efa55 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1439,11 +1439,11 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
 		if (mhp_supports_memmap_on_memory(size)) {
 			mhp_altmap.free = memory_block_memmap_on_memory_pages();
-			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
+			params.altmap = kmemdup(&mhp_altmap,
+						sizeof(struct vmem_altmap),
+						GFP_KERNEL);
 			if (!params.altmap)
 				goto error;
-
-			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
 		}
 		/* fallback to not using altmap  */
 	}

-- 
2.41.0

