Return-Path: <linux-kernel+bounces-32294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15783599E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C158B2325D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25517FF;
	Mon, 22 Jan 2024 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRtPZ3Rq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9C1368;
	Mon, 22 Jan 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892910; cv=none; b=D2Ry5AM4CcrWNC7LCD8PrsORzuf5WYuANXYkNcnJuZyZZ4RqAY+U3wxvxkKJ5xO4CVc9Jpsk0O4lG/wXmuJvrv+dGEUOJILiKhP07nQWQmT5woxfRuPPQnLYR90mD/he9UTUQ4zgtK2uKdYEVRTGtKrwgNasLT78XTUck88e/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892910; c=relaxed/simple;
	bh=uc0WWNGVpuEIEI8luKtG8sjMWn7TPiRNIepgYelNZ/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2ft3qCh9E13VvfkbmmYSNWfs7NPlwkmGAjY4ec+puow6NIP8jceWAzSAE5VyeuAnFJnp0BQwA/Em0pCJNgrEeXDhZ/9d7WDsbxd3uxXxM2tGNHNXDThM7G/VuE2/a0NVNBalcVfCaHAEwda0nRJhvr/FdZ4yDdwH8J3H3HYRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRtPZ3Rq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3437127a12.3;
        Sun, 21 Jan 2024 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705892907; x=1706497707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucXkS6oMg4EwL+WlxCpHjCV2h93GplxRsfWmGVUkm58=;
        b=kRtPZ3RqBIvJb8d18R9m05RxLCA0fU1Jpe4JuG6m97Orzl0/uNgjmhAEfcVGWJfP8e
         /+ncxwyGxQ4h5CmkpokVGc044FvMqXcQFG2r5LppuIPeZa8ZJDe97QX1xBph0jK0UPNM
         3L7l4WKiz8s+tPcatB0x0IR7lC1jbLIXtUm3uB/oj7gH/R1Z5L04DZSMoto84XEbh3yK
         tMH+9y/M/Q1Wc8re3zOke4HpC77qeOlfWZz0wRqDY3lBgvJyKGPWuGjPhLEdw+anlW1/
         UjKfhXRhdycpE6NviIMo0XfCLI56CajR5qTscJNKmDLosozvjZ1xNqQtbykrC2LgUhcx
         COLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705892907; x=1706497707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucXkS6oMg4EwL+WlxCpHjCV2h93GplxRsfWmGVUkm58=;
        b=vTeA/fZg9cjn3Ev8clWJH3rmQSxZzXjbxts5UDhdK1GBZ0MYGqPF694oe9V87Jx8HI
         rFYmVdzxpR7hWKX9qvWkBYtptxJl208ESSsq455kxplqj4p3DtZwMjlq1WtQM8YHf+pK
         oyyIsuYeo3eq2Qk1C5kfLeBoLT/RpyU+gCfDwNZLU1oF51yNNh9To1uPbh6r9u6jPo8h
         rLMEsupbHiXZUnxHWdX4IDq7RIZTuGSA/DaSIRFQMtUm8E2rR37hwWiJv6yONzPm6R/W
         JnlBQu+wIxItWnHkin8fgChoPT7uMwkTnAdlJdOk02QNgMaSwydZySYs6vYIJlBu9/Ix
         eqCQ==
X-Gm-Message-State: AOJu0Yw/HJV8lwifajD7Vo8A5eqlm8HK0AMLPgLTjaGOQm5EpZFqloqg
	GnXSCPYKJc1NRflAQkJmc6GbYWK65bEig6r/u7Tnrudh2oxUeRTCn1kntyKTyENLzU7OWWxw4Tx
	s+rMBTWnWbKf8XvPcN/RVjRo66c0=
X-Google-Smtp-Source: AGHT+IHBlEQTzABTAwFE9MXlg4x8B1g0JUsY8wfw5I1aoumrrxknzpwe2TnErBwPeHVHKfCfTkvjJfMjA5SqsT4J1Yo=
X-Received: by 2002:a05:6402:1618:b0:55a:179f:5eee with SMTP id
 f24-20020a056402161800b0055a179f5eeemr1599278edv.64.1705892906608; Sun, 21
 Jan 2024 19:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com> <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
 <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com>
 <CAD8CoPA0YgVHVW1Ya1O0-vhmpCbiw2h3i29ayzKmg4YTu-zeKQ@mail.gmail.com>
 <CAM9d7ciiKeVJzCjNyJp8hDsMe2ZiVyOKT3ses_SQMfdEQnWiog@mail.gmail.com>
 <CAD8CoPCSDcB+-qvwEZGOrdi01C3W8N3dYN3XQUQ2jrpn1mSf=Q@mail.gmail.com> <CAM9d7cigWxAN_nmT2rO-o7YG0hkmPNjDPeLtsn=z1YqRSjMEjA@mail.gmail.com>
