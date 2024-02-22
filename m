Return-Path: <linux-kernel+bounces-76990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8585FFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403D5284FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68587158D6A;
	Thu, 22 Feb 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="SUq+1qIF"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58966155A25
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623593; cv=none; b=YtMANhqNWflKNc0+7dBCQsrfgcf5qI8GWfSMwf/SUbi1e+3ftpp43hn4cO2q+I3InwFmJuk8pTCKl1Br5MgqpTopW2BzAc/JAVeKlyiDIYrVgDUVoVxNn8d1ayxcrfoMfzk5VQWRmq/+KZEN6xfvQe0lxm9WBWICUIfat5exFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623593; c=relaxed/simple;
	bh=e5/EqNK9UpM0PQlRBjtqkQj6WaKZ0lxzfKw0E0tVZJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biuYmJnk5oxvVRSvJNW7trCRL95vTkIqFBxCPLzLFs3PQjcSlwykMpLBihpl889oUtxylc17J29FHnSmLroHTHDmBJG3LuxzV8L0KSERY65TtI88BTB2wsKb4usnlGhLXXdYZfV2IkNXh0OGJvNwlIgOUlIOwgCd7FkI5HoxOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=SUq+1qIF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-429f53f0b0bso58601501cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623588; x=1709228388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCq+3vWtONMZUCcchixRvndD69tz6ABYgm5wv9T97ic=;
        b=SUq+1qIFGJX2KSx7gOCeTyimDlKQLq0GTGlAM05sJHDPXcw4o8u9HahlDtGj6Pjqem
         xNipopXVFWGha260DWAkgbdcb6DE180aHBVXX3QbWPTLGbxd8dj1E8W/Qu4GE2PljXEl
         Ga78hJWd4yBV7F6fKSAz2NHoVt1PV5ZyP46zwD1Fz//7jbaoi4lYu4oWDyl5hNcbPqka
         NBi/scXvxTYGVPxr89quvOJL9fq8cQt5AjcebgU3uCDhFKPcbF2eijwnkNUTN+hi1/bK
         +nnypxKZUEmwrqPPbL+koZcXlt247YwPDjwHz8kld1LMuzeXGIOpezmjY9G9ovVgoxGP
         mj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623588; x=1709228388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCq+3vWtONMZUCcchixRvndD69tz6ABYgm5wv9T97ic=;
        b=OmS8FDIMgB7NgoPOjgsaQAkD4KkVLWz1ECUcbToz3+gKVofpRHVpz4fhqB5r27Sn6m
         NMJ+3918Nhh/wShdzoxn43vvuVRzPmcqVR1wuyKWY4KaDFzwXFWwuNO3VnuWK0HkK21p
         6iuU/7NZ+nA0WOkB+vKqGXGnU5c9F+XYxaM9Z3hITztHxYTrFtE51uGMYGNpyY10Q5o+
         8On3/wiBThbcY+sxKVSvY7ElsdgHRXOkxtqb9quZbD4eknjlXBlhedtFGAoQfexsjtXX
         xJsEkKLu8VDH2FnMCaz3JTm28kfdTa58hqd89o8C8/bQBPOYtQf1Xkz64N9dIZcTKOEP
         41/w==
X-Forwarded-Encrypted: i=1; AJvYcCWeyg0CG73q5IyTW6+r+75R20Uynemb89Oc5yUXp05H+3Q677JkSTRNWlYproibTUX+oYTwLXzZ/d2TZCUx7KdP+v+iY+L7CNjkfy/e
X-Gm-Message-State: AOJu0YzWpbJwKdoZDNYLsz+r0g6uJ72Gu5TCPIaoRsRFUXXlvn3klZAc
	4T2LcvJbRIfAuBLCo3D/aSCLJfE9ZsuTbVZVFQCB5o6oSRw8COVEmFWXab3jjz4=
X-Google-Smtp-Source: AGHT+IHYsjufxgrQOIaZKGAlBEgAe+E77c4mX2kxpmgTPbMZQuerhv+xRzMr0weawYHNzNvAJaqSlw==
X-Received: by 2002:ac8:7e82:0:b0:42e:5791:3531 with SMTP id w2-20020ac87e82000000b0042e57913531mr1519017qtj.22.1708623587773;
        Thu, 22 Feb 2024 09:39:47 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:47 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v5 02/11] iommu/dma: use iommu_put_pages_list() to releae freelist
Date: Thu, 22 Feb 2024 17:39:28 +0000
Message-ID: <20240222173942.1481394-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the IOMMU page tables via iommu_put_pages_list(). The page tables
were allocated via iommu_alloc_* functions in architecture specific
places, but are released in dma-iommu if the freelist is gathered during
map/unmap operations into iommu_iotlb_gather data structure.

Currently, only iommu/intel that does that.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/dma-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..fa0c4be79f9f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -32,6 +32,7 @@
 #include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
+#include "iommu-pages.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -156,7 +157,7 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		put_pages_list(&fq->entries[idx].freelist);
+		iommu_put_pages_list(&fq->entries[idx].freelist);
 		free_iova_fast(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -254,7 +255,7 @@ static void iommu_dma_free_fq_single(struct iova_fq *fq)
 	int idx;
 
 	fq_ring_for_each(idx, fq)
-		put_pages_list(&fq->entries[idx].freelist);
+		iommu_put_pages_list(&fq->entries[idx].freelist);
 	vfree(fq);
 }
 
@@ -267,7 +268,7 @@ static void iommu_dma_free_fq_percpu(struct iova_fq __percpu *percpu_fq)
 		struct iova_fq *fq = per_cpu_ptr(percpu_fq, cpu);
 
 		fq_ring_for_each(idx, fq)
-			put_pages_list(&fq->entries[idx].freelist);
+			iommu_put_pages_list(&fq->entries[idx].freelist);
 	}
 
 	free_percpu(percpu_fq);
-- 
2.44.0.rc0.258.g7320e95886-goog


