Return-Path: <linux-kernel+bounces-78939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB2861B06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644B428966F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D7613BAC2;
	Fri, 23 Feb 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIIedOCC"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CE12BE83
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711310; cv=none; b=TynRXDmbdw7nGGRqJqPCqNwx0Fa4CS/GeA4ehvt6Nzy+KHIKejt9sIPVdKE3xRmXJmb+HNpxlMz3GVAZv8cp1oIkgNt/t3FCWwrEALjrr04GSrZszKoJwZ25yn38+CH9LHuPRUqsRGJ705Cj7xozpb1+GgZydbBs8FfxVJ5YrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711310; c=relaxed/simple;
	bh=d93vKEyBUqSMfgszb7nKKMpMuQ2x+DYfOVS+gdJdKpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofiR/5S0wqB5NybThijeanaAkFuFOvQOgRPtshxL//lCpmHHSX40xL4UhGZJNUsV5wVSf2yTLVSnwfDdzwnx3eO9Qvq95bjyUNTzbH5qmj9eZrkSSMaNdkPG0sGr1LwyjiYKksILhH/aCONSwlRly/IeIwVRWA9Kg+M1t0kPw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIIedOCC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-428405a0205so8421cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708711307; x=1709316107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRHX8SRb/g3ONTdNjk+xLg/313XUSVGYWCF8v1RW8cY=;
        b=LIIedOCCrQrCTDIanKbTBDa5M9KBgSXuJ/EG7ZzTJXsxtM8xhV6vDvZAQfjuRWik0a
         j4z9cNJBlSAihXOo6+UnxUek8YdjLhmbcSgDa/Tzyu3a8MkCCNGPfSN4GG22ngqjyBZK
         6Ra58W77OaRgUhECT3wkEzBaLWTIaPjuPpBFyPgr2qOWK6z9pG0wcfK6g2sr9o3iRaFH
         cJzLAamxTStMPINA4dpCA38ERWR5sJrreJWKMAcyQVWQOUh3nybgdBelSzOWEmqxYQD0
         lzAlONAbbMOBwpnC/YAbJMeEOpEIImrt6pR3oBrNpsCogngeznjahSgwLgqoz+f0WW5U
         JAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711307; x=1709316107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRHX8SRb/g3ONTdNjk+xLg/313XUSVGYWCF8v1RW8cY=;
        b=NG/yB+DIhUuuQNTr/Lo+I7HKSFJJ4dg6pdrGgQpKxnlgQNZjnVG1GPA2gT/UVVJYR3
         l41lGHUORMrIDVJHi4phsLk6Dy8oyX3BQXOtUqFPOGoQNJzFQ6q1RIHRS6ISZ5w3gc2j
         hdqDJ+kafhbCzRMU+xA+l0nf2iQKR3ODjd0F1nAgbyBOEPcIamnarCIhEw0g1H/BkglP
         E5xTWcJuTGVSdXToz+ZPxOvWwVvJljafq/kwzJolvliCzGbCHnvJCPDBPg49fPSHyGV2
         o7LjEuv3jx0c1kOksqem/I4rwmCu13uZo35uXMGPKC1N2KEUi3xufLHSYIgtIg2DdXMP
         ocNg==
X-Forwarded-Encrypted: i=1; AJvYcCV9YZbspVLNLAakSY+q/Pj9/dDu0tL1u/f9VHECSjJpHBQWNmEcjClm3ov3o6ll7vDiLHUPMapwUKzdHqayMwccUP1jRxnMJ+Cve+ih
X-Gm-Message-State: AOJu0Yz/iwnY8HOpT324yWRLzgBKtit5ycfgLS9iBSukofKU15rX08TF
	8PMWLb7xgZ8prVL4XqvW8gu5VtN/HjJT5+3tQ9iUeIyQzuP24KcVh6nxUZ1czsuk5cu07p5f7OX
	M/QSYPW1oL3aD9HNmoZU6/OkKF+j5BKN8Jp4C
X-Google-Smtp-Source: AGHT+IFjd7LBMxrromnLqLyLXYjRoUlQc0+pZBSVa08jNHz7xjSQcCyQ/TFpeC7YkZ+vu00vxgg0LSWFAqtuVSa+nzc=
X-Received: by 2002:ac8:58d0:0:b0:42d:fb39:def4 with SMTP id
 u16-20020ac858d0000000b0042dfb39def4mr10595qta.24.1708711307057; Fri, 23 Feb
 2024 10:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <ZdemibZepMqWvv6U@x1> <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
