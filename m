Return-Path: <linux-kernel+bounces-94107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55494873A17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99C01F26808
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A113475B;
	Wed,  6 Mar 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZSFZ7s8Y"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4C5D904;
	Wed,  6 Mar 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737485; cv=none; b=k85yBnU/2Vuzs8xTdOlPY9ZIEijQU/XWZZqR7iSfD1ZixMr+ej0b7PVgekP+NNknx8C70EDmy/b9TYZEJEtl/qntpVpqyTVeZvSkq+hx+lxg4NyN+VqDh5cooq51QrhRP8WlE7JO5yo2Hf/NYNdMicaDErNXdW4D66i+7dLED+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737485; c=relaxed/simple;
	bh=s0cP/vdeTBfqUMpPi1K2dMYOFXlNATU+OscAfsIgh9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVBauO5XqTUwpANohxNPl7/09XovzAhJMj0K2kGifo8OtTMe40QnqVPH/B2X0nVFd+V2gbcqOugnRO36pOIxUQyquikhdmX7p2jigb4MUzFyJv+M7JonEdmkA020jFqAOqAUFNMZv0kKEGnUnWXy5r6V2cqurgeP7+wxj+i8LUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZSFZ7s8Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIU+Y5tx9f1r7LHMtxJaaNjMHc4LWtkAUlFKv4XMp0s=; b=ZSFZ7s8YIDIt3b0Xse+j2mtEhj
	YBv9PmhQb2Sr+mtg/nLN85fQCd08SSYbxHLzctr+hn9NTjtJpKHlOZO3UoZkorkMF8JxiHBn35N+K
	kcCo51zZYbX228avPHZxiQzHGn5kj1WL7jgXHzPJKtzaA4Q33z8OYpDxSbyTw0jB/VCXk50bHviC7
	l91UxkVIUBnshpCIvi6dqC6HKYm9rVf/uMuASQlVOPcBPM7dYi7Q/UN+NcF2mwUXFqGB4zFTD+drp
	9/QveY/6yGnml+UULDxNINgBZVmuKJ7gj7tBN5HHWorUcTW2fosCnVaES8QpEqpwQc/15FN9l/RS3
	CX7hQ42g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsow-00000000hHr-35do;
	Wed, 06 Mar 2024 15:04:38 +0000
Date: Wed, 6 Mar 2024 07:04:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-parport@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	iommu@lists.linux.dev, linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Message-ID: <ZeiGBuMN_I9V94Mx@infradead.org>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 06, 2024 at 03:19:52PM +0100, Andreas Larsson wrote:
> > I think that is the correct thing to do then: the only
> > drivers that I see with this dependency are PCI sound cards
> > that apparently rely on DMA to the 16MB ISA range, which is
> > not provided by sparc.
> 
> The ZONE_DMA dependency does not seem related to ISA per se. Commit
> 80ab8eae70e5 ("ALSA: Enable CONFIG_ZONE_DMA for smaller PCI DMA masks")
> that started to introduce it did were about ensuring 32-bit masks.

Yikes!  That commit is just unbelievable buggy.  CONFIG_ZONE_DMA
is only for architetures to select, not drivers.  A driver randomly
enabling such an arch zone is just crazy.

I've been wondering for a while if we need some Kconfig magic
so that certain symbols can only be select from arch/* and not
elsewhere to prevent this (we had a few other similar cases like
DMA_MAP_OPS).


