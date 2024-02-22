Return-Path: <linux-kernel+bounces-77190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52D8601E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C451C264E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350F14264A;
	Thu, 22 Feb 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="QEA+12os"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C043142625
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627282; cv=none; b=Wk8lWUxFYtHfnVTvrO57okw+EPebZXvSug3hq6OfP/9yx7AB9RrUq0FZHHsvW1CleAxWl5LG8JpNL5i7Vf+KtCKW26OQ0A4m2DgZ1HcHeXdCwVVqPpg9beYmWv2XqkDTeIJ5Nbu9CBemuZJIo37OUGypyCOu5p3blYVXCQwtXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627282; c=relaxed/simple;
	bh=ohhya0tdSCnxwC3WMyhJk1oBTRUJ4gMeFY4I7RqtXO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHtOvmgmEFg8qncf62P5p/qy6LXFRf40UVfx5j/mLNCu3KyXbJOlCHujd9i09xhxFB1JPLp35tG3J7Y+KvknVBO8dvdPPVyeu2NqYcoSZl+iIq2Nsj3Z8Wl29wETznL4tU0+k2i8Lelmdzadd7a7Tqdg0OS1CIxRPfiYAoQKDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=QEA+12os; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d25a7b02d6so1034841fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1708627279; x=1709232079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQUwLW8AOwdK6CdoRSCOfOPtqT8y0lv73EB6o8UNivU=;
        b=QEA+12osF5UxbA2LZ8tO3kHSAFMCrhIUUGpsiogCL6CIe025BsMY81A5JdY8qKkjr0
         g8gsEAa68AvysbP+s5bAobNz9bNhM/hlUPkLbfBPxPO2UmZGk/+i+1JfuCRR2L/bQBvl
         77xOYj1A9Cb1qeZIa0UTPkQcJTSCSt6+2ApffqVy1gojzWIG1qHuOET3eiV0WAW4qE7k
         sAx2IPI8Rik7vPkFAQLXvLhJNaP3EKo1tiwf26h/mxiRF3P57tYC5/XaWJTtfpB20S9e
         i0y45dd5E1lY8ApMF0IyHTIc1AjNID31Kx/003tj5oisl1L1nuxgMTy+4SNbYVZDpO6Z
         f3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627279; x=1709232079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQUwLW8AOwdK6CdoRSCOfOPtqT8y0lv73EB6o8UNivU=;
        b=LiehCYTQkcNstWWqjT34C4F7PXknYqXK5Ve5mEysLasg7zNSVxNPS6duIKw69bCurp
         Rts37O9gfBuhEUZxll4P2dP48Xhz8cLGfbfaWlwhDDXc4luo0EyirFJe2wggSNGao11y
         /0l7ob5mrprJstQ73xlL8t/t4cHfAaZNX22tHs/eFKEB7+gT/HXa2jdMUfPb+N4tSSsx
         dJgEdeQZpNIpYD1WOHqwVHRulhtGtBaYCTEQNGJq0e2g1wg3VNiFJkO7D2ge1EK1/vQO
         H066qMgareZ1hNOQGqMRwtNk/n1BGWsWQGPyYZ3le/2Eeon4e6X3ZqBoeWiNgdZ2+vRd
         CnIA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0tRHuUs0FzSUfRuiUfhEX0Ksm1BU/IqBksTWpqGDiCYDQeQ7vdLRmnpYwB2vXRA9qIC/WGjGKwfpf925EHmYBeh/twfY8sDye2w8
X-Gm-Message-State: AOJu0YyIC6cq9J6VLlc7oqIZJJaEs51rV8TutHzcR8Dd/jKY6mBJg/qf
	WFPcSKUVVSPzt5sv/LVXfQsnh9pXnseXuBg0P5W6BkRtZ3FiTIHQ4nYDkS8O/vWJviyTjDmJC1a
	/JCl+N/jWlN2GXvRZdfGsJuWbfVC/ssChDJi6qfewhN/mqWurvw==
X-Google-Smtp-Source: AGHT+IFimfJPlmxqWSr5dO7kWsk4vePkzDPNEkE4uI0aLoa2qCDe69iRFXGgNOX/yY0+7t3xIzZj7FUE0IgIU13SRh4=
X-Received: by 2002:a19:7005:0:b0:512:e1eb:b95e with SMTP id
 h5-20020a197005000000b00512e1ebb95emr955285lfc.47.1708627278540; Thu, 22 Feb
 2024 10:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com> <CAP-5=fVWUAWa4vZ7_Zb_3DjaMiTGT6grfFO2j_kOFbuZemJZTA@mail.gmail.com>
