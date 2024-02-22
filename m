Return-Path: <linux-kernel+bounces-77149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC638601AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F116A1F271B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7210D1448C8;
	Thu, 22 Feb 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDsXer1z"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66E143C77
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626791; cv=none; b=kdgNlvOsMflWj6XhchGbjlleHsXNec5y49YT2YxmNzc0IS6NTzUxMJr89VQmnFosHtTmT/u2YvDTl15/Oh+G13Y8Dqysae2ZHRzxA8OnYEgSmT92ut15OuuRXsRIh4h+QDfvQSqHtffedn3M4Vo0a9OiqVtffS4C1HhwCHfKPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626791; c=relaxed/simple;
	bh=HsYrxcq5tk165uSW3sWTCmo4aIzGksWtXmlA+cPuDG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwR5I450FtF7jTwPo2dfDMVoqkCtgeL3Wli/3Tw9hPs2yRLIW+w5syL9ADzKfkUS32+7JvGgWyO8mJ+Rsfjmbv6opwsCJS29PuSCpNtCgHFiYNIfjzYF0KXBhfYqRIwbAKbn3WEh1wtaKbKMxLqqA4uZbfB6uM1zJI5TQYEp7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDsXer1z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso10905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708626789; x=1709231589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9jAQ6vztnGbguyhKBccVgks3srQ+6XA4/hNYShYVTw=;
        b=HDsXer1zRivKi9BmCSX3bSiyuoZ4Hi2fTfstfZFQS1O4YJTJRMqBilU/rj39IKqjHR
         LQ5yaoCwXSssMkUVAIS7EsPd0uUcArXGR45hHebq4dshgIcH99o7qOw0LsEYWBBwqFfu
         IspXvC6jMQ1miCOBWIX+KCNBqBp5eC8qtvcdvaAoE7kCsuaFYQmELEcCWJ4Czx+lLWm2
         LTn23W7tQTz7BO7yVrKMx0+0UKcmakWjtd2gaDBvzIG8NvUOCAV8xjCVPjd4z/NbG7gS
         EUKI75afMGdWVGUSfd3XmIHLpA8XbEQxMjAms8E5qev9ww4kymNM7XuOAzk7DAO2oQku
         Fo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626789; x=1709231589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9jAQ6vztnGbguyhKBccVgks3srQ+6XA4/hNYShYVTw=;
        b=Nuk1WX/Z5ZVy+q+dl28hSG8z3iLCoB/0fgOi0cTI4mVTSIbif5srs3jmtfU2X3wMNl
         nIPKQua2xOOuZYaIk4DQTSkvHerWlkRqyYj6TT4bbbXy3MZLLDUYdmTpHPIGvP289DfR
         2kDCmWQ0hes9zV1zDv+WHyTYEyl/NpwOYW/9uo7Kqn6gqJ2B3A9IFKAolRt9cusz5fZu
         ptG8IDEe2TalAbIo0lVVk090e+1bBIPIPPZzR7T3qDDTt1BhIj6YufYyjMBmLtCCJYt8
         PkqEX2hNC741pNz2gVGRwBo8HTv4r2b1E9qhDH5Vj80HYqEZMfIxzJUyNvxCvQzfUsbE
         jyRA==
X-Forwarded-Encrypted: i=1; AJvYcCW54vbYwmg/lfFW4k0+qNgwUX8DLfTN1k0gj84zFp6/yU2Z5j4Fi92OC2c6NH6/tPDLgOWB1Loh+HT1ARvtdXlyJDr7IX8S4e+AAfBt
X-Gm-Message-State: AOJu0YxvdbLWaUYS3yfrW4kLFdGFMJsXykePeTN5OFOS6VrpnPKW8PTA
	4uGefMHqMIIRu9MaiHezE2/Lr4z6+NzFiHiWZ2r4TnqEUnqLO2n//bx8DAI8csZltNYz5+EbtHq
	anhZ20kISNjxJeZmKAB/E3CrIKGgx/4NPTGyl
