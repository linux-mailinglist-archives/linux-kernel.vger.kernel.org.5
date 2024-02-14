Return-Path: <linux-kernel+bounces-65845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E838552C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69D81F2AEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574713A264;
	Wed, 14 Feb 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S121XmqB"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D98133438
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936908; cv=none; b=qO5CApT442E9wdoUtUjaiK+PXpKCG5N7a2P2dReBXkNc6y8MppBEhM4lFPG22DesBQI4xvy6sxJIrZJsMsqWLZkiFUUj1xHSRl8LYiB4pit7oQ95zQN7CFewtSSjTiGDe2AiNysKYg9+A0TUoLGJ23xgUBgzjaYGAIxWhSg/u/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936908; c=relaxed/simple;
	bh=lT/X1AIRbNk2Neq323mkmWwsYEJAMoQ7QdshwawIU6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOM06nfZF3eo5It4dZ3gSwaVRw6Nx/BQr3BTu1UIH/wGswRpVODRAse5XvzU+yphcqX/BJlrnts/hvEV4ISGlUs5gPQZ5kXDtoHwUCU2TgU1uSH3/ZMSdCkPMqJ+zXXPPEBNpQIR+ONIkBclQCdMjQTwJHtCQ1k/zEgMmyqo2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S121XmqB; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 13:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707936903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Acyz3pxZ6tCdv6t4q4690mcuB0394xgkvrjHbXOFy0k=;
	b=S121XmqB4Qi5DZat/IhkTFGklxKssSiWwrtQpzwhO8jfsjtgtAFewhQxjbqx0whAdBMbe9
	Fyk3P7FsgOcXD5aA/gL0sr9TgmV4fl9YPHU0SixTl80DWi5kAxxP9NJvhUvLBbzRqgzA3C
	Ox/w7ZMwvC+NKXnyI/FT0xmc3dQ/+U4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik <petrtesarik@huaweicloud.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Kaplan <david.kaplan@amd.com>, 
	Larry Dewey <larry.dewey@amd.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Carlos Bilbao <carlos.bilbao@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, 
	Marc =?utf-8?Q?Aur=C3=A8le?= La France <tsi@tuyoix.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, "Christian Brauner (Microsoft)" <brauner@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, Mike Christie <michael.christie@oracle.com>, 
	Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <g3llwlzlhatvz2a23cntx7lscqarepq4uyaq6wne6my7ddo3mk@6b64pjcnykah>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
 <20240214113035.2117-6-petrtesarik@huaweicloud.com>
 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
 <2024021425-audition-expand-2901@gregkh>
 <20240214155524.719ffb15@meshulam.tesarici.cz>
 <2024021415-jokester-cackle-2923@gregkh>
 <20240214173112.138e0e29@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214173112.138e0e29@meshulam.tesarici.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesařík wrote:
> On Wed, 14 Feb 2024 16:11:05 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesařík wrote:
> > > OK, so why didn't I send the whole thing?
> > > 
> > > Decomposition of the kernel requires many more changes, e.g. in linker
> > > scripts. Some of them depend on this patch series. Before I go and
> > > clean up my code into something that can be submitted, I want to get
> > > feedback from guys like you, to know if the whole idea would be even
> > > considered, aka "Fail Fast".  
> > 
> > We can't honestly consider this portion without seeing how it would
> > work, as we don't even see a working implementation that uses it to
> > verify it at all.
> > 
> > The joy of adding new frameworks is that you need a user before anyone
> > can spend the time to review it, sorry.
> 
> Thank your for a quick assessment. Will it be sufficient if I send some
> code for illustration (with some quick&dirty hacks to bridge the gaps),
> or do you need clean and nice kernel code?

Given that code is going to need a rewrite to make use of this anyways -
why not just do the rewrite in Rust?

Then you get memory safety, which seems to be what you're trying to
achieve here.

Or, you say this is for when performance isn't critical - why not a user
mode helper?

