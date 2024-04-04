Return-Path: <linux-kernel+bounces-132209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A73899168
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3771C231D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B06F514;
	Thu,  4 Apr 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDXNqQ1S"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E96A01E;
	Thu,  4 Apr 2024 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270147; cv=none; b=KK2PhWyi95ErrfVO09B0EKamVFlyjTuiZnY495RaI+wyfqUMn3N2ckoVEx1iIU7g+d3ePKzJ/5lIZzcjXs/+DZkllD77YVyQzgW0QykABVwjuChQyG4Hi6elB/c9ORiFAg3EPhFMdjRYV4dnj/QoIafrlBBBfzGRf28igi8Tkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270147; c=relaxed/simple;
	bh=ccLFujs4PtuZ7Yv9sb1yvfzq72uiKClGnMerPWoLGHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOD316zdUKMlPMdAt0cND+zWmZMOQjKtb3NhJvbqXs8CumgSqqJR9IwB7mnEadHj7Hw2qwSPnI6xXLMH/nT8cVVtA7dId80kG4c4FcsH1jnS7r3XVMUxEsL/hU4/M1fIZJMiWNtHmUe2SGna8Gfe+ITLuIB0yQYnSCkfW49usU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDXNqQ1S; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1302517a12.3;
        Thu, 04 Apr 2024 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712270145; x=1712874945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QfrsL32H/XuBg1IEnWa21H1f1JloPGE0S+M20H3dGg=;
        b=PDXNqQ1SWtJLTLtLsznzJrVX1FFZAfKpY25eHVtyj8lcWgYXSWljLQKVI8mGsSu/f6
         E6znBlKKKe20k7SvRjNFkXYh1LN8y0AmpAUyKaTxkfLQkuauxSXRbRQcHWdR39Zbmdcb
         IH8rtkjyPKqiTkkSptN3hxg1xT6gNtD4rPsDF9AQzJE1pJYjxztUjmU+dQkqEQiT2uGU
         0K1nB3GWM+1QTwYa4NaqJLN9NjPIK2QfLolnuglV77+R3hHoeeKmlJX7yNzXKVUiuh8p
         otND8CqjxGd5w2al67sZbcO8vHlOtx2qeHnydrxqTmPTE10Nl53e296kAoyg6rXIMOoV
         ovGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712270145; x=1712874945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QfrsL32H/XuBg1IEnWa21H1f1JloPGE0S+M20H3dGg=;
        b=RKR24lAZ5Px1Gt02iiame6zDJsF959p5nhz5HsMCiHvnOFmtwsuCnVh24SHktS+0xG
         dM2jFOa5DeMDRvU/8spGiLo8hu7YI79okfd/c2AmiuCFmqYCrGZ1w+MCogqCgxvPcymu
         xFtaqmkD5N+A+1rC0thr/xO97eXQsfoALDijKnpB+RWHM3QRQwleHx9/AGekPI0oOu6q
         FjBjEN1lk59sLvJIrasBM+DoQ75O9NBxOqaDfAF3HeRIlyccvfZY90ozjEk9xKr9C/3T
         G8J774+W4u+ksEvUT+LYPwYgBurBLiM0yzBQFEbwXhl3j2IJC1nilqQTzNKC+PIKxNxq
         Kv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaOXEqU2tPVRFgX/QPmf4SLvGzT7iW6Kttyjg4k+F4dYbdfmAZT1w+gqmpU8+/i0EcQSLHMym/MLqqj/+kDvjgp9LsI5pt8aKMLIHa+GMpooZRtsEpfJn8QKRTSTTZ83Q+
X-Gm-Message-State: AOJu0Yy9TSIbSrCrwxve4Uf/zTX6/J/Dbc6E1rq8UBvHzkuL/+VCjCU+
	NOoUXp9YMXvssO3e9LTHkdI/ivndK1VGp6/mjY3NGZceziu6NJ/D7FVQLpwKJxx4AMQ9pcIVJHh
	3ni0kaI/APGm9rl5l0c50QuPTLQaYh3tr
X-Google-Smtp-Source: AGHT+IFDz7sIojwWiODLHqBbMy/7fZFlticgaZBRGuiUUsACTuMf5avJks8JyJgHcCJH2K1JXk+gB2oG3XwMvvGiWwU=
X-Received: by 2002:a17:90a:9a81:b0:2a2:21a7:48bf with SMTP id
 e1-20020a17090a9a8100b002a221a748bfmr1130335pjp.14.1712270144739; Thu, 04 Apr
 2024 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404010308.334604-1-void@manifault.com> <20240404010308.334604-2-void@manifault.com>
 <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev> <20240404163316.GA385240@maniforge>
 <CAEf4Bza3rGMh=S7yb_Crf8v_SBTrp+NiKn0_frZnWpEi30DkPg@mail.gmail.com> <20240404223044.GA521321@maniforge>
In-Reply-To: <20240404223044.GA521321@maniforge>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 15:35:32 -0700
Message-ID: <CAEf4BzbnG8QufsLmsvwHFG2JKjUCNtbKtU8c5Cb56rWR+s8UBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify calling core kfuncs
 from BPF_PROG_TYPE_SYCALL
