Return-Path: <linux-kernel+bounces-77019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F4860024
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83B11C23CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72E4776E;
	Thu, 22 Feb 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Fw1RGfB6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C1154BE3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624551; cv=none; b=iP1na0+DCpJ++ufjuv+yr23tMuA/zhj/f0Wisi9mlxbQFzMEGFuZ/7+XAH0uyYBwVL7q/mzqq8unFmKJR4Jt5yEVNRJomqBGT0bWGwJOxIValSbu8wURfPClyjeGH4FpmGOUhBW+porNDbem95R0BdztUSCUEWvVaFpf7p3NTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624551; c=relaxed/simple;
	bh=9Ehscx9YJtzqhsAAorDMp+5YYVPvswAX7ZmOOyjUa0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/tPF9nEIyBDdUh0yKQtgBxuzw8L3WqyQpbwI7FHcCYBnvgT2y9uO6DeqEmC8XqlKg79gLTMnuN/azLVaZhrLx5LTcTmhNufgM1CLry23Q4R+l4i2Re2xE5xFiBpd2JMGSTJAgB2Cjeg7lsUDyIyn66TJj93jmVKmbHKSm/k19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=Fw1RGfB6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a34c5ca2537so1582266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1708624548; x=1709229348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmIq5FHO3/Gwj6AT3YZvrf/NJzx2ZnfmImuv+tUNbJc=;
        b=Fw1RGfB6jTnOnyYRYoCHx2Ke2o1SEhdC8SrnQRGpQD3n0SB2EWvYJ1JkR5ky3IT5rV
         LFoy3P5CsyECfy8Jvm5nczfQHFIqaoHS4bnf44m4PEsHJqL867W82LOh3lVbjxXywbKs
         2FSECKdZn+XLNV8VSWAQ50emKEUMvyGp/JoRGzxclXD4tx3nZssyJww9EILxykPMRcFT
         TU8V7kBloKuS17jfTc9E4dcvq4BG4YfDt0yqYbND0cNc5PKzAOsH5fY2aNDaLMCYthgM
         xhRpyfPjUb2SR4dOwOiCTeCClBLepYKEcjoC6rfirGSDKCCWH+9E6aXu393IMV8b2hqj
         fY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624548; x=1709229348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmIq5FHO3/Gwj6AT3YZvrf/NJzx2ZnfmImuv+tUNbJc=;
        b=AapeXVM+04G1q870RzGHSKgsajmOFkcOE3Vw1jjRFZ1iCYwsQckvCRyAqkYnkhIMdx
         wMZQ7yLn1UbRr1tAnFBzh2t6YhMM9lgb3+8vKJslgByql5LVR7BX/YjDx1bXmIsRJ009
         rI76z59JBiTAnHtJ+E8Ywm72EcTszpHYcPU6oMHjLXo0wtNSzpyIPnuQgFxTX5ARQXpo
         k/G8WdTsxZ4KHDGMiSu6utM7/39zfgrNag4v7YsAJH+/XqE/6pQ/cuXhq80YA6BnQkUG
         Am+hdgY8Ld4MDyLI8bgM4+39t9BcHnTQdYoKJ0nR/p4yJ3Wlao6nw7/eOQxwIn+5Lvdn
         EmEg==
X-Forwarded-Encrypted: i=1; AJvYcCWIPqdJw/wpXEU+Lsgd/XrbTDpw08C6R+eE4HHC3PSZTf1AV+TsvQ7C2mp8uMubaxce7HZEVp17+TqN/s/CilkhjNxg4eMAHWRQO43G
X-Gm-Message-State: AOJu0Yyns7hUS2fmb3bvZ1/2PdUUv7hQ1kuvLShSk5V/pj+ZLX32yeDp
	2TbPbhTBmuwFr9/D2HbhREmNTLgZDaCtZAOKR1RCI8ivspG/EDECEYLxDdZAIop8Rlc0rmuEsW4
	Edwqw2iWO4LIxhMn1zA/Dj3eIWDB56b5FsJaR
X-Google-Smtp-Source: AGHT+IF/iNczouT7U3E36vKc0oD7YuI+MlOwBabsQm2U9dQAgV0PWOHlBkweu0I6QcpnYWmYz2QvebgcGTWvmFtT1Es=
X-Received: by 2002:a17:906:240a:b0:a3f:4516:ecf2 with SMTP id
 z10-20020a170906240a00b00a3f4516ecf2mr3478631eja.32.1708624547884; Thu, 22
 Feb 2024 09:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
