Return-Path: <linux-kernel+bounces-141967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB78A2594
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B7C1C224F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B4D1B977;
	Fri, 12 Apr 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKPIo1An"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CD1B946
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898941; cv=none; b=Cr/jp7nRE5AXMRtYgevTlECgQswr3hvdhByfDLsJGGBPKyJ1BEac/eIr1499G/lHrhkQcKbDDJTkkkIwX4Lh9McR0X4307SZecrkfKvsPw+PT+0arZbt/8Y2NI3NdnYVyhLKa133V82NFoh2eBcH/7ftJRNqX/dW4/b606XKHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898941; c=relaxed/simple;
	bh=D9QnQhMThK4LKF3cfKqJQfaVer6KXwrxyUAqxp5ia0A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rFeeu6KemGybnuIbSeNsHJ0w7sbVBmAhZ5scm8oD9cTKz1A2RR/z/NeMp+eha0PwkuW8/ZWo11kzdkWsmd8OI+VW+3mgUWEbTlg4yhXJyz9/9w90njJZ8zP04fmRsHfSxkNeD7d6mY65tQBMCaBrdbQXFpEok0UDprsr6ktkwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKPIo1An; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569E4C2BBFC;
	Fri, 12 Apr 2024 05:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712898940;
	bh=D9QnQhMThK4LKF3cfKqJQfaVer6KXwrxyUAqxp5ia0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oKPIo1AnZUREAgndo3k0RczzqzpQdg+WiSiXn1Hn9nobTswFvHl4ASixUt2oq3xCg
	 r9Uc3S0mibxkClagLT5/qac4/KpfdVvUhDB+1HHakzKXmeukvHq0P5HBiBd9x+o8GD
	 7TiJcj1sQd6aMMynU+uuFbSpqHURwUhfQxtehK65m/AEY5mOIX28AfnURuWQAC8mbo
	 YUiJf23vjOsIgJpFK1/DGjzDrkIWWF2wVsvV+vZ45twSl1uxsqAyA0RHSxmQLWZMMu
	 1rfk1jjL56awsebSrj+GproT9zfINIkaxrktdOEx3bUmxIjKMZfAbuwhicL6svstHF
	 F8yKNNRB2RoWw==
Date: Fri, 12 Apr 2024 14:15:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
 geert@linux-m68k.org, jpoimboe@kernel.org, kjlx@templeofstupid.com,
 linux-kernel@vger.kernel.org, ndesaulniers@google.com,
 peterz@infradead.org, rppt@kernel.org, tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory
 overflow
Message-Id: <20240412141536.3f59fde391a6d28181562dbe@kernel.org>
In-Reply-To: <20240412035109.13680-1-ytcoode@gmail.com>
References: <20240412000858.7d81a7b946af172e6aed554d@kernel.org>
	<20240412035109.13680-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 11:51:07 +0800
Yuntao Wang <ytcoode@gmail.com> wrote:

> On Fri, 12 Apr 2024 00:08:58 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 11 Apr 2024 22:27:23 +0800
> > Yuntao Wang <ytcoode@gmail.com> wrote:
> > 
> > > On Thu, 11 Apr 2024 16:21:37 +0300, Mike Rapoport <rppt@kernel.org> wrote:
> > > > On Thu, Apr 11, 2024 at 09:23:47AM +0200, Geert Uytterhoeven wrote:
> > > > > CC Hiramatsu-san
> > > > > 
> > > > > On Thu, Apr 11, 2024 at 5:25 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > > > We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
> > > > > > static_command_line, but the strings copied into static_command_line are
> > > > > > extra_command_line and command_line, rather than extra_command_line and
> > > > > > boot_command_line.
> > > > > >
> > > > > > When strlen(command_line) > strlen(boot_command_line), static_command_line
> > > > > > will overflow.
> > > > 
> > > > Can this ever happen? 
> > > > Did you observe the overflow or is this a theoretical bug?
> > > 
> > > I didn't observe the overflow, it's just a theoretical bug.
> > > 
> > > > > > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
> > > > 
> > > > f5c7310ac73e didn't have the logic for calculating allocation size, we
> > > > surely don't want to go back that far wiht Fixes.
> > > 
> > > Before commit f5c7310ac73e, the memory size allocated for static_command_line
> > > was 'strlen(command_line) + 1', but commit f5c7310ac73e changed this size
> > > to 'strlen(boot_command_line) + 1'. I think this should be wrong.
> > 
> > Ah, OK. that sounds reasonable. 
> > 
> > > 
> > > > > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > > > > ---
> > > > > >  init/main.c | 8 +++++---
> > > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > index 2ca52474d0c3..a7b1f5f3e3b6 100644
> > > > > > --- a/init/main.c
> > > > > > +++ b/init/main.c
> > > > > > @@ -625,11 +625,13 @@ static void __init setup_command_line(char *command_line)
> > > > > >         if (extra_init_args)
> > > > > >                 ilen = strlen(extra_init_args) + 4; /* for " -- " */
> > > > > >
> > > > > > -       len = xlen + strlen(boot_command_line) + 1;
> > > > > > +       len = xlen + strlen(boot_command_line) + ilen + 1;
> > > > > >
> > > > > > -       saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
> > > > > > +       saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > > > > >         if (!saved_command_line)
> > > > > > -               panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> > > > > > +               panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > > > > > +
> > > > > > +       len = xlen + strlen(command_line) + 1;
> > 
> > Ah, I missed this line. Sorry. So this looks good to me but you don't need any
> > other lines, because those are not related to the bug you want to fix.
> > Please just focus on 1 fix.
> 
> Hi Masami,
> 
> Do I need to split this patch into two? Or should I just repost this patch
> with any other lines not related to this bug removed?

Latter one should be easier. Only add above one line and just explain that this
recovers strlen(command_line) which was miss-consolidated with strlen(boot_command_line)
in the commit f5c7310ac73e ("init/main: add checks for the return value of
memblock_alloc*()"). Simple fix does not confuse reviewers.

> 
> Actually, I think these lines are still necessary as they make the code
> look a bit cleaner.

That is a cleanup, and should be separated from bugfix, because bugfix must
be backported but the cleanup doesn't. As far as I can see, the cleanup
part can not apply to the commit f5c7310ac73e.

Thank you,

> 
> Thanks,
> Yuntao
> 
> > Thank you,
> > 
> > > > > >
> > > > > >         static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > > > > >         if (!static_command_line)
> > > > > 
> > > > > Gr{oetje,eeting}s,
> > > > > 
> > > > >                         Geert
> > > > > 
> > > > > -- 
> > > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > > > > 
> > > > > In personal conversations with technical people, I call myself a hacker. But
> > > > > when I'm talking to journalists I just say "programmer" or something like that.
> > > > >                                 -- Linus Torvalds
> > > > 
> > > > -- 
> > > > Sincerely yours,
> > > > Mike.
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

