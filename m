Return-Path: <linux-kernel+bounces-152617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D848AC137
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FDD1C209B4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495623A8D2;
	Sun, 21 Apr 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZOanAhF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E953A9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713732058; cv=none; b=b0yRHxSh3Pl4hIQP+3gCSiKtBheaZHzPX7U+Yt4wgIMxk09927zqUO3hHqMcsKao3HXCBGMmgS0cEVybrMIJlnCCOTF5PzORMNsWYJxyeAuGZ+VtDcq6mCL77khSkzpc132y61AToQJLWhVF/JlDc/FAuxWFd65MUhzOjDScMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713732058; c=relaxed/simple;
	bh=ILe+0JFrPZ1Gcf62zBLDYj/3a/V4IcaEUhE3Jb6hVBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDPDlSoEwe4lPTafCqaMtH8YUUfIS6RHnHqYeD7uBtS3LxItSFZZSMQKBZBFlC3b0Ul9YZrcS0IKvvVfQDYi+LbJsPfmrRL2Nqb1qKHIsgUWECdvSJ9oRoy/psyQ4kA3uKHp1n1Z2PZX1x/17GoSsF60XwsnwdKGBusOpisoZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZOanAhF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a53f131d9deso453757666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713732055; x=1714336855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F2AYoUrX3xb+yJo1emG/8LdWHKOcDQ2imrc4GccdNA=;
        b=PZOanAhFKCuA6I1/ciQy/taZCkNiLbFMNQPfnmLOR/JLFl3oZWzwM+OttF1xQpxHBQ
         BZ8sX6HGZQMaACDUGukVnTQGqyU0uOkem3lte1ViTlhTHzKNMclKJadywkKT20Qy1jci
         62ddfNBdFvu6tTCNvFLLXbwV45N3PdVADI+pglNbCcGUSsUIAsy6dI1ElVgISUrT4XZC
         iqWrd4MurksP1WvtKpovQ1S2JrK9xYGP8A7NkBd+CgpFgVXQlrj8l9AW5apBpWngL6FI
         QKEN6Om9HO8pOwCyK2UZfS7aA3K53/OdagVjlC5lyVTsV/1O7kz2/307yz61cNn51/xT
         HhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713732055; x=1714336855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F2AYoUrX3xb+yJo1emG/8LdWHKOcDQ2imrc4GccdNA=;
        b=iJii060+LUjB/qbmx06N9ARz9uEe5NqQFe2mnDDIyLJv5naRacvNm7mqKUv9Y+Osws
         qTOWY1iHe+sRq0atZQ4lIYWptQXKRRfyKmCYxRq4eQ9YRSnEyPkLsk0mtk+kkkygQiMy
         nrZNh5GlkO6ROqj6TUCqHM8XT7zSZRHFVUUlv4GcJBgSSLGErv7MD16pqJOaNucDeuB5
         chDWgnoqYmV3ix4Vd8pFNEdLqDFoiGO4yPQkQvgEnblygnmcdKqF+DQXNwaHfWBnId7+
         UHu6WkydHU4KawDYEyyh5+XTNyf70SWXpJBH6b5FVGgP8YAb+2bSXDHfKJqBnFrk3opf
         h8TA==
X-Forwarded-Encrypted: i=1; AJvYcCWMjR/ANRU830HYCx14tPNiOE254sXRVhIMLKKRx0mAE5uTm6Diy9gGAz1KlhI58FGucukdzaGEQj/LyqW0dsUsc8XmyhVEP0MwD6Fb
X-Gm-Message-State: AOJu0YxS77sEo6pBraTctaH/UG9ySa7qM6otA4NtAD031YsijlkdIKYF
	c59+UlrdZJLZoGjcI+Fh8BnArwqYFeoN59MrwVQOeoG6jq6hHm5YRqvUDa2UGQ/oFjZYa2tQJ78
	GUEHwsuecJRXJW9Di6CWavlCt72o=
X-Google-Smtp-Source: AGHT+IFDqKTWbGxYPECU4SJWFvjVAlvnj9Oea5SE8uKG2rQVE3W/y8rbYUbbbNPpZMChszJ8sDCZ+BupiDay0nsHc78=
X-Received: by 2002:a17:906:eb44:b0:a51:a288:5af9 with SMTP id
 mc4-20020a170906eb4400b00a51a2885af9mr4749385ejb.51.1713732055105; Sun, 21
 Apr 2024 13:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713559768.git.jpoimboe@kernel.org> <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop> <20240421052540.w7gtahoko2qerhqq@treble>
In-Reply-To: <20240421052540.w7gtahoko2qerhqq@treble>
From: Paul McKenney <paulmckrcu@gmail.com>
Date: Sun, 21 Apr 2024 13:40:43 -0700
Message-ID: <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers __noreturn
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>, 
	Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

They apply fine as is, so I have started tests with that pair of patches.

                                              Thanx, Paul

On Sat, Apr 20, 2024 at 10:25=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Sat, Apr 20, 2024 at 06:58:58AM -0700, Paul E. McKenney wrote:
> > On Fri, Apr 19, 2024 at 02:09:49PM -0700, Josh Poimboeuf wrote:
> > > The direct-call syscall dispatch functions don't know that the exit()
> > > and exit_group() syscall handlers don't return.  As a result the call
> > > sites aren't optimized accordingly.
> > >
> > > Fix that by marking those exit syscall declarations as __noreturn.
> > >
> > > Fixes the following warnings:
> > >
> > >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() =
is missing a __noreturn annotation
> > >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_=
group() is missing a __noreturn annotation
> > >
> > > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch histor=
y at syscall entry")
> > > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f=
17a3@paulmck-laptop
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> >
> > Looks good, but it does not apply on top of current -next and I don't
> > trust myself to hand-apply it (something about having just got off of
> > a flight across the big pond).
> >
> > Could you please let me know what else do I need to pull in to be able
> > to cleanly apply this one?
>
> This patch has a dependency on an earlier patch in the set:
>
>   https://lkml.kernel.org/lkml/982d05a2f669140f26500bee643011896d661094.1=
713559768.git.jpoimboe@kernel.org
>
> Though I think it's not a hard dependency and I could reverse the order
> of the patches if needed.
>
> --
> Josh

