Return-Path: <linux-kernel+bounces-166832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2C8BA033
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B654B234AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949F173356;
	Thu,  2 May 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAYFHYMy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC52172BCC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673978; cv=none; b=gCmnleyDjRyyWK4+jOTe9MwqrcWdyKyHm5etuSd5ze8MQEZyFQaa8Xs44mgKciRAXE7vlmeLImU6jMyjtyRoqPnORS/VDI68fCbhgnwTfOLLZv+oJIXNqZznzwNvRenjTWhp3Rk6OfEzoRuyxto408MZq0J87KpAOaY2K5cFV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673978; c=relaxed/simple;
	bh=SYlCpBOfXAeKSxneS/U6YkJ45rTbrFjuiWOa01qQagE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R54IR8ZlkMGFJUMF6x9uOEwx75CRbe+KCqvvyuA7uh2qgerc03/6qt98KtacvNlla+cBB5cduSWH4M6fGEmxVEX+fNyNMEZXydoPXryUbjbzfJgZKbrcVhU6b6rc8manm0f5rLpQLMJrUGhI8GvmpkfTaypMlCxO/WzzSx5n/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAYFHYMy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec182ab287so26535ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714673977; x=1715278777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usd3Q8JoS3orjgW7FWjnn2VBZ/CfthnIjfJDew/zyxI=;
        b=ZAYFHYMyZKJb2u8rJMyX8V2ezv5oIkfQA57KwzOJ05MdVP8UgVsfnK8hKrWfwdKCsl
         bGjDqOlHfDL2kUkFudXouK1Im4mu4XVcPkkuHzdGTvdLCIwIEIOVcz710RE0hKCMWnoH
         AaaVt4m7K4dvmPn3urAAxu2XbBpo5UCAHc0vvGK8BA+/Plcvs+faEJvS6cgJiVCpyhvc
         ej3A3b+Zkc1ZtaFxY5M69Rpk5F47MT+rMrWJO4UYAUQoXJHCPbTTNp5DgnSkAu1knYuW
         xSRoyLi8ZreR5c6w/jnI3cy1F6VPTlWbWnFMOb9j4sEI4NQZ2VtDVV+ZUo4UMH7Z8Edn
         FQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673977; x=1715278777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Usd3Q8JoS3orjgW7FWjnn2VBZ/CfthnIjfJDew/zyxI=;
        b=FoFHNH7FfylQlvJR+rCOSsWjyhsdkPqdTJdWtOLbLF1o9R8Bv2yyx4pRy0ONXxMsko
         k8ZgVmXiSODak69JCLLwz2ai/pHvFXAeKXbOjDRK8K9ZGjGDn8wmM58lhgjXK1OFUsLc
         qujrvi1yQQanNJ4I/DcG95EFF9dGZadnI/S/PRsTt8oVsxvM1uIqx+Vaqd8brUBOknbi
         zgyPRrqFsJwpI9QfwhDV+X7xnNvfrJNTZfEsutmaUeBBqwF0vjVARhdxvUaAWXdezI9z
         oeSkKVzMUpmQDX+hEdg1DHQSLk2UTiND1SM2xu30484NKgoB7SQ3vdzy4fp0Slden+ib
         v8Og==
X-Forwarded-Encrypted: i=1; AJvYcCV/8/lyEdzFf9WlCk0gtTMV6k7ohyeskX7xdavrhcUlUZPJisx8i0Vav5aVXMZiG6nHDZzcRusz3cRpbERVXAKhCQeSxyudT4JXsZz/
X-Gm-Message-State: AOJu0YzdStsAr04pxYft6EpxC2rHuwqTSknpJ8+XnIjHM1FWwV8EFiX7
	HrEB3qJhJ5SLP0xfmMOF8aGhfnbyq3HtIlQDF9aaGfTnMLRcaxpSLXSzS7cIfNsNrWFa8KvHmbK
	q9SCjlXMjsbcAlbi7+XrRiB74ru8WrjseZSxb
X-Google-Smtp-Source: AGHT+IH0EzMNHk7bY5qnvmw3tjRb6LSjW0gHXrp3JWHywZhQZVhmVPBhPu9rdb+1xmlGrY05htX1Cc5WKJQ/kpPdSi4=
X-Received: by 2002:a17:903:2286:b0:1e5:5c7a:6a4e with SMTP id
 d9443c01a7336-1ed2c6f6957mr231985ad.2.1714673976198; Thu, 02 May 2024
 11:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com> <78a63434-c7b8-4ada-b59f-b6dd547b5b63@linux.intel.com>
In-Reply-To: <78a63434-c7b8-4ada-b59f-b6dd547b5b63@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 May 2024 11:19:24 -0700
Message-ID: <CAP-5=fX9k91KRiXK18LHKoqTgwYvU3PB1qtfUWuMoPY4Xfffrw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Assume sysfs event names are always the same case
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:15=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-05-02 12:01 a.m., Ian Rogers wrote:
> > By assuming sysfs events are either upper or lower case, the case
> > insensitive event parsing can probe for the existence of files rather
> > then loading all events in a directory. When the event is a json event
> > like inst_retired.any on Intel, this reduces the number of openat
> > calls on a Tigerlake laptop from 325 down to 255.
> >
> > v1 sent as an RFC:
> >     https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@googl=
e.com/
> >
> > v2: addresses review feedback from Kan Liang, by updating
> >     documentation and adding tests.
> >
> > v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
> >     that s390 event names are all upper case. Do a lower case probe
> >     then an upper case probe, make documentation and tests also agree.
> >
> > v4: add checks to write (kernel test robot) and fix a typo.
> >
> > Ian Rogers (6):
> >   perf test pmu-events: Make it clearer that pmu-events tests json
> >     events
> >   perf Document: Sysfs event names must be lower or upper case
> >   perf test pmu: Refactor format test and exposed test APIs
> >   perf test pmu: Add an eagerly loaded event test
> >   perf test pmu: Test all sysfs PMU event names are the same case
> >   perf pmu: Assume sysfs events are always the same case
> >
> >  .../sysfs-bus-event_source-devices-events     |   6 +
> >  tools/perf/tests/pmu-events.c                 |   2 +-
> >  tools/perf/tests/pmu.c                        | 468 ++++++++++++------
> >  tools/perf/util/parse-events.c                |   2 +-
> >  tools/perf/util/parse-events.h                |   2 +-
> >  tools/perf/util/pmu.c                         | 111 +++--
> >  tools/perf/util/pmu.h                         |   4 +-
> >  tools/perf/util/pmus.c                        |  16 +-
> >  tools/perf/util/pmus.h                        |   2 +
> >  9 files changed, 416 insertions(+), 197 deletions(-)
> >
>
> Except the warning for the uninitialized 'ret', the rest looks good to me=
.

Thanks Kan, I'll hunt that down to fix in v5 and add your reviewed-by.
Would be awesome to get Thomas or someone else's s390 thumbs up. The
differences between v3 to v5 should be very minor, so I'd accept a
check on any of them :-)

Ian

> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan

