Return-Path: <linux-kernel+bounces-94642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E2D874293
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B712B2823BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F31BC3C;
	Wed,  6 Mar 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAHb35XV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F21BC22
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763413; cv=none; b=qrx3rpgjwKPz0Zv7p/1tq+spWmeyYAknX1evVbPZ2hoSUN9tteSvep7/iGxD4mMPish6XTAwGyI2hNjfgP+9VxzF7ocVuBj81s8bMPCK0h/UfDx2TOGPvjFD1GYa1kqs7+g/R/UImo9amnP+wuz3oQ3ajpF6DehiazOJL4mEllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763413; c=relaxed/simple;
	bh=YM/H338B8M01FdZ46y0o1dHxsvV8JzksBNCBnoZtyNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV7IuufSS24v92I5ciHciMxR9O493S1NtANE6nqH29JCDLDnBbn1YyXGeYFqEwjHtupjH2r47FsWpfFsLiy78a6GN0luprJ482NhROfjcENZEDAOlc0OsX2WgudtMdiqZ7VyqT7PDkIO56fcJGaKXyEu6tsmNglCMX+5mv4e8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAHb35XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FBFC433C7;
	Wed,  6 Mar 2024 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709763412;
	bh=YM/H338B8M01FdZ46y0o1dHxsvV8JzksBNCBnoZtyNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAHb35XVNOAsbZEKcgCqU8E/MP7fIzvLwtSBgmbKQVVGokuSzV15djI/zw9fqrC+h
	 m9/0EkQXCwKysGi/k11GzlM0JKQD+liQ57lPVMC9C6kH9TH+2nTLQPNuHWS9Lztpvp
	 Ki6xJ8j9+MG/hjkAwl4rQ7RATa0xd+L5gZiv5c5iGNyvScuaFXD+kLvxcRmhi0cyr3
	 /ye6KLpPNxI4kEVBiT0Gq0uvSjXj6CCbfFrJ6GPTpmkxxgcYgUsxoGOCnAKuuQ8qfn
	 GsuqPgBrUL7iTtH1rbsiqcq4Jc3DHxgvEhML2JJrDZOsLWe9XLpG9EuB3J6mvjWcbi
	 Qvdl8uFDh99CQ==
Date: Wed, 6 Mar 2024 14:16:50 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	xrivendell7@gmail.com, ardb@kernel.org, peterz@infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Message-ID: <20240306221650.sw3lha7kca2quv63@treble>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
 <20240306105420.6a6bea2c@gandalf.local.home>
 <20240306193101.s2g33o4viqi2azf3@treble>
 <854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>

On Wed, Mar 06, 2024 at 03:12:07PM -0500, Jason Baron wrote:
> 
> 
> On 3/6/24 2:31 PM, Josh Poimboeuf wrote:
> > On Wed, Mar 06, 2024 at 10:54:20AM -0500, Steven Rostedt wrote:
> > > Now I guess the question is, why is something trying to disable something
> > > that is not enabled? Is the above scenario OK? Or should the users of
> > > static_key also prevent this?
> > 
> > Apparently that's an allowed scenario, as the jump label code seems to
> > be actively trying to support it.  Basically the last one "wins".
> > 
> > See for example:
> > 
> >    1dbb6704de91 ("jump_label: Fix concurrent static_key_enable/disable()")
> > 
> > Also the purpose of the first atomic_read() is to do a quick test before
> > grabbing the jump lock.  So instead of grabbing the jump lock earlier,
> > it should actually do the first test atomically:
> 
> Makes sense but the enable path can also set key->enabled to -1.

Ah, this code is really subtle :-/

> So I think a concurrent disable could then see the -1 in tmp and still
> trigger the WARN.

I think this shouldn't be possible, for the same reason that
static_key_slow_try_dec() warns on -1:  key->enabled can only be -1
during the first enable.  And disable should never be called before
then.

> So I think we could change the WARN to be:
> WARN_ON_ONCE(tmp != 0 && tmp != -1). And also add a similar check
> for enable if we have enable vs enable racing?

My patch subtly changed the "key->enabled > 0" to "key->enabled != 0".
If I change that back then it should be fine.

> Although it seems like the set key->enabled to -1 while used in the inc/dec
> API isn't really doing anything in the enable/disable part here?
> But then the key->enabled I think has to move in front of the
> jump_label_update() to make that part work right...

Yeah, this code needs better comments.  Let me turn it into a proper
patch.

-- 
Josh

