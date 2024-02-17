Return-Path: <linux-kernel+bounces-69958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB698590CE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719161C20FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BABE7CF27;
	Sat, 17 Feb 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kPggfQVX"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B77C0B6;
	Sat, 17 Feb 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186325; cv=none; b=nWzGNzIe3gDmi14uXrkBbKNAvARspowjruMhraW/KLW0fCloF5ylNGqYgNhxo8/rZai4IgjXxwJmv2Ezlfl2rq+iQtQaDn/8+eXgGk4XoF3eznBeazKxqe399oB3J8pQuLHxyzYp2KwxgfsUHUhEtEinJ7p83RYGSCEGQ6ekGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186325; c=relaxed/simple;
	bh=4zjzjqsCerJ94HPCxsMpNDuinRLjJ6fT0fdLNFwRI/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7GGNvsW08w6IDetn4br9qnlkFpsy3RUqpUO9lgFZvonScWY5YEZoBKlr45mOeG082WCwxEuLMZ6+PjyZt6G8tz1paC6Tm7r+Fcxqk1RJAp5fWXbKR8dF3XF8ZEqzmAwnS1xd0fOQqjEWi90PHlMrt6qcP9FZPQx9DMqcLqav5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kPggfQVX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=QOvkX/he/X3w7IIYy+vxewdPTV36nbUL1+0KsqgC1Ks=; b=kPggfQVXpWgIIWwY/gXTSMy+1c
	wp9lE807QC1UO/xX/WmrcGGZXwEr5FseYQtRphj75GVv3x8t13JCayvBXoI7VPA3TCWva5wMDd3M6
	v+r0GtNwm+HgZGVMxYLyxJ+sYL4vT08gMIMXAMR8lOLsKafC8feBYMUmY+0IK5G5htF1R4il2gYLX
	KzOZqsfWe7hERxpgdY6mW5MgniswHiN4qofNAarJ6N5w5o9Pg4RJH7gVT/tDgozZbP1/NlCFiSHa5
	wntWO4yam3SmEsIwOxSmAadY8HaJiscrj7rOXdsLU41VveBqov2726vj73EszvbFt86MCn4BH6YYR
	jlsjAGWA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1rbMqt-007xwA-3A;
	Sat, 17 Feb 2024 15:43:43 +0000
Date: Sat, 17 Feb 2024 15:43:43 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: davem@davemloft.net, sam@ravnborg.org, benh@kernel.crashing.org,
	akpm@linux-foundation.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
	glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v3] sparc: Use shared font data
Message-ID: <ZdDUL8q8U1QGZsLu@gallifrey>
References: <20230807010914.799713-1-linux@treblig.org>
 <86dbf602-7c2c-426e-8e7d-b91572357b3b@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <86dbf602-7c2c-426e-8e7d-b91572357b3b@gaisler.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 15:43:26 up 45 days, 18:33,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Andreas Larsson (andreas@gaisler.com) wrote:
> On 2023-08-07 03:09, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > sparc has a 'btext' font used for the console which is almost identical
> > to the shared font_sun8x16, so use it rather than duplicating the data.
> > 
> > They were actually identical until about a decade ago when
> >    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> >                         "broken bar" to "vertical line"")
> > 
> > which changed the | in the shared font to be a solid
> > bar rather than a broken bar.  That's the only difference.
> > 
> > This was originally spotted by PMD which noticed that PPC does
> > the same thing with the same data, and they also share a bunch
> > of functions to manipulate the data.
> > 
> > Tested very lightly with a boot without FS in qemu.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Applied to my for-next branch.

Thanks!

Dave

> Thanks,
> Andreas
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

