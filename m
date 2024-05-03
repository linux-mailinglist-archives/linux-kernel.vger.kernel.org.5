Return-Path: <linux-kernel+bounces-167641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65F8BAC89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CC0281E30
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD71915358C;
	Fri,  3 May 2024 12:29:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAE15219F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739399; cv=none; b=AsKOKxp9OvIEv9znSpA3T/fyRO04bb3OL5UAA7qVADhi0G9wQIIhl2mBT6O3dn05nLfAusE3TxDxUyo2UBn0u+9R0VS7PTXedUXJBnwyJolh/n2Qso/ZWWnSS98XD1CnmIuSb5kMRjMa702+fazCjXtDGyzcBiHzPEAJCGvLM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739399; c=relaxed/simple;
	bh=9LBlAtBXIHHo+J7MWF9oeoqbPN0hFvzoulgQLJ7oDPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+tfGp6HP1SAz8CLuU4HcD6MgAddSLO0QA9slcUA62a0NwqX8GqG7De5+z2fPT7BaPeI4NQhQn6VcHEgfo+w2IOlWcimsw/sotxqzlAxufVr8bx7GKrzeiBiDLE8GDVLxau+9SfDlfKwApnkmHdR50creQ31xwTDh552LsM+lTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1FF2139F;
	Fri,  3 May 2024 05:30:19 -0700 (PDT)
Received: from [10.57.4.36] (unknown [10.57.4.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04F833F793;
	Fri,  3 May 2024 05:29:52 -0700 (PDT)
Message-ID: <3c474453-fc89-42b2-9ddc-fdc3a2893064@arm.com>
Date: Fri, 3 May 2024 13:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-mapping: benchmark: fix up kthread creation error
 handling
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Xiang Chen <chenxiang66@hisilicon.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Barry Song <song.bao.hua@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240502161827.403338-1-pchelkin@ispras.ru>
 <20240502161827.403338-2-pchelkin@ispras.ru>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240502161827.403338-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-02 5:18 pm, Fedor Pchelkin wrote:
> If a kthread creation fails for some reason then uninitialized members of
> the tasks array will be accessed on the error path since it is allocated
> by kmalloc_array().
> 
> Limit the bound in such case.

I don't think this is right... The put_task_struct() calls on the error 
path are supposed to balance the get_task_struct() calls which only 
happen *after* all the threads are successfully created - see commit 
d17405d52bac ("dma-mapping: benchmark: fix kernel crash when 
dma_map_single fails") - although I now wonder whether that might have 
been better done by replacing kthread_stop() with kthread_stop_put(). It 
doesn't look like we've ever actually tried to free any previous threads 
from the point of allocation failure.

Thanks,
Robin.

> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   kernel/dma/map_benchmark.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..ea938bc6c7e3 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -118,6 +118,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
>   		if (IS_ERR(tsk[i])) {
>   			pr_err("create dma_map thread failed\n");
>   			ret = PTR_ERR(tsk[i]);
> +			threads = i;
>   			goto out;
>   		}
>   

