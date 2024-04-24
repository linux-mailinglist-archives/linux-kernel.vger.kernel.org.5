Return-Path: <linux-kernel+bounces-157211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BF8B0E88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E327B2C4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7F16190A;
	Wed, 24 Apr 2024 15:34:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14D1607AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972896; cv=none; b=B3mDeMbH6Ynyz2z7+v6nAs37o/AgoWRvCtOn2Yp/0ID0tZnv4m+VdJNXY3sdL6/b0oBW5rk/NQk5Ci6z2KoaDrtZuMh9XnjIkLDY82TpOG1ou87qDGKucsFBVTcS2WDKc5cji2z0D3FFNH6q+zuHEFCR/ZeTraMElb4xWGLKxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972896; c=relaxed/simple;
	bh=TttsruVEiGpEdTihSdZHPGzRR4e3nj8xOXWaY9wj/K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4YDUGLQ47iHYgOsjxabxlImW5JymFXT3Y/08/cUVAubPbTe9nAlLAHpaYrnrDADQV+MIpMptVXrY4eR4aEUeQgb+bhD88uhQKmTlWsIKgcKucR+L8s3x+Sz6JG6NVvjn1g/F6JSV/2MONQ8k8D4kereGeaCkC8Mn4drSJKQDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 329421063;
	Wed, 24 Apr 2024 08:35:19 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A55A3F73F;
	Wed, 24 Apr 2024 08:34:50 -0700 (PDT)
Message-ID: <0534d647-0753-4c34-943c-e705db1fbddd@arm.com>
Date: Wed, 24 Apr 2024 16:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: add docs for per-order mTHP split counters
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <20240424135148.30422-3-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240424135148.30422-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 14:51, Lance Yang wrote:
> This commit introduces documentation for mTHP split counters in
> transhuge.rst.
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index f82300b9193f..35d574a531c8 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -475,6 +475,22 @@ anon_swpout_fallback
>  	Usually because failed to allocate some continuous swap space
>  	for the huge page.
>  
> +split_page
> +	is incremented every time a huge page is split into base

perhaps "...successfully split into base..." to make it clear that this is only
incremented on success.

> +	pages. This can happen for a variety of reasons but a common
> +	reason is that a huge page is old and is being reclaimed.
> +	This action implies splitting all PMD/PTE mapped with the huge page.

What does it mean to "split all PTE"? It's already at its smallest granularity.
Perhaps "This action implies splitting any block mappings into PTEs."?

> +
> +split_page_failed
> +	is incremented if kernel fails to split huge
> +	page. This can happen if the page was pinned by somebody.
> +
> +deferred_split_page
> +	is incremented when a huge page is put onto split
> +	queue. This happens when a huge page is partially unmapped and
> +	splitting it would free up some memory. Pages on split queue are
> +	going to be split under memory pressure.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help