X-Google-Smtp-Source: AGHT+IEOdmTEhF3GXiTovqgdmBWSFWJ1yTgGWCkKgjLlSaZUhaKVDLajj4yuSD9kH67iimbz3JjZQRwPrk18uNy1hwE=
X-Received: by 2002:a17:902:8c8b:b0:1db:640f:cb43 with SMTP id
 t11-20020a1709028c8b00b001db640fcb43mr559978plo.8.1708626788451; Thu, 22 Feb
 2024 10:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com> <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
In-Reply-To: <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Feb 2024 10:32:54 -0800
Message-ID: <CAP-5=fVWUAWa4vZ7_Zb_3DjaMiTGT6grfFO2j_kOFbuZemJZTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:55=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com> wro=
te:
> > >
> > > The test uses PERF_RECORD_SWITCH records to fill the ring buffer and
> > > trigger the watermark wakeup, which in turn should trigger an IO
> > > signal.
> > >
> > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > ---
> > >  tools/perf/tests/Build              |   1 +
> > >  tools/perf/tests/builtin-test.c     |   1 +
> > >  tools/perf/tests/tests.h            |   1 +
> > >  tools/perf/tests/watermark_signal.c | 123 ++++++++++++++++++++++++++=
++
> > >  4 files changed, 126 insertions(+)
> > >  create mode 100644 tools/perf/tests/watermark_signal.c
> > >
> > > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > > index 53ba9c3e20e0..de43eb60b280 100644
> > > --- a/tools/perf/tests/Build
> > > +++ b/tools/perf/tests/Build
> > > @@ -67,6 +67,7 @@ perf-y +=3D sigtrap.o
> > >  perf-y +=3D event_groups.o
> > >  perf-y +=3D symbols.o
> > >  perf-y +=3D util.o
> > > +perf-y +=3D watermark_signal.o
> > >
> > >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> > >  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/built=
in-test.c
> > > index 4a5973f9bb9b..715c01a2172a 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] =3D {
> > >         &suite__event_groups,
> > >         &suite__symbols,
> > >         &suite__util,
> > > +       &suite__watermark_signal,
> > >         NULL,
> > >  };
> > >
> > > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > > index dad3d7414142..7ef4e0d0a77b 100644
> > > --- a/tools/perf/tests/tests.h
> > > +++ b/tools/perf/tests/tests.h
> > > @@ -146,6 +146,7 @@ DECLARE_SUITE(sigtrap);
> > >  DECLARE_SUITE(event_groups);
> > >  DECLARE_SUITE(symbols);
> > >  DECLARE_SUITE(util);
> > > +DECLARE_SUITE(watermark_signal);
> > >
> > >  /*
> > >   * PowerPC and S390 do not support creation of instruction breakpoin=
ts using the
> > > diff --git a/tools/perf/tests/watermark_signal.c b/tools/perf/tests/w=
atermark_signal.c
> > > new file mode 100644
> > > index 000000000000..ae4abedc4b7c
> > > --- /dev/null
> > > +++ b/tools/perf/tests/watermark_signal.c
> > > @@ -0,0 +1,123 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <stddef.h>
> > > +#include <signal.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <sys/ioctl.h>
> > > +#include <sys/mman.h>
> > > +#include <sys/wait.h>
> > > +#include <unistd.h>
> > > +#include <errno.h>
> > > +#include <fcntl.h>
> > > +
> > > +#include "tests.h"
> > > +#include "debug.h"
> > > +#include "event.h"
> > > +#include "../perf-sys.h"
> > > +#include "cloexec.h"
> > > +#include <internal/lib.h> // page_size
> > > +
> > > +static int sigio_count;
> > > +
> > > +static void handle_sigio(int sig __always_unused)
> > > +{
> > > +       ++sigio_count;
> > > +}
> > > +
> > > +static void do_child(void)
> > > +{
> > > +       for (int i =3D 0; i < 20; ++i)
> > > +               sleep(1);
> > > +
> > > +       exit(0);
> > > +}
> > > +
> > > +static int test__watermark_signal(struct test_suite *test __maybe_un=
used, int subtest __maybe_unused)
> > > +{
> > > +       struct perf_event_attr attr;
> > > +       struct perf_event_mmap_page *p =3D NULL;
> > > +       sighandler_t previous_sigio =3D SIG_ERR;
> > > +       pid_t child =3D -1;
> > > +       int fd =3D -1;
> > > +       int ret =3D TEST_FAIL;
> > > +
> > > +       previous_sigio =3D signal(SIGIO, handle_sigio);
> > > +       if (previous_sigio =3D=3D SIG_ERR) {
> > > +               pr_debug("failed setting SIGIO handler\n");
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       memset(&attr, 0, sizeof(attr));
> > > +       attr.size =3D sizeof(attr);
> > > +       attr.type =3D PERF_TYPE_SOFTWARE;
> > > +       attr.config =3D PERF_COUNT_SW_DUMMY;
> > > +       attr.sample_period =3D 1;
> > > +       attr.disabled =3D 1;
> > > +       attr.watermark =3D 1;
> > > +       attr.context_switch =3D 1;
> > > +       attr.wakeup_watermark =3D 1;
> > > +
> > > +       child =3D fork();
> > > +       if (child =3D=3D 0)
> > > +               do_child();
> > > +       else if (child < 0) {
> > > +               pr_debug("failed fork() %d\n", errno);
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       fd =3D sys_perf_event_open(&attr, child, -1, -1,
> > > +                                perf_event_open_cloexec_flag());
> > > +       if (fd < 0) {
> > > +               pr_debug("failed opening event %llx\n", attr.config);
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > +               goto cleanup;
> > > +       }
> >
> > Thanks for the work! The perf tool and perf test should run on older
> > kernels ideally without failure. I'm assuming this would fail on an
> > older kernel. Could we make the return value skip in that case?
>
> Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> yes. It's not possible to distinguish between an older kernel and a
> kernel where this fix broke (at least not without hardcoding in an
> expected good kernel version, which seems undesirable), so that would
> mean the test would always return ok or skip, not ok or fail. Is that
> ok?

Not great :-) Is there any hint from the errno? I was hoping for
EOPNOTSUPP but I'm guessing it will be EINVAL, in which case probably
something like:
/* Older kernels lack support. */
ret =3D (errno =3D=3D EINVAL) ? TEST_SKIP : TEST_FAIL;

