Return-Path: <linux-kernel+bounces-133998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63C89ABE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B881F21B6B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB23BBEF;
	Sat,  6 Apr 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wfz+anog"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7213BB27
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419515; cv=none; b=HEXNYbdOUMtmKsZ7MFy80llROjhPRUrPsTLwS/lG7jqjF48xCxjybgiR3zP4Lxv3JY7Byv/CTTw7pATf4gd1ZiFCIMldqYlkow2MjuCx6chm5TBo0ocQcxgKj67Ays/tzx4oazFMRgAambhgpesUL2AdINyCku7HqyMnHbL/8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419515; c=relaxed/simple;
	bh=GO5qzk0Do1SFNPpBvX+bQJe+OSfU3zYEfJnAERn0+lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN2x+dyjR0OtvLqv+tbyQ7jj+LfkWoYDvjQvTd9er3C+xIyR3YwB5dffVi2mQ8VrKLr7ID68mkbSMALuwtjiPGV9k3nSY+1R7D+HHSjTmsjDil8e8LLug6dtc/l0qFxZlkCldpE8VA3sM8Uiqd/vbh6xSbYUJRn62mx1GE0gTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wfz+anog; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e3e03b989so1540966a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712419512; x=1713024312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKqNEwDVffIR0QykbMmc3+0wQU1paowL8CSajKfB9Rw=;
        b=Wfz+anoggv2ha0akWH5na+yEUktgka34FbsKJV+3mE6I6dyYSTQNBMi5tZ8cg6+cet
         dZ9n7Tr7mcLQjrRxyl/lQO1/5sO04LxYQ/IFrTd+/RtLNca9YoB/x8DHZlEKXKIEEXNU
         40jnzqmmd9ya7x6oCecmAjzPNsjm8vL2X7fKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712419512; x=1713024312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKqNEwDVffIR0QykbMmc3+0wQU1paowL8CSajKfB9Rw=;
        b=AJmt8tO7P6JCVzrFX//EvEPr1YfQKNLLDarXamM+rzqGnTHwdNF8DfFc/iH0wcpuHF
         7NNfd36BHGyrOxnVXt0BWOYobrR77EJfug/ZKz3g46NCO1gshNjAbQfFmdMFtKugTII6
         ioHK6HnVGkmjk3q1idXhonWbTF8ObMaOAH8EcBPH4lYRSrxaRadFIDMyqJf61GCitO0B
         /Snjjve9xA6ZXm7UCsScO/Td7UXeNd4qSsznQms5FYmtqO0+HBUZUuHmHsmg/+bP2EvI
         UWNLMWpxRfhiX+pDY+thhwPisU/Ayg2Sf9XyEO9/CCHOGlyyx/qOnjmplSA0AqUSgdnC
         EpkA==
X-Forwarded-Encrypted: i=1; AJvYcCUcKsrwOlxqA1Eyc3PWdkkodiOzXddoGQp5B1lehb846OHuhyBggIwVjYqaLxmjr0VrfTcEvpLVbBmI1cJX99SnEmTIHwQnmh+fb3BK
X-Gm-Message-State: AOJu0Yxk1oBUx7qEn8dPx/gMMGfOE/mhcgjRQYnAYoZ5VojC9S7ri9sy
	Vd0H2vbU2RPd9uEMBokZZaFzsGgN6xzO6AQ4+RFT4oSnO/VIWSzU5ViwuUU2ElxGQ7/F4pmsPaN
	wI476rA==
X-Google-Smtp-Source: AGHT+IHYTpWOCHEIyzzZBYxzhO1enGq6+iG35wdETZ9mmRp1gsbzBiyNi79QKb/ovxI0f7NHFiVPrw==
X-Received: by 2002:a17:906:d932:b0:a51:bf23:5872 with SMTP id rn18-20020a170906d93200b00a51bf235872mr1351381ejb.0.1712419511661;
        Sat, 06 Apr 2024 09:05:11 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ao11-20020a170907358b00b00a51aa517076sm1759056ejc.74.2024.04.06.09.05.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 09:05:10 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a47385a4379so759842266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 09:05:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhmIV0XT/1UKxAWaQxNeo1ka2ivV0rvJaKCdnGuKvGwAC/D6Z13dfICVn7vEkOOPFthUKIbmU43izAQHa5jQ2SoCt1NpoEJSPq+Kcw
