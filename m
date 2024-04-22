Return-Path: <linux-kernel+bounces-152803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410D8AC477
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B161F282830
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28B481C6;
	Mon, 22 Apr 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xJMeSNUS"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5B3FB09
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768580; cv=none; b=kulnInIEAp0JZsfnY5X96BvR95F4vBOW9t33uWfYPIctaB+F25wE5mD9odTuIQ5qxDcCsysBRrAB372caREKd+TknMhVS/ZERVPI2sUy+u4ZlJRXEXwe7P/iTyo3EIjHp43F5aaI0o/BuEmeac3X7wmhDHJv6djiPpp/1Ej0v0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768580; c=relaxed/simple;
	bh=9aKSLviQppqudi7UA0uw6NzOwMoyu+iWPQ0UiXM2u/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GH9vGwhtkZi06izLciuY+1wDzvxKZeLqAL1muLz2eMYKHVYMuFuUvB4+QTauokHWvEuAyiDMJ6Vrc9JyNqXea8rx/NV5edMBafspe+RtJaLSowfhObntQ/j4odDUgQKtpU7PWS6DYaG9iGliEro+Kt524hN4WIrg1mG+pkM0tEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xJMeSNUS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713768575; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=M4r8qRC3GMq/V9Nvk3gHKxi0DstITpx7E6gXzk5LZpI=;
	b=xJMeSNUSWM5482mR8zGS1LAQv1lrkQImFuqmDSLSqzRU1qCNFehglDqvfmaL3UMFgYRWAXKiJGFlnkmUGBo3LOIKQK6rhqi+bXie7de7tRPHMiUZgzarlexxFPUdfDS6wd0LAM9T+issR+DKoLt1HU+axJgxeFaoaCdA0t1/kVE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W5.HVkq_1713768573;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5.HVkq_1713768573)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 14:49:34 +0800
Message-ID: <653923bb-51dc-40c1-aa88-276c71a333a4@linux.alibaba.com>
Date: Mon, 22 Apr 2024 14:49:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: add the missing
 folio_test_pmd_mappable() for THP split statistics
To: Lance Yang <ioworker0@gmail.com>
Cc: david@redhat.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com>
 <20240422061720.61697-1-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240422061720.61697-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/22 14:17, Lance Yang wrote:
> Hey Baolin,
> 
> Maybe I spotted a bug and made a change to this patch as follows.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 824eff9211db..f3c4e08c6d30 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2994,6 +2994,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>   	struct anon_vma *anon_vma = NULL;
>   	struct address_space *mapping = NULL;
> +	int order = folio_order(folio);
>   	int extra_pins, ret;
>   	pgoff_t end;
>   	bool is_hzp;
> @@ -3172,7 +3173,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		i_mmap_unlock_read(mapping);
>   out:
>   	xas_destroy(&xas);
> -	if (folio_test_pmd_mappable(folio))
> 
> IIUC, if we split the folio successfully, it won’t be large here.

Yes, good catch. I did a blindly copy-paste.

Will fix in next version. Thanks for reviewing.

> +	if (order >= HPAGE_PMD_ORDER)
>   		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>   	return ret;
>   }
> 
> Thanks,
> Lance

