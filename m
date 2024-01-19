Return-Path: <linux-kernel+bounces-34824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B28387FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A881F2491C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327152F9B;
	Tue, 23 Jan 2024 07:34:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF851C52
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995280; cv=none; b=F+fwZ3qjcEk6t3Lp/GboHEttgPnSvxLiiJKejiHjHNx8j/lXcQQofTsU0Bw29HywKl1FdDaAD8QJaYrGlgMg7qlwZ2CHMOUUjsdQnJhVH3WN/E29f0qSukbsZiAHWR67z4sksA5vmFgHoOs8LGRNwYDUZ7IxpJIF93Q4WHOcXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995280; c=relaxed/simple;
	bh=1kP/gzgmwnK29sBXxqvZB+h7KVeZ3iSmyB/mZ/UrIWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG7ZlFkMf2hpd9kIyZfs0zWAvZG/fO13027pSaDHA5AjdvBh9eMbaPg5wFwX1MslOmhpNOKS6MUHnZlC2j5203QUi696WGBwBc+ndxMNgi3hJCX4R/5oaWnx6BFS0YPdXRSNHbVvJa3UNFYCUj9pi9NiPByyt+irRXYMDi5HD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8DxWPDl3allVekBAA--.9190S3;
	Fri, 19 Jan 2024 10:26:45 +0800 (CST)
Received: from Board-3A3000 (unknown [111.9.175.10])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxlczh3all+OkJAA--.1584S2;
	Fri, 19 Jan 2024 10:26:43 +0800 (CST)
Date: Fri, 19 Jan 2024 10:26:41 +0800
From: Huang Pei <huangpei@loongson.cn>
To: Mike Rapoport <rppt@kernel.org>
Cc: Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: fix crash when reserved memory is not added to
 memory
Message-ID: <20240119022641.xyw4n4dj2iw2deas@Board-3A3000>
References: <20240118061853.2652295-1-yajun.deng@linux.dev>
 <ZajIQGtqUNWgBWkk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZajIQGtqUNWgBWkk@kernel.org>
X-CM-TRANSID:AQAAf8Bxlczh3all+OkJAA--.1584S2
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF13Aw4UCrW8Zw17Kw1UXFc_yoW8GFWrpF
	W8G3WF9FZ8WFykuF4DJw1Ygrn3Z3Wxtay29rWYy34kZF9xWr9xWF4rW3yq9F98tw4xWr1S
	vF4vva43X34UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU2MKZDUUUU
X-Gw-Check: 94f2b8af54bc04a2

On Thu, Jan 18, 2024 at 08:42:08AM +0200, Mike Rapoport wrote:
> (adding Huang Pei to verify this fixes the crash on loongarch)
> 
It fixed 61167ad5fecd on MIPS/loongson64, tested on 3b1500 with only
this one;

My loongarch64 machine is not available now, I can not test it, sorry.
It is already applied a arch-specific workaround in v6.5+

> On Thu, Jan 18, 2024 at 02:18:53PM +0800, Yajun Deng wrote:
> > After commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()"),
> > we set nid on all reserved pages based on memory region, but some reserved
> > memory may not be added to memory on certain architectures. The nid is
> > invalid.
> > 
> > Add the nid check, make sure the nid is valid by early_pfn_to_nid().
> > 
> > Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > ---
> >  mm/memblock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index abd92869874d..4dcb2ee35eca 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2176,6 +2176,9 @@ static void __init memmap_init_reserved_pages(void)
> >  			start = region->base;
> >  			end = start + region->size;
> >  
> > +			if (nid == NUMA_NO_NODE || nid >= MAX_NUMNODES)
> > +				nid = early_pfn_to_nid(PFN_DOWN(start));
> > +
> >  			reserve_bootmem_region(start, end, nid);
> >  		}
> >  	}
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.