X-Received: by 2002:a17:907:72cc:b0:a51:c311:8199 with SMTP id
 du12-20020a17090772cc00b00a51c3118199mr923076ejc.31.1712419510472; Sat, 06
 Apr 2024 09:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <ZhEqW748nht2M4Si@gmail.com> <CAFULd4bcnEf6MCa1L=hYHHMOP=jB4Bc0Uugugg8xgNogQAU+YA@mail.gmail.com>
 <CAHk-=wicV7y1wnZ0God6HLA-4YSVtEevuVf09t+t=bU4yQFfXg@mail.gmail.com>
In-Reply-To: <CAHk-=wicV7y1wnZ0God6HLA-4YSVtEevuVf09t+t=bU4yQFfXg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Apr 2024 09:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCovph5NDgBNrL_oJmKRCp0nrAK3idJ9Kgr6cZZ0Kz4A@mail.gmail.com>
Message-ID: <CAHk-=wiCovph5NDgBNrL_oJmKRCp0nrAK3idJ9Kgr6cZZ0Kz4A@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 08:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because this code actually requires a data-depencency and not a
> control dependency as a correctness issue because of Spectre-v1.

Just to clarify: our comments in this code are maybe a bit odd,
because our comments are not about the Spectre-v1 issue (which
predates a rewrite) and more about the odd RCU pattern and conditional
avoidance we use here:

        unsigned long nospec_mask;

        /* Mask is a 0 for invalid fd's, ~0 for valid ones */
        nospec_mask = array_index_mask_nospec(fd, fdt->max_fds);

        /*
         * fdentry points to the 'fd' offset, or fdt->fd[0].
         * Loading from fdt->fd[0] is always safe, because the
         * array always exists.
         */
        fdentry = fdt->fd + (fd & nospec_mask);

        /* Do the load, then mask any invalid result */
        file = rcu_dereference_raw(*fdentry);

where *normally* (if RCU wasn't an issue) we'd just write this as

        file = fdt->fd[array_index_nospec(fd, fdt->max_fds)];

where the key part is that "nospec" array indexing that will not
speculatively access the array past the "max_fds".

IOW, the code naively would want to do just

        if (fd < fdt->max_fds) {
                 file = fdt->fd[fd];
                ...

but we need to make sure that it can't be fooled into using a branch
mispredict and use a user-controlled index ("fd") to speculatively
access the array with an arbitrary index and then leak unrelated data
through some side channel (mostly cache access).

And while the normal pattern doesn't expose the mask generation and
just hides that mask in that simpler "array_index_nospec()" macro,
this code actually ends up using the same mask *twice*, because it
will later end up doing this hack:

        file = (void *)(nospec_mask & (unsigned long)file);
        if (unlikely(!file))
                return NULL;

to have just one single conditional at the end (ie we may have loaded
a non-NULL file pointer from fdt->fd[0] because an invalid index got
masked down to a zero index, and the second masking will mask away
that pointer and make it NULL because we're bad people and we know
that NULL is "bitpattern 0" and we care about the code working, not
about some unreal "NULL could be anything else" thing.

End result: this code that is just a few lines long and has more
comments than code, and generates only a handful of instruction is
fairly subtle but also fairly important both for hardware security
issues and for performance.

See commit 253ca8678d30 ("Improve __fget_files_rcu() code generation
(and thus __fget_light())" that actually started doing this "use mask
twice", and realize that that commit is what this performance
regression report is talking about:

    https://lore.kernel.org/all/ZWQ+LEcfFFi4YOAU@xsang-OptiPlex-9020/

ie that whole "use masks and avoid doing the obvious thing" may be a
bit subtle, but it's what turned a 2.9% performance regression into a
3.4% improvement.

(Ok, those performance numbers are on just one random microbenchmark
and don't really matter, so take that with a pinch of salt, but if you
care about a _lot_ of random benchmarks, eventually you get good
performance overall).

Anyway, hopefully that explains the dual issue here: we care about
performance, but we also have to use a specific instruction pattern,
and can't just hope for the best.

                    Linus

