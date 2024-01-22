Return-Path: <linux-kernel+bounces-32421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43E835B83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9D71F2198B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DBF9D2;
	Mon, 22 Jan 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq+9PwEX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DFF9C4;
	Mon, 22 Jan 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907982; cv=none; b=BZJYTghhbVPd9M/OvbvlBrO82nNWZjiuqC4/Ak3Zg4bjxF8ZW12GU++SmSQjPJMfX0DiKctkValB78N9424zv01hd20CTqrk71cz+jixCD1o25JpoQUXdupervuPwGN5TgCZ8raeg5fMZ0qey+jxkqrY9u4lMjV1oo9lt4NanhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907982; c=relaxed/simple;
	bh=dj/LJopYse2HUzcW6afWbr8br4SBQm9nhXp424JXXIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYxW5DQ0TmxM36/oPLrg0fKzze/P2uBmn6B4UIu9nQAFLCj8y03DKDQosQO/fouqwFeRWr8cFGhXiVFg9bAuS/sFXIVNc2DMi0H5SzwsAu7yAQlHqZ8mjrGqsQtmnvrQUTYlO/NMEPxz2R3kOpM5NTiVsk2MMmupAvS6GJhhhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq+9PwEX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so1679624a12.0;
        Sun, 21 Jan 2024 23:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907979; x=1706512779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHfxS5Ol5SGn5i9F3Z2DwGCA8DrLgQq4cMm5+V02usA=;
        b=dq+9PwEXJh8f/vbcnocplDnKUncmLT2q9Fs2swPki0OWuGyk9bPp90xRft9ISxqGOI
         op1L1d2NDsMeiXLtJIY8nFaLaGiJZdzTQsjSUE4hm031aCHT/0JLVCyJgjGKYnifX0nF
         jujUBYsZo2Wzy+aO7ZWAYmQM+iLTTf5/tg5lotqwTJyO83mqKmo5t+Wkaa9Cv97qPOif
         3IfkyVkHvDm1zxAQmlY584l9+sdR918vsrt2XkwPMuiKf+B+sxIAHuwN09lQGQq1Ncue
         VgaBXXXPahgEzkkEto+10hRdh1BkxCZ8UwU9WzxkL8gzSQzoNlX+tZV2vu4ZM/gsEv1G
         PFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907979; x=1706512779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHfxS5Ol5SGn5i9F3Z2DwGCA8DrLgQq4cMm5+V02usA=;
        b=v8x+Bhoh92aQLQb7kDRRqnM/FTLQ5KWyAbVDGmcwAT9UvF3HCzfe2aXR7AWVxqNIWw
         QyI3LPp8Zq1KKbbY7su45IOo2k3cn40yj1QMbYTJdQtrjJtNFXUvTcQdOgRjYpFjBkIb
         +WW8A9ZBcJ7S7pXPQbXTbB/+kjDAf5dFcWgJKCqxUZMblu6i9kbkIwiZLGx82UJ4S7jV
         sYksGHjINEhn5f3UI+B49YolZKWsbxSLW+egwfsahU1eK4ZqIxWxH45RTCmrkxVqMdNA
         L5I4soc/9qHQMBSvBjpGyhzRhR0Uy4UOcq96b4n2oPQQTtH4cVuTK6Z7RkrYQUPcdAhs
         Pzdg==
X-Gm-Message-State: AOJu0YwomEWou2Nr9ALcNaKADRCYyVLCKe6ohOga7YaOJsl5YHfIfq8q
	FCCPfd8QQkn59mPfh9PjH2hllF9kHFbDHHn27Dui+wHw+0ES3XFifQQAf4gnTOs2XWDFZPSnHyJ
	rdhY6ND75ELAvgQHQy4EeCnDEx04=
X-Google-Smtp-Source: AGHT+IHFz/IZ8KDzNs86vVGSZGZizq2DiHBGzIcj/0rCXdm9V1odoIxmTR2rsuJ+ZDauzWaw+Gzj8XNxbF6HndhoGgs=
X-Received: by 2002:a05:6402:35d4:b0:55c:381a:fafc with SMTP id
 z20-20020a05640235d400b0055c381afafcmr369325edc.101.1705907978614; Sun, 21
 Jan 2024 23:19:38 -0800 (PST)
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
 <CAD8CoPCSDcB+-qvwEZGOrdi01C3W8N3dYN3XQUQ2jrpn1mSf=Q@mail.gmail.com>
 <CAM9d7cigWxAN_nmT2rO-o7YG0hkmPNjDPeLtsn=z1YqRSjMEjA@mail.gmail.com> <CAD8CoPChgx_h9KU4nBJ+0__g6J=LvTBuMdbc0-F0dHz4=kjY0g@mail.gmail.com>
