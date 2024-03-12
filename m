Return-Path: <linux-kernel+bounces-100884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EB3879E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1551F286897
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4331448CC;
	Tue, 12 Mar 2024 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8BkA3df"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFC14375A;
	Tue, 12 Mar 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282329; cv=none; b=ViwwH8Z5VkxxPkSB2+M2/YHGzBYbP5FulbfiTB2Ma/C+rC4EawlXGOCTnKvIFnfyiWyXX/vENhcfwjpZZIU2PtIha8pd8fjVPyaAWwuvVWi/OdNzTVnQQDS1n8J+Og3g6Ssdm7DYsK96PTPXXmssJnCFE6Oof0wlRC4UQRoJwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282329; c=relaxed/simple;
	bh=OO2ImKt+yzE/6mQxJap8nWoSwoNAyzAeOPGUmuM5ZJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg7MR0pShC0juiEHT9WjOmwuJxvDN86l37loLxOKNNLXlKbUgiNd8yOvmR7ZX42F9CgesuLjodXIeE/u5afPkzEEmBzTA+Bb+7NJXzcAzi/5RW5AO3cqYtWi3oEKP9/k0E31CAEA1F6pcB5nmDUDAlQtwejBMZqr83uwZ4zE/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8BkA3df; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dshDnzyUQrrdegtxX0ygDjlw8CGJ1te6VM9OOwOHvzQ=; b=T8BkA3dfi2yTsF2TqGpUTvHNcZ
	AGWp0DBuTYTWk1VA3uDouywKT5w7gJbGIJ/NakCsi44nfjbEzz0sjPLROkR+7rtgs+KLfbYEf0mhR
	XEMlCxP3JHjs3B/wlvmrdEE38cTvGhkNOvqxeQAoTwbqqDMeYxUB218tIXCtsg2397TOrPaZ+jiTo
	F6wKaVkryuN0cwHMqLYuWOS73jA+dpN6k6Pkg3gpt8I0IytHdtA2wsvEyufWVXX4xmVqcSowLUk0g
	aTGjAEJEcQuVN2FQTTWAbYHFreJz/5e4qd5weo8BgEKEzm2v/axUzLC6eSpgwAajcw5ObHlY1c1NB
	imeIWiYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkAYp-00000007oot-2n0R;
	Tue, 12 Mar 2024 22:25:27 +0000
Date: Tue, 12 Mar 2024 15:25:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
Message-ID: <ZfDWV227fOffscv7@bombadil.infradead.org>
References: <20240131190251.4668-1-andrew.kanner@gmail.com>
 <20240201052958.GA14943@lst.de>
 <65bb648c.190a0220.d431d.4f63@mx.google.com>
 <ZbvfYqIKKWkTWLf9@bombadil.infradead.org>
 <65cbe0ee.050a0220.1c11e.d156@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cbe0ee.050a0220.1c11e.d156@mx.google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 13, 2024 at 02:10:45PM +0300, Andrew Kanner wrote:
> On Thu, Feb 01, 2024 at 10:13:54AM -0800, Luis Chamberlain wrote:
> > 
> > While you're at it, if you want to try it, you could see if you can
> > improve the situation more by looking at symbol_get() users that remain
> > and seeing if you can instead fix it with proper Kconfig dependency and
> > at build time. Then we can just remove it as well.
> > 
> >   Luis
> 
> Sorry for the late reply.
> 
> Luis, can you give more details of your idea? I re-read it once, then
> came back and still don't understand.
> 
> I see that there are ~10 users for symbol_get() currently. Do you want
> to stringify symbol names at build time to completely remove
> symbol_get() from module.h? Correct me if I'm wrong since using of a
> fuction which is not declared anywhere sounds confusing.

As an example look at the code and see if there's a sensible way to make
some calls built-in instead of part of the module, then the module can
have a kconfig builtin option, that adds to the built-in code which
means you don't need the symbol_get().

For some other pieces of code it may require other strategies.

  Luis

