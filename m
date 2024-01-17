Return-Path: <linux-kernel+bounces-28568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA45830022
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F11C238C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE278F6D;
	Wed, 17 Jan 2024 06:27:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B268C1B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472874; cv=none; b=oUnC5+vfa7Rrh+At8HDNvlr8YIMzYCQmcy/eYIJvHzIZC+a42Uij3HSIy5rSNOLOIztqC8RR4lXQ+ae1SV01yn6wPd9cYpRq5gDxIcjShp3JTDS2d9jKHpQpmiabFKbX0YnGidhAvnokVjnJGaI9H6Q8rwb80MU7ti9R7NNqvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472874; c=relaxed/simple;
	bh=PYNAmLO4Yra4ku4Ukuk0ZUNkXnXzjyFVCFNdfNPnMAQ=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=swCxONG6J6xk/s6/Tb5hKMkNndKexa2APCSruF+jkCVAdLWPBEEFITTNvrE4AvbniCqjWGMWsswuuf+Fmte4V2VNwFPxedxiKt1O5aS877TbkLnxgFW1CjzMOE1DPZ52P0rrur0QeHM1aXJs15Ijz2G/fBCT5G2b+3h7nvAW86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728B42F4;
	Tue, 16 Jan 2024 22:28:37 -0800 (PST)
Received: from [10.162.43.8] (a077893.blr.arm.com [10.162.43.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C2603F5A1;
	Tue, 16 Jan 2024 22:27:47 -0800 (PST)
Message-ID: <2b81f323-c4b1-4580-8f2f-1654b6c1d016@arm.com>
Date: Wed, 17 Jan 2024 11:57:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix a warning in the
 crash_save_vmcoreinfo_init()
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
References: <20240111192329.449189-1-urezki@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240111192329.449189-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/24 00:53, Uladzislau Rezki (Sony) wrote:
> The vmcoreinfo_append_str() function expects "long unsigned int"
> type as a second argument(0x%lx) to print a beginning of vmalloc
> start address which is defined as a VMALLOC_START macro.
> 
> For some architectures it can be considered as "int" type, for
> example m68 generates a compile warning message. To fix it cast
> a second argument to "unsigned long".
> 
> Fixes: 9bdb180b2d ("mm/vmalloc: remove vmap_area_list")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401120218.y469Puyf-lkp@intel.com/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b60de490c1fc..49b31e59d3cc 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -748,7 +748,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
>  #endif
>  	VMCOREINFO_SYMBOL(_stext);
> -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", (unsigned long) VMALLOC_START);
>  
>  #ifndef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(mem_map);

Agree with Christoph - the right place to have this fixed properly is in m68k
platform while defining VMALLOC_START. But otherwise this fix in itself LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

