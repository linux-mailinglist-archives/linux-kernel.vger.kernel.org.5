Return-Path: <linux-kernel+bounces-137247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827389DF70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E431F21373
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45413D511;
	Tue,  9 Apr 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZT0NNfD"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DC13AD08
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677169; cv=none; b=kiYg15XdfVf5h/toXbr0qzbrwdOmOaU5dvZa2XRhQIgFi9nIIJyVChPyqj6HTtV7z+kTElQnuKezjiM6N9wC9iT95AgYjMJyh+XwRK/Ea7cl+nEjFdp6AmMs2c1qZ8/jqKIRdA9CWSK28uIW65Ua3vZA6zubmN9qixFz4LPS80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677169; c=relaxed/simple;
	bh=TdZbbcvibKNEubySC1+cZnIcJaZJ5ysQzEMkQS6d5mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGM3t2WL/i6sFHj3Y6h21zvk5rOSGMYMO5vr/okOEauqufgiCb8Vr9wU4RQKjdSNnSfOvYF/0AThlz7cOnYbHdoflcgVDgYir5LEh4zZcSZAr71o050gX7DXXLrqyQcnXSEBPN+8kPSOR4aCSe2u1Ia9mj4TngM1fh8e+u2zH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZT0NNfD; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a2667fdaeso96625ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712677166; x=1713281966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D59yPPfuGSeOXa0T7H8XaawbruvNp5rSjLW+dQV/V4=;
        b=IZT0NNfDaCWRwnaTClnZvolAXzInxquSWWu5NKczC167BGmkKPkQslPiHETVPO+Zxi
         hRYrh1QzqkC3OLpPyXQIa0UkEWVb+7ifnFPIc4oPuS6zdLmw1rbET52jb0XtILke5+H9
         t0ap2jjFIM0zT6HrIyRpby24BeMcL/v9Kmv5BqOirmctXmLlXQuiXPuOLqmFr9PXvpiv
         y70018dZnhcbkoicxDHKbzdezRrT18c/ESkLO+ADvQeh0fmW2YwOOsbWT52AOAsx7oOl
         vRkZzXrfLHnJfC+mUp8K6EawEYz7GjDceEmibm/YhquclDvU1LHXw4yUIpuLL5GapqcX
         qL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677166; x=1713281966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2D59yPPfuGSeOXa0T7H8XaawbruvNp5rSjLW+dQV/V4=;
        b=aZc87H6GklHJ5RMsaO44AuMzwLft8FAbZt14HDibEgN7ZxUxk9C5STiCWFIszxzuNu
         P+nVIIGp6Gh+ZTJZyZhuXylzmFxx4xkk5blk+RkjMpzUVNl0wgsw1p0sPj1K2c0bDsja
         JiGbRUHiwmCCj+1+HqBKl0H0XOwEP517HVGJPJzP8xFMtIcZOkamGSof+VL7WWlA7KFp
         ZAVrFKdECQSHPcot9/lyLOQPM025xmykhhWeNndQCZvQJhyqI/NZHtYkulnxpZe8rzt5
         bDrwIIRVliFfRuk31ClI9BS+/GV9tUWIM0PlyvpM9PWd+Fh+7PxOLdO+ewm6kB9mMfhv
         vU7g==
X-Forwarded-Encrypted: i=1; AJvYcCUB5Kxz2TD6n1oCZ1LnJofacBtwlW4wOgaew6opeuoFueSeuu00BS6JxM7ONjpOxZXBFwKpcWpFGGrxOlrOmrVCn92tKTfY6dz1+fv5
X-Gm-Message-State: AOJu0YwasI8F8OrXUyxXjElGed15V8sHX1PQNA6xhS5V4g/c/YzI2TIO
	9q0exSysUwnl5IW/FH+wM0fSxc/UT6Ov2bXQ9prPvVaaSWVm3D/r4c0XzhmLhsJr9l26yFv3JgE
	8ayZuR9ToHoaQTt7ryHZ2MPdzylqSjPE2wWVL
X-Google-Smtp-Source: AGHT+IFkayyl+X2axDy+TRHXNNVTcPE8tGFRWfcc/gS5tKeuISFjOsFa6BTkf3xYxLseiI6nYyW/dAZrcZ0vJ7IdyJE=
X-Received: by 2002:a92:910:0:b0:368:8f9f:4066 with SMTP id
 y16-20020a920910000000b003688f9f4066mr177822ilg.9.1712677166065; Tue, 09 Apr
 2024 08:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409084741.405433-1-james.clark@arm.com> <20240409084741.405433-4-james.clark@arm.com>
In-Reply-To: <20240409084741.405433-4-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 08:39:10 -0700
Message-ID: <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tests: Skip "test data symbol" on Neoverse N1
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:48=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> To prevent anyone from seeing a test failure appear as a regression and
> thinking that it was caused by their code change, just skip the test on
> N1.
>
> It can be caused by any unrelated change that shifts the loop into an
> unfortunate position in the Perf binary which is almost impossible to
> debug as the root cause of the test failure. Ultimately it's caused by
> the referenced errata.
>
> Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testing=
")
> Signed-off-by: James Clark <james.clark@arm.com>

This change makes me sad :-( Is there no hope of aligning the loop? We
have little enough testing coverage for memory events and even precise
events on ARM that anything take away testing coverage feels like we
should try to do better.

Which models are we losing coverage for, presumably neoverse-n1 but
what about neoverse-v1 and neoverse-n2-v2?

If aligning the loop doesn't work, could we use objdump and check its
alignment skipping when it is off? Or run the test and turn fails to
skip on neoverse-n1 - so we get some coverage testing.

It would also be nice if the change didn't add a dependency on lscpu
for the sake of parsing /proc/cpuinfo, I see another arm test already
did this test_arm_callgraph_fp.sh - that case looks like it should be
using uname.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/test=
s/shell/test_data_symbol.sh
> index 3dfa91832aa8..ffc641d00aa4 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -16,6 +16,12 @@ skip_if_no_mem_event() {
>         return 2
>  }
>
> +# Skip on Arm N1 due to errata 1694299. Bias exists in SPE sampling
> +# which can cause the load and store instructions to be skipped
> +# entirely. This comes and goes randomly depending on the offset the
> +# linker places the datasym loop at in the Perf binary.
> +lscpu | grep -q "Neoverse-N1" && exit 2
> +
>  skip_if_no_mem_event || exit 2
>
>  skip_test_missing_symbol buf1
> --
> 2.34.1
>

