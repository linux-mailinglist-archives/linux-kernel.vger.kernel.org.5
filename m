Return-Path: <linux-kernel+bounces-80237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774B862C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530881C20B99
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B518EB3;
	Sun, 25 Feb 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmSoAl8x"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1D1862E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883060; cv=none; b=BakQJo2x3pqBefJ45OQVvNa84bYxvrt3009DRBeNeCVjT2cAsm/iqPt2jmKDPb+NjdJRDmcnCa3B6H01i98UqqS95uokOQjWV5UqBNeT2GAgujpxtKDDk5AUfEdQQuO9CqxfgGtsUWtdr9KGmjgkRT9UJ5ApKIB48DP+8vRgNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883060; c=relaxed/simple;
	bh=0K5xMPOYequh7ZQp99U8co9tYPwwBbzQ3CMMu8+kdV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq9/XcxTDrn2J6CuBX02+CXMdwwtqIlbfpMCuzkca9KucnJVv/GfUx1Aud38FuRk+FjZWmwG8OylyTF2Ap1q3suJf0ukcW7nRGzjMcL+ajYdyYnh/jIHPGKwtoVu6jOHVzFZ/hmHbvM24LooIfIoGAW0Lerpd8lvhO2d5K4y36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmSoAl8x; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc744f54d0so163895ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708883058; x=1709487858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qStKuBILkLY1v8oXdUPbeQuvbfRqjxTb+0Ot/9pOfvc=;
        b=cmSoAl8xMrLxnh2LpC+Vcwyk5RHfzVdB4lZ3GKIPeTqCqpMglEj3/ZYv9a9N+w7uif
         avTr62blqQcTHzI1nLp16p2rQsi8ilC6I+Jr+DIETdXon4WagO/wEDw3zX17oCGp4ugG
         +FwMRcsHS7UJ9CGc+4cxOZwrN5QoDlNM0Pw1wvcFzsycRLkIUgrjtBURDKFSjDJbc8RP
         za6xZI6L/rtrJRx0Y/hfOJQNyOynDrR+rTFQ3J6Z2Z3wlCsWb9+bua2rJNPjU99EB3fg
         LbysNdpYiV+99iip/9inGO3UQ7J1ubskXBvk9m6ByLOatAFPCZR/jL5hRttv/pUhxkLH
         M86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883058; x=1709487858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qStKuBILkLY1v8oXdUPbeQuvbfRqjxTb+0Ot/9pOfvc=;
        b=wHoHpMZWj6LO4Cv9eZsfq/nYKZ7rWHeISoeA5V42PMINdJVFuXGqC/woYbLdnFs5p+
         CnKG3njOpZcyCRsgtmywnWJ6mnetmLfAm+d65jT96cXMTqunOapKdp+eUokkQZOn2sV1
         lawUdyZCBPq2fMizhFh7rWLk6i2OcznZTi5fHbMvm6IIBRMfkDEAIlt0+Y3unQ/jFg+w
         Wb0sIslUREn8tknQboEM6sJ7+d29+s+xtTt9VpZB3f2aSey4HwnZtWqDQgtdKTfEegIP
         kiOASv0pLnJZpRkpDUEr7idi5/MT3cAZqozPu3Tp4uibKrcIReBM+JIcG9FKtKpw+6FT
         RiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzttjzXZk4EkafFMlKZ6N3HgEaPPMOJ/XWOPTcSAFWBFiC8qU+SHvvSQP85H3lsGzWc/evHvFAZ+B5CLioSfWlQSKrGfoBTaIm5HZi
X-Gm-Message-State: AOJu0Yx7sWyijimdpQZ7che5SVKzba/KUTYb/LLaBt/7mTQYE70Lo2U0
	/rEndlu1tx7ecAF+4ahc7V8fb7urRLWrWRjKWleDtVmDK8sYq29luimbSdg8CVUK3vcD42Bn7Q1
	rV1g/MDhD0MHj76ykPOkYUFGyG0I7P605pncJ5B2/lbdPb97Bulot
X-Google-Smtp-Source: AGHT+IErOGEY0ni+ULakJAaE+x5eBVu1gsfbzxfzy3KLUCvMo87Nc+2OWz/bDWgTxXZssUbPaDS0WS4CaFvvsNOJJik=
X-Received: by 2002:a17:902:fc4c:b0:1db:971b:cb62 with SMTP id
 me12-20020a170902fc4c00b001db971bcb62mr239463plb.8.1708883058352; Sun, 25 Feb
 2024 09:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
 <3e1ed5a3-55dc-4652-936d-fd36e0442d79@wanadoo.fr>
In-Reply-To: <3e1ed5a3-55dc-4652-936d-fd36e0442d79@wanadoo.fr>
From: Ian Rogers <irogers@google.com>
Date: Sun, 25 Feb 2024 09:44:04 -0800
Message-ID: <CAP-5=fWEQdgOsVioWEHr6QNPv81r6VjAR5vyA3OGSuF09RsXBg@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 7:42=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 26/08/2023 =C3=A0 23:32, Christophe JAILLET a =C3=A9crit :
> > The commit in Fixes has reordered some code, but missed an error handli=
ng
> > path.
> >
> > 'goto err' now, in order to avoid a memory leak in case of error.
> >
> > Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load ti=
me")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
>
> Hi,
>
> polite reminder.

Apologies for the delay.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> CJ
>
>
> >   tools/perf/util/pmu.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index bb2ca29cd7bd..8dfce84ad9fe 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1018,10 +1018,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_he=
ad *pmus, int dirfd, const char
> >        * type value and format definitions. Load both right
> >        * now.
> >        */
> > -     if (pmu_format(pmu, dirfd, name)) {
> > -             free(pmu);
> > -             return NULL;
> > -     }
> > +     if (pmu_format(pmu, dirfd, name))
> > +             goto err;
> > +
> >       pmu->is_core =3D is_pmu_core(name);
> >       pmu->cpus =3D pmu_cpumask(dirfd, name, pmu->is_core);
> >
>

