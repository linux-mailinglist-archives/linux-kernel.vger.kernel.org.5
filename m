Return-Path: <linux-kernel+bounces-122508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7A88F8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E29296180
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50950279;
	Thu, 28 Mar 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTsrj5/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33251C3E;
	Thu, 28 Mar 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611376; cv=none; b=Ne2oSMB9GXGCB9HnI+GdBInJPiTwY8OBr/mgzsrT0GUV3oWKhvyi0SzK65vufrEIghE/BEtNT1LFbaZiWjMMZD56wSqf9JGWib9dF7h0Hw4mEKGj/6oRClyTRUkqmswAa9CtvPi8Wimknlj36JUGtbyFkQrdyHaIYL6DpqPJN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611376; c=relaxed/simple;
	bh=E0xlW2CX/m4Lsu+pWv53RNQvI+T8j1SSWWH4AEJ0ZTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mToZOxKhhyIDw/RolCw18+XebVFE6udwgCcFUsSyApwuKf/ZoyzTAWAcYXjnOepXzOeVn0QLF+QkJ0tXaKKNADsDeptcothzJRek5p1o2d0f7ZX+Y6HXpRg7eJpopLwVILFPRIR5n5tzUmkP8/wugPOllnE7B1rCO8/8qQ7RPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTsrj5/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64C2C433F1;
	Thu, 28 Mar 2024 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711611375;
	bh=E0xlW2CX/m4Lsu+pWv53RNQvI+T8j1SSWWH4AEJ0ZTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OTsrj5/yuI9HrDeYC88Dy5LI7sOBqHTuh8HRW1ucI8jv3M33MU55h60Miw93JHe1n
	 y+uZOcTRtLcQNy+CygyIi9j7DniRqXMfm7QBbf3s8icNKzb9AuEmQVAE4KXePw7scM
	 6xQopNIUHFyzW/UEB7UxUx5jvEfEAS6gMkIT7M8ohVEgOB/k5lqVhVCs7ioIZypIdk
	 1Oc9qSo2Dz5Ue3nbX+rqydCPJs7ClA42eLZuNrZP1Ce+k8QUSYhjIDnI+NGrSNfCVV
	 dmgc47avnlbwPCBHkFI7LrlE9LVvOATK0IndzhHUNRIrEYG94hHpvm0IZEF2iT9+Dq
	 PE/4zJlUMK5KA==
Message-ID: <ba7d201b-3746-4ee1-9574-5782cccbc88e@kernel.org>
Date: Thu, 28 Mar 2024 16:36:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Christoph Hellwig <hch@infradead.org>
Cc: Yihang Li <liyihang9@huawei.com>, John Garry <john.g.garry@oracle.com>,
 yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com, prime.zeng@huawei.com,
 yangxingui@huawei.com
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
 <ZgUPpwhkE9bRwHec@infradead.org>
 <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
 <03ed6449-eb57-4a55-b2bf-ecbb9787feca@kernel.org>
 <ZgUcTLQnoLuqhOxO@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZgUcTLQnoLuqhOxO@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 16:29, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 04:23:22PM +0900, Damien Le Moal wrote:
>> But I thought that the original issue was that some arch have ARCH_DMA_MINALIGN
>> down to 8B but hisi driver needs at least 16 ?
>>
>> So in the end, you need something like:
>>
>> 	size = ALIGN(size, max(16, ARCH_DMA_MINALIGN));
>>
>> no ?
> 
> I don't think we ever have an 8 byte dma minalign.  With 8-byte
> aligned addresses dma_mapping_error could run into problems.

My bad: it is kmalloc() that can return something aligned to 8B...
So "size = ALIGN(size, ARCH_DMA_MINALIGN);" is the right thing to do.

-- 
Damien Le Moal
Western Digital Research


