Return-Path: <linux-kernel+bounces-156465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C638B0303
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676E21C2325C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F461581FC;
	Wed, 24 Apr 2024 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHE2xnfi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262D1581EC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943112; cv=none; b=WoT5LqNIeU/tRfweKTKAPzN7vEswMy46n50coWazJQEgflT+497j9mt7axpjIdXDqKADjHMcA+V1ugcL2AUyLbIFFQYzjbuUCbwDcfS9jIJCWMFvh5efDjEELZbCdXApCwIpgXEwVovlXOGWep4hQnzWf3puDsKvpvhy0p1Kg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943112; c=relaxed/simple;
	bh=qPXfMIhGVBmdKxKqFcMITWrwi1kWPDMcOy70fLaQHP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqrHYXE9A1K2POyRg733/XjysVjqx52vp7ZSmXSIa2VDMQwIJyR7gAoqnkX4Vy82OANy20TpFKEiciw5Al3NeHLaz80Cxh9EBoY3qSpfokLEczqNvkBQPLcKs7krIGNwM72n/nTRGoFOvZV5jIslgDoJOExuTPrhgxp2B12QLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHE2xnfi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943111; x=1745479111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPXfMIhGVBmdKxKqFcMITWrwi1kWPDMcOy70fLaQHP4=;
  b=hHE2xnfi1fI/S9opv7DFHCDQBBaLWX06ZQEUrUxrGqyCVLpTzDZDREGV
   86A7L8Y9HiVnyfsm3F4+emRPSHuNmeq/SU8W3BjIbBQmUM2qw3/yEqqu7
   ETwG9aZCzBKZ2aPT7/Hv/axlTa1x1G8OvJvI89X+vMv/yXrgFa9W+2Tq2
   32T6oBwXnhIM/p6GdAFSuZ8qMZKmysRT6n1eSlczcuLS5tn1VuaOouzfI
   1YreL3obAFnDz862MWmQShqPwneEsPM50oJ3wF+8xwbeeg53uc5/NPv6g
   yoB0B0L2qG3XckaZs+Hqi7McB84AWzOunW4+RdpeUD8i32VH7vbrm4Xkr
   A==;
X-CSE-ConnectionGUID: waqxyPo0TJSIx77Cz4j6CA==
X-CSE-MsgGUID: JAzQK4pnQDCgeJ5/tuCmyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073180"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073180"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:31 -0700
X-CSE-ConnectionGUID: z37Tpke0TwCq2o7Zqthsig==
X-CSE-MsgGUID: z6Let6t/TTabiMRcHbTIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665277"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] iommu/vt-d: Add trace events for cache tag interface
Date: Wed, 24 Apr 2024 15:16:35 +0800
Message-Id: <20240424071644.178250-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace events for cache tag assign/unassign/flush operations and trace
the events in the interfaces. These trace events will improve debugging
capabilities by providing detailed information about cache tag activity.
A sample of the traced messages looks like below [messages have been
stripped and wrapped to make the line short].

 cache_tag_assign: dmar9/0000:00:01.0 type iotlb did 1 pasid 9 ref 1
 cache_tag_assign: dmar9/0000:00:01.0 type devtlb did 1 pasid 9 ref 1
 cache_tag_flush_all: dmar6/0000:8a:00.0 type iotlb did 7 pasid 0 ref 1
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
        [0xeab00000-0xeab1afff] addr 0xeab00000 pages 0x20 mask 0x5
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
        [0xeab20000-0xeab31fff] addr 0xeab20000 pages 0x20 mask 0x5
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
        [0xeaa40000-0xeaa51fff] addr 0xeaa40000 pages 0x20 mask 0x5
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
        [0x98de0000-0x98de4fff] addr 0x98de0000 pages 0x8 mask 0x3
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
        [0xe9828000-0xe9828fff] addr 0xe9828000 pages 0x1 mask 0x0
 cache_tag_unassign: dmar9/0000:00:01.0 type iotlb did 1 pasid 9 ref 1
 cache_tag_unassign: dmar9/0000:00:01.0 type devtlb did 1 pasid 9 ref 1

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/trace.h | 97 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/cache.c | 10 ++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 93d96f93a89b..961ac1c1bc21 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -89,6 +89,103 @@ TRACE_EVENT(prq_report,
 				      __entry->dw1, __entry->dw2, __entry->dw3)
 	)
 );
