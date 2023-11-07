Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C47E35C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjKGHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjKGHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:23:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA4C6;
        Mon,  6 Nov 2023 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699341798; x=1730877798;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HZM5+hBI5lAioW4CqYpnGoymfhCO2XjBgbEz0jWhomc=;
  b=HiUaRcaTM7225K4ENsGwSW3zEaffQme35HJZzgfCb1m4q1piW1tkaRCP
   NhYonyDavNUxFE8e4SLwGddv9sPGKjSGCF44KVpB4I93nHVgrurZkxjoF
   WIY8G7uUOOckiGXJBha5uUFFQ1gml3X2VZoKo1n2Jqs5OV0mg8B6on+Eh
   o+88NWuDloFZcQ1uRSp5UOBaMxLX1oPmGQsnF9+oY6HzVZiAXjpNImbQ2
   iGnsR2zkV3MMSyZS9mz3eQlpA37V/LszN4Y44AZONp4Fql6UUXqQUz/R3
   28vMiEDHe3iO+WakLg2gIxbcTBIPAir/ouYhpKGhwhBqnLaOZzZZdHYjy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475689634"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475689634"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712477221"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="712477221"
Received: from pengmich-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.96.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:23:15 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 07 Nov 2023 00:22:41 -0700
Subject: [PATCH v10 1/3] mm/memory_hotplug: replace an open-coded kmemdup()
 in add_memory_resource()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-vv-kmem_memmap-v10-1-1253ec050ed0@intel.com>
References: <20231107-vv-kmem_memmap-v10-0-1253ec050ed0@intel.com>
In-Reply-To: <20231107-vv-kmem_memmap-v10-0-1253ec050ed0@intel.com>
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
        Vishal Verma <vishal.l.verma@intel.com>,
        Fan Ni <fan.ni@samsung.com>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=HZM5+hBI5lAioW4CqYpnGoymfhCO2XjBgbEz0jWhomc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKmeTx/u2KMpofzhr339p/4ulhoHJrGPXanCC7+ECHxYL
 X9h51uhjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEzk3ByG/9mrWwovZp29Ejbz
 qvedaOUILZP3Ti4Hb8oszGwJtNc+ncnwz3Bv9Z3235/C8n54lB/yKZB+U/r7tc0txUARf/dFErv
 fcwMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ab41a511e20a..3ed48059a780 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1439,13 +1439,13 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
 		if (mhp_supports_memmap_on_memory(size)) {
 			mhp_altmap.free = memory_block_memmap_on_memory_pages();
-			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
+			params.altmap = kmemdup(&mhp_altmap,
+						sizeof(struct vmem_altmap),
+						GFP_KERNEL);
 			if (!params.altmap) {
 				ret = -ENOMEM;
 				goto error;
 			}
-
-			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
 		}
 		/* fallback to not using altmap  */
 	}

-- 
2.41.0

