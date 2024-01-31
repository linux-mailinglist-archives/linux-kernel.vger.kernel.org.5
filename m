Return-Path: <linux-kernel+bounces-46927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102184466E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C851AB2929F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88612F581;
	Wed, 31 Jan 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUOCBvaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2512DDB0;
	Wed, 31 Jan 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723122; cv=none; b=LQw/V/clVa5sHOvSn71+y8UaI9EfkHscZPkuqI0ibIPUbjrPP6W3ZfD2CVtDN9ipV5Pveo8yYMAsevW90n3JiAKgFmxCKsrtSgeH3mCJi7jJ1CGD/CfyszolR4+UWdvw79ngbsBZAn2IPtvsoWtpCC3/05io5p+RqpsgRduz2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723122; c=relaxed/simple;
	bh=nUArffftpYnAZbiHt8Ob1hqxWBT6f6uIQHVJHvysZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo9HJJU9UQt+7WtlShOCgSFLJabOcL0Z6AcDX2dmzbWGbRmOTXHJ8mNVfLYhfuZ6kPFwR0LbHZIZqranZtI3eFmxYtcuI/gIYKRLuPJ37aOCxqbRELPUureCAG5sAQBvizSX3ggFOnlrwt4ltUjKKZcUUTubIV39e4d7QkNQxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUOCBvaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9217BC433C7;
	Wed, 31 Jan 2024 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706723122;
	bh=nUArffftpYnAZbiHt8Ob1hqxWBT6f6uIQHVJHvysZIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUOCBvaBD27KfHv4ciq855lq28+zJV4LoJW8XZ3mtqz19L6eGtrWN3r6HSNOhYWdv
	 5IzVpSVokqn8erbCNinc8v8n1HjHpIVvGkK3lSd+193zpXRwMydajVBfUqfI/RLIvz
	 T3urWj2C8oqdcXd7kUMyMqxf7Cc7jqD5q+ANHCYcsQUTI55yfKPdeEoSsaXwiI2TuI
	 jXeII+l+cK33jMFO7mpLuZKDpRIKGYYweFAjViuoeGWshMeOkcckMgYdKgVqAiM52x
	 OaNcvEdT7JCFy72JbDN/wwJlxKz+nsRJvuT1f1JS20ms6DiTAs9VNGIaAOUCWcHwGv
	 31o6TLZ5w0oiw==
Date: Wed, 31 Jan 2024 17:45:17 +0000
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Fix allocation alignment requirement
 when searching slots
Message-ID: <20240131174516.GA14943@willie-the-truck>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131122543.14791-2-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 12:25:41PM +0000, Will Deacon wrote:
> @@ -1015,14 +1014,16 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	index = area->index;
>  
>  	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> -		slot_index = slot_base + index;
> +		phys_addr_t tlb_addr;
>  
> -		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, slot_index) &
> -		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> +		slot_index = slot_base + index;
> +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> +
> +		if ((tlb_addr & alloc_align_mask) ||
> +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
> +				  (orig_addr & iotlb_align_mask))) {
>  			index = wrap_area_index(pool, index + 1);
>  			slots_checked++;
> -			continue;

Bah, I accidentally dropped this 'continue' when addressing the review
comments, so I'll add it back in v3.

Will

