Return-Path: <linux-kernel+bounces-62972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1893852877
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2411F24BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC71134B9;
	Tue, 13 Feb 2024 05:57:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E9249E6;
	Tue, 13 Feb 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803834; cv=none; b=VnxyDjk6Y35wttsCcgqGIN3r5+CFzp/v5qeOK1ZArbPHsuXwkyUdlZTKEceZwS0SMWKhj3A5+/RlCTJKCVL72B1vI2fXkewmal31zMb9pn/w+9v7VrBZBOD87Z4/qequwVudwgxKOJfY6opqceXbmttJRx7CoKhBqNEtVZcpncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803834; c=relaxed/simple;
	bh=p/s/YHg/ofyuou1+HQj8mlBXfSUgw0Od8Z3nz/6sJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRzuwwVwluY+9quH2h6dQ+lhw8zWKPowwY/dXNPlU4+1AddzvYqln7KhyE6UWkJlfQhc62SiRvXNXALlqJfIq7icsF5LgfLnQeVxBKGs59siZNAb1t6bsYy+M2VuITUU6ag41Vq+Nqvq0Z3O+yLsxIdfp1DSXNEaS2WhpeWM+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5EE32227A87; Tue, 13 Feb 2024 06:57:07 +0100 (CET)
Date: Tue, 13 Feb 2024 06:57:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] dma: compile-out DMA sync op calls
 when not used
Message-ID: <20240213055707.GB22451@lst.de>
References: <20240205110426.764393-1-aleksander.lobakin@intel.com> <20240205110426.764393-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205110426.764393-2-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
> +			       size_t size, enum dma_data_direction dir);
> +void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
> +				  size_t size, enum dma_data_direction dir);
> +void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
> +			   int nelems, enum dma_data_direction dir);
> +void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
> +			      int nelems, enum dma_data_direction dir);

Please stick to the two-tab indentation for continuing prototypes.
The version here is not only much harder to read, but also keeps blowing
up the diffs for current and future changes.

Otherwise this looks good to me.

