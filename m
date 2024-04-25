Return-Path: <linux-kernel+bounces-159182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834728B2A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AA71C22B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12352155311;
	Thu, 25 Apr 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1VhBEb1"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A7152E13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079094; cv=none; b=tnnYnJjGas2ZaQ5N2iiAK//H3MDvVdJ90qR1td4zLFcbUNTwq/+IMuVsLRpswxDi0esJE93MpR/2CGNML52niBQEvaMOWAAs97J6VsHHX+2d36pa8on16dfItprzers3e+YX9zhReEj9EEdeVgAexxBUvfYJSyAlLbW70f30D4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079094; c=relaxed/simple;
	bh=Nu0VY0jwpK1DX56a0LyK3/k7gCJhFBWD17UiCPPfiM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEdoZ5FJK8aY64K3L5A/CKQYfKyEsQm7Q+r5WsivQ8eZy0BThJ5UOZGVDRHCR/sbMP8vuyTYKUlJSFIMD5OnVOyPF2Dg6YjjRISCjubWsIhh5FKMpcMXDC4p7/p6SAZ7MOcUKb47E/257MdO6AkMimWvhxQz6+A2wI6lDpzyTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1VhBEb1; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 17:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714079091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VklnmrM/oloTOZKNCrwIWgMU+XqIMz0SMCJXUZUJzsM=;
	b=s1VhBEb1oCQ6MjYq3v8dmqur48xfAGo5Bo39s4wNorebzmH6gvf2V7i0tet2AM0MLF0RJ+
	RPfAIodbT0oZlE3tTViJVpCPHYbZQ0OrjfrIlr7kNApAQS7i1wurRUqchGHzGBQAPWnWw0
	Ia5a2fXMLZd9ZM5wUE+MOVK2tP5y/rU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZirCbPR1XwX2WJSX@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 09:51:56PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > > The /proc/allocinfo file exposes a tremendous about of information about
> > > kernel build details, memory allocations (obviously), and potentially
> > > even image layout (due to ordering). As this is intended to be consumed
> > > by system owners (like /proc/slabinfo), use the same file permissions as
> > > there: 0400.
> > 
> > Err...
> > 
> > The side effect of locking down more and more reporting interfaces is
> > that programs that consume those interfaces now have to run as root.
> 
> sudo cat /proc/allocinfo | analyse-that-fie

Even that is still an annoyance, but I'm thinking more about a future
daemon to collect this every n seconds - that really shouldn't need to
be root.

And the "lock everything down" approach really feels like paranoia gone
too far - what's next, /proc/cpuinfo? Do we really want to go the
Windows approach of UAC pop ups for everything? I'd rather be going the
opposite direction, of making it as easy as possible for users to see
what's going on with their machine.

Instead, why not a sysctl, like we already have for perf?

The concern about leaking image layout could be addressed by sorting the
output before returning to userspace.

