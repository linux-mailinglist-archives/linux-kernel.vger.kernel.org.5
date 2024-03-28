Return-Path: <linux-kernel+bounces-122525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D688F912
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F96E1C2A7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431D54663;
	Thu, 28 Mar 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G2cLBYV/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC922EF3;
	Thu, 28 Mar 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611956; cv=none; b=my0xWcx7oYHtcxfn0ImxHVBArp3Q5zHqNQB019TR1u6v5k1anTm94f4fzeY+NQqgqUMZREKTyIVurvbNQDI9ceT2LuAKoAulJwvXICF6jBlHWOWjxDx22YChzbc5Wd+ZZKY3uBj6D2AAWm/88F06gQ88aMPWOoRi0yL770hg9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611956; c=relaxed/simple;
	bh=wKboDbN0fNOi3BrGbZoinODMxzdjRGOVKOWRbJfW8So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNaXXi7PW6ZEDXU+ECR0Cy/vXuCjz2Uh84GokRoSW/HCiCzr/rzQj3LiHTRDcaJSp5OG3SHoWm4pU0AKaKIqyj/EeO4iNdorNAWj8hcnG0K1nVrXvmc/WKDFFWafJt0s9XnsR3yyB4XuHVAauJI4Hn5AI4nxZThtgQzzvLOFJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G2cLBYV/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wKboDbN0fNOi3BrGbZoinODMxzdjRGOVKOWRbJfW8So=; b=G2cLBYV/v5lmzVQTjGSCr+KuXU
	gOA1ku7Ys0B2w5vOSyGh5XVvsIeWtebQfUVWQ5T2oOKAxGasXnDG+UtGpoLCKGPOsEe/UtbfW2PJR
	gxchr5zF5LF9bq5nXpNYmkqWnxIJu3ktJwUpCw0N4kxOYKX+0L5six3iSxYsvD8buAoKEJIpaMDI8
	oAUSD/lPbV0/Ozx65d1vlgem7KXmt+nvqnZTki/SXvH7OzjogdHBu+gRaVc1+rSBrBRNXuPd9VsQc
	cTANnG8QIxVTAp/O45BbmsjwAa5StWuvdNxvFAcAUwu3XOsQeL2ZxYLUAhA0D5u/MxjhthaDm/oQ6
	IUuwY2fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkSP-0000000Cvqg-1vis;
	Thu, 28 Mar 2024 07:45:53 +0000
Date: Thu, 28 Mar 2024 00:45:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Yihang Li <liyihang9@huawei.com>,
	John Garry <john.g.garry@oracle.com>, yanaijie@huawei.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	prime.zeng@huawei.com, yangxingui@huawei.com
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
Message-ID: <ZgUgMcOC8DKbOVsN@infradead.org>
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
 <ZgUPpwhkE9bRwHec@infradead.org>
 <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
 <03ed6449-eb57-4a55-b2bf-ecbb9787feca@kernel.org>
 <ZgUcTLQnoLuqhOxO@infradead.org>
 <ba7d201b-3746-4ee1-9574-5782cccbc88e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7d201b-3746-4ee1-9574-5782cccbc88e@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 28, 2024 at 04:36:12PM +0900, Damien Le Moal wrote:
> My bad: it is kmalloc() that can return something aligned to 8B...

Yes, that's new on arm64, and possibly soon riscv.


