Return-Path: <linux-kernel+bounces-85092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D286B056
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C104B25722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3214CACE;
	Wed, 28 Feb 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOWjpnD3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26B1E493;
	Wed, 28 Feb 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126939; cv=none; b=kXb5sln6SoR0LVefME47NxZ65EBa7a7bQ+/vI2n+oIBMiQkjgU7LwZgH3G1lWwl/Lr1Af+Onx+95HmzS0YoQfC8jBa51cInXkDBQ48UURcup4NepCDkSsvhqx91Mu16Tuo0WuEnHNN25S/q59AULPNe8OV2+EwZuChl/hRWgWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126939; c=relaxed/simple;
	bh=JT52S9g7j/kEijySVLsE8fq6O3F0OsyWivHrbOm/DPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfN2HLERRYLzFJhXByVbTtNeYBrxnJhk+KWIBnlmitpfwbeksnOsOXNYM2mSAAW6yGwRIZhjY17X3V2tKhyfl1yUStvJ4YxInEMBM9r25NkPQ10uN3znkzGlJ6dWqYFs9ICfab5k/iRlYCT67Wv743jhm8fjMJ+ZYX0bEFesR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HOWjpnD3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IMpRJRX95zgFjbDJJkVo3LiXZsjgsaeBXPMKkkKcq9s=; b=HOWjpnD3YrDgccps2LwDtdjK7U
	jsFvYTyniWQXf2XSHwVNo9AWHZqyk8q/pHMbqmTW263OFNeZuH5lJT3BeqNocdSZPdV7zJJFRrFy4
	vQErZsPI0aCh8tOcgobDavwQduR8fCgqsdzOlzg9wK570CTysPhxIEQU3pZU1UuzSpTwYwRUh6Sjl
	fCAnA8sS6qNS+mKDg/g9AuzWWueyJkYUS2yQ8+RXE/JESltI89+wFri8TfDb/sTVnkyqeruNUwa01
	jUJvBO6dQCuVpMNJ8/zHh4YHCQVoJJXKPINHzhoq06She7ib+9AL7ICukoVwsSN1ICDj1vSTcxVJ4
	qVOHm10Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfJzU-00000009TRi-3nIU;
	Wed, 28 Feb 2024 13:28:56 +0000
Date: Wed, 28 Feb 2024 05:28:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] bdev: make blockdev_mnt static
Message-ID: <Zd81GHuI7y9s0iuu@infradead.org>
References: <20240227081958.89092-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227081958.89092-1-jiapeng.chong@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 27, 2024 at 04:19:58PM +0800, Jiapeng Chong wrote:
> The blockdev_mnt are not used outside the file bdev.c, so the modification
> is defined as static.
> 
> block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared. Should it be static?
> 

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8341

But I don't think kernel commit should close random bugzillas?


