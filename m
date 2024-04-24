Return-Path: <linux-kernel+bounces-157775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871208B160B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66741F23A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF816D302;
	Wed, 24 Apr 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQcNune3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0315FA70
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997167; cv=none; b=oDKFkoJxF9ZqDX8FoLBa871W9FXgtwLQYl7sL7mbFyW7Vukm45ueLJB15FWFTfjXYUlbPMdzI1RBAkksG2n4UKwzBNjdyXPHpDWZEWKSXsQgJrXEpC8zEXgJJQbYaDVlrg2A9sd95gBoIxhuFKfpD+lneCsir/jsZaeLguLtt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997167; c=relaxed/simple;
	bh=NX5ud4CaT9JaaKudsoo9HAqQnazDTOUJ7K6XBwRDIlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5YmetkfqUJbbkzig0XMU4gSDm5p/EVC6d82+v9Dyh/COdSVMag4mwjn19899V4DvBzARv77xm3YaNxhIwfr12evzkkF+vlTH++UzsusSMk9VzVR+8qJynAN0g/+NzRLxes47YOdpQvrg97hCkhWPBqZ/WAGIYQJ6AN8KeHYPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQcNune3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e8fcb0b860so67805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713997164; x=1714601964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSU58pUDAW526X8Oq5AygsbaAJ3W3pJesITfSQQhWew=;
        b=MQcNune3htZ5WbW5pM5QwGar7yDU6ATlLET2FyxJId5rnpdDpnOjRC9tYOt0c5uSc8
         /NOUkN+9O7PWD66mSILqzdK2XcFnw0vt4yZr6Xd70lalp7vrggip33ODdf4RwpuLWQeh
         3Trg/Luc2LgybUe9pcd/VIPNR2rVfvqpCTvEBDgI9xGKm2HAwX/huhMofl9l/a/ATKSb
         A75FHCCpW2550Zfl/gqKjrGQBAwvd5wraobMiljJrD+ew8SxCr1TPUXKciIcp8GTeRZM
         A7LItE03uPRrvO0IKPQ8mh0Zju3WVhOPYlFl9LMnLKITT3/jJPpd2+HJRkzpiOEsN7TD
         5V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997164; x=1714601964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSU58pUDAW526X8Oq5AygsbaAJ3W3pJesITfSQQhWew=;
        b=K3RpZV5tUbiNKwx/pbIOupgip2mQF9qTna4MCc/nOHMIzRWq8fBnJCZJ9tHqN5erQO
         TBEKiay5TbBz9RwgFmkif6ZSDL4bV2N7v0IIun3+lnV7LJ7KVNEvnD75hvZ9aK911ciY
         NUVr7l7iqocJX176xwDOy74xmfqaIlGGPOwbuoDLRedrbfoulJyxLG7LzRdr72JydiMG
         JmKgO5pXjrN6Zq3B6+4DN4iSdud2E9e4z+96WcDjj4AcPkblETI8GETKsYmrzCrYRoeR
         qGJnjAWPSIsshLgWj8DvuoXwQUbYGewABZbAjnC6ymmbygp9iD7mRoQm2VNecZW7XSFr
         UV6g==
X-Forwarded-Encrypted: i=1; AJvYcCXg3HCF+le7jr0vyqz/nSpX2LPbee8sXfw+vFGLvhVk/I2ziPtMErOFsT7gGhsAefSfx6hs0UUsWoOKFvbP17rFey02MOIkMv5JfteD
X-Gm-Message-State: AOJu0YyDvF1dafznoCvMpkmLSckWDe/GhA+dKJLJqeCz+2DpRAfdPRG+
	DlDhE1dcGm9xtCts06XSEd31UlRCY8bfm7+V5VFLJfAf6gpOi7ck+rRAT+7cg1B/mskvPaqTk6n
	220QRMCQYu8JUt+qI2HU0cMImzdUSRJ3O8Yku
X-Google-Smtp-Source: AGHT+IEqcYtcl/GHMuNoCUNjmYG/0cFftn7omhI6XdCOiCeNCXw5+aicgp48RWK8DqsppATgYtPRgqVNHrIbttSxo8I=
X-Received: by 2002:a17:902:9a01:b0:1e3:d23a:2d5e with SMTP id
 v1-20020a1709029a0100b001e3d23a2d5emr31724plp.21.1713997163967; Wed, 24 Apr
 2024 15:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com> <Zil1ZKc7mibs6ONQ@x1>
In-Reply-To: <Zil1ZKc7mibs6ONQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 15:19:09 -0700
Message-ID: <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 24, 2024 at 12:12:26PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, Apr 23, 2024 at 7:46=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
> > >
> > > Currently, off-cpu samples are dumped when perf record is exiting. Th=
is
> > > results in off-cpu samples being after the regular samples. Also, sam=
ples
> > > are stored in large BPF maps which contain all the stack traces and
> > > accumulated off-cpu time, but they are eventually going to fill up af=
ter
> > > running for an extensive period. This patch fixes those problems by d=
umping
> > > samples directly into perf ring buffer, and dispatching those samples=
 to the
