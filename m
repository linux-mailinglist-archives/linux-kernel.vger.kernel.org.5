Return-Path: <linux-kernel+bounces-37514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F331B83B12C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5744283DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444C7CF3F;
	Wed, 24 Jan 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Eh03j/+"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063612DDA8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121064; cv=none; b=KaoEbUG0rkr5Zou2AMNAdoCcg5QnXTyDl7ycom/OL+Q+TmcFHD0qAxmXGHEWshHKrxPTijE96AM2R6szgO38mV5QE0MMHo5taOKpbIuqUmzQMe1IWsZE1pwqeiC/Dut9swDO4CvFjrH3It61ynV6cvOCmOxYa9I+6TOAp6FHHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121064; c=relaxed/simple;
	bh=P0nzUp0PvO8mm5HPDJlWk9SceYUCT/eyYnvv5nDCvDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8jEy57URjxr0E7sTYbS5uqmwi+zOLuovrP2gl67csSsINxVllybDNeg4CeROjzBcCIbugw7+REy8gA6/J3zN/pQ3kSKI9LJ1jpkULsKMy3m0ZU3Jj8Pa8iFp9XdFCBnabKH1FzgDmdguzV3t0QFbXKFgJpFRNMZ2kJBLLBJS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Eh03j/+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so9385ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706121043; x=1706725843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awu7x77B+bOCRQBjAJIZUBeYxB3ax7vYrRZ3HCTLFHA=;
        b=3Eh03j/+t/viyE0uk9aMiRJsVjcFvBf0ElftPl98m6KT9HrEWdz7OjMaqTfYR8rBo8
         DaGwlFtTdqMP3dBOcDEyiSTn7taXRYzCA7A1PVypzqrc8fFpHdHSvhEwckG2Wtcol3Fh
         3feFxyBZcGfw414b7kn+WnNsZGha35PEj1hVJGiGSKjuuT6lTYmv4cQYMNd6YpDcSGfB
         Ppp+V2/1HjwO0yM34bH7uFa+m/5y/O/ccm1cm63Ruyp48CijTDrpl8ptY+7BPc4Ml+G2
         30uU5OXTg+lVJHhGZbEnUA8IHOK+j8x46deUvllxhjkVzixbuFKHGw5DheoW/SRL++DF
         6roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121043; x=1706725843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awu7x77B+bOCRQBjAJIZUBeYxB3ax7vYrRZ3HCTLFHA=;
        b=weaipnRLIcVSOkNnK4cZpE5Sdg6TUbpeVuygOdwPJnSzStUZFOfIcDg4VsWFL2mK/5
         ZatIkkZWPYhxsOKHuY5Q+bhuj7ArjWbfOuKMVsV2/dZc497zkz1hzptrijXf2oP3F5N2
         PgjZZ4r69HJjd52Mn95YqSQy1ehKrCOdnuWhkOFTsI/T2C5wanl1aFHnryyhEXuqMjWt
         pvmVfXhVy02J/yByl1tru5axt3vKAvPT6mjEulVBwvqNgy6mCUyZKxXKSC/NcHnh2uo1
         mZPPdFRcrW03W8JR+QFdUXPY/7tBomYQWRTCfwMpWCH/6eDyKxBUG6aaJx94TXFeFt/v
         hNBA==
X-Gm-Message-State: AOJu0Yw1WHrhW14RKWL/g+aaiM7khX1KLl/HP4w9oAYdM27HFxAwRqUj
	culpTc8ujewUif+j53R6qA0x69r3Hsy0KeZLOWCpnKGHca9y03vH8IcCTLx4a+Z/0gfWroxbdZF
	+B+cOwohz7R4g7URvSvZSTc+w034CPY2AaAPa
X-Google-Smtp-Source: AGHT+IGreWbUhtTvW+9Ga/OKnLbooNk4a5Iwt7NwGJpE8zRFyvmFj3idijd5lXxo3w4ouUVDvMSVHo93vSPjfKgoMAM=
X-Received: by 2002:a05:6e02:3207:b0:35f:dab8:1152 with SMTP id
 cd7-20020a056e02320700b0035fdab81152mr15036ilb.3.1706121043449; Wed, 24 Jan
 2024 10:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123163903.350306-1-james.clark@arm.com> <20240123163903.350306-3-james.clark@arm.com>
 <CAP-5=fX4QQYNzEY7-6GyqWJTuH-RQxxc3jB5B1k8HZtDZCHmFw@mail.gmail.com> <faba2e97-7e88-9dcc-756d-f256a6304836@arm.com>
In-Reply-To: <faba2e97-7e88-9dcc-756d-f256a6304836@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:30:32 -0800
Message-ID: <CAP-5=fUfY0weHXpDaz-oABsspnUyUdaF8ZYDUBFwFOCyiH80sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding
 isn't built in
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Spoorthy S <spoorts2@in.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:24=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 23/01/2024 17:41, Ian Rogers wrote:
> > On Tue, Jan 23, 2024 at 8:39=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> >>
> >> Even though this is a frame pointer unwind test, it's testing that a
> >> frame pointer stack can be augmented correctly with a partial
> >> Dwarf unwind. So add a feature check so that this test skips instead o=
f
> >> fails if Dwarf unwinding isn't present.
> >
> > Hi James,
> >
> > Is there value in testing without the partial Dwarf unwind? Presumably
>
> Yeah I think we could add a test for just --call-graph=3Dfp, I don't thin=
k
> there is one. But that would be separate to this test, and would be
> redundant if the tests are run with a dwarf unwinder present because
> this test already requires the frame pointer unwinder to be correct.
>
> > that is covered by the existing dwarf unwind test?
>
> There is no overlap, this test test is for --call-graph=3Dfp, and the
> dwarf test is for --call-graph=3Ddwarf
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/dwarf-unwind.c?h=3Dperf-tools-next
> > If the issue is inlined functions I'm surprised addr2line isn't doing
> > the job properly. Is there an addr2line perf script issue here?
> >
>
> The issue isn't inlined functions, it's when the leaf frame doesn't
> insert a frame pointer. In that case we use the link register to see
> what the parent function of the leaf frame was and insert it into the
> frame pointer stack.
>
> Dwarf is only used in this case to confirm if the link register was
> valid at that instruction.
>
> See commit b9f6fbb for more info. Long story short this test was only
> added for that feature and it requires a dwarf unwinder to pass despite
> being called test_arm_callgraph_fp

Ok, not directly seeing b9f6fbb being dependent on
HAVE_DWARF_UNWIND_SUPPORT. I'll assume I'm ignorant and the fix here
is obviously a workaround.

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > Thanks,
> > Ian
> >
>
>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/p=
erf/tests/shell/test_arm_callgraph_fp.sh
> >> index e342e6c8aa50..83b53591b1ea 100755
> >> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >> @@ -8,6 +8,12 @@ shelldir=3D$(dirname "$0")
> >>
> >>  lscpu | grep -q "aarch64" || exit 2
> >>
> >> +if perf version --build-options | grep HAVE_DWARF_UNWIND_SUPPORT | gr=
ep -q OFF
> >> +then
> >> +  echo "Skipping, no dwarf unwind support"
> >> +  exit 2
> >> +fi
> >> +
> >>  skip_test_missing_symbol leafloop
> >>
> >>  PERF_DATA=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >> --
> >> 2.34.1
> >>

