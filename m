Return-Path: <linux-kernel+bounces-143445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4B8A3930
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459A9282A51
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F9CA40;
	Sat, 13 Apr 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="DWOaT9wU"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110A46BA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967933; cv=none; b=An3muN8YPPy0diUOGTaWH5cyfWDBxQtfouJS9/mVlixXveSkfgV9jD1v1jP2BXMD3d0YnMAe55R9xSFBhi60m7henuUKoDT/ERBaipBLc7XMt+5RFgVGp0fzb/xHscKijtdJEEuVjxsvClKS339A5evEyylU/XckU9aZ/I7U2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967933; c=relaxed/simple;
	bh=tvr+YHESVCDsvV6C8kn/Jw8FuPrm06qlyauU87/mTpU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoEMtz2k9pjflzJjQtUf6lmdKsfKOHuOzA/yNvZTBmNOeJa6AcZh0diddh0/0+IZ4/lK6pn0NKh9gKfkmbwSoV740b9ujB/kPl4/cntZhNw1IistbtRetewbwFyX4U4B+x6sU2MQQJcaD1fSj+7F8sfxND9aZhdXrXhfLollERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=DWOaT9wU; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-233e41de0caso341601fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967929; x=1713572729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/4w+T4tucdgPG/H173cldAS0HyQQ6sjlO97Kz+1k94=;
        b=DWOaT9wUjja0bmWpnZ7j1V+TuJ+B8Y9462KWdbJZWRqTajRsvxxqxjh1hPBub5q3V8
         xq3B8xt2eO/c+UuRPzddSdLZNvFH3fq8tv1QdCO1RgOXiMzA/QXvogrGG0YwsXmNlrW9
         3l2wCSNfrYG5zl/IKzkmdf2NJ9yeCijQfjqptZrz1VxGpLce+MCXgZ+i+TPl2CZRBhgQ
         xdyHqVLPvIYGq20COZkOY+jqL+Qfg6LY+r2HQFTTALmBLc5S9yObEpX5wik4YMCkxYpt
         gDbEU2K4eoD+XVZ5o7RBfMYEzxBYFPRKNtBi9IHu1GkJx3dYc4fYcBpnuZ+X31GwYz/2
         dc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967929; x=1713572729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/4w+T4tucdgPG/H173cldAS0HyQQ6sjlO97Kz+1k94=;
        b=jbz0oI31chLPkXHbAZE97bA4bxyQlsLZDXyQjnUetLq/hot35aN0GA4aJgkP4cmwv0
         EgU1vOhIjzRs6sIMTtLM83IsDhzHDDxWNnkVFe9CVhdIcAJKos2aSa7SkNpgzChYPHoc
         f97YZ+YIYChPyhJlKyLjHCqebMLOoevSQfwBApeccnR531KFFjsa9M5jEj3zTzMiGsak
         TeMINiY2rhAztgr5/Ltm5nK6fI4ZgynT9m73fHe1lPh4VzSsV/hfqYTysL/e8iTV21eX
         rLJfW6bQoPFR71KV2cf4uR9Hmckfz+RMWeK5dTYkvgYOE+6uwqXcFXry0Sjkm/l0q5Q8
         hJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaO+MEGJvP+aczhrK21bQp+gM80CudDW0sehVlW+DTgzGSotxtghKghrG1dOolJOtQINmpv4PPh9OOcukcV8mxRWbbscNsK60wqJ1y
X-Gm-Message-State: AOJu0YwVNHYfenpkaDnXu8Uy9cIi+vZrjj4pt/7Zn8Rrp+0Tev1vpeUr
	kNU1arLC5w1SpDmGsLTrf+dcOkV/LLhCmMCTIZsyFEaNz7nasdk3gqeUcRXY34k=
X-Google-Smtp-Source: AGHT+IGQ8QPk+98rhr31FfHy1KfwN56vAk+9hMwwlY09C3v6VEVpJ5zGBKiShhcihkczGu9koLGDjQ==
X-Received: by 2002:a05:6870:2254:b0:22e:8ba0:921f with SMTP id j20-20020a056870225400b0022e8ba0921fmr4264166oaf.52.1712967929611;
        Fri, 12 Apr 2024 17:25:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:28 -0700 (PDT)
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
Subject: [PATCH v6 04/11] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Sat, 13 Apr 2024 00:25:15 +0000
Message-ID: <20240413002522.1101315-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/io-pgtable-arm.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/io-pgtable-arm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..3d23b924cec1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -198,14 +199,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
 
-	if (cfg->alloc) {
+	if (cfg->alloc)
 		pages = cfg->alloc(cookie, size, gfp);
-	} else {
-		struct page *p;
-
-		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
-		pages = p ? page_address(p) : NULL;
-	}
+	else
+		pages = iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
 
 	if (!pages)
 		return NULL;
@@ -233,7 +230,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
 	else
-		free_pages((unsigned long)pages, order);
+		iommu_free_pages(pages, order);
 
 	return NULL;
 }
@@ -249,7 +246,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
 	else
-		free_pages((unsigned long)pages, get_order(size));
+		iommu_free_pages(pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-- 
2.44.0.683.g7961c838ac-goog


