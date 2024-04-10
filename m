Return-Path: <linux-kernel+bounces-138963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C265A89FCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74505284794
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881117A93A;
	Wed, 10 Apr 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmb7HOSC"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79B17A93E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765840; cv=none; b=MYCnagNJn4AtKGuw4XgM9FOXnsSAgb2UMWjm45GQQsV1H0kAO+p2QYg6deljbjzLQYgYKgJ0Wtafis5AH/PNXK+EOfNvJV1WS7AKkcR0yAFRkZOASzrikk2EhUEmCDWwOvsZtlq+2ouKKIVjq4shmpXXX9wrftwn4CB+TX2Gve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765840; c=relaxed/simple;
	bh=z6IKR3JAhKYZVwCJuBfAEGi31YQCyS3o5wJrNYaVLZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA+DftqLq6ohcpPmsxq8LTK/KTC6zTn7+Ii3+EXPl21BarLsX/5j5y348j5d+GjYvgMrfz20WUN1tsR+y5sg1e9hbde8E6dQOTY+n6fN16N1oxuhs3MkIDYfbdgu3yIa2KFfgNrtTtUIKMyqRqxAkrOtrk1suOdKt3YordPH6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmb7HOSC; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so174835ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712765836; x=1713370636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S59M5ErJ4ghJIk0WuQtKw5Oah+bXQHt5R+GLddM1KKg=;
        b=dmb7HOSCx0aOaxYV/MYcS7ebcCA2nJ6wfPnfA29+V0tO7yUB6hGVEUq/lQJJf4fH8F
         7NhnoEhDs/HZjML4Xx/G3qDa9C+PhO8OnkgtKnrHiatAgWTGtnL2KK/Q3lJ4JeFigltA
         rnUDPjHIFmxJ+9qY7qdxerxPGlfCG3SUGTdEhQ/sgy//elfQQFQPkzU/MhjbqiC888xQ
         hzvQFEG2B7/3l7CwdSYkacIRHYLszG0F2FPGWXA1j76JWMsjozffKf8jMvIiuUOMovyr
         DlNC8DA6YSddrBGBVn+V6rQgsMppY/YSEKMHcfn2Qn6Eu29etcm+sxbRgoFLjU/6Istf
         Uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712765836; x=1713370636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S59M5ErJ4ghJIk0WuQtKw5Oah+bXQHt5R+GLddM1KKg=;
        b=rrnQZCmoFFh4oX7eeOlgqLYyJSdV/qqv0AZkf2rB7vkWsB4BRNK2AL7hG/Nm7q8Lgm
         GyMPSKemqVseRE2NP4PqU71B+rv/hf4lHEmKvOf+jWiEvsFvWSI+acxSgMGFQGQ+UKrJ
         RgSJDM0EPbZBYWF3Cu26YQyWJTveU9nrBQFlALjj4IhPcaDGpt23XPJKTVSg4IaRm9wA
         7M3qoMxlZc8R+bWp1nu35l9qwdU2HaZR4JU/0hZAE9COFV0/pKEBDoWRHttV6vDOVkka
         Cm49HzIuSf6KPLuv+f4Fn+4tdqm1pRw/IqjjYphlJ6VdaEXBwBo4JbwOPFKOs3NQDVzg
         3V6A==
X-Forwarded-Encrypted: i=1; AJvYcCUhCVZmKRBYwZV3KFeFo6TZ0HuSNIKFCFmlZwzUYCL4KCd40WkWtiSOjLfsYGcj5tlrpmFmnxZ+XusRrwVlwCTEMvOODd6cf+p9DYey
X-Gm-Message-State: AOJu0YxvGf0nDwJcku44X2vaUY5QWs3lkFjU5xUP1za/V6Mla/Ty1whx
	ygd1aUfFNowWDC22/n7SXt68HQG7FxIWePyeo8flanttBHgApNHKDRmMw4XldnAWaVeFrDJmSa1
	dRh7Y8Y8wXwUJrlJR95NsghJW9HD55cn4iGLt
X-Google-Smtp-Source: AGHT+IFSvH09coKrJ0WxqpOywmBxAI87YC290XDstCLKVDm1m1WDtulWPdOHHiub4CKMpx0EF/LCtFf+rgqg4r4N370=
X-Received: by 2002:a05:6e02:ee3:b0:36a:3d5f:e269 with SMTP id
 j3-20020a056e020ee300b0036a3d5fe269mr131406ilk.13.1712765835647; Wed, 10 Apr
 2024 09:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410103458.813656-1-james.clark@arm.com>
In-Reply-To: <20240410103458.813656-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 09:17:04 -0700
Message-ID: <CAP-5=fVgf3cOgbV1KGGLd5gykxT+BzuX1=XUsp+2BNUahGn6QQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf test: "object code reading" test fixes
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Spoorthy S <spoorts2@in.ibm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:35=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> A few fixes around the object code reading test. The first patch
> appears to be unrelated, but in this case the data symbol test is
> broken on Arm N1 by the second commit.
>
> Changes since V1:
>   * Put data symbol test fix first so that bisecting still works on N1
>   * Instead of skipping "test data symbol" on N1, add some noise into
>     the loop.
>   * Add a commit to replace the only usage of lscpu in the tests with
>     uname
>
> James Clark (4):
>   perf tests: Make "test data symbol" more robust on Neoverse N1
>   perf tests: Apply attributes to all events in object code reading test
>   perf map: Remove kernel map before updating start and end addresses
>   perf tests: Remove dependency on lscpu

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/tests/code-reading.c                 | 10 +++++-----
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh |  4 +++-
>  tools/perf/tests/workloads/datasym.c            | 16 ++++++++++++++++
>  tools/perf/util/machine.c                       |  2 +-
>  4 files changed, 25 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>

