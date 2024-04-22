Return-Path: <linux-kernel+bounces-152786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341FC8AC431
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1C51F21536
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BE41238;
	Mon, 22 Apr 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFpEfUjj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88E3FBA0;
	Mon, 22 Apr 2024 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767308; cv=none; b=QIcUTP3gcT/FgCRhSb+v+ohzJTbwu4bBCrnr7tld0D8sF2KTAr5Juo7Xt4IrloaDksZE7fJDwcP5dRPzjBa/ZF2+toIWOMpCdL2OwLHGQS7D9N8rrxGXLGjcEE6MVaa/kfgzrXKFMd9E35mdfq78nb9UcjkHJ1cnLnCDXcrN34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767308; c=relaxed/simple;
	bh=1CXRUi8kECrLxrQwSZnzJQdfh9qu0GY60yrCy+rztNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEMmpYWD6pWdrkWdJN284IgpzqpAGaUu8CAKpAn2eYZYsMVjMol5KrxIBoAak5BwHBnPCNIMJ+MR6Jb2fP0inQiaUOAbIASQHy5v2t2x8Lax/7po+6j5+d6t+P6mLNhtKjIgDodj+hDv39nBP0Y1J0SO3HiaMGJ527zGwX/Uqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hFpEfUjj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aynr/ns6L8RuQzuBfA56RC77v8u4u9ryKPKNAb0jnmc=; b=hFpEfUjjC8Igh6zP7W3i+VGNJc
	zumLU4Y1rKHn/m6pA+33tNtPvmgiv4/K4dB+jLsBpwUmJHKe3SaOsyeM92Qsm9RuYdgD/5YeIHA49
	qccolprv3Ybo4yJIbEMUnEcYhexmRXljLAWwwoqWrXW1FF1otOqNb5jKKaA+mGdP7Gb33W5tVAW4e
	7HycxgtlzVEIDXEadX5ZPrP34ET67rHalqUhPsqUiPL7DLNKrcfL55pykuBwhhns4qPyBSgEZWwQV
	PBNHEhuMmjRLGRPs13fbMGrAnhJq0+XOG9nhZyChUaZjKUBD5rPI0WEhaYzCjoZY347DTmIyBhYhA
	1ZHWxVGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rynAA-0000000CFgP-29a6;
	Mon, 22 Apr 2024 06:28:26 +0000
Date: Sun, 21 Apr 2024 23:28:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	harrisonmichaelgreen@gmail.com
Subject: Re: INFO: task hung in bdev_open
Message-ID: <ZiYDiptCPKDNwE-J@infradead.org>
References: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
 <ZiYDaN7fDzzEyVQr@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiYDaN7fDzzEyVQr@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Apr 21, 2024 at 11:27:52PM -0700, Christoph Hellwig wrote:
> On Sat, Apr 20, 2024 at 06:19:01PM -0700, Marius Fleischer wrote:
> > Hi,
> > 
> > We would like to report the following bug which has been found by our
> > modified version of syzkaller.
> 
> For your reports to be useful please make sure your szybot actually
> provides the same features as the real one, that is link to the
> reproducer, mention the exact git commit reproducing it, provide a way
> to submit fixes.

. or just feed your modifications to the original one so that
everything just works..


