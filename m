Return-Path: <linux-kernel+bounces-152524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF938ABFFB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546CC1F210DB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC91BC4E;
	Sun, 21 Apr 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJXoVa9V"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044791B977
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715493; cv=none; b=BgTPvv93sMNGtD2jXHVtR6TovgEob4nnNU90L2oPM08gzGVe7yrNWRYYbnNg9QCPcO9kSFGPr0Dn7XQqAbcfjLkOMgW1nIAtFVd2DEC6PzMoNiLo5ebQEnhFdfZcah3ZpG664QJYubMQPKeqKmbqBpx5WSzUEy2tpkWjf57NwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715493; c=relaxed/simple;
	bh=2M6GaHV9sMSfCXjCBMsfVQw6K83qKyB9KbBEyHhGlaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2VVnYZXnEB2r5c3sMHAHPmqbUqkJ9BuIrKffP43Agz6yHz9xv4AoYIS2669KUn8/ieG+3qCX5MyZhMf416FVcqxIpnqGW+mSAnFPQf0VuOOa68ZF/sZa9lzZWHohOR1svnKAwRjUubEmWGdGmN5zQdukTA56Tg/SOJGRcbzgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aJXoVa9V; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51b09c3a111so688145e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713715490; x=1714320290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGbOttjXSy/dn3keYAVj3six2JIbvufZsOSIb9RbwPA=;
        b=aJXoVa9VipHg79p5W9Vuno8rsPU45ervHo0dF8UnyithyOzZsf/j6IJsBO5v63chIG
         5DIsxxdDn7AKosiOETXEMaHLjf3BzB7diN13hfEqM/jQpzX8OH/+IA3SYDQFDcjdC/mv
         Gh2DhucqJwNnqFfk3EZF2aTre7+TMVBvXc7GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713715490; x=1714320290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGbOttjXSy/dn3keYAVj3six2JIbvufZsOSIb9RbwPA=;
        b=eyfk7u2RfCgshyApvlVsXSNsGCcV4TDW/v4xgg6Ks1SKBlnfDvwh082FtqDE5tDCPt
         JzFtVxjdN1NM+3KWzDSp2M5pCILxEeLBouMbii6YhCoaXKLZk90x4DEEclXuwUb6ZRXu
         OWYCQe/yECxAj6Z7TYbRMGdhAU/0pajfC9u+rYgq1tZMlohoWaSnT7yU84L0Rv+OypuC
         qWb3RtmgfjI/b886TGHa9aWKmBZY6dpfN/Wd08VBeFMAJhADUl0YmAUatIGsBFmAebUN
         sHXv41U3pHiaCJ22TFNbBNCMX/E3mA0mmRNQmyUIpWKip9H2nlz4oTwZTmu4gq7S0ZQG
         ArgA==
X-Forwarded-Encrypted: i=1; AJvYcCXVKAzxxFhMmlsQWCx38GHKiW7Npj/XB5eA5tvfcNFGGEh+0t5Yj/w5pk+rIMHABShKZStYI7WrLhNzsBsDNYgTKfT52QnG35lteSbE
X-Gm-Message-State: AOJu0YxxImwB4GnTB9IsPFcxy4n9+Ll1NaMeJJxCLpnCBT3PQ53GO5CB
	ltAi5zB/TSuo+ApQGEd1pKZxO9zN8HtZJbAUnrOou2nMcoKflbcfmnbr2KpndEfj2dFiRMfmxmU
	g6kX64Q==
X-Google-Smtp-Source: AGHT+IFXg7hFYoe7ct6NSfl0dgOJ6Hgx/hYc0f7udRz7HDIf4XZfraXdU5hWDyMhH6PHlCHZFVfJ/A==
X-Received: by 2002:ac2:4986:0:b0:519:3c0d:d0b with SMTP id f6-20020ac24986000000b005193c0d0d0bmr4781499lfl.39.1713715489945;
        Sun, 21 Apr 2024 09:04:49 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id h2-20020a170906398200b00a4df061728fsm4660390eje.83.2024.04.21.09.04.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 09:04:49 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4702457ccbso401611866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 09:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUjjxiCs1NSewnvTtEQwgT+2qMzQGZ4WrLzGK7FAsY1qF9hLV75OtFWiE6wGrz/luyTynOG7tG9IS0ZdkEmwbhybIiE8OT3P3Bt8WP
X-Received: by 2002:a17:906:1949:b0:a52:5925:1f76 with SMTP id
 b9-20020a170906194900b00a5259251f76mr4723538eje.47.1713715488755; Sun, 21 Apr
 2024 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
 <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
 <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com> <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
In-Reply-To: <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Apr 2024 09:04:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
Message-ID: <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Apr 2024 at 06:28, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> "struct tty_ldisc_ops" says that ->write() function (e.g. gsmld_write())
> is allowed to sleep and "struct tty_operations" says that ->write() function
> (e.g. con_write()) is not allowed to sleep.

Well, clearly con_write() *is* allowed to sleep. The very first thing
it does is that

        console_lock();

thing, which uses a sleeping semaphore.

But yes, the comment in the header does say "may not sleep".

Clearly that comment doesn't actually reflect reality - and never did.
The console lock sleeping isn't some new thing (ie it doesn't come
from the somewhat recent printk changes).

So the comment is bogus and wrong.

> Thus, I initially proposed
> https://lkml.kernel.org/r/9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp
> which makes con_write() no-op when called with IRQs disabled.

The thing is, that's not the only thing that makes atomic context.

And some atomic contexts cannot be detected at run-time, they are
purely static (ie being inside a spinlock withg a !PREEMPT kernel
build).

So you cannot test for this.

The only option is to *mark* the ones that are atomic. Which was my suggestion.

> My major/minor approach is based on a suggestion from Jiri that we just somehow
> disallow attaching this line discipline to a console

Since we already know that the comment is garbage, why do you think
it's just a con_write() that has this issue?

And if it is only the console that has this issue, why are you testing
for other major/minor numbers?

> Now, your 'struct tty_operations' flag saying 'my ->write() function is OK with
> atomic context' is expected to be set to all drivers.

I'm not convinced. The only thing I know is that the comment in
question is wrong, and has been wrong for over a decade (and honestly,
probably pretty much forever).

So how confident are we that other tty write functions are ok?

Also, since you think that only con_write() has a problem, why the
heck are you then testing for ptys etc? From a quick check, the
pty->ops->write() function is fine.

                  Linus

