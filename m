Return-Path: <linux-kernel+bounces-54233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8384AC9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53B81C22B40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7F7318F;
	Tue,  6 Feb 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t+wZN6y9"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF096E2D0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188678; cv=none; b=HvZV5Ci4hldOLj8b8L3AdBXIzNmvI299R27bo6dLvU8E6dDd2A5s7lIyeDuxDB6gh7QnxiUD57dz3YgfFRwtA0DZkyQG1MkNI09k09LLNvmDoyjTzgB00t+/TBV4MkHTVsI3rNM3IWEu2q90SSmIUB9caDGXXgU3lGSUpJkDH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188678; c=relaxed/simple;
	bh=ne9JUsjTXyxLjlyYsZnE6He33Wl0F4KvtV6zAXvFlbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyA2LNn/ZX8UXrcf0QnsmrMc97lUa43a6mVJ9XoQE/4cH/JdbUxzU9X4Thsip9GLPYAVO/HDdpXgEwf8tm2iIqJBENqPsL2KY1v7ElL2YUEca721w9aKFUrFsemYT7bPhPFMPb8+X3n9TMQOYDzfG0CuBD2od/R/A634m7v1LVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+wZN6y9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d93b982761so150745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707188676; x=1707793476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XVXU4jAI/ZUz/I4D5gYYVK37UMhSbbkdn1X91/JlTo=;
        b=t+wZN6y9Ffl/AmEMSY0oio0GMdYUO/RablQv7b6jzA2IdbVFPaQ1qPLpKG+LIFTidY
         5+ySQa0mGqmHOs0tdjkj0dlrWRJSpN8Gq+nSncL58cN3Yt9ceJFeE4YoPNN2Y7+XoYi4
         U2zB3rTho2ODaDpcGPEr2dxHL8izaTWuX6trFoCHCQUFR0f9vI9sdCJKMa2Kw9m/4Ran
         BWx+V+7Ij0rDFXR/qJIyASZMl9saqL4lIbEgzFOEdUnysTWyMZdaeEvnDv5gyBVi08Hv
         5A/T/1Cwry2ZEpJsqsaaplGVedXxsWbG3q69yYEh4D9TRxT2YT7yceCxRxiEFgpjmuBO
         mWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707188676; x=1707793476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XVXU4jAI/ZUz/I4D5gYYVK37UMhSbbkdn1X91/JlTo=;
        b=HoIO4wmULzoDJxfnk/cM1nCkLa3BxXDy9a9rRRkl8xrEzkH+j+87zrAhx96XcHlTkk
         iKJS7NzkWMu2rFi6TKiwDhzGka4iZXvTIEcDvLUkx/3gV6ZoRNsnqW5/8TshTKsM+N8u
         AbwSUhLBWLq3ZuJTohWKYmYN51lCJIBr4f43ZxtYQkijKS3knVHbwqTHRQTyySpalhLx
         evfLscbEu3u1zHuPrN1lQQbMxTovY8C5A+FQsPJJGg5C0guafYm5+KQJwP11lh4DzGe6
         PQxO8YzQxolegPH/wiDqEYJ5x2sh4u1zI+c++lpqGVkg6ukFO3uX2Wl622zQaWEVYEEW
         IoUg==
X-Gm-Message-State: AOJu0YwcUJWUZdt07CAcpmG8dyj+XmtLdBEWhT4JCU/K0qafFfPgFyF5
	b8gBaKvvMzdUxnKhQEgO4KJdS4dvFL+ogSrjYyLYVY6fIvo/Ok09rjqBv2lsDaGGq5BKlebgwH1
	fWxVFdx59iCI4zOPDBS5fXXEwjlCYWR4LnXvn