In-Reply-To: <CAM9d7cigWxAN_nmT2rO-o7YG0hkmPNjDPeLtsn=z1YqRSjMEjA@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 22 Jan 2024 11:08:15 +0800
Message-ID: <CAD8CoPChgx_h9KU4nBJ+0__g6J=LvTBuMdbc0-F0dHz4=kjY0g@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf sched: Fix task state report
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 6:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Jan 18, 2024 at 5:54=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrot=
e:
> >
> > On Fri, Jan 19, 2024 at 7:53=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jan 17, 2024 at 7:15=E2=80=AFPM Ze Gao <zegao2021@gmail.com> =
wrote:
> > > >
> > > > On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Ze Gao <zegao2021@gmail.co=
m> wrote:
> > > > >
> > > > > On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > The problems of task state report in both libtraceevent
> > > > > > > and perf sched has been reported in [1]. In short, they
> > > > > > > parsed the wrong state due to relying on the outdated
> > > > > > > hardcoded state string to interpret the raw bitmask
> > > > > > > from the record, which left the messes to maintain the
> > > > > > > backward compatibilities for both tools.
> > > > > > >
> > > > > > > [1] has not managed to make itself into the kernel, the
> > > > > > > problems and the solutions are well studied though.
> > > > > > >
> > > > > > > Luckily, as suggested by Steven, perf/libtraceevent
> > > > > > > records the print format, especially the __print_flags()
> > > > > > > part of the in-kernel tracepoint sched_switch in its
> > > > > > > metadata, and we have a chance to build the state str
> > > > > > > on the fly by parsing it.
> > > > > > >
> > > > > > > Now that libtraceevent has landed this solution in [2],
> > > > > > > we now apply the same idea to perf as well.
> > > > > >
> > > > > > Thanks for your work.  But perf links libtraceevent
> > > > > > conditionally so you need to make sure if it works without
> > > > > > that too.
> > > > >
> > > > > Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
> > > > > out perf removes perf sched subcmd without libtraceevent,
> > > >
> > > > FWIW,  commit 378ef0f5d9d7f4 ("perf build: Use libtraceevent
> > > > from the system") has proved this as well.
> > >
> > > Right, but I think we can enable perf sched without libtraceevent
> > > for minimal features like record only.  But that doesn't belong to
> > > this change set.
> > >
> > > >
> > > > > which explains why the compiler does not complain no
> > > > > evsel__intval() defined when !HAVE_LIBTRACEEVENT
> > > > > given the fact so many references of evsel__intval() in
> > > > > builtin-sched.c.
> > > > > Here evsel__taskstate() uses the exact assumption as
> > > > > evsel__intval(), so I put it next to it for clarity and it works
> > > > > without a doubt.
> > > > >
> > > > > > I think all libtraceevent related stuff should be in the
> > > > > > util/trace-event.c which is included only if the library is
> > > > > > available.  Maybe util/trace-event-parse.c is a better
> > > > > > place but then you need to tweak the python-ext-sources
> > > > > > and Makefile.perf for the case it's not available.
> > > > >
> > > > > Thanks for pointing this out. I will do the hack if you insist
> > > > > on this move :D. But I think the current version is clear
> > > > > enough, otherwise we need to move all the parts guarded
> > > > > by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
> > > > > What do you think of it?
> > >
> > > Oh, I realized that all the affected codes are under the #ifdef
> > > properly then maybe it's ok for now.  But I prefer moving the
> > > code if you're ok.  Maybe I can accept this code as is and you
> >
> > Sounds great!
> >
> > > can work on the refactoring later.  Does that work for you?
> >
> > Absolutely! Will send the following refactoring patches soon. :D
>
> Thanks, but your patches don't apply cleanly.  Could you please
> rebase it onto the current perf-tools-next tree?

Oops, that is kinda weird. I've tested and managed to cherry-picked all 4
patches onto branch perf-tools-next in [1], with no conflicts being
hit.  Maybe I used the wrong branch tip?

FWIW:  the tip I rebase onto is

d988c9f511af (perf/perf-tools-next) MAINTAINERS: Add Namhyung as
tools/perf/ co-maintainer

[1]:  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/

Regards,
        -- Ze

> Thanks,
> Namhyung

