Return-Path: <linux-kernel+bounces-69270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52AE858675
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C23F1F227A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B1137C50;
	Fri, 16 Feb 2024 19:57:37 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E371369BE;
	Fri, 16 Feb 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113457; cv=none; b=iVFz0P4Bp3RM+nxM/mhxLdpiXOQ2p5kLI80UTXjFu294VdrsBO9lavO+cmquU1Y+7FJ/rEcT3J2k/Vk4DtOV/3Gxy/Yk944b/kH1xEvn6ZlMzMLnzifHOeczZoWZ5kd80WcnBKT5Td04sBQ517D4JvLDk/hB8iblQ8zv3K9MNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113457; c=relaxed/simple;
	bh=mwBXSOLbzppGPcectkAGNJ7sViWWfxda+/ZYkgbgHHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIzlqdSHW6QGAmQow//xuT1+7wbkkeUZtEY1J0OiMfk3bgthAwUEbqdL1jZQsIdRo178BkDw1YKIrfe2cQ1SV5XqH+HfXPi4eGWYu6If0DnLKpfs2pNilqO2bpUqBdDy8WK+EDzXdgJUfPuyH1qGSGaUVT0eOSVgsWmAIg3BA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2608597a12.0;
        Fri, 16 Feb 2024 11:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113455; x=1708718255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT8lrnb7gXnsbOnwG07kVXdw+Ry7KiTiqSIe4Bjzp5k=;
        b=DqyeWv/hUSDiruCDOAI8OFGu6TFhoFoY2SF8vTV4JIAMF7WG3KpsMA1cdhbxM3oYtv
         47Qmlfl9r2Lz43kk/9G67/iTgG/EL+9tzrlELf11EIYknAOimGaLrrH4kSO92aOYZyOm
         Yj6dwpVeccZg+iI9Vp3Z/IG3NpRCwr3d8VSLwcYpl2o16LUdsdwNAqptCCVV5YCU7Jzy
         434ZcLpBZ6VzPwq697/Btp7JCLSb/OciaLKfqVhr8dpyNcFjhs0gvWgH3nUv/sTNXzRl
         KIMTXrVBi8aDguY2WavB0+aHocC1oiTxHNq9/4I/Gq2o1bOrPNMkIfKEst0990xlI1ug
         f7cg==
X-Forwarded-Encrypted: i=1; AJvYcCXlq5mRuSOggYmqc/oLBkXUm8DAacs+RjzwpwBPBbP/Nyh8hg0biCrtoRcekhz9PIASPMPNfFCM40fuoessWM16wyBIOnE0i3wA20k9SxtE2icROi8MBLjLvpHan4WqhA2scH7G6YtgfP2B+/WilA==
X-Gm-Message-State: AOJu0YyfiwAA94vLYpfjZ4/jqpBA/3bTIkFdw4l6tfWkCkOPYGIm+O16
	WpijVVBPb9fEelfZmjzdAcUruMZElCIwpkN0CtOhnxRlS2ND5j8PISq2v5Py7vbS8geSN6JvwaT
	04dekRVuB1ud4eI8BdMeunYWYcq4=
X-Google-Smtp-Source: AGHT+IFWRpynq69LNZN+UBhnF0PizVRFiXuYFvBza7v/gwZSo5+4DFDMusqXm9IXSVEcvBZ2bBqUqKse9+m6yZL3s8I=
X-Received: by 2002:a17:90b:19d5:b0:299:2d92:4942 with SMTP id
 nm21-20020a17090b19d500b002992d924942mr4919146pjb.7.1708113455044; Fri, 16
 Feb 2024 11:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 11:57:23 -0800
Message-ID: <CAM9d7cjXAKARq_7x0nif+vaiAfHHRhWEWHLYT3jkVugeXMncag@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Run tests in parallel
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, James Clark <james.clark@arm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Tue, Feb 13, 2024 at 8:54=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> If command line option '-p' is provided, start/fork all tests in the
> main thread and then gather them in order at the end. On a laptop test
> time was reduced from 5 minutes 21 seconds to 1 minute 50 seconds. The
> option isn't default as the test shows up perf and test flakes.

It's a bit sad that tests flake when run in parallel but I think we can
work on improving it later.  So

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> The '-v' option is modified so that 'perf test -v' will give verbose
> output only from failing tests.
>
> v4 - fix bug in width computation.
> v3 - fix a crash if shell test directory isn't found, remove merged patch=
.
> v2 - fix parallel test output/verbose issue
> v1 - initial PoC
>
> Ian Rogers (8):
>   perf thread_map: Skip exited threads when scanning /proc
>   perf list: Add scandirat compatibility function
>   perf tests: Avoid fork in perf_has_symbol test
>   tools subcmd: Add a no exec function call option
>   perf test: Rename builtin-test-list and add missed header guard
>   perf tests: Use scandirat for shell script finding
>   perf tests: Run time generate shell test suites
>   perf tests: Add option to run tests in parallel
>
>  tools/lib/subcmd/run-command.c                |   2 +
>  tools/lib/subcmd/run-command.h                |   2 +
>  tools/perf/tests/Build                        |   2 +-
>  tools/perf/tests/builtin-test-list.c          | 207 ----------
>  tools/perf/tests/builtin-test-list.h          |  12 -
>  tools/perf/tests/builtin-test.c               | 378 ++++++++++--------
>  tools/perf/tests/shell/lib/perf_has_symbol.sh |   2 +-
>  tools/perf/tests/tests-scripts.c              | 257 ++++++++++++
>  tools/perf/tests/tests-scripts.h              |   9 +
>  tools/perf/util/print-events.c                |  12 +-
>  tools/perf/util/thread_map.c                  |   9 +-
>  tools/perf/util/util.c                        |  19 +
>  tools/perf/util/util.h                        |   8 +
>  13 files changed, 509 insertions(+), 410 deletions(-)
>  delete mode 100644 tools/perf/tests/builtin-test-list.c
>  delete mode 100644 tools/perf/tests/builtin-test-list.h
>  create mode 100644 tools/perf/tests/tests-scripts.c
>  create mode 100644 tools/perf/tests/tests-scripts.h
>
> --
> 2.43.0.687.g38aa6559b0-goog
>

