Return-Path: <linux-kernel+bounces-160398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48368B3D11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300AC1F238C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A5158D93;
	Fri, 26 Apr 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nb1k/G2M"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E2156864
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149958; cv=none; b=GqtbQo2MoEZiGwaBvYUwY11uRlZ0ipKh0tHE1kxSV4uTIFn5J6JialFMBo1TS46X/fIThnwA47t+mGWkON32DYYTVlYRZWmNvIfNEMg7rw+n2yV+iKNEU4O48PhXIAMNF5AR0CajeXnDc0HJ0u46Tu/x6Agvpbn+/WIt6yEd9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149958; c=relaxed/simple;
	bh=TsW6GTHiTQeGY0lIhBtmL90amY6atH1W3WIzWx9xDaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Htdn1FFFXrcLVUUgzrEd3b16VX/pqSKrQJIn6bcio/CWn4gnF4TKaa6Vd/c58+cn0poyjDTpDzcasUbPL/eupY7F4dCR1aiORCud+97D6nwlh6+Gt+LOPAWH5KArcQx1Nrk+LyymIUg5rMIWXTk2slkuOpGlVHhsAgi1KBX/qmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nb1k/G2M; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36b34effb04so1155ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714149956; x=1714754756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH10hcFVd/zxNn6ShOQRCsj816hnsyk+v3ag974TenE=;
        b=Nb1k/G2MXiB/ZuLOY3onBlgsEzvobn58IY7qHac3Og9w9qhCQ79WzwrNjNGf6p3vPW
         3UGZ+qz3mWS8wFQsp9vxjAJj9ix62hj1ElGCC1TyJch/ZrvkinjDkhXsMaiw/dBDGAZt
         ED00auW81sEnF8gGAh0LIC7ZnXphnxX/BoxYKPhBdsCIdWHZ1QEmzNWPu3OIfeQ/sRtK
         BTF6aE1ohif60xaAeg+7BPi8ScAjYrR7CB1r/4o+Bil/rZP4S0dYj7YIJRzHQkqFTVXf
         EkNCwnqcrtQBbjWIZ9oBOnSzxEFhz5xmJl8UJMHU0z0FY+s2bxPx5lUjmr+gcvQIT1S+
         CZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714149956; x=1714754756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH10hcFVd/zxNn6ShOQRCsj816hnsyk+v3ag974TenE=;
        b=qsMMjlGs6t/tcE4TSZPUwZ/oEZ0XP+LTi4svDBBtxFbdoFyU3riIZtbjKuH6KwFvVr
         sIXLEmnkcbSieGLg1A3scjULxRGy9UUAiwhXpZfSGLzeIHr6zuntBJ+NzX96OD3z2iH2
         N1HuLs0Md3vadrPyd826QL1A+2otvaoBO5wh0hhHC8oboKB9QoavNT5yn26Q4Nk/lOgL
         ClgBaWztWQKP0gxx5BMpjNFU1wIywrRNvUmbwpT0a7uprCo0084uUDNwuOUbprMKUMWs
         5f5MUj5kgYB3f3IeyJFHc+I5UqWOwRQx3i/TcShf4a47ExP59hLc5+8OkeyHAgLBQacU
         9Eaw==
X-Forwarded-Encrypted: i=1; AJvYcCUwpPkeeWHoMzv0Nm/HEaT75ohPIcm/tQxw8fQdag9UmguT1NT6vQZXezA2ScCG2nIL2Li+ipKny1b3LPEi7O6588pmEj8d1X/vVTmP
X-Gm-Message-State: AOJu0YzQiuN8Uz3znuK8qOA4woyxPGquzmJlimqOSx8lITQRstQpYHXX
	JVg2f4hGOg/9wUjPQehuvcPwxxYi+hpu/2yHgmHqoaGuJxMAw9TOiORfs+yMaqFiZiW21M1MbgB
	9Yfxqzykv5ny1UzIybqEcUiSo81r5MqsPm8dv
X-Google-Smtp-Source: AGHT+IGyqiUHq+bsq/fcDLWIZFYHRSRwpnnauY5KJb3XD469uS70sYP9EhJoE2ZqedpHAuLk5QeNwVmENstOTUvQIIw=
X-Received: by 2002:a05:6e02:13f0:b0:36c:3046:a6ef with SMTP id
 w16-20020a056e0213f000b0036c3046a6efmr283307ilj.12.1714149956436; Fri, 26 Apr
 2024 09:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301174711.2646944-1-irogers@google.com> <3e54fea7-2a37-4774-8a6a-85f75cc4a9ea@arm.com>
 <88b460e5-ef2f-4b2f-a173-deac34c99788@intel.com>
