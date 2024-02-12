Return-Path: <linux-kernel+bounces-62422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06D852049
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9107F286B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C255C32;
	Mon, 12 Feb 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvRlxHiF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993054FB8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774010; cv=none; b=pGNbCabccXshm/xdsJVZxKzGtrL/NDXrmdH44oi6OZAisKh3ZFF2ILGzFY1SKCIuRi6McTeqhnHr+JuHRNl4clFQ5zDUprQmfY0COlkhQSGDWWqgQbOXZFy/Oc2vExoPaoWWet25Zq1YIkXGABTcwv9l+8/XBLbC7ZtWhiQixvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774010; c=relaxed/simple;
	bh=WU1Yd9/gqCbsh2b9xBYcpCwZaKdATTDllI8Tygx0va0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hfWkE6G9CYMW7p9l9ijA3RyQb29kNugn7UCw0N99+GqtNFuWO1ffPyZDAxChznruVEZ48REjynr4XSzzyljJpW6uE0+4J1uK/RzipSmVeE82a9JdYYZe4h2TTO4cHkr53/QR9BD/FFC+fRb+Zji2JQu5HoJfpFfWiXBd0Tf4K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvRlxHiF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077ca6e1e1so4680107b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774007; x=1708378807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyt+GmM2eMHRRKEe8/8uFf8EZSlg2sZI9NA/PbSxBWI=;
        b=DvRlxHiF587qX6HoKtQvW/pudyQIDSDzUvqlNsAytsy5ctav0atDoxEAr7WhjygAur
         0eFQdqvrkgWk8dOWqlp5x6TF5mUHzT6X4xsJQK7eTTg64QEed5gj+N+PI/5LhqKm2Scu
         xnRNyTTbPlRQXWwnNf7N1J8UoBYGFQR7ZbEw1y6R74SXCUpnhW4vr8MBWDAiwh83SqM/
         I+PxrOHHhKuymyI0cjXtC0XyjKDjNM377M1tJiShWCupwgt/JIyoZsQ5IqsmdoB0Sgh5
         6CaBljCSck3ZXWhujhxwIPLjFfaJLJqj8RdWVb9pV/gmFIyudCQG2OpWv5d8797vBtml
         Mpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774007; x=1708378807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyt+GmM2eMHRRKEe8/8uFf8EZSlg2sZI9NA/PbSxBWI=;
        b=Uxx1EuSvjdomeKW0PaN7nHxqwb9DgOinS6q6kfYLt3BKbC/8lslBi/EYCC6s/GNBjv
         46KudjaygTYERTgrX5UdSqeMG60Kf0n8AryHmDwlhcgi1LMT7NwyyGwaj9VHvumZkIku
         hOx/hG0hiXT5Lk28hTsqS8iIVD0jxo3sahxWH+uKKCzM71je/d3AF8g5b/eZEVi0aW8m
         z9UaQYL8ggxVQpQGOHazEiUwToHtqqBS3/mDO4QnDjuMpZsyGr8OYXRuUAAL1yY/YbAY
         o+rMV23EQJhI6eBVo6iu0K24bx9iJ6JtUum3rqIHa9FCLft6voBSm+UNjaDYmeGZcBgh
         dPXA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcbyM3LBQ+GC9oPFU9UsT5iQLr/f/uubJx4d4u0mi8wmsTfmf1/+h8mv3bbWKpLTSLO6ae9Kso8Q1y7UhTOf8X86Sy62+R36pa6wr
X-Gm-Message-State: AOJu0Yw/ZBokjzxro/6PR5vSU9ppPP6/U3HKYslEwRTSh2CM4qk9cJKg
	7emlCw46oS0GvJYTnlY70E+KUDZWByhL4QgG1VbdPq74uZ17uEb022Igtxe6MyESoICphKtUSLY
	/RQ==
X-Google-Smtp-Source: AGHT+IFq2nZiWlkvaCq5BbxuMd0rU4hXzsPUeXzg8XtldG/VPRi/VWxJUnymRdhbS2wacAZbpAHHkokQ9sA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a81:848a:0:b0:604:49a1:8da0 with SMTP id
 u132-20020a81848a000000b0060449a18da0mr1393758ywf.8.1707774007616; Mon, 12
 Feb 2024 13:40:07 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:02 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-17-surenb@google.com>
