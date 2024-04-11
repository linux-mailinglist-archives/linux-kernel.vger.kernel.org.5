Return-Path: <linux-kernel+bounces-140646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EDB8A1726
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E89281F82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB814EC6C;
	Thu, 11 Apr 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkG9A9mb"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7A14E2DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845672; cv=none; b=FTlBwvkDbe/JZ7Z2tnDX805aWU55cuGI0rTuDhUDv9UGxzmWnj9/F5Y242L5NQEEOZtKv8/9Hd1CzyyZR4Y42+InophuGoFDIR/t4B3ZlovoweyHgVyZTLeEGvA578deR41463aE+NNPfliqR2SITVi8dAtIm1vQU13uyTXXBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845672; c=relaxed/simple;
	bh=w9o1XgcltQhWTXVm1JiWAGcO8AEFOVm8o98Qvyf7ZV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOvx0fyb7s7oVgOrPBrVU0CSfHGZkFkGXIi/i7aJr19SMFEmK74CxG5vIdkCwDBnoihhqq1YotiGNAm4Hf9Y6BPUQoGlLC9MsNPRI2GuwLPuuqCZcrRbB5Nxlaf4NNYFyLTpJzSC5HoejyYeYiS9EG77fp3GfHuMCRbJDuLRWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkG9A9mb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dff837d674so65916305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712845671; x=1713450471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV8tJIjUzXHbl0VfRKq6lXNz71phUi80Xt/ITrcltAs=;
        b=OkG9A9mbqj6Aw64QR3yy3nMohdjSMKmpu8g6hERyTUmXASs2KfIKEz79kCx7SWBMJH
         JBSxWSclPFco5JOcQa01ntgd47IA5GUOdtAWVRhE1TxesfcXHMDOXhZR8O7Ip0gToTTV
         TkswFpDSOludaNgoBm3WqQlmFunFVB67TiHyg9quZO4E0y0vBtZS/ld7uEyoNKzPgqG7
         +UZYV/chbdZY7vPYycuzgKWUNTw9m3wKoylg/O8PGg9bega89de4QHueqeyY3U9JzoAK
         SbbUJUE5DfSb571fe23O2poDptzWawlVLqbAK5T9xgjoe2/sQ+udpyEfmWzP3rONhu3Z
         A70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712845671; x=1713450471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV8tJIjUzXHbl0VfRKq6lXNz71phUi80Xt/ITrcltAs=;
        b=IKU3f+7X7Njrco5r165sonHkyn3UjvbN/5P6+3ezOGjDQ9IRrVR+aXGrujA5Lf2hQG
         v4ijaigC3y7LrMIcoHwqEg6fLqX3f1+RuWX55pbG6WJQS9FevUqk5Qf9iME5X8r6CKyv
         TzT1oT5hcBKeHObLm2MYhDsScx5JJpdk3LbuLhgx6Fb8SJoLbKonR1zpRSVNnjM9sPgA
         Fq5dz4V+LikK+EuBlcN4zJ64aDZESoyQvuiTTlobwNun/KCQeCRSuJUqX+BlSNeDUXub
         BfUQMa4ff+gwjbJ3+PvqjHwB8+epfI0SABVMd8UgkYSxuP5Qrl2Cyb1Pg3HdJFBXSzkq
         o/UA==
X-Forwarded-Encrypted: i=1; AJvYcCUgC4642kaWT7ZGblsE1e9TpCFwcKlo6ktDipy9Mn36N1V3YIzIMgMpUSQf0riEZQWkPHLCWaytHiOw03hP9maXXNvG5hIV6QwNFJjy
X-Gm-Message-State: AOJu0YwoGJ8qU8rsS2J6q9ACOTjH8YLG54FiOiojgjiqSzrs4wq1ZI6L
	MQBsHf/pPCvXCTzpfyB1CAla2S9j3uz+QHEDa6/0SargI8RPbwJiMlCFbH+X
X-Google-Smtp-Source: AGHT+IGKSqHXfRvr61t0+2EENyO351XU3EoE5xwRYiwQtdgPz/e3Za/SaUZo1UjNefMy9B/3oFYCZw==
X-Received: by 2002:a17:903:13d0:b0:1e3:dfdb:ac6b with SMTP id kd16-20020a17090313d000b001e3dfdbac6bmr6861325plb.4.1712845670814;
        Thu, 11 Apr 2024 07:27:50 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b001e294f2f30dsm1228876plg.93.2024.04.11.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:27:50 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: rppt@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory overflow
Date: Thu, 11 Apr 2024 22:27:23 +0800
Message-ID: <20240411142735.245515-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <Zhfj4T1-u354E_KP@kernel.org>
References: <Zhfj4T1-u354E_KP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 16:21:37 +0300, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Apr 11, 2024 at 09:23:47AM +0200, Geert Uytterhoeven wrote:
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
> Can this ever happen? 
> Did you observe the overflow or is this a theoretical bug?

I didn't observe the overflow, it's just a theoretical bug.

> > > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
> 
> f5c7310ac73e didn't have the logic for calculating allocation size, we
> surely don't want to go back that far wiht Fixes.

Before commit f5c7310ac73e, the memory size allocated for static_command_line
was 'strlen(command_line) + 1', but commit f5c7310ac73e changed this size
to 'strlen(boot_command_line) + 1'. I think this should be wrong.

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
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> 
> -- 
> Sincerely yours,
> Mike.

