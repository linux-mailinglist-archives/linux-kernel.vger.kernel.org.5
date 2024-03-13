Return-Path: <linux-kernel+bounces-100992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED687A08A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213941C22A82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1BCAD54;
	Wed, 13 Mar 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QkpHlH54"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CDAD25;
	Wed, 13 Mar 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292328; cv=none; b=mTfQI6WrHvUsQBGxCTD/CkMCUof0GxPy37TRJGd4kAVbvknOlZhqY/yFwjv0/kut/PvNDmwtg9EKFzP3Jq/9z4oJ8nm04DTg26UFpnDKsvtaJG+9WTsW0M4xtlTbFHtCRrKrcNFNJ/Gr9mZPba35UPIpkLHKbsKOKlqerqObHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292328; c=relaxed/simple;
	bh=Xp28m89tphCyPltHb8qKLxLSTrAyX5asPVVyb3lH2x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HymwzaeHWhEKbQm8/8+tKIJLVAi/LFmeKGrgDJ8nutBQzkUJ4ICx+pAHkyUVVh6rP6MVxkH9qQ4aMfcU3Shs2tjENXotJGht+8CLQr1CjIvy5NGmCEa2KhMCVOdwaRWNPfmmJK/VujngIES5+z6yAR4VddwA2QVsYTtS6t6RQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QkpHlH54; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TqsuPcIuwfxU9ldEwFf3ygLp9QwI+Zgl6lIFWmffSGY=; b=QkpHlH54vu6v6nxowOEc9SUX1P
	T3yAi/Raw/XSW/yvq7uRUr1bykTohr5V2+bxSBvLrIJjJmBz3udi+FGJ9580Rnnocm69bKv3uKQ6L
	mvUdzoLnmnsyKrnMgDq52Q+i/bWwhKarOuNyoWsIiWGVbFjBeWifz0VPQSmBoPf5L42pmyW3eGjKo
	gs2Rc9kWA+dtJL+Q7NiXO3UutDJEUrb2c+zJgJ6nBQBPFrob5TNcn83UB6Jgeumyef4WgnymfAQkm
	mDJJZ7b+2vm/JUD/I/cWBlGB9Canm99OJJGugZeVezqp6aksXgdvTBuYX/Kb7vh1cxazkuGYI45Bb
	U9KHFr9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkDA5-00000008JYn-370X;
	Wed, 13 Mar 2024 01:12:05 +0000
Date: Tue, 12 Mar 2024 18:12:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
Message-ID: <ZfD9ZdfCYVj9Qh-D@bombadil.infradead.org>
References: <20240131190251.4668-1-andrew.kanner@gmail.com>
 <20240201052958.GA14943@lst.de>
 <65bb648c.190a0220.d431d.4f63@mx.google.com>
 <ZbvfYqIKKWkTWLf9@bombadil.infradead.org>
 <65cbe0ee.050a0220.1c11e.d156@mx.google.com>
 <ZfDWV227fOffscv7@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfDWV227fOffscv7@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Mar 12, 2024 at 03:25:27PM -0700, Luis Chamberlain wrote:
> On Tue, Feb 13, 2024 at 02:10:45PM +0300, Andrew Kanner wrote:
> > On Thu, Feb 01, 2024 at 10:13:54AM -0800, Luis Chamberlain wrote:
> > > 
> > > While you're at it, if you want to try it, you could see if you can
> > > improve the situation more by looking at symbol_get() users that remain
> > > and seeing if you can instead fix it with proper Kconfig dependency and
> > > at build time. Then we can just remove it as well.
> > > 
> > >   Luis
> > 
> > Sorry for the late reply.
> > 
> > Luis, can you give more details of your idea? I re-read it once, then
> > came back and still don't understand.
> > 
> > I see that there are ~10 users for symbol_get() currently. Do you want
> > to stringify symbol names at build time to completely remove
> > symbol_get() from module.h? Correct me if I'm wrong since using of a
> > fuction which is not declared anywhere sounds confusing.
> 
> As an example look at the code and see if there's a sensible way to make
> some calls built-in instead of part of the module, then the module can
> have a kconfig builtin option, that adds to the built-in code which
> means you don't need the symbol_get().
> 
> For some other pieces of code it may require other strategies.

An example is FW_LOADER_USER_HELPER which is bool only, and is selected
by users. It didn't use symbol_get() before, however its an example of
how through Kconfig you can align requirements and define built-in
components, even if they do come from a module.

  Luis