Subject: [PATCH v3 16/35] change alloc_pages name in dma_map_ops to avoid name conflicts
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After redefining alloc_pages, all uses of that name are being replaced.
Change the conflicting names to prevent preprocessor from replacing them
when it's not intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/alpha/kernel/pci_iommu.c           | 2 +-
 arch/mips/jazz/jazzdma.c                | 2 +-
 arch/powerpc/kernel/dma-iommu.c         | 2 +-
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 arch/powerpc/platforms/pseries/vio.c    | 2 +-
 arch/x86/kernel/amd_gart_64.c           | 2 +-
 drivers/iommu/dma-iommu.c               | 2 +-
 drivers/parisc/ccio-dma.c               | 2 +-
 drivers/parisc/sba_iommu.c              | 2 +-
 drivers/xen/grant-dma-ops.c             | 2 +-
 drivers/xen/swiotlb-xen.c               | 2 +-
 include/linux/dma-map-ops.h             | 2 +-
 kernel/dma/mapping.c                    | 4 ++--
 13 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index c81183935e97..7fcf3e9b7103 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -929,7 +929,7 @@ const struct dma_map_ops alpha_pci_ops = {
 	.dma_supported		= alpha_pci_supported,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 };
 EXPORT_SYMBOL(alpha_pci_ops);
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index eabddb89d221..c97b089b9902 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -617,7 +617,7 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 };
 EXPORT_SYMBOL(jazz_dma_ops);
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 8920862ffd79..f0ae39e77e37 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -216,6 +216,6 @@ const struct dma_map_ops dma_iommu_ops = {
 	.get_required_mask	= dma_iommu_get_required_mask,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 };
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index d6b5f5ecd515..56dc6b29a3e7 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -695,7 +695,7 @@ static const struct dma_map_ops ps3_sb_dma_ops = {
 	.unmap_page = ps3_unmap_page,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
 
@@ -709,7 +709,7 @@ static const struct dma_map_ops ps3_ioc0_dma_ops = {
 	.unmap_page = ps3_unmap_page,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 2dc9cbc4bcd8..0c90fc4c3796 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -611,7 +611,7 @@ static const struct dma_map_ops vio_dma_mapping_ops = {
 	.get_required_mask = dma_iommu_get_required_mask,
 	.mmap		   = dma_common_mmap,
 	.get_sgtable	   = dma_common_get_sgtable,
-	.alloc_pages	   = dma_common_alloc_pages,
+	.alloc_pages_op	   = dma_common_alloc_pages,
 	.free_pages	   = dma_common_free_pages,
 };
 
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 2ae98f754e59..c884deca839b 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_ops = {
 	.get_sgtable			= dma_common_get_sgtable,
 	.dma_supported			= dma_direct_supported,
 	.get_required_mask		= dma_direct_get_required_mask,
-	.alloc_pages			= dma_direct_alloc_pages,
+	.alloc_pages_op			= dma_direct_alloc_pages,
 	.free_pages			= dma_direct_free_pages,
 };
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..8a1f7f5d1bca 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1710,7 +1710,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
 	.free_noncontiguous	= iommu_dma_free_noncontiguous,
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 9ce0d20a6c58..feef537257d0 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1022,7 +1022,7 @@ static const struct dma_map_ops ccio_ops = {
 	.map_sg =		ccio_map_sg,
 	.unmap_sg =		ccio_unmap_sg,
 	.get_sgtable =		dma_common_get_sgtable,
-	.alloc_pages =		dma_common_alloc_pages,
+	.alloc_pages_op =	dma_common_alloc_pages,
 	.free_pages =		dma_common_free_pages,
 };
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 784037837f65..fc3863c09f83 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1090,7 +1090,7 @@ static const struct dma_map_ops sba_ops = {
 	.map_sg =		sba_map_sg,
 	.unmap_sg =		sba_unmap_sg,
 	.get_sgtable =		dma_common_get_sgtable,
-	.alloc_pages =		dma_common_alloc_pages,
+	.alloc_pages_op =	dma_common_alloc_pages,
 	.free_pages =		dma_common_free_pages,
 };
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 76f6f26265a3..29257d2639db 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -282,7 +282,7 @@ static int xen_grant_dma_supported(struct device *dev, u64 mask)
 static const struct dma_map_ops xen_grant_dma_ops = {
 	.alloc = xen_grant_dma_alloc,
 	.free = xen_grant_dma_free,
-	.alloc_pages = xen_grant_dma_alloc_pages,
+	.alloc_pages_op = xen_grant_dma_alloc_pages,
 	.free_pages = xen_grant_dma_free_pages,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0e6c6c25d154..1c4ef5111651 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -403,7 +403,7 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.dma_supported = xen_swiotlb_dma_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 	.max_mapping_size = swiotlb_max_mapping_size,
 };
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..9ee319851b5f 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -29,7 +29,7 @@ struct dma_map_ops {
 			unsigned long attrs);
 	void (*free)(struct device *dev, size_t size, void *vaddr,
 			dma_addr_t dma_handle, unsigned long attrs);
-	struct page *(*alloc_pages)(struct device *dev, size_t size,
+	struct page *(*alloc_pages_op)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, enum dma_data_direction dir,
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..5e2d51e1cdf6 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -570,9 +570,9 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	if (dma_alloc_direct(dev, ops))
 		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
-	if (!ops->alloc_pages)
+	if (!ops->alloc_pages_op)
 		return NULL;
-	return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
+	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
 }
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
-- 
2.43.0.687.g38aa6559b0-goog


