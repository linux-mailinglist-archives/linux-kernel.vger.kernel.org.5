Return-Path: <linux-kernel+bounces-137604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14A89E488
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1681F22EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A30158850;
	Tue,  9 Apr 2024 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rjrrc7Hf"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1012A14F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695137; cv=none; b=Kobn7Z++wbe9uG67CUn2bm57J0o8a/S0W138MwY80kw+JlNwrX+BZc7d9+TaVNdu2ZK9Ztfr9R63lKz3nZ8Meawf7dDzRYY0xVbQJg6PxgaS2NappgxOIRCN4J6CPTaUFcU3bD7oN2kPl1x2ctqpDg1qQMNP/fA14cfw6DRadyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695137; c=relaxed/simple;
	bh=QM3cBIIQLd+S6HuFYGBl+C2WiO/9cnzJr0zApXIOspc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW093anOrp3te4SuyfyrUoY41uuejidoTeiCEXVRTgRqJtJqI//Lf4/3FZK7z3AcDTJ1nYDlc5DndztO3aBQZBbsLtkSOdu6eEPWgvpq08nn1qPzRihzHEywqC9U37sjB0f21z+ijCXXvJP0kVNeT7uOyC7DWv8DUxt4y39+OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rjrrc7Hf; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so7705ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712695135; x=1713299935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEpSynouo13r5lCjoT67i+zVhW/0v1Pag1t/B87ygP0=;
        b=Rjrrc7Hf8qn0R1VWb7/WnojDuByGnJmmvQRv3khyrRJZdEshcUcLtP/wZWvQxrH6da
         S20IgEGIwqh7NeRZ2GTiAVHrbPWckr2D1nevYsD5Na0ehYlqX9chqSRONYVqxl3TPAT4
         X9ZPT1QH1h7hraXNYS2xL+737B55ZiBlBnrhIyQQHk2+S/GSVpfui/Mu5JdrL8n1JL6E
         o9V8rMzFp911SaFZo9QUN2XCgquDxmfPQ9z9n6zjicX4IIShPSDfWTE/wurkJpEZZUK5
         c5p1h4tR6eI6Y38YDlpb1/qHG0Ma+bnaspQKoIi24gZA0uz0lQ3hlEJaOb9/KNjZtGeW
         LpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695135; x=1713299935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEpSynouo13r5lCjoT67i+zVhW/0v1Pag1t/B87ygP0=;
        b=sAJOH0zmsOqOc0Pi22luBiwihwcgf2oqftN/JMVaIV6a15XZqzBtjM4wEo/9UeG5cF
         buHiFwIJJHbLMRwK56jFAf9kX00LpLKYuROzJ6XEue/VS1gE7Aojt07sVLd/s5NoEJ3T
         Ro/rYOUG7d3ZVgHuX2NxkkAlvguCABdg+JAOiUS+S825+Sw26nqcD5XlDyHI0mWtJqIN
         p06TBXNFZYaz4Kyst7W5Gwr+sihS5de7I0wUqnTqqRcZYgIVoGRUKI7CEs3zRSwC56Dh
         VmV3oEF/7Yr+XNavGexT+zoirrH9C/gapWKkFmd0lQs7JKJyhG/kT1zhOsZy/AczqRBi
         GZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXPSC1pmHkGeaxBn1hUpsmiwLDC7JEXGxQVpcQuvA5kbOTD4hlyDTamBCBaEplRkQ7BChmEEM9V8V01goFwDrayK6WEO/5skraOCebz
X-Gm-Message-State: AOJu0YypB3hSzCAlX7vr304p61+39xtYiLcaOihRw6riqNOvCS3VFuGA
	J7ZrPdURpv8eau79e1mWlAAThCvU9SCPgrEXIlv19eH5+303W/QtPWMBxNeciiE2kSsiRtgb0rQ
	qIPOByInL3sxOvCwbcuLNSqAFteULHofe6a9O
