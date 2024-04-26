Return-Path: <linux-kernel+bounces-159385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19F8B2DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC31F2182F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF5EACD;
	Fri, 26 Apr 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YbVIVPPf"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3954BE48
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091233; cv=none; b=LVV7WE7+iPKbXafc9t6q2N8RXF5Ubkk7l3NPUqHWdO7V33oio4gWtdVX5FX+0Gx3aH348I+35+q4awdOWqgxvJU07/JpIqZYOIxOizwkvIL+Q5KI0jG6vAtyvGjwOnLnt/40W3mzHTjSeBVfvCtznRHAf+QrE+hdpyWIl6A0id4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091233; c=relaxed/simple;
	bh=6ZLqPJ79OAvK4ZDl5r7ixlLIkaymNFETzEUzOahTaPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiXCCc2d+oMWo5x20wyo+LGnX1LEEoJBqVOmqrWxuDWbpA5PG+WRAvzHuxX4tUkUZOtz5e4UFMUxORBPEEQu47jxzopIUr7/Sf5YddfatgQ8IKsF6n4J2ODXjQuh3SRWhG48mYnP/sgppxr2puEJlr+tABx05fYdqNgttv9xbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YbVIVPPf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 20:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714091229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74Ca9TZVZ4/9yXxdfEPPZI3l3hqJoOs9XFtaW+2gklw=;
	b=YbVIVPPfrA9evtJHL9Kb27hMnM/D5KQXgqK2yL2TjLglDiYQ0s3g6Zyg5BvbmmlAqKHuRM
	QgJ3Q02N6bdLd9v1QOOGZI29SDfgpLOvstNSblhQs5p6PCD6yfn0qLMDVk959d359YG2iv
	NdLCI0oqjuEqK7nzss6HT/bndZI4Aew=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 04:47:18PM -0700, Andrew Morton wrote:
> On Thu, 25 Apr 2024 15:42:30 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > > The concern about leaking image layout could be addressed by sorting the
> > > output before returning to userspace.
> > 
> > It's trivial to change permissions from the default 0400 at boot time.
> > It can even have groups and ownership changed, etc. This is why we have
> > per-mount-namespace /proc instances:
> > 
> > # chgrp sysmonitor /proc/allocinfo
> > # chmod 0440 /proc/allocinfo
> > 
> > Poof, instant role-based access control. :)
> 
> Conversely, the paranoid could set it to 0400 at boot also.
> 
> > I'm just trying to make the _default_ safe.
> 
> Agree with this.
> 
> Semi-seriously, how about we set the permissions to 0000 and force
> distributors/users to make a decision.

I'm ok with 0400 for now since it's consistent with slabinfo, but I'd
really like to see a sysctl for debug info paranoia. We shouldn't be
leaving this to the distros; we're the ones with the expertise to say
what would be covered by that sysctl.

