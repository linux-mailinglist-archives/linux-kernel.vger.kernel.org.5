Return-Path: <linux-kernel+bounces-32297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617178359B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD7328306A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2A31849;
	Mon, 22 Jan 2024 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMeAeUOP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F115AF;
	Mon, 22 Jan 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705893347; cv=none; b=L3e6wsEC2qjydU5u6ku/lMiuejw+PtGSIs47PYlfzNDzvmLicrFGxmLbigrf8LHHG5LSIyDB5+ytZF338lcIEM8vUsJ3sCua2rsK303tx/rMi9TzQZgeQeB2DGc37zsV59WL2m3IwtqUW5y8l01B+UzkOPZGeS45dhsmgQ7FCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705893347; c=relaxed/simple;
	bh=06YlbewJXRAhOm7tJ/5PfYvStXE7hGG8dYBwOma+Qzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQEy/mA+6VbGlQqBQkwnLZHl3Zvb8NftX1fkX/uKsx1jLs8VWEkHTgdpnTXO08j1VwC/kOV/YB4o2CZ4oQmxzBTnImPGEBkCE87NCVYvN/pZ6G5X/93nvKFHXV3ijASKD3TbSI01v4T0mxyBs9WFq5OG6iNPMIfar+OTsKQgb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMeAeUOP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c4ec68993so153700a12.3;
        Sun, 21 Jan 2024 19:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705893343; x=1706498143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7xdyl5DA3xSeSKcVJW9Zs9TsQMTTFI5fMd5HEPoi88=;
        b=gMeAeUOPz2IrZAfmIcirTxXNmrXNpvF/s32NxG7+PxowbummuP4OvOb9YwEUjSy6nx
         V///SqCVW2ady5VBD2mmmbXu8XgAp0HoYmHLFXWNlFWisvXQ9amokv0sPAXghlZ60Qxa
         skEsO+r2mQ9AUroAacCgHYNeFwSEmnRMrDwClwdU24TVYasyLm9vyJ490+7P73LxsBJe
         ODIgW7+VflvLZ4YHkD3ATuBW05cDmHG0W7n+cx9eR9TUTjQtehzgrvcwO68DHuVw8C/T
         +7Ha6HwyR1Ctbcq4Ii3JPF2J9G+PjU9NXPlcTj6J3xqcpe1pD8xX2jziLwg+7xoh9rpr
         BaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705893343; x=1706498143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7xdyl5DA3xSeSKcVJW9Zs9TsQMTTFI5fMd5HEPoi88=;
        b=eluZzlSN8+Hw/uGbq9Sj4dBwdW1wdgAYAcHsI9W04Cgpa1RHxMiDBXwFSzeZfl2LST
         OjR/JHWdPaetZdYaLO4LXQ9OoclOVntEKMItcvL0K5jKZqLmq790imr/g5sSCDGIetSa
         ek+BTuGH1tVRo8x8zn42Hxa2Ci6VtTC0JxjIhQfz6Eq0XpsqPN9fIhOaYZeZlvd7nU5P
         qK749OBctGcdKtlfySqKcRUiUEvFwN5WO1k6CkGqaOLnEt5Y7LeXMAkqhQ7MRNZOn5in
         8RICz4BYjY8xW1jeWSOtYH5960WeukHztCbQr75HfALLDizEciqRPYYMzDk8+Vk1P4/0
         yCJg==
X-Gm-Message-State: AOJu0Yyz+CXmTlGRVBNI7gOC6v2a/207zm5wxZ2QNLHy8sxLeYi0aOlh
	zF1Ck0WOrQDrFPFyFCK9dVvt1MWvyWSHVupq/H8qgqPSTdUL5XPfO+V+GZx0akbwVeuUFZUZq+i
	OvG/yQYmfejTpfyyvc4Si4E6Am5s=
X-Google-Smtp-Source: AGHT+IG2z+ecGlrBiwX7zX5v2PDcPw6i1sihRbutu0f/m3St7fHbXxtjgeB+qAdVopa5x3OTCAosfxIrHr9ZpPpqLSQ=
X-Received: by 2002:aa7:d883:0:b0:559:ac5b:1a8 with SMTP id
 u3-20020aa7d883000000b00559ac5b01a8mr1370661edq.80.1705893343347; Sun, 21 Jan
 2024 19:15:43 -0800 (PST)
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
Date: Mon, 22 Jan 2024 11:15:32 +0800
Message-ID: <CAD8CoPDna2eSsYjkmJukShLfuo3po06za6nCiPfqrEY-RBjwJw@mail.gmail.com>
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
> hit.  Maybe I used the wrong branch tip?

For reference, it ends up like:
    https://github.com/zegao96/linux/commits/perf-tools-next/

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