In-Reply-To: <CAD8CoPChgx_h9KU4nBJ+0__g6J=LvTBuMdbc0-F0dHz4=kjY0g@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 22 Jan 2024 15:19:27 +0800
Message-ID: <CAD8CoPC1-AZd6vRKFT_w-0ov8Rtm0yLnbMPGnJ4B3hh5C8bMyQ@mail.gmail.com>
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

On Mon, Jan 22, 2024 at 11:08=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote=
:
>
> On Sat, Jan 20, 2024 at 6:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, Jan 18, 2024 at 5:54=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wr=
ote:
> > >
> > > On Fri, Jan 19, 2024 at 7:53=E2=80=AFAM Namhyung Kim <namhyung@kernel=
org> wrote:
> > > >
> > > > On Wed, Jan 17, 2024 at 7:15=E2=80=AFPM Ze Gao <zegao2021@gmail.com=
> wrote:
> > > > >
> > > > > On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Ze Gao <zegao2021@gmail.=
com> wrote:
> > > > > >
> > > > > > On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@=
kernel.org> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gm=
ail.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > The problems of task state report in both libtraceevent
> > > > > > > > and perf sched has been reported in [1]. In short, they
> > > > > > > > parsed the wrong state due to relying on the outdated
> > > > > > > > hardcoded state string to interpret the raw bitmask
> > > > > > > > from the record, which left the messes to maintain the
> > > > > > > > backward compatibilities for both tools.
> > > > > > > >
> > > > > > > > [1] has not managed to make itself into the kernel, the
> > > > > > > > problems and the solutions are well studied though.
> > > > > > > >
> > > > > > > > Luckily, as suggested by Steven, perf/libtraceevent
> > > > > > > > records the print format, especially the __print_flags()
> > > > > > > > part of the in-kernel tracepoint sched_switch in its
> > > > > > > > metadata, and we have a chance to build the state str
> > > > > > > > on the fly by parsing it.
> > > > > > > >
> > > > > > > > Now that libtraceevent has landed this solution in [2],
> > > > > > > > we now apply the same idea to perf as well.
> > > > > > >
> > > > > > > Thanks for your work.  But perf links libtraceevent
> > > > > > > conditionally so you need to make sure if it works without
> > > > > > > that too.
> > > > > >
> > > > > > Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
> > > > > > out perf removes perf sched subcmd without libtraceevent,
> > > > >
> > > > > FWIW,  commit 378ef0f5d9d7f4 ("perf build: Use libtraceevent
> > > > > from the system") has proved this as well.
> > > >
> > > > Right, but I think we can enable perf sched without libtraceevent
> > > > for minimal features like record only.  But that doesn't belong to
> > > > this change set.
> > > >
> > > > >
> > > > > > which explains why the compiler does not complain no
> > > > > > evsel__intval() defined when !HAVE_LIBTRACEEVENT
> > > > > > given the fact so many references of evsel__intval() in
> > > > > > builtin-sched.c.
> > > > > > Here evsel__taskstate() uses the exact assumption as
> > > > > > evsel__intval(), so I put it next to it for clarity and it work=
s
> > > > > > without a doubt.
> > > > > >
> > > > > > > I think all libtraceevent related stuff should be in the
> > > > > > > util/trace-event.c which is included only if the library is
> > > > > > > available.  Maybe util/trace-event-parse.c is a better
> > > > > > > place but then you need to tweak the python-ext-sources
> > > > > > > and Makefile.perf for the case it's not available.
> > > > > >
> > > > > > Thanks for pointing this out. I will do the hack if you insist
> > > > > > on this move :D. But I think the current version is clear
> > > > > > enough, otherwise we need to move all the parts guarded
> > > > > > by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
> > > > > > What do you think of it?
> > > >
> > > > Oh, I realized that all the affected codes are under the #ifdef
> > > > properly then maybe it's ok for now.  But I prefer moving the
> > > > code if you're ok.  Maybe I can accept this code as is and you
> > >
> > > Sounds great!
> > >
> > > > can work on the refactoring later.  Does that work for you?
> > >
> > > Absolutely! Will send the following refactoring patches soon. :D
> >
> > Thanks, but your patches don't apply cleanly.  Could you please
> > rebase it onto the current perf-tools-next tree?
>
> Oops, that is kinda weird. I've tested and managed to cherry-picked all 4
> patches onto branch perf-tools-next in [1], with no conflicts being

Please forget about this. Looks like git-cherry-pick is smarter to
figure out where to
apply when in the same repo ( or than git-am ?).

Anyway I've resent a v2 series:
    https://lore.kernel.org/all/20240122070859.1394479-2-zegao@tencent.com/

Tested and verified. Hope this time i don't mess it up :)

Thanks,
        -- Ze

> hit.  Maybe I used the wrong branch tip?
>
> FWIW:  the tip I rebase onto is
>
> d988c9f511af (perf/perf-tools-next) MAINTAINERS: Add Namhyung as
> tools/perf/ co-maintainer
>
> [1]:  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/
>
> Regards,
>         -- Ze
>
> > Thanks,
> > Namhyung