To: David Vernet <void@manifault.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 3:30=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Thu, Apr 04, 2024 at 03:16:56PM -0700, Andrii Nakryiko wrote:
> > On Thu, Apr 4, 2024 at 9:33=E2=80=AFAM David Vernet <void@manifault.com=
> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 09:04:19AM -0700, Yonghong Song wrote:
> > > >
> > > > On 4/3/24 6:03 PM, David Vernet wrote:
> > > > > Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs=
, let's
> > > > > add some selftests that verify as much. As a bonus, let's also ve=
rify
> > > > > that we can't call the progs from raw tracepoints.
> > > > >
> > > > > Signed-off-by: David Vernet <void@manifault.com>
> > > >
> > > > Ack with some comments below.
> > > >
> > > > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > >
> > > Thanks for the review. It looks like accidentally replied directly to
> > > me, so I'll re-add the missing cc's.
> > >
> >
> > And dropped bpf@vger :) adding back
>
> *facepalm*, thanks!
>
> >
> > > >
> > > > > ---
> > > > >   .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
> > > > >   .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
> > > > >   .../selftests/bpf/progs/cgrp_kfunc_common.h   | 21 ++++++++++++=
+++++++
> > > > >   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  4 ++++
> > > > >   .../selftests/bpf/progs/cgrp_kfunc_success.c  |  4 ++++
> > > > >   .../selftests/bpf/progs/cpumask_common.h      | 19 ++++++++++++=
+++++
> > > > >   .../selftests/bpf/progs/cpumask_failure.c     |  4 ++++
> > > > >   .../selftests/bpf/progs/cpumask_success.c     |  3 +++
> > > > >   .../selftests/bpf/progs/task_kfunc_common.h   | 18 ++++++++++++=
++++
> > > > >   .../selftests/bpf/progs/task_kfunc_failure.c  |  4 ++++
> > > > >   .../selftests/bpf/progs/task_kfunc_success.c  |  4 ++++
> > > > >   11 files changed, 83 insertions(+)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c =
b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > > > index adda85f97058..73f0ec4f4eb7 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > > > @@ -102,6 +102,7 @@ void test_cgrp_kfunc(void)
> > > > >             run_success_test(success_tests[i]);
> > > > >     }
> > > > > +   RUN_TESTS(cgrp_kfunc_success);
> > > > >     RUN_TESTS(cgrp_kfunc_failure);
> > > > >   cleanup:
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c =
b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > > > index d4579f735398..3db4c8601b70 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > > > @@ -94,5 +94,6 @@ void test_task_kfunc(void)
> > > > >             run_success_test(success_tests[i]);
> > > > >     }
> > > > > +   RUN_TESTS(task_kfunc_success);
> > > > >     RUN_TESTS(task_kfunc_failure);
> > > > >   }
> > > >
> > > > The above RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_su=
ccess)
> > > > will do duplicate work for *existing* bpf programs in their respect=
ive
> > > > files. I think we still prefer to have cgrp_kfunc_success tests
> > > > in cgrp_kfunc.c to make it easy to cross check. But in order to
> > > > remove duplicate work, one option is to make other non-RUN_TESTS
> > > > programs in those files not auto-loaded and their corresponding
> > > > prog_tests/*.c file need to explicitly enable loading the problem.
> > >
> > > Good point, and yes I agree with that approach of not auto-loading
> > > non-RUN_TESTS programs. Considering that we have a  __success BTF tag=
 to
> > > say, "this prog should successfully load", it seems odd that we'd als=
o
> > > automatically load and validate progs that _didn't_ specify that tag =
as
> > > well. At that point, I'm not sure what value the tag is bringing. Als=
o,
> >
> > Just more explicitness (if desired). Normally __success would be
> > augmented by __msg() or __retval(). I'd feel uncomfortable just
>
> But __success really has no actual purpose, right? Isn't it identical to
> if it's just left off? You don't need __success to specify __msg() or
> __retval() right?

right, it's just a more explicit documentation-like annotation, if you will

>
> > silently skipping programs that are not marked with __success, as it
> > would be too easy to accidentally forget to add it and not know that
> > the BPF program is not tested.
> >
> > I'd say that RUN_TESTS-based programs should be kept separate from any
> > other BPF programs that have a custom user-space testing part, though.
>
> IF we do go this way, maybe just a __skip or something tag would be
> sufficient?

if we go this way we wouldn't need __skip, but if we do not go, then
sure, why not. But in general, __skip makes sense either way, I guess,
I have no problem with it.

>
> > About the patch itself. I don't really see much point in adding
> > *_KFUNC_LOAD_TEST macros. They are used once or twice in total, while
> > obscuring *what* is actually being tested. Unless you expect to add 5+
> > more copies of them, I'd just inline them explicitly.
>
> It's not really important what's in the actual prog though -- the point
> is that we're verifying we can invoke some kfuncs in a certain prog
> type. But yes, it does obscure what's there, and I'm fine with
> copy-pasting them if that's your preference. The reason I went with a
> macro was to make it easy for us to quickly test new prog types as we
> add support for them, or to add other negative testcases for unsafe prog
> types. Right now we're just testing tracing progs.

I'm always for less macro usage, if possible :)

For the use case you are describing I'd just add static subprog that
exercises all the kfuncs of interest, and then call this subprog from
all the (explicitly defined) main entry program of desired program
types

>
> >
> > > that was the expected behavior before RUN_TESTS() was introduced, so =
it
> > > hopefully shouldn't cause much if any churn.
> > >
> > > > Maybe the current patch is okay even with duplicated work as it
> > > > should not take much time to verify those tiny problems.
> > >
> > > IMO it should be fine for now as the overhead for validating and load=
ing
> > > these progs is low, but it'd definitely be good to address this probl=
em
> > > in a follow-up. I don't think it should take too much effort -- AFAIC=
T
> > > we'd just have to mark a test spec as invalid if it didn't have any B=
TF
> > > test tags. Ideally I'd like to separate that from this patch set, but=
 I
> > > can do it here if folks want.
> > >
> > > Thanks,
> > > David

