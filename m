Return-Path: <linux-kernel+bounces-159727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC918B3336
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764C2B21748
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333143AC5;
	Fri, 26 Apr 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EenxUM0r"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8DF824BF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121212; cv=none; b=ZZKtVsHJYq24VRercIriNEA9CKRVfIcRSDhn0LauTP3y0F8PSVr+S1sVozQWKiphTBMAhT8+LeQFgiTZ6jddBIt3pPAXzTNzp2zVYbW502djWCl8pQ/B39nntb9bGY2U7acNSWVekB2npN8Z5m+/6gMYpGjaMiWdSByUs6Y3LaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121212; c=relaxed/simple;
	bh=aSRZo1R/V0HkN+sFEJyvYL9owvPFQd9CoPfi0h+CIWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZHEb4VFnWIgkoS7DPWdSDlLGCx1Z8TQeYAzILsHJjf+Q4U2Tmg+yK0EHOYaXoTldAu052arqdrBIc5pv1jfD7GFpFv0eGYpfHJ6SIbTyAviq+8hOLT2evDNw4iJbozE9kGjB7aou/VXKvrR+YZlY//arc/ROgSSSre0/0Au1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EenxUM0r; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Apr 2024 04:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714121207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fD6phTLFszOoj2PuCrCjp02WsBZ/dFu3rb01qh85uXU=;
	b=EenxUM0ra1YpDLwe8ySCjb/39+3a0W7+RBiOtxGJPXMfE49jWH3Yv/676XOdijykrVANke
	dsoPiW63bw0jH0SAcj8LWySgngy9sg2BORG8CfHyU68tq/NjgR4ixolL2U1JTZvQ8c7B+N
	BEDitbYZBUgvaUhA4X8FBE51aSNUFIk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pavel Machek <pavel@ucw.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <lrxro6vscss37qje4guawymibqcpao4ar4oitc4wjnpkfgkhdi@pmfn3gi2wvxn>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
 <Zitmm2SWucJA1Bdb@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zitmm2SWucJA1Bdb@duo.ucw.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 10:32:27AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > > The /proc/allocinfo file exposes a tremendous about of information about
> > > > > > kernel build details, memory allocations (obviously), and potentially
> > > > > > even image layout (due to ordering). As this is intended to be consumed
> > > > > > by system owners (like /proc/slabinfo), use the same file permissions as
> > > > > > there: 0400.
> > > > >
> > > > > Err...
> > > > >
> > > > > The side effect of locking down more and more reporting interfaces is
> > > > > that programs that consume those interfaces now have to run as root.
> > > >
> > > > sudo cat /proc/allocinfo | analyse-that-fie
> > >
> > > Even that is still an annoyance, but I'm thinking more about a future
> > > daemon to collect this every n seconds - that really shouldn't need to
> > > be root.
> > 
> > Yeah, that would preclude some nice usecases. Could we maybe use
> > CAP_SYS_ADMIN checks instead? That way we can still use it from a
> > non-root process?
> 
> CAP_SYS_ADMIN is really not suitable, as it can do changes to the
> system. On working system, allocinfo is really not dangerous, it just
> may make exploits harder. CAP_KERNEL_OBSERVER or something...

There's _really_ no reason to use capabilities at all for something that
has file ownership - just use a group.