X-Google-Smtp-Source: AGHT+IENXxmgQziH6fpQsqF7G4W2/PhhQ3etqtTZVXpMqrnIzVWVS5i2UCg5LADUiUHntlFr2fQ/EcYtDA0F+Y7n5+E=
X-Received: by 2002:a17:902:d507:b0:1d9:aa55:e4c1 with SMTP id
 b7-20020a170902d50700b001d9aa55e4c1mr149250plg.20.1707188676257; Mon, 05 Feb
 2024 19:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-2-irogers@google.com>
 <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
 <CAP-5=fUBr60o22P4Op-J=TPkdfnby9vLetHQZ4UqjuX+nvbG9w@mail.gmail.com>
 <CAM9d7cjO2vxa_bvKFrVpX2PViHqZy_dtyf28EaSACwKv6BEHiw@mail.gmail.com> <CAP-5=fUBf41b=p7iVwoANZtRifR8ftuE00zQqLWz54KZ-9VWtw@mail.gmail.com>
In-Reply-To: <CAP-5=fUBf41b=p7iVwoANZtRifR8ftuE00zQqLWz54KZ-9VWtw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Feb 2024 19:04:24 -0800
Message-ID: <CAP-5=fVm4rcieqApYP9ai0FO10qW0Q8VWeYxnpfTKgeKFzwRPQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/50] perf comm: Use regular mutex
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Sat, Dec 2, 2023 at 3:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Thu, Nov 30, 2023 at 10:28=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Wed, Nov 29, 2023 at 4:56=E2=80=AFPM Namhyung Kim <namhyung@kernel=
org> wrote:
> > > >
> > > > On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > The rwsem is only after used for writing so switch to a mutex tha=
t has
> > > > > better error checking.
> > > > >
> > > > > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mute=
x")
> > > >
> > > > I think we talked about fixing this separately, no?
> > >
> > > Sorry, I'm unclear on an action to do. Currently changing the
> > > RWS_ERRORCHECK in tools/perf/util/rwsem.h will break the build withou=
t
> > > this change.
> >
> > Can it be like this?
> >
> > #ifdef RWS_ERRORCHECK
> > #define RWSEM_INITIALIZER  { .lock =3D PTHREAD_MUTEX_INITIALIZER, }
> > #else
> > #define RWSEM_INITIALIZER  { .lock =3D PTHREAD_RWLOCK_INITIALIZER, }
> > #endif
> >
> > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/util/comm.c | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> > > > > index afb8d4fd2644..4ae7bc2aa9a6 100644
> > > > > --- a/tools/perf/util/comm.c
> > > > > +++ b/tools/perf/util/comm.c
> > > > > @@ -17,7 +17,7 @@ struct comm_str {
> > > > >
> > > > >  /* Should perhaps be moved to struct machine */
> > > > >  static struct rb_root comm_str_root;
> > > > > -static struct rw_semaphore comm_str_lock =3D {.lock =3D PTHREAD_=
RWLOCK_INITIALIZER,};
> > > > > +static struct mutex comm_str_lock =3D {.lock =3D PTHREAD_ERRORCH=
ECK_MUTEX_INITIALIZER_NP,};
> > > >
> > > > IIUC it has a problem with musl libc.  Actually I think it's better=
 to
> > > > hide the field and the pthread initializer under some macro like
> > > > MUTEX_INITIALIZER or DEFINE_MUTEX() like in the kernel.
> > >
> > > Will there be enough use to justify this? I think ideally we'd not be
> > > having global locks needing global initializers as we run into
> > > problems like we see in metrics needing to mix counting and sampling.
> >
> > I don't know but there might be a reason to use global locks.
> > Then we need to support the initialization and it'd be better
> > to make it easier to handle internal changes like this.
>
> Right. So you are suggesting I make a macro for initialization but
> when this change is applied it will remove the only user of the macro.
> The macro would clearly be redundant which is why I didn't do a
> separate fix for that before doing this change - to use a mutex as the
> rwsem here is only ever used as a write lock. If we're looking to
> improve rwsem I don't think adding unused macros is the best thing,
> for example, we could remove references to perf_singlethreaded which
> is an idea that has had its day.

Note, RWS_ERRORCHECK being enabled still is broken without this.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Namhyung

