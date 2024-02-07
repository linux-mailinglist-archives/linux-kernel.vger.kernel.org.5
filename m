Return-Path: <linux-kernel+bounces-56835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A184CFF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764361F21227
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727098563B;
	Wed,  7 Feb 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="K1ytdu0P"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08E83CA1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327674; cv=none; b=lbccVEygoiy4g3rn/LjvFuj3wSLhmrgQiJV+zOA0/o1iIKW3ylwMTp+zvJP3/u6s3yDKz+wvJ3t98do1FWbEGqSYlAumd6+eIumJEV592asGnzhbK6Pi0XzzFwieGVyygNs00y/5lpgT+A2JZ44sHPpSegCoNq74cYKVd9YlQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327674; c=relaxed/simple;
	bh=Zec+oC0sSzYmmKG72i4DD9eirVjLgY52/x/asRLZ6zg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoghAlJCSE7WksaywceVjzD7VR9gTc7QJygqk/JxHcJoXnkWuZPe7A3J2anHX4pujpjzfDWst61M7lV0s85x+4Q7Zm0zIzKNrRO9lDWBLEOoXNyLK74NYxaLcasBWcaCsvEjN4vmKXSG1gp/vvx8PpmmvDKkrgoN9g5DAaON0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=K1ytdu0P reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783f27300b1so40594385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327670; x=1707932470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JA+g9MenvDAdiHbGDRChMbxLGZk1W2zcwaqv2KKBmE=;
        b=K1ytdu0Pj1IRCDEzuUdweANcKDzfdqGBvR3eaUXgRy3o7UG9pJqkg//CBT8IOMAA43
         FAIyxLi4UqNxnktTetVX+JPpn92FhICBWk9W21ssX4XQLDpMtLVlfPKSGwbFUH7fxX7w
         ti60lkLVIScqapwhSoMoLANVv93Y01r5zlLTjJ+Jic/za1WeVOFDUUwJTcl18cmq4G+k
         r2yi2lZe6lG+zDYe8wilHTc+lFn4zIZDiimRvI8ASIOn0a1rCjmNrgbCYJPN2LXt7aRX
         AaDQjv/+Z+7hnI44aMtKF/9tx4j0k4tCm2WLi/8E4dPKc786cIaSV6Ng+9/Li2gnTnTf
         ZBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327670; x=1707932470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JA+g9MenvDAdiHbGDRChMbxLGZk1W2zcwaqv2KKBmE=;
        b=gRjpbYvnyPcz/kH8WjvTz8pDcx+tBIgiSPUT+5sKaMwhaKJQEqLodU3g6QRf1l8FJp
         yZ06fr8J2L7M1fxUSQbv8szsmzrwBVBkJ02s75CB4HOjL1QtwM417Hv+/IXC2825uem1
         pOYIaElD8x1sK3w4w9x8kf+kE2eZEDGtagfSUw/IBndMBGyVNFZB2QwOGEaLbYStk7cp
         15ssPC1FpgQYTgvd6+kQ0BL9s7GQzoeKA2TpiM8gVN45VlCmzvm1XrqtVzVmrFcOmKpj
         ZFmIuBFx48ApWEadtp4E++kuhdK1Yo2VJLVzAbCiFzECiKaKeezcLq6ZGlBUajnN2Ijs
         Hu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzgl+Fr1i0JCqrsar4jKtDOfrNnqlMv8nIVOIUbkDJg9u+AroeK0H1S0FzqgSrZ2RGNMcul6G1L2ab8FJb/cPsTmeQn6O8K4U+eseF
X-Gm-Message-State: AOJu0Yz1E/iW3bD3g65vmA5GGfCpSEPPqxolW/XJw4FpDBfnZPRcpsuo
	bcRAVQkL2ol7qdk3gkNrYLVRHeA75ppLIJyHjR49WZ0G75vrfOSPojQ5kSO0RD8=
