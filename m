Return-Path: <linux-kernel+bounces-122504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F688F8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD13B1F26AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F051C55;
	Thu, 28 Mar 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgFUBrYk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249C2561F;
	Thu, 28 Mar 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610960; cv=none; b=BTxBgBqjDpifQd8z+LdTyZWYvysqLjYOtsvq4GudzmfZmoUyMwLdmGPD30WXQW7dKFxAM2LAxtmnoqwPKrOOG3ubPwsVW6KTxQ7qvYNFx/ObMvmHDV8fMe0MQ80m6n6VQ2XfL6c9hXeliTIUzPGQxVUE9lXKPY6zwEwtwzYcOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610960; c=relaxed/simple;
	bh=FiCIkTLUjia6oZra0f+d1gUdBJtXinTNpnbzT5pmwP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1fZAjaZJkbaKmjGFaPiyAtdBxl3/26NXQrN4xri44lumFJQDDPvbtzIxoTibIg4Tn0aBK6szG+Rcwb7JhrxDXuW9hMqy2h7lW/tgbPEh+Ct4UcyIcd1qvIDZ2t+c6DuJmCjH+RmTDO4o6HA2CRdc7SHKantjjogF71RqNCdQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jgFUBrYk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZHG7bc9PgDrabFkR4+E2NwrDV4EJzWyNJdahkzxAUog=; b=jgFUBrYkh6xtqYLnocTPXtT4Qq
	CqMvUpA5U1MUFNbuiCcp9o3fqf3wwWo34KUnJBUjmAsVoJy47B0NPIlwUtKD74+qiM2AibCiWGj6/
	o4nUm+jgd3Qo5y6Pg7beHlq5qHrunMoLYYJ6yuZq3+9uBdPKEoAJThZOTmbHBR2U1cIslYGkElsme
	FOPnGjnUzr0cFqmyNVmbrVVmVNacqp6OWU5nAZAgrGP8z8IP2ckIx4u2keAS3aCUnjzzOiDp4tC3G
	zzTZ6Zv6/LWWYWMsyTKLpsFANpK7Yjb9SqmAmOVaLqriwYD3pIFU0cc1T5QiaipA8WnaUyx78jUFr
	9kB1bkYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkCL-0000000Cs43-0GGI;
	Thu, 28 Mar 2024 07:29:17 +0000
Date: Thu, 28 Mar 2024 00:29:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yihang Li <liyihang9@huawei.com>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>, yanaijie@huawei.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	prime.zeng@huawei.com, yangxingui@huawei.com
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
Message-ID: <ZgUcTLQnoLuqhOxO@infradead.org>
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
 <ZgUPpwhkE9bRwHec@infradead.org>
 <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
 <03ed6449-eb57-4a55-b2bf-ecbb9787feca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ed6449-eb57-4a55-b2bf-ecbb9787feca@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 28, 2024 at 04:23:22PM +0900, Damien Le Moal wrote:
> But I thought that the original issue was that some arch have ARCH_DMA_MINALIGN
> down to 8B but hisi driver needs at least 16 ?
> 
> So in the end, you need something like:
> 
> 	size = ALIGN(size, max(16, ARCH_DMA_MINALIGN));
> 
> no ?

I don't think we ever have an 8 byte dma minalign.  With 8-byte
aligned addresses dma_mapping_error could run into problems.