In-Reply-To: <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 22 Feb 2024 09:55:36 -0800
Message-ID: <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Ian Rogers <irogers@google.com>
Cc: Kyle Huey <khuey@kylehuey.com>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > The test uses PERF_RECORD_SWITCH records to fill the ring buffer and
> > trigger the watermark wakeup, which in turn should trigger an IO
> > signal.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > ---
> >  tools/perf/tests/Build              |   1 +
> >  tools/perf/tests/builtin-test.c     |   1 +
> >  tools/perf/tests/tests.h            |   1 +
> >  tools/perf/tests/watermark_signal.c | 123 ++++++++++++++++++++++++++++
> >  4 files changed, 126 insertions(+)
> >  create mode 100644 tools/perf/tests/watermark_signal.c
> >
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 53ba9c3e20e0..de43eb60b280 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -67,6 +67,7 @@ perf-y +=3D sigtrap.o
> >  perf-y +=3D event_groups.o
> >  perf-y +=3D symbols.o
> >  perf-y +=3D util.o
> > +perf-y +=3D watermark_signal.o
> >
> >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> >  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index 4a5973f9bb9b..715c01a2172a 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] =3D {
> >         &suite__event_groups,
> >         &suite__symbols,
> >         &suite__util,
> > +       &suite__watermark_signal,
> >         NULL,
> >  };
> >
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index dad3d7414142..7ef4e0d0a77b 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -146,6 +146,7 @@ DECLARE_SUITE(sigtrap);
> >  DECLARE_SUITE(event_groups);
> >  DECLARE_SUITE(symbols);
> >  DECLARE_SUITE(util);
> > +DECLARE_SUITE(watermark_signal);
> >
> >  /*
> >   * PowerPC and S390 do not support creation of instruction breakpoints=
 using the
> > diff --git a/tools/perf/tests/watermark_signal.c b/tools/perf/tests/wat=
ermark_signal.c
> > new file mode 100644
> > index 000000000000..ae4abedc4b7c
> > --- /dev/null
> > +++ b/tools/perf/tests/watermark_signal.c
> > @@ -0,0 +1,123 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stddef.h>
> > +#include <signal.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/mman.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +
> > +#include "tests.h"
> > +#include "debug.h"
> > +#include "event.h"
> > +#include "../perf-sys.h"
> > +#include "cloexec.h"
> > +#include <internal/lib.h> // page_size
> > +
> > +static int sigio_count;
> > +
> > +static void handle_sigio(int sig __always_unused)
> > +{
> > +       ++sigio_count;
> > +}
> > +
> > +static void do_child(void)
> > +{
> > +       for (int i =3D 0; i < 20; ++i)
> > +               sleep(1);
> > +
> > +       exit(0);
> > +}
> > +
> > +static int test__watermark_signal(struct test_suite *test __maybe_unus=
ed, int subtest __maybe_unused)
> > +{
> > +       struct perf_event_attr attr;
> > +       struct perf_event_mmap_page *p =3D NULL;
> > +       sighandler_t previous_sigio =3D SIG_ERR;
> > +       pid_t child =3D -1;
> > +       int fd =3D -1;
> > +       int ret =3D TEST_FAIL;
> > +
> > +       previous_sigio =3D signal(SIGIO, handle_sigio);
> > +       if (previous_sigio =3D=3D SIG_ERR) {
> > +               pr_debug("failed setting SIGIO handler\n");
> > +               goto cleanup;
> > +       }
> > +
> > +       memset(&attr, 0, sizeof(attr));
> > +       attr.size =3D sizeof(attr);
> > +       attr.type =3D PERF_TYPE_SOFTWARE;
> > +       attr.config =3D PERF_COUNT_SW_DUMMY;
> > +       attr.sample_period =3D 1;
> > +       attr.disabled =3D 1;
> > +       attr.watermark =3D 1;
> > +       attr.context_switch =3D 1;
> > +       attr.wakeup_watermark =3D 1;
> > +
> > +       child =3D fork();
> > +       if (child =3D=3D 0)
> > +               do_child();
> > +       else if (child < 0) {
> > +               pr_debug("failed fork() %d\n", errno);
> > +               goto cleanup;
> > +       }
> > +
> > +       fd =3D sys_perf_event_open(&attr, child, -1, -1,
> > +                                perf_event_open_cloexec_flag());
> > +       if (fd < 0) {
> > +               pr_debug("failed opening event %llx\n", attr.config);
> > +               goto cleanup;
> > +       }
> > +
> > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > +               goto cleanup;
> > +       }
>
> Thanks for the work! The perf tool and perf test should run on older
> kernels ideally without failure. I'm assuming this would fail on an
> older kernel. Could we make the return value skip in that case?

Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
yes. It's not possible to distinguish between an older kernel and a
kernel where this fix broke (at least not without hardcoding in an
expected good kernel version, which seems undesirable), so that would
mean the test would always return ok or skip, not ok or fail. Is that
ok?

> > +
> > +       if (fcntl(fd, F_SETOWN, getpid())) {
> > +               pr_debug("failed F_SETOWN getpid() %d\n", errno);
> > +               goto cleanup;
> > +       }
> > +
> > +       if (fcntl(fd, F_SETSIG, SIGIO)) {
> > +               pr_debug("failed F_SETSIG SIGIO %d\n", errno);
> > +               goto cleanup;
> > +       }
> > +
> > +       p =3D mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_SHA=
RED, fd, 0);
> > +       if (p =3D=3D NULL) {
> > +               pr_debug("failed to mmap\n");
> > +               goto cleanup;
> > +       }
> > +
> > +       if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
> > +               pr_debug("failed PERF_EVENT_IOC_ENABLE %d\n", errno);
> > +               goto cleanup;
> > +       }
> > +
> > +       sleep(30);
>
> This is kind of a painful wait, could it be less? No sleeps would be best=
 :-)

We could synchronize with the child using SIGSTOP instead of sleeping
here. Not sure about getting rid of the tiny sleeps in the child. I
have observed that sched_yield() doesn't reliably trigger context
switches (which isn't surprising). I'll experiment with blocking on a
pipe or something.

- Kyle

> Thanks,
> Ian
>
> > +
> > +       ret =3D (sigio_count =3D=3D 1) ? TEST_OK : TEST_FAIL;
> > +
> > +cleanup:
> > +       if (p !=3D NULL)
> > +               munmap(p, 2 * page_size);
> > +
> > +       if (fd >=3D 0)
> > +               close(fd);
> > +
> > +       if (child > 0) {
> > +               kill(child, SIGTERM);
> > +               waitpid(child, NULL, 0);
> > +       }
> > +
> > +       if (previous_sigio !=3D SIG_ERR)
> > +               signal(SIGIO, previous_sigio);
> > +
> > +       return ret;
> > +}
> > +
> > +DEFINE_SUITE("Watermark signal handler", watermark_signal);
> > --
> > 2.34.1
> >

