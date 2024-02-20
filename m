Return-Path: <linux-kernel+bounces-72724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9185B7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A381C20BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C82612D6;
	Tue, 20 Feb 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdasEJXK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01968612C4;
	Tue, 20 Feb 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422163; cv=none; b=YHOYGLPOAmOAlEb3NPtbpxGBJkEtoDLit5OMDralDUfcUvhU3ifeDmFDzB/ZsmS7GeUrgKPMd/YGhkfqU9tHSbRHEiDSdw0/P2BMlorJhSeQAlU1Av1OQVT2lXXle2hlDfM8rvDK1oR2dnjegqbOtdNUtf0J7D+LtB5vP0kND+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422163; c=relaxed/simple;
	bh=uDG9cAYKJYSYSHi325nWVNf8kjyRZS47PqKTYPJsUAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra2Dm0W1400as/i6CQ6V84DTOvEKkpZLgWVARpZ25UU37dAjV8QLBL3wFDBqINeOoL1zfX5TFT8ZKzhYWunt2a12VFXOKvsADpVwtzIflMWddrYkBL/iIoT8KUIT9nYcqFfCvDz4OaNe1uVU3Aia2CllCUs6z+VkatkH+hcjAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdasEJXK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5SSkrbrnicB74FPesB7xzBJgVzBnvlkeQP7w3VkDLKU=; b=BdasEJXKfWVY+L9Pc4se7Nr7+o
	si6UvA4SUbJeKoz3mH4fBTuOvl9XdyYqliKSLK2SFHdARXj1RwEJcvgR3gy1f7IBhYHqDfRjQwJDd
	o12R+g2RBtd4e3dinT87WSCprqhcv/5SGLLhVw+VbFD0rjMV0TWxKTYhlK9p8AN+DHIfWiKHiT4IQ
	5XTpSRCLhBRoSndPrNMqWTVE2Q8rey+Zuoolp8GJiPk4mE9tNK553y2JRMls8xao0oFnFa5Q+vB11
	GZ/qAVKNGG9qUeHr1xupgkVtUJgAk80OZwfaBhGiTrhD5C3qN89lQZ7NPnmfCQEWpQja8Eg21uiVN
	uevkRmhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcMe6-0000000E3ir-0atQ;
	Tue, 20 Feb 2024 09:42:38 +0000
Date: Tue, 20 Feb 2024 01:42:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH 2/2] block: adjust CFS request expire time
Message-ID: <ZdR0DtDCWWFkSiUn@infradead.org>
References: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
 <20240220061542.489922-2-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220061542.489922-2-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 20, 2024 at 02:15:42PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> According to current policy, CFS's may suffer involuntary IO-latency by
> being preempted by RT/DL tasks or IRQ since they possess the privilege for
> both of CPU and IO scheduler.

What is 'current policy', what is CFS, what is RT/DL?  What privilege
is possessed?

> 1. All types of sched class's load(util) are tracked and calculated in the
> same way(using a geometric series which known as PELT)
> 2. Keep the legacy policy by NOT adjusting rq's position in fifo_list
> but only make changes over expire_time.
> 3. The fixed expire time(hundreds of ms) is in the same range of cpu
> avg_load's account series(the utilization will be decayed to 0.5 in 32ms)

What problem does this fix, i.e. what performance number are improved
or what other effects does it have?

> +		 * The expire time is adjusted via calculating the proportion of
> +		 * CFS's activation among whole cpu time during last several
> +		 * dazen's ms.Whearas, this would NOT affect the rq's position in
> +		 * fifo_list but only take effect when this rq is checked for its
> +		 * expire time when at head.
>  		 */

Please speel check the comment and fix the formatting to have white
spaces after sentences and never exceed 80 characters in block comments.


