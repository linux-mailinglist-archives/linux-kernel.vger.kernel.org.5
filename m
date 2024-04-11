Return-Path: <linux-kernel+bounces-139640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0EE8A05A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923E81C22865
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EA26215F;
	Thu, 11 Apr 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRapF9GF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43C60EC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800018; cv=none; b=kymiFXJpgKT0Uk3IKTyo3l2I4ZbSjnYCCuIKPXaQqJpR2lwTJKv2AQIqWS0fmc7X8ss7DsPPBo5BqODaXx77GNbqAtFDyuDybvipMHV1+XFzSmRjWHq8ZJhn4PrR7axNTep8t/WqHdT2NupFFNkSZDCCY6ZLhN7PgNUZ44/uGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800018; c=relaxed/simple;
	bh=BFo3JVFEHL1mrx8xnMU9B1mY4rA+IblCBl9UOAIhXhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+SkLp2FDZGZRJUCEmt818Zx1/uRyPiABXsIGdOs0FARwpjINBNgUmzwqjgOyo+/0NQk5RyNVZk2R90+RVmJ7AYnCoFZ2qa/Qsldzb2rNSF02d9At31xaINoBWx0NtRhEAoVxMpW9SHBLlQVzuE670rAFoUJo2XOdIVMexJdHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRapF9GF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed267f2936so3216512b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712800016; x=1713404816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBkc5xYVwMKEG/SI/x9eG7MtNlDql2BuiF4/x6PZqbY=;
        b=HRapF9GFCD512HtI02QWKUY7wZy7a60efadnDSxWJ4unAcrFaJfQG6E4R8/DD8FEnF
         goB1Qa050adK9VMfJh262jhDZZKopBZckN65qQbdNjaRcZ+Exz+pP8Dqq3Hrp26HD+rV
         1fZ79S3wTHpWY0dPrwNEr73NpIrhh9fjxXhiGVkezsAk49wlpJ8Omq2ZTjem3l1/hcRr
         P3YExJkiFlb6Owjv84sSMbeSHc1xw9jh1KUk1gWhysvfwblUFPiYqHQy/+b3N4FYnv1c
         mJTD33XzjNFAU4Id/kfJjjx5SV+MlZChQdcis84fm8Lcw/Q+EsXVrdWFiwWmVolGl0ng
         pPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712800016; x=1713404816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBkc5xYVwMKEG/SI/x9eG7MtNlDql2BuiF4/x6PZqbY=;
        b=h7f/ujKpgvrDR4Xs2s7LNDtPYSMCZWaeRLvGrf6WcgbLFgyh6XyqvPu3Zm3gT37V68
         DGyFUbxDW/4yeGby6ATQpycNmC8ISctjROgLpRC4vPm4NXzJPW486x5tnauJPpS529jO
         uxsQEXt7SMNlMy53IEfZNGBTk3P5+nkiI6sgBLtq6AWBfp1ZyaxStYu9qppmV/cT0bxZ
         3vvG0QgitsAOhBtJOIviCvdCKfyixnytTdXo7vTN8h0r1xUpglguqViLBI4reUsej7em
         ZlRRF4CxS2MJrECwvAWP+gpE0zIYPd5TTWtFNrY20gmDOyG1e/7Zk70IIm42q0bnG9OS
         /TRA==
X-Forwarded-Encrypted: i=1; AJvYcCU7q4f9aUm8xLmzj48p+FdavTgjfWLoz7gmwC76PKRtBF6HFZHE3TzjmH1ZRfNJuOp8eswreFVRjLlXW22VvVcX2lYLR3xTJkRQ9Stx
X-Gm-Message-State: AOJu0YzfJHsHwbzguWRtW3yCDmk3N3c7S5H1cgJgeKdaV/1tl9GgN8XC
	Hx5nI0lgjVP7z3aj0ME0fDs9UiQXwwnBX/cxLA6fHM+9T8jM3SMN
X-Google-Smtp-Source: AGHT+IEEmEz02QQP8SKCrvx6IzhdE10K7XIaKIEQQio2L3lnH2XboM4Zvu+Ae/3Xc0aAJOJYwyO8Pw==
X-Received: by 2002:a05:6a00:2d8f:b0:6ed:416d:e9a with SMTP id fb15-20020a056a002d8f00b006ed416d0e9amr4359419pfb.7.1712800016324;
        Wed, 10 Apr 2024 18:46:56 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id j16-20020a62b610000000b006ecceed26bfsm294724pff.219.2024.04.10.18.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:46:55 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: sj@kernel.org
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
Date: Thu, 11 Apr 2024 13:46:36 +1200
Message-Id: <20240411014636.14023-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410231538.131175-1-sj@kernel.org>
References: <20240410231538.131175-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
>>  	}
>> 
> From the latest mm-unstable tree, I get below kunit build failure and
> 'git bisect' points this patch.
> 
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>     [16:07:40] Configuring KUnit Kernel ...
>     [16:07:40] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=um O=../kunit.out/ olddefconfig
>     Building with:
>     $ make ARCH=um O=../kunit.out/ --jobs=36
>     ERROR:root:.../mm/memory.c: In function ‘do_swap_page’:
>     .../mm/memory.c:4169:17: error: implicit declaration of function ‘count_mthp_stat’ [-Werror=implicit-function-declaration]
>      4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
>           |                 ^~~~~~~~~~~~~~~
>     .../mm/memory.c:4169:53: error: ‘MTHP_STAT_ANON_SWPIN_REFAULT’ undeclared (first use in this function)
>      4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
>           |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     .../mm/memory.c:4169:53: note: each undeclared identifier is reported only once for each function it appears in
>     cc1: some warnings being treated as errors
> 
> My kunit build config doesn't have CONFIG_TRANSPARE_HUGEPAGE.  Maybe that's the
> reason and this patch, or the patch that introduced the function and the enum
> need to take care of the case?

Hi SeongJae,
Thanks very much, can you check if the below fix the build? If yes, I will
include this fix while sending v3.

Subject: [PATCH] mm: fix build errors on CONFIG_TRANSPARENT_HUGEPAGE=N

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index acc023795a4d..1d587d1eb432 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4142,6 +4142,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* We hit large folios in swapcache */
 	if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio)) {
 		int nr = folio_nr_pages(folio);
@@ -4171,6 +4172,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 check_pte:
+#endif
 	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;
 
-- 
2.34.1


