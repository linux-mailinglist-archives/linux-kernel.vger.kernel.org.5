Return-Path: <linux-kernel+bounces-97864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA98770A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA891F21740
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA2364DC;
	Sat,  9 Mar 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P8HBvKE8"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07134364AB
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709983497; cv=none; b=XFLpgV9tcZoPPUUHwe2XRaFzzZ93xmRg8Bhpy7m1DJgujzH1R/Ykeh/VmoU7ecmJa9i2ElHsGpKkpEQ4sKAY+sJd0MY3UwHOtJ/wGytCy1DBVqX+LXefuKF+onXsaUMl9qiXE3iNNglNhNUafVbgFvikkphLh2lFZlMVrQPhXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709983497; c=relaxed/simple;
	bh=1740AqjlhtbDQcgr3kz2VUTqsFMO67FamFli+bFM8gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn1/gdgtXI/tzFrCC+HDqwESleB17A6niqrllWaDlNJyeZCdcWME1x6zTSn+If92qSKTsn20G4HI7QgiNRIMJc8H9mJbkmVmEe2yLOpc+2pOGMW1JC+pELUBgEbZDxjvKbRyVMba0bnJkLQn0bdBzdm/yzlxz7MyjM+Dj3g9F5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P8HBvKE8; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8bc1aebf-8395-416f-8c23-53cbd25d0eef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709983492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eL7mM7sZYIm+/FYyJAxbcAh676RdIHz8wgb5OtaQOqQ=;
	b=P8HBvKE8AWR+nWpWUoVPjwvk3yc6jQPFvPcr7KtVMESfTR55wM1FSzLKpvQ8P+Kj4NCPPV
	ZeHlzKjWzvHSMuZHuHoYKKUykgys45sWKm+xuGAM9NBbqHnUXHQaaENnc9Ga7XRPOEsAZ8
	aFxe15F4yQ3UMPDxHFKIOrsBBMWvMKI=
Date: Sat, 9 Mar 2024 19:24:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: mark racy accesses on slab->slabs
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <tencent_60DA4643DAB0341D8320190AC0A403636807@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <tencent_60DA4643DAB0341D8320190AC0A403636807@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/9 15:48, linke li wrote:
> The reads of slab->slabs are racy because it may be changed by 
> put_cpu_partial concurrently. And in slabs_cpu_partial_show ->slabs is
> only used for output. Data-racy reads from shared variables that are used
> only for diagnostic purposes should typically use data_race(), since it 
> is normally not a problem if the values are off by a little.
> 
> This patch is aimed at reducing the number of benign races reported by 
> KCSAN in order to focus future debugging effort on harmful races.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..7b20591e7f8a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6257,7 +6257,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  
>  		if (slab)
> -			slabs += slab->slabs;
> +			slabs += data_race(slab->slabs);
>  	}
>  #endif
>  
> @@ -6271,7 +6271,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  
>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  		if (slab) {
> -			slabs = READ_ONCE(slab->slabs);
> +			slabs = data_race(slab->slabs);
>  			objects = (slabs * oo_objects(s->oo)) / 2;
>  			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
>  					     cpu, objects, slabs);

There is another unmarked access of "slab->slabs" in the show_slab_objects(),
which you can change too.

I'm not sure that it's really safe to access "slab->slabs" here without any protection?
Although it should be no problem in practice, alternative choice maybe putting partial
slabs count in the kmem_cache_cpu struct.

Thanks.

