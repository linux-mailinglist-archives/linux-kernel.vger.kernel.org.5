Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0135E7F98F3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjK0Fyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Fya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:54:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CB131
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:54:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso3756357b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701064475; x=1701669275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOXILmKXZldhKWQnQlWNCBsYfucE8pgkM3z8uK/DEzw=;
        b=NqbYI2bUVmAHejc3pCQ0T1pHUpj9DBHrNj0TxeCzBrWT23HvYWVdohbg9AG/2hfkoV
         azuvGeWJtmFxZwxpmAmczuMTAwl/gqq7L6h+uUtYTrRK0CnwWNB/DAApr1/fQatF5BqZ
         bRppd+vksl3ItA7lYrRkVK/wncStqPXhdahgmn/tEMVZo4DEP7Dc4xmL+Bbo70KhT4kK
         V7UsTFbEGKCZ6dSlA5sU1xRC7Nkm6X6vO7jvEklkfDLTPb5ZXL2GJoTHjA6OCVkiQdvY
         yjxhmYUYE11owxBiR1Ttx8bR0HwFxVQtBf9CGkqrcCxG2F1gjXbjbG5isD0lLO+jJbhf
         5IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701064475; x=1701669275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOXILmKXZldhKWQnQlWNCBsYfucE8pgkM3z8uK/DEzw=;
        b=ITRia1hLlVi8RmK6zLZLnUogTbw8+g0XxWCYXm7wsFyDetUmTfN0d87t4tVCV465Qr
         rbUuLCq/SL6/dtY9kacXwPMiBbzUuj6tNQZiP/L5RGKab+Ka+t3ZMrPk94VuL5CIhGk3
         LpVuBdiLDvXL5IxN0UkQywZ7Sk+nl9iqx39ct0DRyamNBl0LqSkDNt28FvsF11d8hvLp
         rkjjYuUlmLhO9lfdPVRTEWlHO9SlNtC4pmLd+Im/CNFOhIFd6u/4pD9rvSaa9VfvJMdw
         MlqgP3mQ0fiWdSdXeW7yMwbo8cncY9+2MTqhwjz62HreGiJ3Lnyvvrq4li9o16r+QV7T
         ctbA==
X-Gm-Message-State: AOJu0YxYWTwAo+KpMDZ0C0HE9uPo3hwILbl3Itob5YyR666u5GMsAHVz
        iupKBj80cL2vNaFuU4gK7fs=
X-Google-Smtp-Source: AGHT+IHyx7SqBKV4eZDV5ZT42b271aGYC7KYgXNe9EH1UiqXskUInT4E8XIHNPcjIJEdM0Tb4s1VtQ==
X-Received: by 2002:a05:6a00:2d9d:b0:6cb:8ccc:a5cf with SMTP id fb29-20020a056a002d9d00b006cb8ccca5cfmr12497223pfb.18.1701064475563;
        Sun, 26 Nov 2023 21:54:35 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:6f18:c2e2:c23c:9ba2])
        by smtp.gmail.com with ESMTPSA id t22-20020aa79396000000b006be0fb89ac2sm6435370pfe.197.2023.11.26.21.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:54:35 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Date:   Mon, 27 Nov 2023 18:54:14 +1300
Message-Id: <20231127055414.9015-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163018.1303287-2-ryan.roberts@arm.com>
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> +		  pte_t *dst_pte, pte_t *src_pte,
> +		  unsigned long addr, unsigned long end,
> +		  int *rss, struct folio **prealloc)
>  {
>  	struct mm_struct *src_mm = src_vma->vm_mm;
>  	unsigned long vm_flags = src_vma->vm_flags;
>  	pte_t pte = ptep_get(src_pte);
>  	struct page *page;
>  	struct folio *folio;
> +	int nr = 1;
> +	bool anon;
> +	bool any_dirty = pte_dirty(pte);
> +	int i;
>  
>  	page = vm_normal_page(src_vma, addr, pte);
> -	if (page)
> +	if (page) {
>  		folio = page_folio(page);
> -	if (page && folio_test_anon(folio)) {
> -		/*
> -		 * If this page may have been pinned by the parent process,
> -		 * copy the page immediately for the child so that we'll always
> -		 * guarantee the pinned page won't be randomly replaced in the
> -		 * future.
> -		 */
> -		folio_get(folio);
> -		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
> -			/* Page may be pinned, we have to copy. */
> -			folio_put(folio);
> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> -						 addr, rss, prealloc, page);
> +		anon = folio_test_anon(folio);
> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
> +						end, pte, &any_dirty);

in case we have a large folio with 16 CONTPTE basepages, and userspace
do madvise(addr + 4KB * 5, DONTNEED);

thus, the 4th basepage of PTE becomes PTE_NONE and folio_nr_pages_cont_mapped()
will return 15. in this case, we should copy page0~page3 and page5~page15.

but the current code is copying page0~page14, right? unless we are immediatly
split_folio to basepages in zap_pte_range(), we will have problems?

> +
> +		for (i = 0; i < nr; i++, page++) {
> +			if (anon) {
> +				/*
> +				 * If this page may have been pinned by the
> +				 * parent process, copy the page immediately for
> +				 * the child so that we'll always guarantee the
> +				 * pinned page won't be randomly replaced in the
> +				 * future.
> +				 */
> +				if (unlikely(page_try_dup_anon_rmap(
> +						page, false, src_vma))) {
> +					if (i != 0)
> +						break;
> +					/* Page may be pinned, we have to copy. */
> +					return copy_present_page(
> +						dst_vma, src_vma, dst_pte,
> +						src_pte, addr, rss, prealloc,
> +						page);
> +				}
> +				rss[MM_ANONPAGES]++;
> +				VM_BUG_ON(PageAnonExclusive(page));
> +			} else {
> +				page_dup_file_rmap(page, false);
> +				rss[mm_counter_file(page)]++;
> +			}

Thanks
Barry