In-Reply-To: <CAP-5=fVWUAWa4vZ7_Zb_3DjaMiTGT6grfFO2j_kOFbuZemJZTA@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 22 Feb 2024 10:41:07 -0800
Message-ID: <CAP045Arp+1j_W_iiHWwOGRCvvXCg3pC=gH5WMho-RpQXi4H1xg@mail.gmail.com>
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

On Thu, Feb 22, 2024 at 10:33=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Feb 22, 2024 at 9:55=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com> w=
rote:
> > > >
> > > > The test uses PERF_RECORD_SWITCH records to fill the ring buffer an=
d
> > > > trigger the watermark wakeup, which in turn should trigger an IO
> > > > signal.
> > > >
> > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > > ---
> > > >  tools/perf/tests/Build              |   1 +
> > > >  tools/perf/tests/builtin-test.c     |   1 +
> > > >  tools/perf/tests/tests.h            |   1 +
> > > >  tools/perf/tests/watermark_signal.c | 123 ++++++++++++++++++++++++=
++++
> > > >  4 files changed, 126 insertions(+)
> > > >  create mode 100644 tools/perf/tests/watermark_signal.c
> > > >
> > > > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > > > index 53ba9c3e20e0..de43eb60b280 100644
> > > > --- a/tools/perf/tests/Build
> > > > +++ b/tools/perf/tests/Build
> > > > @@ -67,6 +67,7 @@ perf-y +=3D sigtrap.o
> > > >  perf-y +=3D event_groups.o
> > > >  perf-y +=3D symbols.o
> > > >  perf-y +=3D util.o
> > > > +perf-y +=3D watermark_signal.o
> > > >
> > > >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> > > >  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> > > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/bui=
ltin-test.c
> > > > index 4a5973f9bb9b..715c01a2172a 100644
> > > > --- a/tools/perf/tests/builtin-test.c
> > > > +++ b/tools/perf/tests/builtin-test.c
> > > > @@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] =3D {
> > > >         &suite__event_groups,
> > > >         &suite__symbols,
> > > >         &suite__util,
> > > > +       &suite__watermark_signal,
> > > >         NULL,
> > > >  };
> > > >
> > > > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > > > index dad3d7414142..7ef4e0d0a77b 100644
> > > > --- a/tools/perf/tests/tests.h
> > > > +++ b/tools/perf/tests/tests.h
> > > > @@ -146,6 +146,7 @@ DECLARE_SUITE(sigtrap);
> > > >  DECLARE_SUITE(event_groups);
> > > >  DECLARE_SUITE(symbols);
> > > >  DECLARE_SUITE(util);
> > > > +DECLARE_SUITE(watermark_signal);
> > > >
> > > >  /*
> > > >   * PowerPC and S390 do not support creation of instruction breakpo=
ints using the
> > > > diff --git a/tools/perf/tests/watermark_signal.c b/tools/perf/tests=
/watermark_signal.c
> > > > new file mode 100644
> > > > index 000000000000..ae4abedc4b7c
> > > > --- /dev/null
> > > > +++ b/tools/perf/tests/watermark_signal.c
> > > > @@ -0,0 +1,123 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include <stddef.h>
> > > > +#include <signal.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > > +#include <sys/ioctl.h>
> > > > +#include <sys/mman.h>
> > > > +#include <sys/wait.h>
> > > > +#include <unistd.h>
> > > > +#include <errno.h>
> > > > +#include <fcntl.h>
> > > > +
> > > > +#include "tests.h"
> > > > +#include "debug.h"
> > > > +#include "event.h"
> > > > +#include "../perf-sys.h"
> > > > +#include "cloexec.h"
> > > > +#include <internal/lib.h> // page_size
> > > > +
> > > > +static int sigio_count;
> > > > +
> > > > +static void handle_sigio(int sig __always_unused)
> > > > +{
> > > > +       ++sigio_count;
> > > > +}
> > > > +
> > > > +static void do_child(void)
> > > > +{
> > > > +       for (int i =3D 0; i < 20; ++i)
> > > > +               sleep(1);
> > > > +
> > > > +       exit(0);
> > > > +}
> > > > +
> > > > +static int test__watermark_signal(struct test_suite *test __maybe_=
unused, int subtest __maybe_unused)
> > > > +{
> > > > +       struct perf_event_attr attr;
> > > > +       struct perf_event_mmap_page *p =3D NULL;
> > > > +       sighandler_t previous_sigio =3D SIG_ERR;
> > > > +       pid_t child =3D -1;
> > > > +       int fd =3D -1;
> > > > +       int ret =3D TEST_FAIL;
> > > > +
> > > > +       previous_sigio =3D signal(SIGIO, handle_sigio);
> > > > +       if (previous_sigio =3D=3D SIG_ERR) {
> > > > +               pr_debug("failed setting SIGIO handler\n");
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       memset(&attr, 0, sizeof(attr));
> > > > +       attr.size =3D sizeof(attr);
> > > > +       attr.type =3D PERF_TYPE_SOFTWARE;
> > > > +       attr.config =3D PERF_COUNT_SW_DUMMY;
> > > > +       attr.sample_period =3D 1;
> > > > +       attr.disabled =3D 1;
> > > > +       attr.watermark =3D 1;
> > > > +       attr.context_switch =3D 1;
> > > > +       attr.wakeup_watermark =3D 1;
> > > > +
> > > > +       child =3D fork();
> > > > +       if (child =3D=3D 0)
> > > > +               do_child();
> > > > +       else if (child < 0) {
> > > > +               pr_debug("failed fork() %d\n", errno);
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       fd =3D sys_perf_event_open(&attr, child, -1, -1,
> > > > +                                perf_event_open_cloexec_flag());
> > > > +       if (fd < 0) {
> > > > +               pr_debug("failed opening event %llx\n", attr.config=
);
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > > +               goto cleanup;
> > > > +       }
> > >
> > > Thanks for the work! The perf tool and perf test should run on older
> > > kernels ideally without failure. I'm assuming this would fail on an
> > > older kernel. Could we make the return value skip in that case?
> >
> > Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> > yes. It's not possible to distinguish between an older kernel and a
> > kernel where this fix broke (at least not without hardcoding in an
> > expected good kernel version, which seems undesirable), so that would
> > mean the test would always return ok or skip, not ok or fail. Is that
> > ok?
>
> Not great :-) Is there any hint from the errno? I was hoping for
> EOPNOTSUPP but I'm guessing it will be EINVAL, in which case probably
> something like:
> /* Older kernels lack support. */
> ret =3D (errno =3D=3D EINVAL) ? TEST_SKIP : TEST_FAIL;

