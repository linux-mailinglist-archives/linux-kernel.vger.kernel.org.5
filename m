Return-Path: <linux-kernel+bounces-140495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5E8A156E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110C51C2142B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6814C5BA;
	Thu, 11 Apr 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSby2ypO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82A28FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841761; cv=none; b=nhRc5nhNv+xUTjetuqFT8anL+VdQ0Zhc6HtoK6kK6dYhpuRTdMQf+4ZcDqbII54QvmKgezQ2OHHq0j/nKzYYrKKPGQswpIUeuipm/JWsyiZwdywlLHNWK5BKhpXlOrfBBGhnjepKQ+dbcuiWBwViXClUyQFUq+lz+HF9lTeFhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841761; c=relaxed/simple;
	bh=oFQCtMDMv3w6WRwA1HLjJqSklYOlziJ7QD5xsD3KecU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5ORxkMOcYnYHXjTnazxaR5w4gHwtVrfL5gMvysGNmoNeK/3MTvRor0twWFJv7svmEpRH6iuIusZJQpFe5e/3PxjW1bJ8nK5OweqaEPpjeO5eXXG6oVt8pso1Ae9xwwogXuqfc07YZa/5N2nN6fVdlI2akkf4ouc25tISyBrOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSby2ypO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABB5C04D3C;
	Thu, 11 Apr 2024 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712841761;
	bh=oFQCtMDMv3w6WRwA1HLjJqSklYOlziJ7QD5xsD3KecU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSby2ypOwMO5LVMLeZ9cpiWm8pCYyRO/lkviEGzjZpwLQcLeWHU3HoW8Zwkcfz03A
	 jIvCjpX2uOAxPnLw3YkRmynzzBFcoc0W+/vXMto5opv3qkoonpyGZmt1WKXyphsgGG
	 u3voYUfF7R16ZkJ4ah1nu241bAmwh3byMTRkjUj1nSlz+zhuiFMP8cJlFUrn0jmhCj
	 w6Z56veQVpFNsKbQhDuF68oXfIz5Lr4t6fGN5nME9mSvm6qW3tlPaD5ET7ylZJuaZP
	 Intt8OWUs+KPYbQc7WFu253n8+coGwQH6saMAd/4dD8ry7D4/URbAitIQ7pTBcjo6n
	 lEPZiEo/bq8kA==
Date: Thu, 11 Apr 2024 16:21:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory
 overflow
Message-ID: <Zhfj4T1-u354E_KP@kernel.org>
References: <20240411032155.208042-1-ytcoode@gmail.com>
 <CAMuHMdULF9KemeFkv09s3b9T8Ka-AkC8A8-pc_FpdXnjrOjwgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdULF9KemeFkv09s3b9T8Ka-AkC8A8-pc_FpdXnjrOjwgQ@mail.gmail.com>

On Thu, Apr 11, 2024 at 09:23:47AM +0200, Geert Uytterhoeven wrote:
> CC Hiramatsu-san
> 
> On Thu, Apr 11, 2024 at 5:25 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
> > static_command_line, but the strings copied into static_command_line are
> > extra_command_line and command_line, rather than extra_command_line and
> > boot_command_line.
> >
> > When strlen(command_line) > strlen(boot_command_line), static_command_line
> > will overflow.

Can this ever happen? 
Did you observe the overflow or is this a theoretical bug?

> > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")

f5c7310ac73e didn't have the logic for calculating allocation size, we
surely don't want to go back that far wiht Fixes.

> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> >  init/main.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 2ca52474d0c3..a7b1f5f3e3b6 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -625,11 +625,13 @@ static void __init setup_command_line(char *command_line)
> >         if (extra_init_args)
> >                 ilen = strlen(extra_init_args) + 4; /* for " -- " */
> >
> > -       len = xlen + strlen(boot_command_line) + 1;
> > +       len = xlen + strlen(boot_command_line) + ilen + 1;
> >
> > -       saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
> > +       saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> >         if (!saved_command_line)
> > -               panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> > +               panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > +
> > +       len = xlen + strlen(command_line) + 1;
> >
> >         static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> >         if (!static_command_line)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Sincerely yours,
Mike.