X-Google-Smtp-Source: AGHT+IE1uN12iLC9a9nYxOq5JgkhhkK3PZ6feRQDo+9/2sFR2ctnDFUBnPYFvwPkozUuKRizNq4hJSNzfxhWVnXAjZI=
X-Received: by 2002:a05:6e02:3f04:b0:36a:19a6:bc78 with SMTP id
 dr4-20020a056e023f0400b0036a19a6bc78mr6603ilb.1.1712695134944; Tue, 09 Apr
 2024 13:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406073804.1932415-1-irogers@google.com> <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
 <CAP-5=fU=bEvzWw+62HxL=5kOSqQxaBYeDBomv8Fdu+R+fNv5sw@mail.gmail.com>
 <cd4b5229-b938-44ef-822a-68d29c463aa7@linux.intel.com> <CAP-5=fUNTiju7sv5R3P+=rUm-BzL_HmaEicdhCuBVPKooPHWeA@mail.gmail.com>
 <8fb7e240-07af-4c7e-8eac-60731d837bd7@linux.intel.com>
In-Reply-To: <8fb7e240-07af-4c7e-8eac-60731d837bd7@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 13:38:43 -0700
Message-ID: <CAP-5=fW4-uYT=v8U7atuNKUnWx+=2Z+vAyOo_Jy011fuTshqUg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Remove evlist__add_default_attrs use strings
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:50=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-09 12:04 p.m., Ian Rogers wrote:
> > On Tue, Apr 9, 2024 at 9:00=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >>
> >>
> >>
> >> On 2024-04-09 11:20 a.m., Ian Rogers wrote:
> >>>>> +             ret =3D parse_events(evlist,
> >>>>> +                             "context-switches,"
> >>>>> +                             "cpu-migrations,"
> >>>>> +                             "page-faults,"
> >>>>> +                             "instructions,"
> >>>>> +                             "cycles,"
> >>>> "cycles",
> >>>> "instructions",
> >>>>
> >>>> It's better to keep the original order.
> >>> So the original order was:
> >>> "cycles,"
> >>> "stalled-cycles-frontend,"
> >>> "stalled-cycles-backend,"
> >>> "instructions"
> >>>
> >>
> >> Right. The stalled-* events are added between default_attrs0 and
> >> default_attrs1.
> >>
> >>
> >>> but many/most/all core PMUs don't provide the stalled-* events. At th=
e
> >>> programmer level instructions is the most fundamental thing, so havin=
g
> >>> it last felt wrong hence moving it to be the first after the software
> >>> events. My thought was, if we're going to reorder things then let's
> >>> not do a half measure like:
> >>> "cycles,"
> >>> "instructions,"
> >>> "stalled-cycles-frontend,"
> >>> "stalled-cycles-backend"
> >>>
> >>> let's just put things into their best order. It is obviously easy to
> >>> change but having this way wasn't an accident. There's obviously
> >>> subjectivity about whether cycles is more fundamental than
> >>> instructions, my thought is that you get taught instructions first an=
d
> >>> that these take some number of cycles to execute, hence thinking
> >>> instructions should have some priority in the output over cycles -
> >>> some people may not even know what cycles means, it is hard enough
> >>> when you do given the variety of different clocks =F0=9F=99=82
> >>>
> >>
> >> My concern is that there may be someone who still relies on the std
> >> output of perf stat default. So the output format/order matters for
> >> them. Their scripts probably be broken if the order is changed.
> >
> > I think making everyone suffer for the case of a tool that may behave
> > in this way doesn't make sense. The tool should transition to not care
> > or to say the json output, or at least contribute a test. There is
> > precedent for this attitude, the default metrics for topdown removed
> > the event names in perf stat default output - no one screamed, and I
> > expect that to be the case here.
> >
>
> They did, but that happened after the change was merged. And there was
> no test case for the output at that time.
>
> I agree that if the order is important, there should be a test for it.
> I've emailed the tool owners I know and see if the change impacts them.
> But they are all out of office this week and should be back next week.
> I will let you know regarding their feedback. If the order is important,
> I will update the stat+std_output.sh.

Thanks Kan, just knowing if we should or shouldn't care is progress.

Ian

> Thanks,
> Kan

