Return-Path: <linux-kernel+bounces-36699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4183A52E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AB28F506
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81818E14;
	Wed, 24 Jan 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWIw3d6+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6A182DD;
	Wed, 24 Jan 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088015; cv=none; b=ghn510BRO2xGSE2Nww3bybOB/BC7j+p84oXsESbsJ9XbOy8WxIxaYepB1P+/swaKV/xzbczfLvnNme7/N+Yh5wWTz6ZONQmztSAF1Xl5FTNVm+y/dOrC0xhFDd3QrWxomzm2P/9u879jgQrUL6Ni/PKzWF0Yv9Mz9v3kBvERH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088015; c=relaxed/simple;
	bh=0RNVoVPorVZfd5XfeIrUrbw9uQITz+8rwALrIiiF5SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk1bcq41CSORHkXm88eTSBV930pAQuoMkxaE69n+JnmUVZ6dY3GQbcSTNVnVqv6CkBVrKZK6ONbnZ03ErWQHlbxv22D2kewEsHAeizZV1oZ3zH2D4RexhJmbYfhkSuYwEZieazU0h+gtI/I9eqab5qwq7Zv162KbycsxwfTrCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pWIw3d6+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c+ZfvrjquqzlfSZdWFV1/+Mtsm0Gets8I4mX6+MdRHE=; b=pWIw3d6+jgURd/sfpZEVB1Aiml
	vM1O8VgYkw32OUUokRaha95eKs81ULZjWXHkhsUL3xnYi7r7PvBvftRJ8l4CSHNqUStqBEYptww4D
	5KSU1WgXxBv2BaluAoqZEYsilp+LiZ0knK8rhJU64j2F2+50DSmcLEdVbXywP+/yzCxyOilVOC2wm
	y7Ccnq0mtlWXFXosjW8h+s6X6n93pkulx1j6D9nuxjBLhhu4+TqaE36D+HZyhXzvfetcHgG74Acqa
	xTyMXU0qUnkKRyArkhnttoLhuWK0guIAsi4jn+v3AktzS0GlKGmF6eyYdu04dmhsFi5YWj+aJgTfH
	x171c8qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZQX-002BYQ-1t;
	Wed, 24 Jan 2024 09:20:09 +0000
Date: Wed, 24 Jan 2024 01:20:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv2 1/1] block: introduce content activity based ioprio
Message-ID: <ZbDWSUkT/OjHTe0t@infradead.org>
References: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 24, 2024 at 04:53:34PM +0800, zhaoyang.huang wrote:
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
> +	activity += bio_page_if_active(bio, page, IOPRIO_NR_ACTIVITY);
> +	bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);

If you need to touch anything in the block layer I/O path
you're doign this wrong.  The file system that is submitting the
I/O needs to be in control of the priorities.
must not hack the assignment behind the 

