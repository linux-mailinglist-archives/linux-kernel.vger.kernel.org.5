Return-Path: <linux-kernel+bounces-77892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3445860BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F38E2844F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C88171A6;
	Fri, 23 Feb 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFbTSIFQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD24414;
	Fri, 23 Feb 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675420; cv=none; b=PwpelitrvtNkBB5TeEHb8f3Ys/K3YUcCxL4INrDUrNHw+PcaJaBOcF4BEAQw0YRJYtNyWXdhUwJc7mKZKB8uOrposY/ffScfLkAW8IAwnx/771ZcE3Rlwo9d5Lv214bqGfYLWl7rYr8W4ZwkfZbRqBYudd+c8cXq+fNSfrBOL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675420; c=relaxed/simple;
	bh=KrdAbu7vFuDAxh60xIAq4DCNIP7bmUzOzIQZIfJxERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k07VmA+56pLW/dKKnPlvW6gyzUsytBpGpwcS+tqjJbNYkwmyP4CJnpapLfXO9bXOuYCGEsetyNIYyRWrp7mE+K+L7P0yawdQwCYHhKqcIHALds5nHIvfHeD8Ym7mGtx5woGNjD3SZtmJwr2xUCSSJuQvRwdVX14ien+rXAy8bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EFbTSIFQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fZw/7FWIZCP3rlrNit4Cu4sOKIBy8Icb2/Ch7C+m1dM=; b=EFbTSIFQQhE4pz/GyRHpok3GRo
	n6sfnPliTKOzk23Rpg+/0osKCzLlzZu5Sgjzz9C5sj06/0QX83bIOZ7jM+iRvlCd6YaYVci2DBH/3
	eSblmbW2ih9igDH4//EVBA8BAYoR9KvrswvA3gj+eDP5VldjQ9FRjpm6pFqYacKCfv6nhNabcr/rp
	z6neL60IpJkoz8k0apRGsSUuaxWf+IhMqgHYfzpuGsitOnbBiegegIMeQhXBq98ECyRk9qW+u4gnb
	aqDrGCpCmh1Vg0xaY1RVXxZEKpFUNLdBEFRqV91qVNtjjQoogNH2rtQ41EP31PMMTknBeJYd8Baut
	NNTK0XbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQWL-00000008OyF-3mql;
	Fri, 23 Feb 2024 08:03:01 +0000
Date: Fri, 23 Feb 2024 00:03:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
	axboe@kernel.dk, gregkh@linuxfoundation.org, brauner@kernel.org,
	lstoakes@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	david.marchand@redhat.com
Subject: Re: [PATCH] vduse: implement DMA sync callbacks
Message-ID: <ZdhRNeJRo1UaZt2F@infradead.org>
References: <20240219170606.587290-1-maxime.coquelin@redhat.com>
 <ZdRqcIRmDD-70ap3@infradead.org>
 <20240222152541-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222152541-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 22, 2024 at 03:29:10PM -0500, Michael S. Tsirkin wrote:
> In a sense ... but on the other hand, the "fake DMA" metaphor seems to
> work surprisingly well, like in this instance - internal bounce buffer
> looks a bit like non-coherent DMA.  A way to make this all prettier
> would I guess be to actually wrap all of DMA with virtio wrappers which
> would all go if () dma_... else vduse_...; or something to this end.  A
> lot of work for sure, and is it really worth it? if the only crazy
> driver is vduse I'd maybe rather keep the crazy hacks local there ...

Well, vduse is the only driver that does this hack - we had a few more
and we got rid of it.  It basically is the only thing preventing us
from doing direct calls into the iommu code and compile out dma_ops
entirely for non-Xen builds on the common architectures.

So yes, I'd really like to see it gone rather sooner than later.

