Return-Path: <linux-kernel+bounces-141976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440128A25AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF28B22206
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFB1B81F;
	Fri, 12 Apr 2024 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0Qz3sWn"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8931B96E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899380; cv=none; b=h/MpbhMC56f5jRVZnA6sX9dDLGB4kydxjn0oLxko6WyaSqoQPMiuISS0EKsKgFm3mwxsVqiMgpAWHqXxthvbOHXl3Hz3a5sbOxXWSIgb6j1NPtOo0/5XdeGmyijOXPWwSIJRx6uAe+/mQuvLFHqyXqF0xaKArRhBMFs5C7p9bcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899380; c=relaxed/simple;
	bh=UL/LpncOZyGtWXw7sXb64CLmGe4yYisGgtysed72NNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYcJkwzO5dZzGv3eJYUsy8Gty4BJwAG+VJSPeURnACGQWlhesc/IKgh6rdLFsI9On0Idts2ND+7BLW8MzzjfrbidbxZ3PrQPwS0qF8BZbThNCii4ZnwhRrt2Wyo9AFW2PgimSmdEP7Sl1/g7rSBgh8pudanlTGNaVjoJ2EH39Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0Qz3sWn; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36aff988d73so71885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712899377; x=1713504177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gNpPlT+WGI2X/oljO6U2N2ieR5VZIoAm4qmJbHtId0=;
        b=M0Qz3sWnk3Ddf4Z7GodnMzpq64pZNnS+8Rnc27GLfBCfwTEgBRSTprycyRG9DKt/ur
         8aeNT8qvkZRU82efIdjG87XlGru0Nwf/znmPwD2dKTxyCjXVtaSWSK9Mx0PUQ/uJzz9d
         cGrXbMt3t8KDNVtTHYVt3aSYLA1aHSO+VydU7dc58FDtYJ8bGDsOkPyhhvAhUSulxm4M
         YnQTp+kuUBKb1MYDZbO5ROGdQubWrHx8HUzC8ZAcrcTaDnI2XZImS+TxYSij15qqEdGU
         JMHHVERhv9jVO4giQ1p/CE5iP7SS7ItOMWJLgJpa8e4fXoxIL6Dydxdp8f5dPS46KKRO
         CZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712899377; x=1713504177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gNpPlT+WGI2X/oljO6U2N2ieR5VZIoAm4qmJbHtId0=;
        b=BBErFs8o7/3oIAKwanzdJpFVZ+7OFqaVrptflES+LUB7mn9UO25BfBbIwnD2qsuHPt
         9L98dq7hJ8GbUVxXLODi3Ts+AeW5oOWV6QATMWtVvH/y2DcUxkeJ5ZaYUW54rHeKPPd7
         5as80p2G/PcXJd9ey7zePvvOGjUtNawQ2Og0+IDyAJG9qN9z6v3pYLdPZ2CVU1vYVYYU
         JGxyHrLy/Y74diX8X189uVkNH1joF4iVcRwxR64AKvoOlnMTwoILuOx5pzDfxKyulbRh
         M2ekhEExKfeLWBvvBdvK8zUCJMRLN0GkhwzSFAXdgkBdG85QBfNYoWO3TX2C8STAT3tZ
         g1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWzboSoK4ryfJalsPCFZA9MNjEFXv7RkdeqRmUl3jyDY6VXhp3sK9NA2oLmq7PngFBTWoLd7yX8ecEa4yNU0Rrl8rPc1R2lH9TTkPz8
X-Gm-Message-State: AOJu0YwJMecKu5aZIoYXCo8D6gyYfqay7JVazQgF8GC0UlsYEmnwez6b
	zk/+eUIUTHAOul0pbtWn7NZbZTkQVRbJNciHb3sN2u96hs/JJxjekLxvNP1hRvlJm8A86Z7hyd2
	+9b2xwW/Pcq6+KRRVY0ForGq2e0a66AD2uFu5
X-Google-Smtp-Source: AGHT+IFaxXfvgMGaQqQrfx6l6wm45mGMVB40AypZPvgD2u24sPWZke6TU3DNIdrJaUHBpgEu+mazw+ENL8ObWHJtEy4=
X-Received: by 2002:a05:6e02:2190:b0:36a:36e7:6bf8 with SMTP id
 j16-20020a056e02219000b0036a36e76bf8mr117545ila.15.1712899376701; Thu, 11 Apr
 2024 22:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405070931.1231245-1-irogers@google.com> <20240405070931.1231245-2-irogers@google.com>
 <ZhP7VBvlSPrJKDP6@x1>
