Return-Path: <linux-kernel+bounces-133708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C589A79C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A644B1F224EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15D374CB;
	Fri,  5 Apr 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6j5uwVx"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9151E528
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712360663; cv=none; b=Gtt/f5b3eYkOIDkhed2SrwQ+XUraSKQpyqETDh/qhM213haeSZ0KSQUEC6AlYJAGWqsXBWM2diR7PIzrolRtOnxeqyEm1fXJoQdpjvjNaFd3/h8aEYqH3pETtRSAGxBS/mFLps0tmurYHZOQ7Y+KjVhzfEuw+luHlBp+MXbu3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712360663; c=relaxed/simple;
	bh=IZ2lpztq4nfTZplg/hN3aPSylSfMe4ljslvcySjCYjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhsPzjnU/GQKcBM6ErSwNFkmD67SCMwBVrWCkaVxwTJ7K8vPXEpwLMee5pPe7+hb+draQczaqmhMvJdVbRaPrakMoLDRjN/QQgcp5TPxSnSLf4/uuT6SY2iiiKnviEVQj5oJMVE29PQ/ftgiY2Ecuc/koLAnnRa5SSgM2dox9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6j5uwVx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430d3fcc511so52991cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712360661; x=1712965461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzcd1UZQERfxvTBnVGRGRZ63pCnV3q/1zmShLREA7NM=;
        b=C6j5uwVxA5eTVfMbPq+PMfPPDo2QWiYyY81riLYh7UqljfGL7Gvu/xpyBykajfBKlh
         WUD7XtSHAoZMqvCntmNKGtndzNkMw7h2q6ugdPJrasEjLGlOADYbtTMkV6GV4aW7tBvk
         3b8Ujxd30JelF/muKUwIzvYCaGcNBmAzMRLJOgtW9uOQ+3leqsOR4EcJXVc4VI1n+8ne
         P57TxwPIwgXk9LgfNF6O1LwWpr2sSDp2Rj/GuOoLccheS3LmCsCR+v6VgUHPJ8PNYlAK
         3zH6RQmgSvxpMHYaIdpKOnbW3Sylfry/4bSiBoRI9dDTN6UknbsnAFpwppxq6e4GWTTP
         90Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712360661; x=1712965461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzcd1UZQERfxvTBnVGRGRZ63pCnV3q/1zmShLREA7NM=;
        b=aXh5Ne4qMmEch+FCDDs0IfiXCmhaFrxaIYIXJQHaJPf9883A8gphP63h4L3TfrJ79V
         R43ePlPg7ZZhPgSSWNioYKVVqCeZo/XJuhTS5ZeRPEUq3Oqy4kK1xqz9SXxKonje2yF4
         PTpkYmRTBqiK6WJDuBqw0Xa1SyJpWbITe1gsFb7fCcYnpZnFSre47nKNhvHeWg7slsxv
         fjI/RSN04wupJ5jkfgxpy6/m1DfvQE+jCWDEraPL0V3DZRx1Kexr/c5jTozMowSA/F4q
         4HBmP1mRhhaqvZ8UyN4paTpyO21v233daRRt4UVZz3V8Qgz6Hu1bjBE18+VRCQ8I1XK4
         UiQw==
X-Forwarded-Encrypted: i=1; AJvYcCUmqdhlPLcS98kNxGuNBv6CH+Yg77Mt6xHDconB/9pTOvLOMQ4Kqjg/QM/hO8t+G08TcdWiqe6ggnLhQFwXn6J+HjNmwUO3hzqH4yNF
X-Gm-Message-State: AOJu0Yw04GornLydIyhZ0SdWGTh2ksTf8HWTYnhLGAPXLSqG8rMzF5Dn
	H/nGMG/BFfUJEdcL2Ftrc7NkpoxS4IIBdVSzJz8zoiWHetadtUYcAP/7Vkb20C5xAI/645p3GRz
	g/0uIJ1RNDKiCGDLzC0T3cvxheJb4xJe9t5sR
X-Google-Smtp-Source: AGHT+IFaqFRPN9oSFJ4DwSKUGBnSZ5yHVceduoylc1pLK/WHWMifbp7si8I875NiT0l5NXm9dD4rfMQLYdukF/Cd3sM=
X-Received: by 2002:a05:622a:22a7:b0:431:3d25:f699 with SMTP id
 ay39-20020a05622a22a700b004313d25f699mr47295qtb.19.1712360661116; Fri, 05 Apr
 2024 16:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404175716.1225482-1-namhyung@kernel.org>
In-Reply-To: <20240404175716.1225482-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Apr 2024 16:44:09 -0700
Message-ID: <CAP-5=fUHxvawZwD91u5iGi9KrMNnhDhtUL7sph52nXWYX09XWg@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf annotate: More memory footprint reduction
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This work is continuation of the previous work to reduce the memory
> usage in symbol and annotation structures.  Basically I moved some
> fields in the annotation which consume spaces in the struct symbol
> which is allocated regardless if the symbol has a sample or not when
> annotation is enabled.
>
> With this change applied, the struct annotation only has two members -
> annotated_source and annotated_branch.  The next step would be to
> remove the struct annotation and to have a hash table from symbol to
> each annotated struct directly.
>
> No function changes intended.
>
> The code is available at perf/annotate-diet-v3 branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (9):
>   perf annotate: Fix annotation_calc_lines()
>   perf annotate: Staticize some local functions
>   perf annotate: Introduce annotated_source__get_line()
>   perf annotate: Check annotation lines more efficiently
>   perf annotate: Get rid of offsets array
>   perf annotate: Move widths struct to annotated_source
>   perf annotate: Move max_jump_sources struct to annotated_source
>   perf annotate: Move nr_events struct to annotated_source
>   perf annotate: Move start field struct to annotated_source

Series:

Tested-by: Ian Rogers <irogers@google.com>

using -fsanitize=3Daddress. Only nit was noticing 4 bytes of padding.

Thanks,
Ian

>  tools/perf/ui/browsers/annotate.c |  15 ++-
>  tools/perf/util/annotate.c        | 174 +++++++++++++++++-------------
>  tools/perf/util/annotate.h        |  39 +++----
>  3 files changed, 123 insertions(+), 105 deletions(-)
>
>
> base-commit: b6347cb5e04e9c1d17342ab46e2ace2d448de727
> --
> 2.44.0.478.gd926399ef9-goog
>