> > > correct format.
> >
> > Thanks for working on this.
> >
> > But the problem of dumping all sched-switch events is that it can be
> > too frequent on loaded machines.  Copying many events to the buffer
> > can result in losing other records.  As perf report doesn't care about
> > timing much, I decided to aggregate the result in a BPF map and dump
> > them at the end of the profiling session.
>
> Should we try to adapt when there are too many context switches, i.e.
> the BPF program can notice that the interval from the last context
> switch is too small and then avoid adding samples, while if the interval
> is a long one then indeed this is a problem where the workload is
> waiting for a long time for something and we want to know what is that,
> and in that case capturing callchains is both desirable and not costly,
> no?
>
> The tool could then at the end produce one of two outputs: the most
> common reasons for being off cpu, or some sort of counter stating that
> there are way too many context switches?
>
> And perhaps we should think about what is best to have as a default, not
> to present just plain old cycles, but point out that the workload is
> most of the time waiting for IO, etc, i.e. the default should give
> interesting clues instead of expecting that the tool user knows all the
> possible knobs and try them in all sorts of combinations to then reach
> some conclusion.
>
> The default should use stuff that isn't that costly, thus not getting in
> the way of what is being observed, but at the same time look for common
> patterns, etc.
>
> - Arnaldo

I really appreciate Howard doing this work!

I wonder there are other cases where we want to synthesize events in
BPF, for example, we may have fast and slow memory on a system, we
could turn memory events on a system into either fast or slow ones in
BPF based on the memory accessed, so that fast/slow memory systems can
be simulated without access to hardware. This also feels like a perf
script type problem. Perhaps we can add something to the bpf-output
event so it can have multiple uses and not just off-cpu.

To turn the bpf-output samples into off-cpu events there is a pass
added to the saving. I wonder if that can be more generic, like a save
time perf inject.

I worry about dropping short samples we can create a property that
off-cpu time + on-cpu time !=3D wall clock time. Perhaps such short
things can get pushed into Namhyung's "at the end" approach while
longer things get samples. Perhaps we only do that when the frequency
is too great.

It would be nice to start landing this work so I'm wondering what the
minimal way to do that is. It seems putting behavior behind a flag is
a first step.

Thanks,
Ian

> > Maybe that's not a concern for you (or smaller systems).  Then I think
> > we can keep the original behavior and add a new option (I'm not good
> > at naming things, but maybe --off-cpu-sample?) to work differently
> > instead of removing the old behavior.
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > Before, off-cpu samples are after regular samples
> > >
> > > ```
> > >          swapper       0 [000] 963432.136150:    2812933    cycles:P:=
  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > >          swapper       0 [000] 963432.637911:    4932876    cycles:P:=
  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > >          swapper       0 [001] 963432.798072:    6273398    cycles:P:=
  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > >          swapper       0 [000] 963433.541152:    5279005    cycles:P:=
  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > > sh 1410180 [000] 18446744069.414584:    2528851 offcpu-time:
> > >             7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)
> > >
> > >
> > > sh 1410185 [000] 18446744069.414584:    2314223 offcpu-time:
> > >             7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)
> > >
> > >
> > > awk 1409644 [000] 18446744069.414584:     191785 offcpu-time:
> > >             702609d03681 read+0x11 (/usr/lib/libc.so.6)
> > >                   4a02a4 [unknown] ([unknown])
> > > ```
> > >
> > >
> > > After, regular samples(cycles:P) and off-cpu(offcpu-time) samples are
> > > collected simultaneously:
> > >
> > > ```
> > > upowerd     741 [000] 963757.428701:     297848 offcpu-time:
> > >             72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)
> > >
> > >
> > >       irq/9-acpi      56 [000] 963757.429116:    8760875    cycles:P:=
  ffffffffb779849f acpi_os_read_port+0x2f ([kernel.kallsyms])
> > > upowerd     741 [000] 963757.429172:     459522 offcpu-time:
> > >             72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)
> > >
> > >
> > >          swapper       0 [002] 963757.434529:    5759904    cycles:P:=
  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
> > > perf 1419260 [000] 963757.434550: 1001012116 offcpu-time:
> > >             7274e5d190bf __poll+0x4f (/usr/lib/libc.so.6)
> > >             591acfc5daf0 perf_evlist__poll+0x24 (/root/hw/perf-tools-=
next/tools/perf/perf)
> > >             591acfb1ca50 perf_evlist__poll_thread+0x160 (/root/hw/per=
f-tools-next/tools/perf/perf)
> > >             7274e5ca955a [unknown] (/usr/lib/libc.so.6)
> > > ```
> > >
> > > Here's a simple flowchart:
> > >
> > > [parse_event (sample type: PERF_SAMPLE_RAW)] --> [config (bind fds,
> > > sample_id, sample_type)] --> [off_cpu_strip (sample type: PERF_SAMPLE=
_RAW)] -->
> > > [record_done(hooks off_cpu_finish)] --> [prepare_parse(sample type: O=
FFCPU_SAMPLE_TYPES)]
> > >
> > > Changes in v2:
> > >  - Remove unnecessary comments.
> > >  - Rename function off_cpu_change_type to off_cpu_prepare_parse
> > >
> > > Howard Chu (4):
> > >   perf record off-cpu: Parse off-cpu event, change config location
> > >   perf record off-cpu: BPF perf_event_output on sched_switch
> > >   perf record off-cpu: extract off-cpu sample data from raw_data
> > >   perf record off-cpu: delete bound-to-fail test
> > >
> > >  tools/perf/builtin-record.c             |  98 +++++++++-
> > >  tools/perf/tests/shell/record_offcpu.sh |  29 ---
> > >  tools/perf/util/bpf_off_cpu.c           | 242 +++++++++++-----------=
--
> > >  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 163 +++++++++++++---
> > >  tools/perf/util/evsel.c                 |   8 -
> > >  tools/perf/util/off_cpu.h               |  14 +-
> > >  tools/perf/util/perf-hooks-list.h       |   1 +
> > >  7 files changed, 344 insertions(+), 211 deletions(-)
> > >
> > > --
> > > 2.44.0
> > >

