Return-Path: <linux-kernel+bounces-162402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5F8B5A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8871F2141A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DE745C3;
	Mon, 29 Apr 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihclxSWS"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F72940D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398966; cv=none; b=u5ERrLAlm9pI5fAqlmPbJweo8+1IIHxzo1EeE9GBzcbSACgOtpF5hK883qz7J9H50ovWAsf1QyzIuzZG/VSGNa88LzTElg87x4K85b13JCZJSakzAAYrqjnGF9a5egtz0H4OFc0j2kOJZrtO8SedURkUjyMEvJ2BVIUzVorSueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398966; c=relaxed/simple;
	bh=KPPrqlc4ZJJeSjSUgiLUuySnt0snj2gr7SuaO9otL0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNriGLMj1GnOm65RShpe6ZDkPDTF1fubsfPztLsniLreYLlTVs7dSCMK99H2gmtEKLy+GsXJiSy4zmCNdvp0qjNCdCnYSltnOY4LkAnDS6MWsvwWhPL7so+Gf/eEOJLezLD4in4xNjx8ijfbBGvpa04Hlo21q4lYCRIuIlrX2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihclxSWS; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47a404c6decso1146895137.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398964; x=1715003764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPPrqlc4ZJJeSjSUgiLUuySnt0snj2gr7SuaO9otL0Y=;
        b=ihclxSWS7UUNWtf1zeuZCql23gBKSqgxbMJOCh4WTibnzahnaw9rEH2QEplYsZaZ7X
         ushk9T+qzTKtikhfy7o0vXnVpgQtqdscpt8b9baQ7ndTD3WSSmCFT+/G8yr+OVeHdt8o
         YuQKD5l8U0i3OpqrrV/vdZEECZ74lielMEGfNH7CSPqV9sVR1o/yVWiAR3gFoBfNKtrj
         xRYUJvzLh585IbnfYe4K8POvfvApsbTKJ0saaHE7BGwhBxnNCVUMEyP1VVIn2DZvILYK
         7Z8EKWxds+qZHMmE8j4/c+BAkMe0i0erDeZvpe1ILuhmN8ckWMRVrVklopHDeNp0Rcd+
         Z40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398964; x=1715003764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPPrqlc4ZJJeSjSUgiLUuySnt0snj2gr7SuaO9otL0Y=;
        b=r3ucXm6iMZVs2fc1Ai9uGWpQHolZRnAn/qC8Sc/TOpQCrKvNNS+2Ha8VYxwEpr/Rn3
         VXOYscQvd5iH9/cT8dFzw1qAsH174Nv2hXGJmGUGJE54wefzAm04tsJntMKk6WynQNAu
         Q1a23e7RdkVdo05UrW7benf1hJEs/UKItcskmydALd1gnhK7t8YQdNZnLnXs4+Yis+dM
         dXSj1A7/8cEBMa1AICNAXlPvogfSIo7EBmdfSAJJlvco4O3wTpyQ1y4Gj3f4K7/G2Rt+
         kUQlGmvjJptGpZROC/ITqQFJf/bDp/LScaHq+hvdp9bIjxEjLB8gk9yNWwQNsVBg+sNQ
         /97w==
X-Forwarded-Encrypted: i=1; AJvYcCUcshlNEyuUaVsD1IqnhSpjilOafB3KcoHxIRGuuvs2q5fZYMhWj+4j844c3rrrZlxnkvuUcdtKGbPTA2ZhgvxfdlP+0bdSw1dF/wLR
X-Gm-Message-State: AOJu0YwJyVM4VKao+xnN93Y3nNs1S5bh1O5RBiYsKuHO4jGaG1xXBqbV
	ICu3v+ss+nZqqdN4SdfQyuOp0gW8VolAiTAyNgz0sj75UoHZgW+418MN3OL+IKfD+NFsO4vZFaK
	QaSfiMofqTN9eakuANUJnXBEJLPOz3q1zSxGY
X-Google-Smtp-Source: AGHT+IF8JpCyn31ULHyA46TSyFjb5HfLep3bC8UDj4tp+hbUuFAo0ncMe2+Xi3ltUDDtsDTqLZJ+glPFAXrjD7a4y1U=
X-Received: by 2002:a05:6102:3583:b0:47b:b2f7:2006 with SMTP id
 h3-20020a056102358300b0047bb2f72006mr9958251vsu.3.1714398964079; Mon, 29 Apr
 2024 06:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV> <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV> <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh> <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp> <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
In-Reply-To: <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Apr 2024 15:55:25 +0200
Message-ID: <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 20:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 28 Apr 2024 at 03:20, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > If we keep the current model, WRITE_ONCE() is not sufficient.

FWIW, the original report here came from syzbot, which is configured
so that the WRITE_ONCE() is sufficient
(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n,
CONFIG_KCSAN_IGNORE_ATOMICS=y ... long names, I know), because this
was an idiom we ran into in the past and just wanted to filter them
out (for better or worse).

That being said, the reader side still has a real problem, even if
hidden in some KCSAN configs. Up to you if the WRITE_ONCE() is
sufficient or not, at least on syzbot this case wouldn't resurface
(for now).

> > My understanding is that KCSAN's report like
>
> I find it obnoxious that these are NOT REAL PROBLEMS.
>
> It's KCSAN that is broken and doesn't allow us to just tell it to
> sanely ignore things.
>
> I don't want to add stupid and pointless annotations for a broken tooling.

KCSAN is the messenger in this case that our mental model vs. what our
language/memory model gives us is wrong: we already have our own
memory model (!= C11), but we still have data races, and have to deal
with the fallout. Data races (here: 2 plain unmarked accesses of the
pointers) still exist, and the compiler is still free to optimize them
(miscompile them according to our mental model).

Assuming the data race is not a problem assumes all compilers on all
architectures won't mess up the accesses.

This comes up over and over, and the problem hasn't gone away. Our
compilers still don't know about the kernel doing things outside the
scope of standard C - we can beat the compiler into submission with
lots of flags, but we know [1] compilers break our assumptions. What's
the long-term fix? I don't know, besides trying to teach compilers
more of what Linux wants.

[1] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf

> Can you instead just ask the KCSAN people to have some mode where we
> can annotate a pointer as a "use one or the other", and just shut that
> thing up that way?

Saying "use one or the other" pointer, implies atomicity of the load
and store. Telling KCSAN about our assumption of what we think the
compiler should do is the wrong way around - we should tell the
compiler. Which part of the code is telling the compiler we want
atomicity of the loaded pointers?

A WRITE_ONCE() / READ_ONCE() pair would do it here. What should we use instead?


Thanks,
-- Marco

