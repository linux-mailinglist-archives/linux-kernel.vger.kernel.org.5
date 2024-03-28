Return-Path: <linux-kernel+bounces-122465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDC88F7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF6D1C24EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEB2C6BA;
	Thu, 28 Mar 2024 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKIaoq0D"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256A21101;
	Thu, 28 Mar 2024 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607723; cv=none; b=uak1Q4SGO5ajNI6rthQmMX8GSr5W3LO7qllRW/KtZQvboyjz4WPLuYyr/saMyyVuGAK583C7CUR9jhYNWh15Ga8ecJ9ut78j8Ay3gCm1EGavpVO7X+M5kzHlrzT+HxyRDWMl/CqsbOu24Me0Re6D0e+OS4oN17ZS5pQap8di1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607723; c=relaxed/simple;
	bh=6G1sdm/Mzhb5jcW0q/QmO6HkpDa6kSYLU5wqvdfM+eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNZjLY3xFcb84340ZdstCKliKqxajCQaFwLE3C8udrtN8fJ7Te4YEbt/DZTU8dzAWB6nn0ZDXzAgM7fHyF4kRg/esZr1/VE5yCpJgxlB9DOK/HXT81dzmjbAtoh6jrQKXbSbLJWamT85CaiYovJ1QArvbqw9RYRPTHPf8TwppTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QKIaoq0D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I9oAmld5QX0jZjclvixZH9ygB8dtXnOdM00iyF+Eodw=; b=QKIaoq0DQM+pMcoJ/ZomQC2wsI
	MZGE6pmn+xwMSGaMd+ZwrZSJUaS0OfpMfUcBBeH3XLR8sWDQKEfq6FY0RTqQj++RCbZ38NS8l5HkH
	/8XXc1hnnqUlZZ3LlhcyTkAa5F0BDeKWMehMdLxaW7CBKUD+uLRPP347yLsrLoWI19Mn19gh2R8SB
	zusQ08tkaJWKM+MlCBOAYFjoasGv5m3vuojsOm1PtHoTE/Y6qmtdpm+SiLsARAeJtW/sp4bNX5dnF
	rad8JJNdfLJ986enlo3SSrznxH0HLEz+Q0k47QHfTcFvbuR4NQnKM5qR7sktcyd9fNa9XX10c1Ltj
	+GfmwykA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjM7-0000000CjXP-3YqS;
	Thu, 28 Mar 2024 06:35:19 +0000
Date: Wed, 27 Mar 2024 23:35:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Yihang Li <liyihang9@huawei.com>,
	yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	prime.zeng@huawei.com, yangxingui@huawei.com
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
Message-ID: <ZgUPpwhkE9bRwHec@infradead.org>
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 26, 2024 at 01:32:09PM +0000, John Garry wrote:
> > > +	u8 *p;
> > > +
> > > +	size = ALIGN(size, ARCH_DMA_MINALIGN);
> 
> 
> If this is a hisi_sas requirement, then why use ARCH_DMA_MINALIGN and not
> 16B as minimum alignment?
> 
> Or are we really talking about an arch requirement?

One thing is that we should never allocate unaligned memory for
anything DMA mapped, or data will be corrupted by non-coherent DMA.
So ARCH_DMA_MINALIGN needs to be here.  If specific hardware has
further requirements we'll need to communicated it through a field
or op vector.