X-Google-Smtp-Source: AGHT+IElGFXh4B0vtRDxKd8uklPl89u5PGWF33uvo1vT3Tprks3bAAOetfH+2TcFICeRh6m1eJF/jA==
X-Received: by 2002:a05:620a:4393:b0:785:98ab:8898 with SMTP id a19-20020a05620a439300b0078598ab8898mr3650487qkp.18.1707327670170;
        Wed, 07 Feb 2024 09:41:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnOhFQK//OwjZNKUHINcQcq4GudU6s8Wsutjl75lKOf6D9RWh4FLHgsOUIKofDqbNFRfWgV/NHq4wMqswC5boWbx8uBB3eLjdPPJEDG+JpokbKJ24prVlsZCvz1bJ8lArrWCc2ovwEGlsvxtG2iwKNu+/Trrg2V6q2NVi2AnFBisRh30T4uHYT71AYbFR4RAaBrB9DJfu9gBgqW67xCIrBebLJHhdBt6iemjDFphM1ze+qyCJ3SfW7rnvQ5VN6LILBv5D3M7D7p6BESzx5yvv9tZ5MPENSw4Yf9hiA8/mM0hyJirPFR3Xlk2WeN4BnK0oM+unwGSpufCd27SfWadz7626HL/nyFqCDcbVwRo8suAZcfP7aVH3ftKhXi6Q8gEh19xp+lm04M8pJOSbegy3UzRzuOw3uqCPHO7d8Ej+iytbJKsDI2UXVT9eAbbYyddf8AnjZLxS1cT8BWSLa6QB/OJDMNI7YrAQ3ZRoUeEb7ZtVTnV0VjJOOJ6Q7tLPMt8I93o5ADXBUFTOS9Z9dIxPsD7pylm5o6N1CCII9ENXJ6rarWAvN+lCwGz8ANG5TOcZPgc2iBQK9wElVV3Q0nKQCa4keQlJZlBGxROG/lIjqXc8OZkfJELUKKlOCYFqJwdG3iUsNbOyS5cfUAg2cD9YpKt2ZAVtvZ9RW1/CCho7S2eD9vihzafV7l7B+GY27RkKonMQEbqUHIdBr25L/ZVWDF/B20M96ndDH/iNnjt1cg/U80ydG5MX4tEA4YoPWEnJkF4/BKzDpEGuIWseeppB1JFzf4HUfSuRm/JSL/kw+l0fYUTI1X4A5KLT8AAhJEptMUaFu18pKAwXNBHVI4MJTHWXC6vB/NP8WjoxON8R4WP1Ffpw01ZL8E75NGkzZcgJmptCJQrPFWgJ/dJ8JHS5Rh+kHTNTYJL6Scxh+h3vshyVNyKXHTwab2M6eST2kOzCUNQ
 +Zy4XD7JcdygwKNsFqhHYU9f4qLik9Wt+jJXdBCmW00mbGJQLSbt3auPkpzgZCWxdDiUkyWmSy2erf5ZmNoCCvTODBILMexUleg+8Zh/lUkX0mcQ2a3MEsLeys6KUqvNvWS18JlWOiJw7TALOzXDz3BxJS9qCWzgIT7MpIfbZLqPPjvO1RwhcvaMoGpFJABn52u1L64O87/jK116UWlhgXqQ0Xvme+jQrcJnwQxdgnLFl1NuOU9EBjTG0MLF2Zs9CkGuzI9VfaEAw6FFDPBRx/3kRTFC+HLR/teJ9sN6aRXkgugBq3eJQbqTGhWa6RM01Mqk6tgSJO978N5R3lGHqQkt5pjjpX5hqYiMYIyWldRmjRI1ZqkL3m60FfU2mFBF+CA91okBT0Jdtj/YeL/cJRGUvYR6Uqz6L3ShLyC2UepAwEUE9xgfVRs8EEJx2MJn6QdFO8I493pkNddkbzt8GpT4eFRrro01q41ZILmvRYLx0l
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:09 -0800 (PST)
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
Subject: [PATCH v4 03/10] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Wed,  7 Feb 2024 17:40:55 +0000
Message-ID: <20240207174102.1486130-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
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
2.43.0.594.gd9cf4e227d-goog