+
+DECLARE_EVENT_CLASS(cache_tag_log,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag),
+	TP_STRUCT__entry(
+		__string(iommu, tag->iommu->name)
+		__string(dev, dev_name(tag->dev))
+		__field(u16, type)
+		__field(u16, domain_id)
+		__field(u32, pasid)
+		__field(u32, users)
+	),
+	TP_fast_assign(
+		__assign_str(iommu, tag->iommu->name);
+		__assign_str(dev, dev_name(tag->dev));
+		__entry->type = tag->type;
+		__entry->domain_id = tag->domain_id;
+		__entry->pasid = tag->pasid;
+		__entry->users = tag->users;
+	),
+	TP_printk("%s/%s type %s did %d pasid %d ref %d",
+		  __get_str(iommu), __get_str(dev),
+		  __print_symbolic(__entry->type,
+			{ CACHE_TAG_IOTLB,		"iotlb" },
+			{ CACHE_TAG_DEVTLB,		"devtlb" },
+			{ CACHE_TAG_NESTING_IOTLB,	"nesting_iotlb" },
+			{ CACHE_TAG_NESTING_DEVTLB,	"nesting_devtlb" }),
+		__entry->domain_id, __entry->pasid, __entry->users
+	)
+);
+
+DEFINE_EVENT(cache_tag_log, cache_tag_assign,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag)
+);
+
+DEFINE_EVENT(cache_tag_log, cache_tag_unassign,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag)
+);
+
+DEFINE_EVENT(cache_tag_log, cache_tag_flush_all,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag)
+);
+
+DECLARE_EVENT_CLASS(cache_tag_flush,
+	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
+		 unsigned long addr, unsigned long pages, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, pages, mask),
+	TP_STRUCT__entry(
+		__string(iommu, tag->iommu->name)
+		__string(dev, dev_name(tag->dev))
+		__field(u16, type)
+		__field(u16, domain_id)
+		__field(u32, pasid)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned long, addr)
+		__field(unsigned long, pages)
+		__field(unsigned long, mask)
+	),
+	TP_fast_assign(
+		__assign_str(iommu, tag->iommu->name);
+		__assign_str(dev, dev_name(tag->dev));
+		__entry->type = tag->type;
+		__entry->domain_id = tag->domain_id;
+		__entry->pasid = tag->pasid;
+		__entry->start = start;
+		__entry->end = end;
+		__entry->addr = addr;
+		__entry->pages = pages;
+		__entry->mask = mask;
+	),
+	TP_printk("%s %s[%d] type %s did %d [0x%lx-0x%lx] addr 0x%lx pages 0x%lx mask 0x%lx",
+		  __get_str(iommu), __get_str(dev), __entry->pasid,
+		  __print_symbolic(__entry->type,
+			{ CACHE_TAG_IOTLB,		"iotlb" },
+			{ CACHE_TAG_DEVTLB,		"devtlb" },
+			{ CACHE_TAG_NESTING_IOTLB,	"nesting_iotlb" },
+			{ CACHE_TAG_NESTING_DEVTLB,	"nesting_devtlb" }),
+		__entry->domain_id, __entry->start, __entry->end,
+		__entry->addr, __entry->pages, __entry->mask
+	)
+);
+
+DEFINE_EVENT(cache_tag_flush, cache_tag_flush_range,
+	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
+		 unsigned long addr, unsigned long pages, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, pages, mask)
+);
+
+DEFINE_EVENT(cache_tag_flush, cache_tag_flush_range_np,
+	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
+		 unsigned long addr, unsigned long pages, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, pages, mask)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 0539275a9d20..e8418cdd8331 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -17,6 +17,7 @@
 
 #include "iommu.h"
 #include "pasid.h"
+#include "trace.h"
 
 /* Check if an existing cache tag can be reused for a new association. */
 static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
@@ -69,11 +70,13 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 			temp->users++;
 			spin_unlock_irqrestore(&domain->cache_lock, flags);
 			kfree(tag);
+			trace_cache_tag_assign(temp);
 			return 0;
 		}
 	}
 	list_add_tail(&tag->node, &domain->cache_tags);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
+	trace_cache_tag_assign(tag);
 
 	return 0;
 }
@@ -91,6 +94,7 @@ static void cache_tag_unassign(struct dmar_domain *domain, u16 did,
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
 		if (cache_tage_match(tag, did, iommu, dev, pasid, type)) {
+			trace_cache_tag_unassign(tag);
 			if (--tag->users == 0) {
 				list_del(&tag->node);
 				kfree(tag);
@@ -316,6 +320,8 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
 			break;
 		}
+
+		trace_cache_tag_flush_range(tag, start, end, addr, pages, mask);
 	}
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
@@ -356,6 +362,8 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 						  IOMMU_NO_PASID, info->ats_qdep);
 			break;
 		}
+
+		trace_cache_tag_flush_all(tag);
 	}
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
@@ -404,6 +412,8 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 							 addr, mask,
 							 DMA_TLB_PSI_FLUSH);
 		}
+
+		trace_cache_tag_flush_range_np(tag, start, end, addr, pages, mask);
 	}
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
-- 
2.34.1