In-Reply-To: <ZhP7VBvlSPrJKDP6@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Apr 2024 22:22:42 -0700
Message-ID: <CAP-5=fVbhf_JgO9APwgOVyktazOAyEL-3vM2d-M4ropMDdYH2w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Display number of remaining tests
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:12=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Apr 05, 2024 at 12:09:31AM -0700, Ian Rogers wrote:
> > Before polling or sleeping to wait for a test to complete, print out
> > ": Running (<num> remaining)" where the number of remaining tests is
> > determined by iterating over the remaining tests and seeing which
> > return true for check_if_command_finished. After the delay, erase the
> > line and either update it with the new number of remaining tests, or
> > print the test's result. This allows a user to know a test is running
> > and in parallel mode (default) how many of the tests are waiting to
> > complete. If color mode is disabled then avoid displaying the
> > "Running" message.
>
> Tested and applied, great improvement!

And I think it is broken. Specifically I think the nohang waitpid can
cause the later read of the stdout/err pipe to fail. We may need to
drain the files before checking. I suspect this as I've seen an
increase test fails where the verbose output shows nothing. The only
remedy for that in the current code would be to run the tests
sequentially, so we should probably back this out for now.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
> >  tools/perf/util/color.h         |  1 +
> >  2 files changed, 53 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index 73f53b02f733..15b8e8e32749 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -238,7 +238,10 @@ static int run_test_child(struct child_process *pr=
ocess)
> >       return -err;
> >  }
> >
> > -static int print_test_result(struct test_suite *t, int i, int subtest,=
 int result, int width)