> > > +
> > > +       if (fcntl(fd, F_SETOWN, getpid())) {
> > > +               pr_debug("failed F_SETOWN getpid() %d\n", errno);
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       if (fcntl(fd, F_SETSIG, SIGIO)) {
> > > +               pr_debug("failed F_SETSIG SIGIO %d\n", errno);
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       p =3D mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_S=
HARED, fd, 0);
> > > +       if (p =3D=3D NULL) {
> > > +               pr_debug("failed to mmap\n");
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
> > > +               pr_debug("failed PERF_EVENT_IOC_ENABLE %d\n", errno);
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       sleep(30);
> >
> > This is kind of a painful wait, could it be less? No sleeps would be be=
st :-)
>
> We could synchronize with the child using SIGSTOP instead of sleeping
> here. Not sure about getting rid of the tiny sleeps in the child. I
> have observed that sched_yield() doesn't reliably trigger context
> switches (which isn't surprising). I'll experiment with blocking on a
> pipe or something.

Great, thanks!
Ian

> - Kyle
>
> > Thanks,
> > Ian
> >
> > > +
> > > +       ret =3D (sigio_count =3D=3D 1) ? TEST_OK : TEST_FAIL;
> > > +
> > > +cleanup:
> > > +       if (p !=3D NULL)
> > > +               munmap(p, 2 * page_size);
> > > +
> > > +       if (fd >=3D 0)
> > > +               close(fd);
> > > +
> > > +       if (child > 0) {
> > > +               kill(child, SIGTERM);
> > > +               waitpid(child, NULL, 0);
> > > +       }
> > > +
> > > +       if (previous_sigio !=3D SIG_ERR)
> > > +               signal(SIGIO, previous_sigio);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +DEFINE_SUITE("Watermark signal handler", watermark_signal);
> > > --
> > > 2.34.1
> > >

