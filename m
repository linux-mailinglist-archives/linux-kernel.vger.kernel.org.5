Return-Path: <linux-kernel+bounces-152784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F7F8AC42D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C0A1C212A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1934120B;
	Mon, 22 Apr 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VvtB3a7i"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8C2BAEB;
	Mon, 22 Apr 2024 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767274; cv=none; b=EX43nmlq2pn+7r83lLucxlA8X7xMfl8QSCnKB2GSZtSMUIbSabO33GyGwA9o1OHn/820z4VMvImPc+meNo3Sx1frfO6NeacBWiECBrw0tJ+OSG8dZAAGMftLTGE3qLxeS8hf/J5/CT3w+vVvTF08J4l9UklnvvslA9/sztVPo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767274; c=relaxed/simple;
	bh=wWpP86gA2HALaUhmci9H61XrMGZbnbW0oJ9RXEDJE+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvE2qK8XYM7IT+tgWxFKTdDWxL1csH6wnEWF+BVlyG7s0rDl+m2UUzqZncRHCBSJP1t1DCpJFZB1WX1AzuusSNNl/p5g43KMxQzx2UKWD/A1HeGQW6RaBYRVzA2GmgjvJ2h2/NnVMWHz85sBqFwewkAAQ+Rs4vEECXEKcgd3uMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VvtB3a7i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3KYviStJPjU7WXAc2NZoJO3MuarI/nLZGkoJmTgiM0=; b=VvtB3a7ixH1xGOOxAJ28dYtw+Y
	BvYIoyhucr4MNFhCKgAQ9pIE5Wb+KRylNFaj2XjiGfMAtoy/ZToRbGkP5xF1G+zsA+xI35R8XuL42
	wT2dO7dVtKo46jEh6QnoAXY7d88o8fwXZaDZpQ6XZkbKXvJtl3coTVNl//vOIHaNWPc20I4j+DtKP
	FM54nLCqwSd6YP2BHEs15LmxkRX14HQaRlA6k8kdS+uuSiojI9xTKrMqfxGzLNAH4a0nOEIv3gr9T
	7F89xO8ICJ0bH0M+33a/eisTVXMgLP8p7LZLZNIlTU3wkqbCEpbnXZ01nO/qsbFh4BbEzd9+SGU+m
	Zov2Nq3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryn9c-0000000CFXZ-3fpj;
	Mon, 22 Apr 2024 06:27:52 +0000
Date: Sun, 21 Apr 2024 23:27:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	harrisonmichaelgreen@gmail.com
Subject: Re: INFO: task hung in bdev_open
Message-ID: <ZiYDaN7fDzzEyVQr@infradead.org>
References: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 20, 2024 at 06:19:01PM -0700, Marius Fleischer wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.

For your reports to be useful please make sure your szybot actually
provides the same features as the real one, that is link to the
reproducer, mention the exact git commit reproducing it, provide a way
to submit fixes.


