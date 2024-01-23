Return-Path: <linux-kernel+bounces-35311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B361838F60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A88C28C6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42895FBB7;
	Tue, 23 Jan 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YbuXwDeZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1C5B1E7;
	Tue, 23 Jan 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015168; cv=none; b=lAOOBcU6oZo1b9WizYhfnoaXTyW5nh9pNK39wM0KPMpnhQAjBj+zLMZAnJqVnGN3pgrAsWk67hZqrnuj/sB37EZ5veUcxN7LATC3hwf7AmhK9uxWcNTnr8pKgVPO5LxRghoWOpeZbqyF+ehYONy+lpyAn0lxzEWkGhQvEywYA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015168; c=relaxed/simple;
	bh=g0dnF+NECiQbHDnWwa3MMF+2D3t75MQuHk8tAQx9Ny4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOC2U9dsmQwpHSuq4pBHBMG3c6hpoKgrAKpLHI1LAvpRdEwqOsudtZ+oHz2Uv7Xq3vI7AyyxHS/oWfnZT2t3q8akx9OQGx4b8NdXoE0abnzENb9cv9oAik0aHleUxHP9q8WxQL2LMARtkL+8bDRfrnb86L85jZDX5+9/WBT1jPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YbuXwDeZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qwauO3AxNZKEMyDmk1GpZcqoFFny7B+dKCM+s95wTR8=; b=YbuXwDeZ1PEf5vLFq8E7oGEDeK
	2jH4XYzsgClbQxyxDzOJag5ctYJJA9TAhU6IhpdTHMc5UGh7MTCivFybUkRN89NcOJ7+W4CrE4mEQ
	TdRoQFYQ1xJ+jqlWd0BahotRbEgnGh62QB2PCAzJCv/fog8Y0TlJVl9TA97fr6V1hSQNpX7WrppRj
	5391lQADRt8WCS0CcDCtyCpvvGQRtZKZ/qf1SWx08/flHNCDUFvlvXgLRrbnPBSdSoI455optma5C
	o1+rT5x/ka2DUGINg3D2zAtcapwv0Cpuy9zjrFd9oDLBy7CfslBgevG5ywWHGGrSYVvwSTuxgiG5+
	YlBYiAYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSGTY-00GViu-0l;
	Tue, 23 Jan 2024 13:06:00 +0000
Date: Tue, 23 Jan 2024 05:06:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] block: introduce content activity based ioprio
Message-ID: <Za+5uEpmNWbT8tXt@infradead.org>
References: <20240123093352.3007660-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123093352.3007660-1-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 23, 2024 at 05:33:52PM +0800, zhaoyang.huang wrote:
>  #define ALLOC_CACHE_MAX		256
> @@ -1069,12 +1070,21 @@ EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
>  void __bio_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int off)
>  {
> +	int class, level, hint, activity;
> +
> +	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +	activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> +
>  	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
>  	WARN_ON_ONCE(bio_full(bio, len));
>  
>  	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
>  	bio->bi_iter.bi_size += len;
>  	bio->bi_vcnt++;
> +	activity += (bio->bi_vcnt <= IOPRIO_NR_ACTIVITY && PageWorkingset(page)) ? 1 : 0;

The block layer must not look at page bits.  I've fixed all this crap
with a lot of work and we're not going to re-add it for another qute
hack.  The place to figure out any kind of I/O priority is the file
system (preferably using generic helpers).