In-Reply-To: <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Feb 2024 10:01:31 -0800
Message-ID: <CAP-5=fXzidk9hLm5bek3q1crds4mEjdgpq=s0YCSzLCj1GtvzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Kyle Huey <me@kylehuey.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kyle Huey <khuey@kylehuey.com>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Thu, Feb 22, 2024 at 11:54=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Feb 22, 2024 at 09:55:36AM -0800, Kyle Huey wrote:
> > > On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com>=
 wrote:
> > > > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > > > +               goto cleanup;
> > > > > +       }
> >
> > > > Thanks for the work! The perf tool and perf test should run on olde=
r
> > > > kernels ideally without failure. I'm assuming this would fail on an
> > > > older kernel. Could we make the return value skip in that case?
> >
> > > Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> > > yes. It's not possible to distinguish between an older kernel and a
> > > kernel where this fix broke (at least not without hardcoding in an
> > > expected good kernel version, which seems undesirable), so that would
> >
> > Take a look at:
> >
> >  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/tools/perf/tests/sigtrap.c?id=3D650e0bde43f35bb675e87e30f679a57cfa22e0e=
5
> >
> > To see how introspecting using BTF can be used to figure out if interna=
l
> > data structures have what is needed, or if functions with some specific
> > arguments are present, etc, for sigtrap we have, in the patch above:
> >
> > -       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_=
THREADS * ctx.iterate_on);
> > +       expected_sigtraps =3D NUM_THREADS * ctx.iterate_on;
> > +
> > +       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepab=
le_spinlocks()) {
> > +               pr_debug("Expected %d sigtraps, got %d, running on a ke=
rnel with sleepable spinlocks.\n",
> > +                        expected_sigtraps, ctx.signal_count);
> > +               pr_debug("See https://lore.kernel.org/all/e368f2c848d77=
fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");
> > +               return TEST_SKIP;
> > +       } else
> > +               TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_cou=
nt, expected_sigtraps);
> >
> > And then:
> >
> > +static bool kernel_with_sleepable_spinlocks(void)
> > +{
> > +       const struct btf_member *member;
> > +       const struct btf_type *type;
> > +       const char *type_name;
> > +       int id;
> > +
> > +       if (!btf__available())
> > +               return false;
> > +
> > +       id =3D btf__find_by_name_kind(btf, "spinlock", BTF_KIND_STRUCT)=
;
> > +       if (id < 0)
> > +               return false;
> > +
> > +       // Only RT has a "lock" member for "struct spinlock"
> > +       member =3D __btf_type__find_member_by_name(id, "lock");
> > +       if (member =3D=3D NULL)
> > +               return false;
> > +
> > +       // But check its type as well
> > +       type =3D btf__type_by_id(btf, member->type);
> > +       if (!type || !btf_is_struct(type))
> > +               return false;
> > +
> > +       type_name =3D btf__name_by_offset(btf, type->name_off);
> > +       return type_name && !strcmp(type_name, "rt_mutex_base");
> > +}
> >
> > > mean the test would always return ok or skip, not ok or fail. Is that
> > > ok?
> >
> > It should return:
> >
> > Ok if the kernel has what is needed and the test passes
> > Skip if the test fails and the kernel doesn't have what is needed
> > FAIL if the test fails and the kernel HAS what is needed.
> >
> > 'perf test sigtrap' also checks for the presence of the feature it
> > requires:
> >
> > static bool attr_has_sigtrap(void)
> > {
> >         int id;
> >
> >         if (!btf__available()) {
> >                 /* should be an old kernel */
> >                 return false;
> >         }
> >
> >         id =3D btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_=
STRUCT);
> >         if (id < 0)
> >                 return false;
> >
> >         return __btf_type__find_member_by_name(id, "sigtrap") !=3D NULL=
;
> > }
> >
> >         fd =3D sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cl=
oexec_flag());
> >         if (fd < 0) {
> >                 if (attr_has_sigtrap()) {
> >                         pr_debug("FAILED sys_perf_event_open(): %s\n",
> >                                  str_error_r(errno, sbuf, sizeof(sbuf))=
);
> >                 } else {
> >                         pr_debug("perf_event_attr doesn't have sigtrap\=
n");
> >                         ret =3D TEST_SKIP;
> >                 }
> >                 goto out_restore_sigaction;
> >         }
> >
> > - Arnaldo
>
> I think perhaps I'm barking up the wrong tree here. This seems like a
> ton of work just to write a regression test. Maybe I should be doing
> this in tools/testing/selftests instead?

The problem is detecting support for the feature in the kernel. The
BTF approach isn't that bad, a couple of finds, but I think in this
case there isn't anything to be found to indicate the feature is
present. I like the perf test as perf tests are a form of
documentation. Perhaps just using TEST_SKIP here (rather than
TEST_FAIL) is best and the skip_reason can be a presumed lack of
kernel support.

Thanks,
Ian

> - Kyle

