Return-Path: <linux-kernel+bounces-149622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D957B8A9394
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E43E1F21DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438E737719;
	Thu, 18 Apr 2024 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rf4a6dBH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD85F9E9;
	Thu, 18 Apr 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423370; cv=none; b=lUhV6dk3QvMVvWeEkrLPPJTwyfJ/+ATO/jNTkH1Dl+65bR48ccPZ7Z3RivSVnDjd1ANNxYd6z1+v2BSbkAdN1fNM02aIMHuIK6FGfom1az+q56sRj4efJtEHNhgbn6mCIzkOXEi3+vipEoJJtBfetwuV5YbAd3jsgfgqy2sePss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423370; c=relaxed/simple;
	bh=IsExlcz2Xfug/BF9nxQEE7UvsLNy9ys/X476DRWYKxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uuu0QG68bNfC0r53zMTkRNads6a8gaPZZL/72LabiQHR5U3CbwHGBWI00rIMeUs+3si6K7JOrT8PSTKCkCII5fhuE7OeyesadWO6FxFYfxiJCjUwZW7rmIBvp4KTEkUMkSkMwnf7rDZEBj9AqtYvqw/RYhH0Xmd+XHvKQoBZnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rf4a6dBH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=rf7iH3kMuOmRA9x6ghFFTvcsrJ/ISQqGDxDhjq51q04=; b=rf4a6dBHA2GobREdG26szefzxA
	HSdTSboPz51McD1ZaykaePmvtrK+wfJ3fJtYeQ+ygTaEGUMwhjlX8/2o9MIqjv3jY8jiJxazjH/YB
	0xLiJgo4KxO2X85TbAjbjW+KherNdx8wK9ZuWOaN0f+PkW9bvtnMqFcjgAflHBIdZK8BtKJX/Tie6
	sinLcqdj0XCZ8mNS2kgNb8rGaqrFLcEj6UPXn2j2q3PjaCuEO3K3VmBBH7/RdSCT53J5EF2r/VdSQ
	IrMHyg0G6SzcYdf0iPM3kHeQmSSmF1UQTGYLeOhJ9fX4otg1XYoU4vbVzZpsA43QLRxuW0A8RYEJz
	pKdaUvMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxLgm-00000001Bod-2kwO;
	Thu, 18 Apr 2024 06:56:08 +0000
Date: Wed, 17 Apr 2024 23:56:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Xiubo Li <xiubli@redhat.com>, linux-xfs@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com
Subject: Re: xfs : WARNING: possible circular locking dependency detected
Message-ID: <ZiDECInm854YiSPo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiCp2ArgSzjGQZql@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Adding the KASAN maintainer so that we actuall have a chane of
fixing this instead of a rant that just gets lost on the xfs list..

On Thu, Apr 18, 2024 at 03:04:24PM +1000, Dave Chinner wrote:
> The only krealloc() in this path is:
> 
> 	new = krealloc(ifp->if_data, new_size,
>                         GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
> 
> And it explicitly uses __GFP_NOLOCKDEP to tell lockdep not to warn
> about this allocation because of this false positive situation.
> 
> Oh. I've seen this before. This is a KASAN bug, and I'm pretty sure
> I've posted a patch to fix it a fair while back that nobody seemed
> to care about enough to review or merge it.
> 
> That is: kasan_save_stack() is doing a fixed GFP_KERNEL allocation
> in an context where GFP_KERNEL allocations are known to generate
> lockdep false positives.  This occurs depsite the XFS and general
> memory allocation code doing exactly the right thing to avoid the
> lockdep false positives (i.e. using and obeying __GFP_NOLOCKDEP).
> 
> The kasan code ends up in stack_depot_save_flags(), which does a
> GFP_KERNEL allocation but filters out __GFP_NOLOCKDEP and does not
> add it back. Hence kasan generates the false positive lockdep
> warnings, not the code doing the original allocation.
> 
> kasan and/or stack_depot_save_flags() needs fixing here.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
---end quoted text---