Ah, I see. The issue I am trying to fix is not that setting FASYNC is
rejected with an error code, it's that it doesn't actually send the IO
signal when the watermark is reached.

- Kyle

> > > > +
> > > > +       if (fcntl(fd, F_SETOWN, getpid())) {
> > > > +               pr_debug("failed F_SETOWN getpid() %d\n", errno);
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       if (fcntl(fd, F_SETSIG, SIGIO)) {
> > > > +               pr_debug("failed F_SETSIG SIGIO %d\n", errno);
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       p =3D mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP=
_SHARED, fd, 0);
> > > > +       if (p =3D=3D NULL) {
> > > > +               pr_debug("failed to mmap\n");
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
> > > > +               pr_debug("failed PERF_EVENT_IOC_ENABLE %d\n", errno=
);
> > > > +               goto cleanup;
> > > > +       }
> > > > +
> > > > +       sleep(30);
> > >
> > > This is kind of a painful wait, could it be less? No sleeps would be =
best :-)
> >
> > We could synchronize with the child using SIGSTOP instead of sleeping
> > here. Not sure about getting rid of the tiny sleeps in the child. I
> > have observed that sched_yield() doesn't reliably trigger context
> > switches (which isn't surprising). I'll experiment with blocking on a
> > pipe or something.
>
> Great, thanks!
> Ian
>
> > - Kyle
> >
> > > Thanks,
> > > Ian
> > >
> > > > +
> > > > +       ret =3D (sigio_count =3D=3D 1) ? TEST_OK : TEST_FAIL;
> > > > +
> > > > +cleanup:
> > > > +       if (p !=3D NULL)
> > > > +               munmap(p, 2 * page_size);
> > > > +
> > > > +       if (fd >=3D 0)
> > > > +               close(fd);
> > > > +
> > > > +       if (child > 0) {
> > > > +               kill(child, SIGTERM);
> > > > +               waitpid(child, NULL, 0);
> > > > +       }
> > > > +
> > > > +       if (previous_sigio !=3D SIG_ERR)
> > > > +               signal(SIGIO, previous_sigio);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +DEFINE_SUITE("Watermark signal handler", watermark_signal);
> > > > --
> > > > 2.34.1
> > > >

