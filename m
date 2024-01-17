Return-Path: <linux-kernel+bounces-28550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89370830002
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198671F24805
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E28BF3;
	Wed, 17 Jan 2024 06:08:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CF79DC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471725; cv=none; b=R1wAqJHDzlfp5bNmzQFbrBtaZVVdNcnUBPUBikuRegZxzILAyPvSBQWeAtsTar0WMrcB6PVLukig+pzXKopxb6suNyAi9lUlHZsEPBIQZmABrIPbX7ZDHaVUPzGPxxbbT6vr8xAPKYi9WaswvhLQeEAz419+nDscHW7ypud/LTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471725; c=relaxed/simple;
	bh=FncW2w5rE4J4VfxL3D735D8mU5IalNeYnlrhqqiHJA4=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=WdlE5DItra27anMlqwUEpqUUAq3rVp2BjimFb89vHhqByKMD8vrtey2YBge03YkzWYykiaDW0YIlfTBHpXwkGVcccb33XE0yiVD5Y27Z9kR51sBree8eCRTKfA+eaAUQVXKniCDrapvB7tsD10aZiY+4OTXuvF4knNCDkZuGR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4AD92F4;
	Tue, 16 Jan 2024 22:09:27 -0800 (PST)
Received: from [10.162.43.8] (a077893.blr.arm.com [10.162.43.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E4D3F5A1;
	Tue, 16 Jan 2024 22:08:32 -0800 (PST)
Message-ID: <7d6590e5-0e5f-4d01-8bd3-2e46f6951e53@arm.com>
Date: Wed, 17 Jan 2024 11:38:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: vmalloc: Mark vmap_init_free_space() with __init
 tag
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Dave Chinner <david@fromorbit.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 kernel test robot <lkp@intel.com>
References: <20240111132628.299644-1-urezki@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240111132628.299644-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/24 18:56, Uladzislau Rezki (Sony) wrote:
> The vmap_init_free_space() function is called only once
> therefore tag it with __init. Apart of that it access the
> "vmlist" variable that is located in ".init.data" section.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401112056.I41bELL4-lkp@intel.com/
> Fixes: 86817057732 ("mm: vmalloc: remove global vmap_area_root rb-tree")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 43a6608e1397..257981e37936 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4834,7 +4834,7 @@ module_init(proc_vmalloc_init);
>  
>  #endif
>  
> -static void vmap_init_free_space(void)
> +static void __init vmap_init_free_space(void)
>  {
>  	unsigned long vmap_start = 1;
>  	const unsigned long vmap_end = ULONG_MAX;

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

