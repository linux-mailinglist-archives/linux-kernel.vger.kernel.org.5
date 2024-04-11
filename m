Return-Path: <linux-kernel+bounces-140703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F075A8A17FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653C11F22E93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84489DF71;
	Thu, 11 Apr 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jILJ0s7V"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B18DF43
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847583; cv=none; b=bqP2Dcu+ebSpAA7piIZRCR0A66E6nX2+x1mVmK1ygvpTKXWcOi/b1XvoPEfXqUz9B/GiQrgz2zGrxAH25h5FPIUmAYMJH7wEw2oeDMssU8cwxXQoPWCJUWkvdragNidi1TfG3qEI5+psKrf4BgItL/PWKXNYx06AQIu8D3km5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847583; c=relaxed/simple;
	bh=XOkuJ7liq7HFtOSOqifMgfnooi/w2Xowz/+JJWDXXeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSH1ZoeDl2uu06b29WQQ6fZeqiiLbShd+n13D8kG1YIJYhS9P5stxCGQayBG6tMfvox8b49leFLv1LpBWcHbXIacoox3XYchG5E2GfvEGSKh0fJ6g/Jx4kS9vSxlqakCMfAjgRlUJY8jKPd5OjPVTDWBUPqS5BRqWCOMYI0qycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jILJ0s7V; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso7045478b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712847579; x=1713452379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWl7aWejmOmSmRavRDDwn4JBr1uDDkzku1Ac+VvzCk0=;
        b=jILJ0s7VA4SP8HuAN07FKC5D0JUemCwKI78gX8SXZdq4BSv27dr8/T/VRgQHVWYUBZ
         ol7Xar+D2S4V0Ws3rVbO5le7YtiONVbQrUIIBCbiO7q9qL3E4MpAEFHxWHYXzYtqV86e
         eCEjLno0gmFrlfzh32Hz5wOmfLvEEusa3T5ceGoPX0rcPQ+NjGLAqFgYFmvUT0WHz9FB
         MzQsKKZ0Ras9Pd+rDIJLOpImyXn7ocHLqljc9WIwwIQ1OrKKozRVDmSOBGjC/qvDOAjT
         04pbO+PY4otVZCOYTmaOvXCYUxExom3/LvDrPZMhQG5IXcgdXx/EvGE6dYHSbFiOKF9L
         gkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847579; x=1713452379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWl7aWejmOmSmRavRDDwn4JBr1uDDkzku1Ac+VvzCk0=;
        b=KV5qcMz+Gr6Acfok95T9kDPfOS/GhEkvyI0jpHlUK8QZnAOFUGwgFqGcm9BL7/KlFE
         Yo8pIY4IEdaXHEKk7hPovzLJDXrUWUNk/Lw8yWb6F/jL7aVW/P0inv4uVrJpzp6N8An8
         DoRrvWN7Q8zi6CnVrm4nAQ5zXoB69svHi+fCGQOUhR9X3KIbV+V4S4FznM83gCZDve12
         L2oTw7l0wFa2QBCkpQt0CBCFGMNoW8os4FTmL8nrNMTx5PzqM9tJPhMrMO25XVNDzOqg
         sSRSjgndG6/WogNlMJqi3d29cvBIX3fIYShn8P8Ha3bUEZ4p/k0f+qDqWfPTkymYcSVD
         BgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCViGRIBWzd+2pXtmFrKsHCJf0wEEEG3UK9rsA0vMsjgJJ8G85uKvyko2A6rGWEGT3q/5L08oNe67uxaBdGitaqo/2LB0n8Qemylk3fG
X-Gm-Message-State: AOJu0Yw1UftITtJLeKT5cGWpGoEATA5G0Hlcl2k1NzMHGmnlJAJtLtar
	LucLkTBPKmL5h9V5/ujS66UohM6EYyDKm5VC16/hy4tM4BqKyWZM
X-Google-Smtp-Source: AGHT+IGzNTLV3q3qwdvhih+Jkkh97YUaF6n8VQQV0vmWxFQzyMrvwM5ZUWv7OZnTGSPZQUROlhQhqw==
X-Received: by 2002:a05:6300:808b:b0:1a7:5100:7559 with SMTP id ap11-20020a056300808b00b001a751007559mr58821pzc.32.1712847579504;
        Thu, 11 Apr 2024 07:59:39 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id j16-20020a62b610000000b006ecceed26bfsm1256171pff.219.2024.04.11.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:59:39 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory overflow
Date: Thu, 11 Apr 2024 22:59:26 +0800
Message-ID: <20240411145928.247071-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411232901.2c0aaa13f790d0ef97e484cd@kernel.org>
References: <20240411232901.2c0aaa13f790d0ef97e484cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 23:29:01 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 11 Apr 2024 09:23:47 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > CC Hiramatsu-san
> > 
> > On Thu, Apr 11, 2024 at 5:25 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
> > > static_command_line, but the strings copied into static_command_line are
> > > extra_command_line and command_line, rather than extra_command_line and
> > > boot_command_line.
> > >
> > > When strlen(command_line) > strlen(boot_command_line), static_command_line
> > > will overflow.
> 
> Hi Yuntao,
> 
> OK, but this is not a good way to fix.
> We should introduce "slen = strlen(command_line) + xlen + 1" and use it for
> allocating static_command_line.

Hi Masami,

But this would introduce an additional variable 'slen', which seems unnecessary.

In fact, we can use 'len' directly, this makes the code more concise.

> > >
> > > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
> 
> As Mike pointed, this is not the best commit.
> 
> Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
> 
> Thank you,

I have reviewed the commit 51887d03aca1, but I don't think this commit introduced the issue.
I still think it was introduced by the f5c7310ac73e commit. Or perhaps I missed something?

> > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > ---
> > >  init/main.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/init/main.c b/init/main.c
> > > index 2ca52474d0c3..a7b1f5f3e3b6 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -625,11 +625,13 @@ static void __init setup_command_line(char *command_line)
> > >         if (extra_init_args)
> > >                 ilen = strlen(extra_init_args) + 4; /* for " -- " */
> > >
> > > -       len = xlen + strlen(boot_command_line) + 1;
> > > +       len = xlen + strlen(boot_command_line) + ilen + 1;
> > >
> > > -       saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
> > > +       saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > >         if (!saved_command_line)
> > > -               panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> > > +               panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > > +
> > > +       len = xlen + strlen(command_line) + 1;
> > >
> > >         static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > >         if (!static_command_line)
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > -- 
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68korg
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

