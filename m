Return-Path: <linux-kernel+bounces-90088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D166486FA11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5421F21613
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81C111B0;
	Mon,  4 Mar 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sPquiY6o"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50F11199
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533843; cv=none; b=bX8zmzYxDD+NoR4mBzH4wfbNq1TpJPVq08trhzJWg6/p1K9IHqlwfFteHF9bozCnTUjw0cO5RhCP3+CU+XdI7p77CTI492Dsx2K4H0UjUZDiHlqa0EfovbqcccHUhdKh0ffyuza6bUlF+VgcOwpCAyhpKku0DrDAWyUntZI6Q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533843; c=relaxed/simple;
	bh=oRuL5E03NRBdlsCXDyKaHFjeY88RtCn+H3QpyLpZHgI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ZXcJN0tarQUozJpDZH0Ohe/mx+bvrhaYO8T2hH1psYvArZcztQRsriqSRecu+VZ+QtHwHyf6HPChSWqmFszNCpm2iH/4D4DIPMAmu6OhNVOicvwm5WQwirNH1S6byRgJA6gtiGLZIf+zEsAsnVUgsjjodsJNqJ7WCDpGp7y+xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sPquiY6o; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709533833; h=Message-ID:Subject:Date:From:To;
	bh=NGXjorvuk11qTskGv8WPgdXQ88lN94avzSL2JOcc1C8=;
	b=sPquiY6or+egThxF2tTEh0EE8v8UOQUYiOseVtW3MzTvkr+XUFty0kSDja9xFMf8vJZY8S9k8JPaZF/498yq+a2iZzgR4V8e/KhistVE0i5Z5t6n2crtIttAAIF792c27zFv1VeVtegHgmlusCcU/TT8ABqWpPlhx6sjvoxrvXU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1kG7dz_1709533832;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1kG7dz_1709533832)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 14:30:32 +0800
Message-ID: <1709533720.5072534-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Date: Mon, 4 Mar 2024 14:28:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev,
 Zelin Deng <zelin.deng@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
 <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
 <20240301082703-mutt-send-email-mst@kernel.org>
 <d4f2f99c-b8bb-4ed9-8d91-ed0f5b418425@arm.com>
In-Reply-To: <d4f2f99c-b8bb-4ed9-8d91-ed0f5b418425@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 1 Mar 2024 18:04:10 +0000, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2024-03-01 1:41 pm, Michael S. Tsirkin wrote:
> > On Fri, Mar 01, 2024 at 12:42:39PM +0000, Robin Murphy wrote:
> >> On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
> >>> On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> >>>> Not only is this idea not viable, the entire premise seems flawed - the
> >>>> reasons for virtio needing to use the DMA API at all are highly likely to be
> >>>> the same reasons for it needing to use the DMA API *properly* anyway.
> >>>
> >>> The idea has nothing to do with virtio per se
> >>
> >> Sure, I can see that, but if virtio is presented as the justification for
> >> doing this then it's the justification I'm going to look at first. And the
> >> fact is that it *does* seem to have particular significance, since having up
> >> to 19 DMA addresses involved in a single transfer is very much an outlier
> >> compared to typical hardware drivers.
> >
> > That's a valid comment. Xuan Zhuo do other drivers do this too,
> > could you check pls?
> >
> >> Furthermore the fact that DMA API
> >> support was retrofitted to the established virtio design means I would
> >> always expect it to run up against more challenges than a hardware driver
> >> designed around the expectation that DMA buffers have DMA addresses.
> >
> >
> > It seems virtio can't drive any DMA changes then it's forever tainted?
> > Seems unfair - we retrofitted it years ago, enough refactoring happened
> > since then.
>
> No, I'm not saying we couldn't still do things to help virtio if and
> when it does prove reasonable to do so; just that if anything it's
> *because* that retrofit is mature and fairly well polished by now that
> any remaining issues like this one are going to be found in the most
> awkward corners and thus unlikely to generalise.
>
> FWIW in my experience it seems more common for network drivers to
> actually have the opposite problem, where knowing the DMA address of a
> buffer is easy, but keeping track of the corresponding CPU address can
> be more of a pain.
>
> >>> - we are likely not the
> >>> only driver that wastes a lot of memory (hot in cache, too) keeping DMA
> >>> addresses around for the sole purpose of calling DMA unmap.  On a bunch
> >>> of systems unmap is always a nop and we could save some memory if there
> >>> was a way to find out. What is proposed is an API extension allowing
> >>> that for anyone - not just virtio.
> >>
> >> And the point I'm making is that that "always" is a big assumption, and in
> >> fact for the situations where it is robustly true we already have the
> >> DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism.
> >> I'd consider it rare for DMA
> >> addresses to be stored in isolation, as opposed to being part of some kind
> >> of buffer descriptor (or indeed struct scatterlist, for an obvious example)
> >> that a driver or subsystem still has to keep track of anyway, so in general
> >> I believe the scope for saving decidedly small amounts of memory at runtime
> >> is also considerably less than you might be imagining.
> >>
> >> Thanks,
> >> Robin.
> >
> >
> > Yes. DEFINE_DMA_UNMAP_ exits but that's only compile time.
> > And I think the fact we have that mechanism is a hint that
> > enough configurations could benefit from a runtime
> > mechanism, too.
> >
> > E.g. since you mentioned scatterlist, it has a bunch of ifdefs
> > in place.
>
> But what could that benefit be in general? It's not like we can change
> structure layouts on a per-DMA-mapping-call basis to save
> already-allocated memory... :/

We can put the memory together. If the unmap is not needed, then we do not
allocate the memory. That is the way we are trying.

Thanks.



>
> Thanks,
> Robin.
>
> >
> > Of course
> > - finding more examples would be benefitial to help maintainers
> >    do the cost/benefit analysis
> > - a robust implementation is needed
> >
> >