> > +#define TEST_RUNNING -3
> > +
> > +static int print_test_result(struct test_suite *t, int i, int subtest,=
 int result, int width,
> > +                          int remaining)
> >  {
> >       if (has_subtests(t)) {
> >               int subw =3D width > 2 ? width - 2 : width;
> > @@ -248,6 +251,9 @@ static int print_test_result(struct test_suite *t, =
int i, int subtest, int resul
> >               pr_info("%3d: %-*s:", i + 1, width, test_description(t, s=
ubtest));
> >
> >       switch (result) {
> > +     case TEST_RUNNING:
> > +             color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d re=
maining)\n", remaining);
> > +             break;
> >       case TEST_OK:
> >               pr_info(" Ok\n");
> >               break;
> > @@ -269,13 +275,15 @@ static int print_test_result(struct test_suite *t=
, int i, int subtest, int resul
> >       return 0;
> >  }
> >
> > -static int finish_test(struct child_test *child_test, int width)
> > +static int finish_test(struct child_test **child_tests, int running_te=
st, int child_test_num,
> > +                    int width)
> >  {
> > +     struct child_test *child_test =3D child_tests[running_test];
> >       struct test_suite *t =3D child_test->test;
> >       int i =3D child_test->test_num;
> >       int subi =3D child_test->subtest;
> >       int err =3D child_test->process.err;
> > -     bool err_done =3D err <=3D 0;
> > +     bool err_done =3D false;
> >       struct strbuf err_output =3D STRBUF_INIT;
> >       int ret;
> >
> > @@ -290,7 +298,7 @@ static int finish_test(struct child_test *child_tes=
t, int width)
> >        * Busy loop reading from the child's stdout/stderr that are set =
to be
> >        * non-blocking until EOF.
> >        */
> > -     if (!err_done)
> > +     if (err > 0)
> >               fcntl(err, F_SETFL, O_NONBLOCK);
> >       if (verbose > 1) {
> >               if (has_subtests(t))
> > @@ -304,29 +312,48 @@ static int finish_test(struct child_test *child_t=
est, int width)
> >                         .events =3D POLLIN | POLLERR | POLLHUP | POLLNV=
AL,
> >                       },
> >               };
> > -             char buf[512];
> > -             ssize_t len;
> > -
> > -             /* Poll to avoid excessive spinning, timeout set for 100m=
s. */
> > -             poll(pfds, ARRAY_SIZE(pfds), /*timeout=3D*/100);
> > -             if (!err_done && pfds[0].revents) {
> > -                     errno =3D 0;
> > -                     len =3D read(err, buf, sizeof(buf) - 1);
> > -
> > -                     if (len <=3D 0) {
> > -                             err_done =3D errno !=3D EAGAIN;
> > -                     } else {
> > -                             buf[len] =3D '\0';
> > -                             if (verbose > 1)
> > -                                     fprintf(stdout, "%s", buf);
> > -                             else
> > +             if (perf_use_color_default) {
> > +                     int tests_in_progress =3D running_test;
> > +
> > +                     for (int y =3D running_test; y < child_test_num; =
y++) {
> > +                             if (check_if_command_finished(&child_test=
s[y]->process))
> > +                                     tests_in_progress++;
> > +                     }
> > +                     print_test_result(t, i, subi, TEST_RUNNING, width=
,
> > +                                       child_test_num - tests_in_progr=
ess);
> > +             }
> > +
> > +             err_done =3D true;
> > +             if (err <=3D 0) {
> > +                     /* No child stderr to poll, sleep for 10ms for ch=
ild to complete. */
> > +                     usleep(10 * 1000);
> > +             } else {
> > +                     /* Poll to avoid excessive spinning, timeout set =
for 100ms. */
> > +                     poll(pfds, ARRAY_SIZE(pfds), /*timeout=3D*/100);
> > +                     if (pfds[0].revents) {
> > +                             char buf[512];
> > +                             ssize_t len;
> > +
> > +                             len =3D read(err, buf, sizeof(buf) - 1);
> > +
> > +                             if (len > 0) {
> > +                                     err_done =3D false;
> > +                                     buf[len] =3D '\0';
> >                                       strbuf_addstr(&err_output, buf);
> > +                             }
> >                       }
> >               }
> > +             if (err_done)
> > +                     err_done =3D check_if_command_finished(&child_tes=
t->process);
> > +
> > +             if (perf_use_color_default) {
> > +                     /* Erase "Running (.. remaining)" line printed be=
fore poll/sleep. */
> > +                     fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
> > +             }
> >       }
> >       /* Clean up child process. */
> >       ret =3D finish_command(&child_test->process);
> > -     if (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL) {
> > +     if (verbose > 1 || (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL)) {
> >               /* Add header for test that was skipped above. */
> >               if (has_subtests(t))
> >                       pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_d=
escription(t, subi));
> > @@ -335,7 +362,7 @@ static int finish_test(struct child_test *child_tes=
t, int width)
> >               fprintf(stderr, "%s", err_output.buf);
> >       }
> >       strbuf_release(&err_output);
> > -     print_test_result(t, i, subi, ret, width);
> > +     print_test_result(t, i, subi, ret, width, /*remaining=3D*/0);
> >       if (err > 0)
> >               close(err);
> >       return 0;
> > @@ -351,7 +378,7 @@ static int start_test(struct test_suite *test, int =
i, int subi, struct child_tes
> >               pr_debug("--- start ---\n");
> >               err =3D test_function(test, subi)(test, subi);
> >               pr_debug("---- end ----\n");
> > -             print_test_result(test, i, subi, err, width);
> > +             print_test_result(test, i, subi, err, width, /*remaining=
=3D*/0);
> >               return 0;
> >       }
> >
> > @@ -376,7 +403,7 @@ static int start_test(struct test_suite *test, int =
i, int subi, struct child_tes
> >       err =3D start_command(&(*child)->process);
> >       if (err || !sequential)
> >               return  err;
> > -     return finish_test(*child, width);
> > +     return finish_test(child, /*running_test=3D*/0, /*child_test_num=
=3D*/1, width);
> >  }
> >
> >  #define for_each_test(j, k, t)                                       \
> > @@ -461,7 +488,7 @@ static int __cmd_test(int argc, const char *argv[],=
 struct intlist *skiplist)
> >       }
> >       for (i =3D 0; i < child_test_num; i++) {
> >               if (!sequential) {
> > -                     int ret  =3D finish_test(child_tests[i], width);
> > +                     int ret  =3D finish_test(child_tests, i, child_te=
st_num, width);
> >
> >                       if (ret)
> >                               return ret;
> > diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
> > index 01f7bed21c9b..4b9f8d5d4439 100644
> > --- a/tools/perf/util/color.h
> > +++ b/tools/perf/util/color.h
> > @@ -22,6 +22,7 @@
> >  #define MIN_GREEN    0.5
> >  #define MIN_RED              5.0
> >
> > +#define PERF_COLOR_DELETE_LINE       "\033[A\33[2K\r"
> >  /*
> >   * This variable stores the value of color.ui
> >   */
> > --
> > 2.44.0.478.gd926399ef9-goog

