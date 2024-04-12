Return-Path: <linux-kernel+bounces-141877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC38A2482
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A0A1C211EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77017BD4;
	Fri, 12 Apr 2024 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4UTcjRO"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB115AF1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893881; cv=none; b=TRnZduJb2GcBviRnaRzgXwdinuCH0the+pt8l5lSa0BKPyhs1CoScWsqCAHneGwcXrbc6vHCKoqIxSGKNCgjPQutJVk+sLERpUV6DVKfVJVnGWMhCbQNhqUGBc5eNj4rvT7zuSDWYicM9U0sYvwhvpKryjyrSdgsuA4RNnMcj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893881; c=relaxed/simple;
	bh=pcBlVy6bPYDqNoRlb1dwSstSZkriaADkJyZMbpJXDKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6fde0feoOZMLy6Me91kNYT4uJ+sQgao5OzYDxID+qLP0Nfcbof0/fgHmOse4CxJkopTlJPzTNx21jFzBkguHCj8UMVv49J/vhc41fgx95ZQ/ORR70jO8DWUt5rCxUXtS/WXuG+FVzR9nl7HDlxLzsZikD1nnFIxiGPFcHJ1U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4UTcjRO; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa22ebd048so376360eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712893879; x=1713498679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bzY4596sfM/9zLFq+hul7IoQ+dQ+EIJvV2zsj37DAk=;
        b=l4UTcjROEsVQEhLAG1tG9FvkTbaeDu+quRyn1uq/K2J0VCbXeCtu5NuizXb3XDbJx9
         swCjkBONSQSVpTccCsU4oSxxMhhkr08M4lJ++bpEMYaeNOiOUp/0593dGx7i4JJ7IJyd
         nrT26eST1UOO5CgMrFKYuWaaV8W/ZGgD6JWoIxBkCveVunu6an/OcS02X2UXtLAbOuIb
         iyNMLb5hECF8SkjOUJQFKuwTEG8e+ioCOzJGoVnSO8HZsG4c6paeiIFNwexjZ0EU/gI0
         RW3bcxT0AQ0ldQuk5F0dU2TJSz/RxolmXCjD58okqJLmgr/vji8D8MCivATXtQdowscO
         rm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712893879; x=1713498679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bzY4596sfM/9zLFq+hul7IoQ+dQ+EIJvV2zsj37DAk=;
        b=kWbkW4AT6oDhuj5tbM99i+6m/NtEL/ttymSSYH1n5l1XvjWRlqpNeT1qW1DsAIf3Ng
         IC4/qcS7ZoAZ1Hf6Sw5xU+4g96BlH/a4LmKdeXhQlbgJ+jCrOp+iTQuN7IvwAKgGarhk
         /mHXxzCUSULIF9iemIdNj44iodyes5uYBJrcGnOTAyM38U0Uwfv5Vmo2ILWi7+3eNNR2
         XTAx9zoSlMCbgKMGladJMSa3nuMX/btPcBrRssmuWnNCVNzRJsJAiWApLozNKHS+CMSx
         42g4CD1cpO9NStCQ2zDL1atE/CQgsi/aBtP7ewvVdOQUZ3ptrMaymtl1MoGpNCkE6Jbs
         q1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgWFK6NvzC70nWbXk/A1Kz/M2fJzl9e+OkwbHXT/fo1KIl3P5woEN++6N7JFRnCQKwFJtlH+TG7r5rKe7oRKdc0FZ8aEwwVrcdkMKr
X-Gm-Message-State: AOJu0YwZDDTOhjoDcWbu79pwa/jK44ts3MEeVm40DkkON5+EV9eB8GlK
	Cc7vmb3CxncpYUcqRI8TAAUcfRTghiq1bk39xDunSr/gR2QrW/KIc2MyNW7W
