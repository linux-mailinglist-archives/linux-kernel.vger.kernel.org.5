Return-Path: <linux-kernel+bounces-90082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346786F9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE10B20AE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E99CA73;
	Mon,  4 Mar 2024 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eJ0UGOcm"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBDBE4C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533302; cv=none; b=OWWxtEMupVS6Zx/eQNfegIjSW+0cLcOU3Xh85NCRPYnCN3TVYBGqdpH7+aYZwgkQ1l8tzBntbzfOzRR7W7M5pni+QAfPbnWCdpLBOorFFCrE4N5/XFOUEtF2s93vHYSV9sCD8jmg5cgVQYKsPgmu+sH64in0gfXllmiyoIvS1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533302; c=relaxed/simple;
	bh=RY90ZcVRTd3xTZgswgtC+XVHYgz5ZvIpGUvShK7L7Nk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=khgODcGY2+ubtdZv4S/tEmtOorpG96lYibfnFW5iKHH5Acy44BkNXx9I1IDY/K1gu6QiliDpnpu9tL/eEpzI/k7mKZLNJkGdv0zbtT82/zyOwuVlDGBRnaCG9bhXM9SH/C6TWml6l2FJW3isBXR1Jj57r0suay9ksR4mhPohZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eJ0UGOcm; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709533291; h=Message-ID:Subject:Date:From:To;
	bh=dUDdh5wVcfRP3a5H1iRsoBCROf53bWeQiUnd3Swr9r8=;
	b=eJ0UGOcmlGDp0/TF1/qm3jPa4BRfBL2rnbzCTV6arPW6fucQnbsDNBoLWpi8VG62VKEeMXrmKMpyG4Rvqwib+shtNPOsIZqbXfrM5eBa9pmspmlR6Gohp6mU+YH5m38HZc4v0jXFUFBoeFG2WQ2dTqpEncwe3quftDpQDENhHkw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1kG4O-_1709533290;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1kG4O-_1709533290)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 14:21:31 +0800
Message-ID: <1709533151.0138865-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Date: Mon, 4 Mar 2024 14:19:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev,
 Zelin Deng <zelin.deng@linux.alibaba.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
 <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
 <20240301082703-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240301082703-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 1 Mar 2024 08:41:50 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Mar 01, 2024 at 12:42:39PM +0000, Robin Murphy wrote:
> > On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
> > > On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> > > > Not only is this idea not viable, the entire premise seems flawed - the
> > > > reasons for virtio needing to use the DMA API at all are highly likely to be
> > > > the same reasons for it needing to use the DMA API *properly* anyway.
> > >
> > > The idea has nothing to do with virtio per se
> >
> > Sure, I can see that, but if virtio is presented as the justification for
> > doing this then it's the justification I'm going to look at first. And the
> > fact is that it *does* seem to have particular significance, since having up
> > to 19 DMA addresses involved in a single transfer is very much an outlier
> > compared to typical hardware drivers.
>
> That's a valid comment. Xuan Zhuo do other drivers do this too,
> could you check pls?

I checked some drivers(gve, mlx, ice), no one has the same operation like
virtio-net. We can do it because we have indirect feature.

Thanks.



>
> > Furthermore the fact that DMA API
> > support was retrofitted to the established virtio design means I would
> > always expect it to run up against more challenges than a hardware driver
> > designed around the expectation that DMA buffers have DMA addresses.
>
>
> It seems virtio can't drive any DMA changes then it's forever tainted?
> Seems unfair - we retrofitted it years ago, enough refactoring happened
> since then.
>
>
> > > - we are likely not the
> > > only driver that wastes a lot of memory (hot in cache, too) keeping DMA
> > > addresses around for the sole purpose of calling DMA unmap.  On a bunch
> > > of systems unmap is always a nop and we could save some memory if there
> > > was a way to find out. What is proposed is an API extension allowing
> > > that for anyone - not just virtio.
> >
> > And the point I'm making is that that "always" is a big assumption, and in
> > fact for the situations where it is robustly true we already have the
> > DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism.
> > I'd consider it rare for DMA
> > addresses to be stored in isolation, as opposed to being part of some kind
> > of buffer descriptor (or indeed struct scatterlist, for an obvious example)
> > that a driver or subsystem still has to keep track of anyway, so in general
> > I believe the scope for saving decidedly small amounts of memory at runtime
> > is also considerably less than you might be imagining.
> >
> > Thanks,
> > Robin.
>
>
> Yes. DEFINE_DMA_UNMAP_ exits but that's only compile time.
> And I think the fact we have that mechanism is a hint that
> enough configurations could benefit from a runtime
> mechanism, too.
>
> E.g. since you mentioned scatterlist, it has a bunch of ifdefs
> in place.
>
> Of course
> - finding more examples would be benefitial to help maintainers
>   do the cost/benefit analysis
> - a robust implementation is needed
>
>
> --
> MST
>