In-Reply-To: <88b460e5-ef2f-4b2f-a173-deac34c99788@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Apr 2024 09:45:42 -0700
Message-ID: <CAP-5=fWk6hMWMy93QgRAWUowRk5LNEkqRVa3u4h0fPRXyE-y+Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Run tests in parallel by default
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:42=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 26/04/24 18:06, James Clark wrote:
> >
> >
> > On 01/03/2024 17:47, Ian Rogers wrote:
> >> Switch from running tests sequentially to running in parallel by
> >> default. Change the opt-in '-p' or '--parallel' flag to '-S' or
> >> '--sequential'.
> >>
> >> On an 8 core tigerlake an address sanitizer run time changes from:
> >> 326.54user 622.73system 6:59.91elapsed 226%CPU
> >> to:
> >> 973.02user 583.98system 3:01.17elapsed 859%CPU
> >>
> >> So over twice as fast, saving 4 minutes.
> >>
> >
> > Apologies for not replying earlier before this was applied. But IMO thi=
s
> > isn't a good default. Tests that use things like exclusive PMUs
> > (Coresight for example) can never pass when run in parallel.
>
> Yes, that is an issue for Intel PT also.

Right, Arnaldo and I discussed this and the safe thing to do for now
is to keep the default at serial - ie revert this change.

My longer term concern is that basically means people won't use
parallel testing and we'll bitrot in places like synthesis where it's
easy to make naive assumptions that say /proc won't be changing.

We have these tests set up for continuous testing in my team, and as
part of that set up each test is run independently to maximize
parallelism. This means the exclusive PMU thing does make the tests
flaky so it would be nice to have the tests address this, either by
skipping or busy waiting (only when the error code from the PMU is
busy, up to some maximum time period).

> >
> > For CI it's arguable whether you'd want to trade stability for speed.
> > And for interactive sessions there was already the --parallel option
> > which was easy to add and have it in your bash history.
> >
> > Now we've changed the default, any CI will need to be updated to add
> > --sequential if it wants all the tests to pass.
>
> Same here.
>
> >                                                 Maybe we could do some
> > hack and gate it on interactive vs non interactive sessions, but that
> > might be getting too clever. (Or a "don't run in parallel" flag on
> > certain tests)
>
> Perhaps more attention is needed for the tests that take so long.
> For example, maybe they could do things in parallel.

This is true for the tool in general. The problem is a lack of good
abstractions. Probably the easiest candidate for this are the shell
tests.

> Also -F option doesn't seem to work.
>
> $ tools/perf/perf test -F
> Couldn't find a vmlinux that matches the kernel running on this machine, =
skipping test
>   1: vmlinux symtab matches kallsyms                                 : Sk=
ip
>   2: Detect openat syscall event                                     : Ok
>   3: Detect openat syscall event on all cpus                         : Ok
>   4.1: Read samples using the mmap interface                         : Ok
>   4.2: User space counter reading of instructions                    : Ok
>   4.3: User space counter reading of cycles                          : Ok
>   5: Test data source output                                         : Ok
> WARNING: event 'numpmu' not valid (bits 16-17,20,22 of config '6530160' n=
ot supported by kernel)!
>   6.1: Test event parsing                                            : Ok
>   6.2: Parsing of all PMU events from sysfs                          : Ok
> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by =
kernel)!
>   6.3: Parsing of given PMU events from sysfs                        : Ok
>   6.4: Parsing of aliased events from sysfs                          : Sk=
ip (no aliases in sysfs)
>   6.5: Parsing of aliased events                                     : Ok
>   6.6: Parsing of terms (event modifiers)                            : Ok
>   7: Simple expression parser                                        : Ok
>   8: PERF_RECORD_* events & perf_sample fields                       : Ok
>   9: Parse perf pmu format                                           : Ok
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
> failed: recursion detected for M1
> failed: recursion detected for M2
> failed: recursion detected for M3
> Not grouping metric tma_memory_fence's events.
> Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constrain=
t:
>     echo 0 > /proc/sys/kernel/nmi_watchdog
>     perf stat ...
>     echo 1 > /proc/sys/kernel/nmi_watchdog
> Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constrain=
t:
>     echo 0 > /proc/sys/kernel/nmi_watchdog
>     perf stat ...
>     echo 1 > /proc/sys/kernel/nmi_watchdog
> ...
> ^C

Not working meaning the errors are going to stderr? The issue is that
pr_err will write to stderr regardless of the verbosity setting and
some tests deliberately induce errors. We could use debug_set_file
 to set the output to /dev/null, but that could hide trouble. -F
usually means your debugging so we've not cared in the past.

Thanks,
Ian