X-Google-Smtp-Source: AGHT+IGCOWvN10gwtK41NG7gcU83k5LcliiTl9q4NSeG7jIUo4FN8waEU5bHybUmzOYVFJBlQ5BXiQ==
X-Received: by 2002:a05:6358:6b0b:b0:186:41a2:cbd2 with SMTP id y11-20020a0563586b0b00b0018641a2cbd2mr1325524rwg.27.1712893878886;
        Thu, 11 Apr 2024 20:51:18 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id c31-20020a631c5f000000b005dc9439c56bsm1815658pgm.13.2024.04.11.20.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:51:18 -0700 (PDT)
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
Date: Fri, 12 Apr 2024 11:51:07 +0800
Message-ID: <20240412035109.13680-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412000858.7d81a7b946af172e6aed554d@kernel.org>
References: <20240412000858.7d81a7b946af172e6aed554d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 00:08:58 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 11 Apr 2024 22:27:23 +0800
> Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > On Thu, 11 Apr 2024 16:21:37 +0300, Mike Rapoport <rppt@kernel.org> wrote:
> > > On Thu, Apr 11, 2024 at 09:23:47AM +0200, Geert Uytterhoeven wrote:
> > > > CC Hiramatsu-san
> > > > 
> > > > On Thu, Apr 11, 2024 at 5:25 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > > We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
> > > > > static_command_line, but the strings copied into static_command_line are
> > > > > extra_command_line and command_line, rather than extra_command_line and
> > > > > boot_command_line.
> > > > >
> > > > > When strlen(command_line) > strlen(boot_command_line), static_command_line
> > > > > will overflow.
> > > 
> > > Can this ever happen? 
> > > Did you observe the overflow or is this a theoretical bug?
> > 
> > I didn't observe the overflow, it's just a theoretical bug.
> > 
> > > > > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
> > > 
> > > f5c7310ac73e didn't have the logic for calculating allocation size, we
> > > surely don't want to go back that far wiht Fixes.
> > 
> > Before commit f5c7310ac73e, the memory size allocated for static_command_line
> > was 'strlen(command_line) + 1', but commit f5c7310ac73e changed this size
> > to 'strlen(boot_command_line) + 1'. I think this should be wrong.
> 
> Ah, OK. that sounds reasonable. 
> 
> > 
> > > > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > > > ---
> > > > >  init/main.c | 8 +++++---
> > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/init/main.c b/init/main.c
> > > > > index 2ca52474d0c3..a7b1f5f3e3b6 100644
> > > > > --- a/init/main.c
> > > > > +++ b/init/main.c
> > > > > @@ -625,11 +625,13 @@ static void __init setup_command_line(char *command_line)
> > > > >         if (extra_init_args)
> > > > >                 ilen = strlen(extra_init_args) + 4; /* for " -- " */
> > > > >
> > > > > -       len = xlen + strlen(boot_command_line) + 1;
> > > > > +       len = xlen + strlen(boot_command_line) + ilen + 1;
> > > > >
> > > > > -       saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
> > > > > +       saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > > > >         if (!saved_command_line)
> > > > > -               panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> > > > > +               panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > > > > +
> > > > > +       len = xlen + strlen(command_line) + 1;
> 
> Ah, I missed this line. Sorry. So this looks good to me but you don't need any
> other lines, because those are not related to the bug you want to fix.
> Please just focus on 1 fix.

Hi Masami,

Do I need to split this patch into two? Or should I just repost this patch
with any other lines not related to this bug removed?

Actually, I think these lines are still necessary as they make the code
look a bit cleaner.

Thanks,
Yuntao

> Thank you,
> 
> > > > >
> > > > >         static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > > > >         if (!static_command_line)
> > > > 
> > > > Gr{oetje,eeting}s,
> > > > 
> > > >                         Geert
> > > > 
> > > > -- 
> > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > > > 
> > > > In personal conversations with technical people, I call myself a hacker. But
> > > > when I'm talking to journalists I just say "programmer" or something like that.
> > > >                                 -- Linus Torvalds
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

