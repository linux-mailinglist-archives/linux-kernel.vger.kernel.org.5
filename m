Return-Path: <linux-kernel+bounces-49862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBC8470A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9AF1C228A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BCE5253;
	Fri,  2 Feb 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fM4KnXiH"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAD185B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878078; cv=none; b=Qf2SWTaMkmXr3vLQ5Ec8yimYxipMGZ7qRuiAHtnurfrdHm3uj7IvJ8nCy9EsbcYAJjU/CVvPAvqAh480WjkGdbq5yiTDoIY3SG5SxdUTPcfKqdrFrtTDsc7iRSZCJznthPSa1P3cOYthq9p4rllHp+3z3JvqkkmaAdQOnunSQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878078; c=relaxed/simple;
	bh=RdTmza3iZdCn9aokmFdZsGKf1WkeNmgHQkyy7tSm8lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMl4QdeJ9XGclkLPlUK57z189OXpsDpcKx0f9pk9btQACWDVctz2s/vJYfqauC2efZZz5CwWe0T6xbuIrNZJ/ClMfcWjZ/feI9QQqyChygB5LJ5VFxeu3uIbkhCju3w+4WcvUiPWSKNQ0DI3LFNhAAObt5TrIslNK/jhQyQgLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fM4KnXiH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 07:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706878073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xb97amKiVjHfa56AqmJwWt5AiBv9K/QA/PEcc/1iKAU=;
	b=fM4KnXiHEeMdAKYtzIZQSnI4BYWCbgXBoXDNmFxQt6LB3ps+0jhsSPrdCEBvRner8OmAxX
	ZxpFZp9CwTdDbNAh/e0+RTQfz9C63GdnrEQJ8RqGEqkW9jlMqrx4FrVPefi3CtwtKTO3Ym
	HyzeF71W3DAuKwjIBvV7QhPGHa63+sA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, peterz@infradead.org, boqun.feng@gmail.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
Message-ID: <3nakly5rpn4eomhlxlzutvrisasm6yzqaccrfpnpw2lenxzfmy@vpft5f4osnye>
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
 <20240127020833.487907-2-kent.overstreet@linux.dev>
 <20240202120357.tfjdri5rfd2onajl@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202120357.tfjdri5rfd2onajl@quack3>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 02, 2024 at 01:03:57PM +0100, Jan Kara wrote:
> On Fri 26-01-24 21:08:28, Kent Overstreet wrote:
> > *_lock_nested() is fundamentally broken; lockdep needs to check lock
> > ordering, but we cannot device a total ordering on an unbounded number
> > of elements with only a few subclasses.
> > 
> > the replacement is to define lock ordering with a proper comparison
> > function.
> > 
> > fs/pipe.c was already doing everything correctly otherwise, nothing
> > much changes here.
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> I had to digest for a while what this new lockdep lock ordering feature is
> about. I have one pending question - what is the motivation of this
> conversion of pipe code? AFAIU we don't have any problems with lockdep
> annotations on pipe->mutex because there are always only two subclasses?

It's one of the easier conversions to do, and ideally /all/ users of
subclasses would go away.

Start with the easier ones, figure out those patterns, then the
harder...

