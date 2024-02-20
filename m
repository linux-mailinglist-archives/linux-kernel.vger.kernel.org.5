Return-Path: <linux-kernel+bounces-72634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EF85B683
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3DE1F2245D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628D5C5EB;
	Tue, 20 Feb 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqk3YcAi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90860ED3;
	Tue, 20 Feb 2024 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419707; cv=none; b=RfpZt+h/0Ie5+mzqTMhvQV/PobXG4EHHQSnKfvMPrYAtyZXIYnKM+7UXgF5+FNkVdcqKDFzsq48bznChZ3HjiTF4j9DIYhYSzgG1WvkYhdl+wnwjpADLiKuGDovyPHSbkQkBmmBxCp3dKkvD30ldn1kknFLUqqZLtQ07bltRybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419707; c=relaxed/simple;
	bh=w5txP1p8eaflpPcLD3mB5+qv4wWL4h7pHa6trQ/riJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQyA/4N/SWwMabZxSLzFIls29GtDV3RNtUOiljfz/QJnOExNpJm6zmon2Emx2WNMGqQR4nJms9+kVDHsTcP1jPfBsKT3qzLmVoE5k/EK+pLKFYQ3gmbwJHTihXOfAdVDXFiIR+nj69IE2RWcHozyZuTyXyX0uj1As6zkkVfE9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iqk3YcAi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VRlf7svvB4q3qj2+V468QhWzpfRTFZwbhai9UV0td6E=; b=iqk3YcAiFd67dsPwfK7F8Vp89Q
	h1ifVmoTcjWdUAELwGMWt/o22BxGyK8VB6vEfvCNU7pC3aeDkIQck28i1sW9j+g3ADN523WIBvpo3
	qru/5jsN0BGt6hMF/B9zbxlcg/+P7XUE7HVFPa2wrnRsh9FT4d2Qi3oaH/yay+d5rTullBwcvqAfT
	5lH0fHeWuZxIAsOBDagQPUdFKUzgNvQDCeF0dnRLfQRZaSDnhAWdeS8u3MNE68dLkHyPOSvX3fnTl
	SXAod76wUbXj22LGZeAYnJcesZa1FYGz5MMt8rBzm447+KuzBC+w2SEYFx1NdPs0aZGlEIRCvpWwI
	NZB4OjRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcM0O-0000000DrMm-3rVh;
	Tue, 20 Feb 2024 09:01:36 +0000
Date: Tue, 20 Feb 2024 01:01:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com, axboe@kernel.dk,
	gregkh@linuxfoundation.org, brauner@kernel.org, lstoakes@gmail.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, david.marchand@redhat.com
Subject: Re: [PATCH] vduse: implement DMA sync callbacks
Message-ID: <ZdRqcIRmDD-70ap3@infradead.org>
References: <20240219170606.587290-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219170606.587290-1-maxime.coquelin@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 19, 2024 at 06:06:06PM +0100, Maxime Coquelin wrote:
> Since commit 295525e29a5b ("virtio_net: merge dma
> operations when filling mergeable buffers"), VDUSE device
> require support for DMA's .sync_single_for_cpu() operation
> as the memory is non-coherent between the device and CPU
> because of the use of a bounce buffer.
> 
> This patch implements both .sync_single_for_cpu() and
> sync_single_for_device() callbacks, and also skip bounce
> buffer copies during DMA map and unmap operations if the
> DMA_ATTR_SKIP_CPU_SYNC attribute is set to avoid extra
> copies of the same buffer.

vduse really needs to get out of implementing fake DMA operations for
something that is not DMA.


