Return-Path: <linux-kernel+bounces-77844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA4860AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292901F250D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577412E43;
	Fri, 23 Feb 2024 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EUL4UEIP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FD12B6A;
	Fri, 23 Feb 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670479; cv=none; b=nEvGwpkGZScwWRubPqT+hmcDFWqgWSUl3x2cQLZGZXbqDYwnAWaaFEYMpL869vTjoEN7nwPKM9Vz683UNCJfXeZNuQP0Rozq6CUfslm14DZLRkyr/nlGcAIOeFDTBJK6+s2QbGMFpWMLJb7NJ4wKm8cuEkJR9rLvJKXRCmVF5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670479; c=relaxed/simple;
	bh=dypHDYf4wlvZtREbD73PlIUET+KS+kYSAis3lxZth+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzUQZA1+uJGC9SxEj4ra3L2HynGUM+Phs4nhkxWHi2W+avtICaSO2uBTQ5IRZy1cbq4ntETjec4dRI42mJ/unsWw0vEJx64PVN4Vc8BYFvy8ggq5RmmOFBU4qOcjLKykvXRpyq1YdwFE8AEe0Q0q4AY6DGGDEoCgyd9pnyzRkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EUL4UEIP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l1Z2QgoLNvQn9EbmGVVkeygMx21FKuk+s/9jRpAWTkg=; b=EUL4UEIPpJeOy4pPl2ZhPSaAta
	osmyuBSVNzjjGtxnSLseTF1O2YCxpTfPDmPMiW+tiGo3T7IwxpoHFfHFqvXL1KMLGu5HxrjoqRn1V
	DLeXHhlZI37DxS60a9X3N4DaUP+hVVEFQ5b0u/f9kmBQPq6dR5cwTUkWABW0FR69rZQ72WM/H5veG
	UKYEpfxIBGPFDH526NpxRtqArwhfKME6kkQCEyx0em7UUFK3DQBgQ7aBpVYfLRNboZEEzHvUJ44wi
	PYS71Pgi29EcvTrpbc5Sf2qc6fecQNvFSv2IaPBkuj1xAkznRBfj+zrxfLg9HuxOzrcPKKazja+UV
	hV3El6aA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPF4-00000008Cua-1ADq;
	Fri, 23 Feb 2024 06:41:06 +0000
Date: Thu, 22 Feb 2024 22:41:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv2 1/2] sched: introduce helper function to calculate
 distribution over sched class
Message-ID: <Zdg-AvQpsgB8AS5X@infradead.org>
References: <20240222092220.642294-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222092220.642294-1-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 22, 2024 at 05:22:19PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> As RT, DL, IRQ time could be deemed as lost time of CFS's task, some
> timing value want to know the distribution of how these spread
> approximately by using utilization account value (nivcsw is not enough
> sometimes). This commit would like to introduce a helper function to
> achieve this goal.

Maybe I'm just thick but this still looks like alphabet soup to me.
Can you try to exlain why this matters, or maybe get help from the
scheduler folks to help with explaining the concepts?


