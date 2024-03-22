Return-Path: <linux-kernel+bounces-111680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB960886F75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901571F22AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273984D9FC;
	Fri, 22 Mar 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPlLRpNd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A92481B3;
	Fri, 22 Mar 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120187; cv=none; b=YCk638+GQ0VIHW409/WY1U6qnjKJHPtLaujtgKaqhpOh2kl+ETVJhPDcuDUZ9uFlNWf4tbJ/LDOB9xEl1ZoKKU1dMCgEKyD5ANyXGiizMjxGGQSryQ1wiKY+s48JpQISMaAOSBQUa8x/j5FRI1wjcvvsD7yXhCLzww8leY3MGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120187; c=relaxed/simple;
	bh=UXgPa4p5wBn1d97FInWzLgeWdHJZdB/ycE6abVVuEHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeMeWAnVUGKB9Cl6n4d/zBIJ5/7Y0U+w9SSQXj9XiQa9sObGXFF/NMzy/jG6/EmOgpRE+pcMuTWLp+wsBBjLw9EOEw2UiLypPP2jgUKoVv4lv8hPO8+WQ3i80M1x88Sl7rLlqKehQX0P20+g2hS6mt7fgVCoEBhjKQ+bvAHifII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPlLRpNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD70C433F1;
	Fri, 22 Mar 2024 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711120187;
	bh=UXgPa4p5wBn1d97FInWzLgeWdHJZdB/ycE6abVVuEHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPlLRpNdS0FHw4DD9EZneTwobhZblVezN/Y/Y5CiXqGdaxw4FLFxImpc4d2HP/RgC
	 ZxPntCPNxSokHzmY+inIKJlDcfRR4ldf1ugOGXa8ymSMVizhTL5WxdKOI2FoyjI/bm
	 IXvjvB+JROneBphP6GvK4+3fwFQqnawdTrWzKIvGCSk7bLXbFVATkEsTIVhZ2YGML/
	 IiOPbS3Za+YsVysbG+t96OHjLmyG+sGkXdzJSfSJOaO0WFegSZJ59z7siq0zr/ehIa
	 5g7e++IWf253Io63or2ImSQ127kTbhSZyn4JtO6yk+IfNLkKFnecTd+0RCZjNai8Kr
	 uTOAqNF1rftag==
Date: Fri, 22 Mar 2024 15:09:41 +0000
From: Will Deacon <will@kernel.org>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: Re: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Message-ID: <20240322150941.GA5634@willie-the-truck>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321171902.85-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Petr,

On Thu, Mar 21, 2024 at 06:19:00PM +0100, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
> covers some bits in the original address between IO_TLB_SIZE and
> alloc_align_mask, preserve these bits by allocating additional padding
> slots before the actual swiotlb buffer.

Thanks for fixing this! I was out at a conference last week, so I didn't
get very far with it myself, but I ended up in a pickle trying to avoid
extending 'struct io_tlb_slot'. Your solution is much better than the
crazy avenue I started going down...

With your changes, can we now simplify swiotlb_align_offset() to ignore
dma_get_min_align_mask() altogether and just:

	return addr & (IO_TLB_SIZE - 1);

?

Will

