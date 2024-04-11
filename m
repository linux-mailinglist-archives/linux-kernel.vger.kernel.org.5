Return-Path: <linux-kernel+bounces-140649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334F8A172C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42E71C2120B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B114F112;
	Thu, 11 Apr 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISte5fHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290F14EC7D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845747; cv=none; b=af7Tpi33LX/j36k1INAjzGtGP6s0KS9EVCarPDJEPiDdhS3BGusb6YlVG41CTFyHLm0ATtUDmn8wTMqOdVzvxAnleCa+sC2/APr0WJUfzEEPqGqUKb0+/BoWOHt0lMI6dp89VhuBJwWQoaJDKBkVxKk3NpH+4cb5eF18l4sD7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845747; c=relaxed/simple;
	bh=SW4hK70SXQiIF+IRlkKS131ASNl2NwZlPORYfiz9RvM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EBcrqI1pWtSC/hPSe50CPBozX4tZ/7U27qynCHl+8nF8hBJHMh272KNNjJUw43t0R86G3kXxukwktBa5kvStKUF1R3QZm84yDfxIAQdBsYVcDbu9SLno5Hky0FihrMPW7JvgDV2kBiHZEH3W/ZVGwN6xol4uqBSDJCiVgvAGzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISte5fHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30382C072AA;
	Thu, 11 Apr 2024 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712845746;
	bh=SW4hK70SXQiIF+IRlkKS131ASNl2NwZlPORYfiz9RvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ISte5fHvgDWUeoXFyTXouydVIdLkpywu6P7naRterLnTVxRm7lhZ+9cyk2PVtzibE
	 11PGtm3Il+KskyBAp2h64dt3qCs5NOJHmcQv3K5QlQMZcr3wtmjUNnb2LqHZFf/V4F
	 xf+BQ5Ipz5/N+79tfB+niD5imHAu9iLZS5aCPeY3loi+EI20WU3+LCYBlXz1ML9RZs
	 6iz7CM1irKPif8UPFB1sJT4WrC5KmjAyGlYhuUpngTMJvzCFvh9uFZoJbxPhNfrrgb
	 xG0T1UPmhVPjQabQj4T4Cqqkr9yGcotfVQakA7uYDW9/8hm9zbtr0h/phusudz38v7
	 t9jIe0XhqENlQ==
Date: Thu, 11 Apr 2024 23:29:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "ndesaulniers@google.com" <ndesaulniers@google.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Krister Johansen <kjlx@templeofstupid.com>, Arnd Bergmann <arnd@arndb.de>,
 Mike Rapoport <rppt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory
 overflow
Message-Id: <20240411232901.2c0aaa13f790d0ef97e484cd@kernel.org>
In-Reply-To: <CAMuHMdULF9KemeFkv09s3b9T8Ka-AkC8A8-pc_FpdXnjrOjwgQ@mail.gmail.com>
References: <20240411032155.208042-1-ytcoode@gmail.com>
	<CAMuHMdULF9KemeFkv09s3b9T8Ka-AkC8A8-pc_FpdXnjrOjwgQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 09:23:47 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

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

Hi Yuntao,

OK, but this is not a good way to fix.
We should introduce "slen = strlen(command_line) + xlen + 1" and use it for
allocating static_command_line.

> >
> > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")

As Mike pointed, this is not the best commit.

Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")

Thank you,

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
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68korg
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

