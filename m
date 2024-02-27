Return-Path: <linux-kernel+bounces-83518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73783869A98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E376282FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEE145B37;
	Tue, 27 Feb 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFpLYTJH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05718145351;
	Tue, 27 Feb 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048436; cv=none; b=fAQMS3x63QfYClnqo9iJPHHWzJ6cJsTdnUAdXf1Fz6eqG8ohLIQ47jta3rl0GQh43j9CUR9Dg7X8wRpDVF+BDwAHZnF/6U1Vc0NhqbBpX81NcW4NM5zP7FiEQUFrpzbnVri1u3Uly/J1QMQLD34Xhz2AhqB5ALiixNcjnjMQjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048436; c=relaxed/simple;
	bh=lBLIuciUfLLdhMU8sA8OeS0LAgcXIgpkhNbhKryepEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWqrD6pclLI6xGT3JxHh41/lNudkQIPNGjId+IG5KDogjx2oPtVu0RKXqfN2zAh2i/lyAlbcXxSyLuHtF1WQNpJslTT2W9FGCGdXRAIrftlay88xu0eDYihvaoZsdBcBj8e+Jqsk8fLtGzVysv9Rj+PUHIQxHXEPoxk09jYqRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dFpLYTJH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r3ZEbWsCJHgCVJ0r8he9VWyoedSF99TnfaCfGUy0RzA=; b=dFpLYTJHypNqkRcwjKNx3n26Dd
	D+ZsaJT/6nPEiWlbZe9DtgWSHqAwI4HfF4rb4sA6BRu3iznLrsRk4QJOEHzd5Sj0ahPH5GJFekTPH
	h2AAAgK9+pgzypZHzeR8kIy7N36rn9ciusynwb89QxKoG2O5JqkX3Wrdt/qPMnRCNWN4JuTJVQMnJ
	AiK+Ml28K63mmZ7CaHBrDJMp2TFniMy5gqdpOJc1gFU4WOYo8psOBy5sN/ZGREHj6JkFNpxjOLbui
	5CX1RuI4G6QefI7+ERYX0VMhkIRaMJlCTkc9unqKrvKt9LJoWtuj56NVTiW0SQXPI7f/aMmEIuBQ5
	SYj91vDg==;
Received: from [12.229.247.3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezZJ-00000005oXH-1yMi;
	Tue, 27 Feb 2024 15:40:33 +0000
Date: Tue, 27 Feb 2024 07:40:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Message-ID: <Zd4CcL3Nnvybw2xF@infradead.org>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221113504.7161-6-will@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 21, 2024 at 11:35:04AM +0000, Will Deacon wrote:
> +static size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> +		return swiotlb_max_mapping_size(dev);

Curious: do we really need both checks here?  If swiotlb is active
for a device (for whatever reason), aren't we then always bound
by the max size?  If not please add a comment explaining it.


