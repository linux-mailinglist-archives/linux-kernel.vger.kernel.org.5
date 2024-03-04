Return-Path: <linux-kernel+bounces-90943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48587074E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2141C20970
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975BB4CB54;
	Mon,  4 Mar 2024 16:36:45 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE91756D;
	Mon,  4 Mar 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570205; cv=none; b=JljURleTT4eVWBqtrqzcUoA65Ap74RIFMykRFOdqkMMmcSSCtQgPmKHuE0dBmvFqHbEykslfupibKSvQqnfBO9mFz6amjS9p8PiWquxzlAJgy+lOg4u0ZdMiTO+pRe9d2Z6qfOC+9Yj0ZDEEew33af7MakZPsUo514zjITvel8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570205; c=relaxed/simple;
	bh=DQkB7bsi1xFX4kYyEKMzTRCXSDivug9bERZkG+PiyVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1PLfstWtXJu5AHFtv6vJozDqt3nn6AeGnq3Yz03gb1FraSCVcZUJro7lN0wgj1gj+mI9N2VVQClfNKsoGWolAcvK19Tu+YCs5akpfIaxgySpetWH9Sag1NTVJQYotspeD3N62TGncFEDvMgXavSXeJiS9KACO0rI0tSWxTuWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso3175871b3a.3;
        Mon, 04 Mar 2024 08:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570203; x=1710175003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlDi0YrWDCXYNmQcYg0srfw9ph3/dQq4IPuLsyD6ZSQ=;
        b=PtvgxnLKA5T4FDhbD6eu90jPz0cN5UKdWdzRR+U8fPlr7ajlNsFmGOMbDVmRJUCVbj
         gcVdPufnsxBwl8Xz7uqohyys5vcAisCJiFqekUuKutIlrniinbTRP6kd7L6FWU4X8n5/
         XaCarF7QydXKRXraJ57XmcK5oiUFI/xQpiB7Rj+cXYBWcFOmuK8yLkFKPGxPUcP/9VBb
         d66xp03VPt9dLttUKXHlFWwyD1ZJdwQfxlaZuilW7+uKz3cBFFjnXkrVo1gD+M7hgsfE
         qyjIsFzX2C5durKLvUD5qchE8cZlN/4NsqfhNmLa47ajMu4DgFvQK4aA1IUSZBZ8nLPK
         6V/g==
X-Forwarded-Encrypted: i=1; AJvYcCVpZ3yWTcz1ZeLk4w2ejKYdQ/kZFLZuT+01FXeuuZdRwLHOxWfi8o5jmFokmHcGzt+5JhzMueb/5xgL8bkXqmNj9bYQI5+LfnMu+0t+gYnB/SyMzVWnzn1cTBFe6gZJ77oG08WuEvJqSgvG3095Nw==
X-Gm-Message-State: AOJu0Yz1L2n7JzSlo+np8bTKc5OjILElFXjyuNqJTwpXyETDrvhTUZh0
	VUuJuKSY9D4ZscwMBUfvkPI54gXbKi6Jfro0AHuSZxujiwWpE/DZm+QG/En7sclyaBfAxo3o2ok
	fvb02EC8BrUwJ2Hj2kFunOQonzcA=
X-Google-Smtp-Source: AGHT+IHRWKQG1jGKrTLpTWr2pZTsKBvY+LaJUqx4iQTwj8XxpVZuOCBqbmO5i0orV5uFjxGGDImnVwfH8QSWhoe2zx0=
X-Received: by 2002:a05:6a00:99c:b0:6e6:16b5:2eaa with SMTP id
 u28-20020a056a00099c00b006e616b52eaamr3796502pfg.7.1709570202870; Mon, 04 Mar
 2024 08:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org> <ZeXTmdhu3Y_gC9ma@x1>
In-Reply-To: <ZeXTmdhu3Y_gC9ma@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Mar 2024 08:36:30 -0800
Message-ID: <CAM9d7chEoab71v8=th7NAWcsPPZV+oGiJPGfiCcjdS3L+u13dA@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate: Improve memory usage for symbol histogram
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Mon, Mar 4, 2024 at 5:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Feb 27, 2024 at 04:52:26PM -0800, Namhyung Kim wrote:
> > This is another series of memory optimization in perf annotate.
>
> > When perf annotate (or perf report/top with TUI) processes samples, it
> > needs to save the sample period (overhead) at instruction level.  For
> > now, it allocates an array to do that for the whole symbol when it
> > hits any new symbol.  This comes with a lot of waste since samples can
> > be very few and instructions span to multiple bytes.
>
> > For example, when a sample hits symbol 'foo' that has size of 100 and
> > that's the only sample falls into the symbol.  Then it needs to
> > allocate a symbol histogram (sym_hist) and the its size would be
>
> >   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) =3D 1616
>
> > But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> > get worse if the symbol size is bigger (and it doesn't have many
> > samples in different places).  Also note that it needs separate
> > histogram for each event.
>
> > Let's split the sym_hist_entry and have it in a hash table so that it
> > can allocate only necessary entries.
>
> > No functional change intended.
>
> I tried this before/after this series:
>
>   $ time perf annotate --stdio2 -i perf.data.annotate
>
> For:
>
>   perf record -e '{cycles,instructions,cache-misses}' make -k CORESIGHT=
=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
>
> And found these odd cases:
>
>   $ diff -u before after
>   --- before    2024-02-28 15:38:25.086062812 -0300
>   +++ after     2024-02-29 14:12:05.606652725 -0300
>   @@ -2450826,7 +2450826,7 @@
>                                 =E2=86=93 je       1c62
>                                 =E2=86=92 call     operator delete(void*)=
@plt
>                                 { return _M_dataplus._M_p; }
>   -                       1c62:   mov      0x13c0(%rsp),%rdi
>   +  0.00   0.00 100.00   1c62:   mov      0x13c0(%rsp),%rdi
>                                 if (_M_data() =3D=3D _M_local_data())
>                                   lea      0x13d0(%rsp),%rax
>                                   cmp      %rax,%rdi
>   @@ -2470648,7 +2470648,7 @@
>                                   mov      %rbx,%rdi
>                                 =E2=86=92 call     operator delete(void*)=
@plt
>                                 using reference =3D T &;
>   -  0.00   0.00 100.00  11c65:   mov      0x8(%r12),%rax
>   +                      11c65:   mov      0x8(%r12),%rax
>                                 size_t size() const { return Size; }
>                                   mov      0x10(%r12),%ecx
>                                   mov      %rax,%rbp
>   $
>
>
> This is a large function:

Thanks for the test!  I think it missed the cast to 64-bit somewhere.
I'll check and send v2 soon.

Thanks,
Namhyung


>
> Samples: 574K of events 'anon group { cpu_core/cycles/u, cpu_core/instruc=
tions/u, cpu_core/cache-misses/u }', 4000 Hz, Event count (approx.): 614695=
751751, [percent: local period]$
> clang::CompilerInvocation::ParseCodeGenArgs(clang::CodeGenOptions&, llvm:=
:opt::ArgList&, clang::InputKind, clang::DiagnosticsEngine&, llvm::Triple c=
onst&, std::__cxx11::basic_string<char, std
> Percent
>
> Probably when building the BPF skels in tools/perf/
>
> - Arnaldo

