Return-Path: <linux-kernel+bounces-102789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9087B74F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CC91F22FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAFDDAE;
	Thu, 14 Mar 2024 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nh+tgZg+"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF58F7A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394537; cv=none; b=TGPvQNHj24Xb8ogQ6IqrYhr1g0lhAo3DLGV5EVlndM3VHhQOrNmO9XvMPjG/8HqhFX6DKIUhyissZ4GchZAacB4zxEWvgmFiYalnf6RVL6pjmh9Qjx0sQR6ofReNr9S4NzyrUSc04SsPRsIt/Kfv84MwK/i8M1s/0Qad09fsFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394537; c=relaxed/simple;
	bh=xy+yihGYgmGmElHluWjV+klBZIrdr8SZjpVJJwUTbRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9BbEztw1ENn2AMj4neWtsh11BTehJhNd7CacZf8vIxWX66LFB64xFzPlttVeAD9TCh+NwriIJ5ON/MEZfYhqeBjdyyhwyow49ORM9OGsbAI80OCoHamvU2eqZHkLnt/t6Y4pV/N2SbpYgt/55inZF0VRH7UHkibvnq5NE+zpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nh+tgZg+; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so44965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710394534; x=1710999334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRDPxJVTHieOMR3Hi1d1OF7eIKdaIqrR5LQQJbNyQzY=;
        b=Nh+tgZg+lhnywmiFpFav38vo/wDiDXwzTtJHxdkkOeW/7BEeI2t6kWWQPV0UYeKyfP
         BwiOjCHhWvOGDQoeRMVdUwnUoN1gmA0EIrkrTut6vD6VIaCrEm4R92D2T1YTQV9PgMqa
         sqLjD1aF9PJgUDBank0O1Vkk+KJb0fSN/QGqkCyHZI36EeSElW+oQi3C+aFfgYFV0ehx
         E4wYLONf3c84wj6I2FPSaDpC3/vUWL07aoxDdH4u65rSNf8nIohDKsV0t7JGbjTtIlHG
         Q/LrrS8xIUsBACIbHPXR2EXe1UXxZEaVwaN2POTPYWU1EX9kaA/GFyjx8Obd661HcLZ3
         l8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710394534; x=1710999334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRDPxJVTHieOMR3Hi1d1OF7eIKdaIqrR5LQQJbNyQzY=;
        b=AjGJeHVdAtLrJWgawnad+BWBgVpuEbwSTzceRAAmZ0CEN1uAYF0cGdy05VqAI2JN5K
         FfReu8fp8z+iFJAV9PVdsEiIjcX3elYUY9GMwRE1lmciDQtwzEcbEscNTSch0tHN3n20
         RTyti9HYw1S52LNdXW6EFfOaK2eCT3HmrG9yq+mI+//SQiznRCUOsLMNv9CQChtdUgPS
         Xp9tZhl6DNov5wYIoseMxB7OWrwVrA3vXyyke4gwzRa4ZQVZl32un8iDyTckNr55539B
         Lu8qJiRymO/QURn4/enbbhjinnu9fRXEmjdXa86TPczGtXCMbOSjMfeBwUgWEPcyqn2J
         ryoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi5S0PthzYbjmIk/s4549GQov212UzyylIHgUqLg5tU7+eYrIvXeAV0PT/f9jl4HdQ88ap4HC0oniqwPmlqBghbZ5OnUViD/sI1hBC
X-Gm-Message-State: AOJu0YwNPG7jBorr/vjnNMrOXXVHzFbgwZwiH/7w9AER3RFUJQA9csb/
	AYL/4rrz5WhIwNj2zNiSPCd13ogx4H93ohygrVFEY24BqZ+RZje0mm8OgtsW/Epzr1C1TMVoL75
	Ja6Vn2dgD6HhtzLQ07vkIppIjLtUbh47nY+F5
X-Google-Smtp-Source: AGHT+IEJSm5V0OXFp5NUsTIYQhAkR1uFtPgMbLi4oFiAtso/P8YCTZrbfl03711ANo1DPKkK9Dz22Hul1RM1t/ecGX8=
X-Received: by 2002:a92:ca45:0:b0:366:796e:eb95 with SMTP id
 q5-20020a92ca45000000b00366796eeb95mr146084ilo.29.1710394534350; Wed, 13 Mar
 2024 22:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com> <20240302005950.2847058-6-irogers@google.com>
 <CAM9d7cjVE=gH8A4zzsUFwLibgHy=3C71UnFe5SEu-RDFTOWkDw@mail.gmail.com>
In-Reply-To: <CAM9d7cjVE=gH8A4zzsUFwLibgHy=3C71UnFe5SEu-RDFTOWkDw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Mar 2024 22:35:20 -0700
Message-ID: <CAP-5=fVqDEXHaoONKjsaMuDG5B-kH1zX01R3fg7QkYn83LHCiw@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] perf jevents: Support parsing negative exponents
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Mar 1, 2024 at 5:00=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Support negative exponents when parsing from a json metric string by
> > making the numbers after the 'e' optional in the 'Event' insertion fix
> > up.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/metric.py      | 2 +-
> >  tools/perf/pmu-events/metric_test.py | 4 ++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/me=
tric.py
> > index 847b614d40d5..31eea2f45152 100644
> > --- a/tools/perf/pmu-events/metric.py
> > +++ b/tools/perf/pmu-events/metric.py
> > @@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
> >    # a double by the Bison parser
> >    py =3D re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', =
py)
> >    # Convert accidentally converted scientific notation constants back
> > -  py =3D re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
> > +  py =3D re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
>
> I don't understand how it can handle negative numbers.
> Why isn't it like Event\(r"(e-?[0-9]+)"\) ?

When something like 3e12 is converted at this point it would be:
3Event("e12")
and so this substitution remove the Event and puts it back to:
3e12
but it expects a number with the "e". For a negative exponent like 3e-12 we=
 get:
3Event("e")-12
and so there's no number and no substitution. Changing the + to a *
means the number in the event next to the "e" becomes optional and so
we match and remove the Event again.

I'm wondering about having this be a bit more of a parser, but then it
kind of defeats using Python's eval as being the parser.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >    # Convert all the known keywords back from events to just the keywor=
d
> >    keywords =3D ['if', 'else', 'min', 'max', 'd_ratio', 'source_count',=
 'has_event', 'strcmp_cpuid_str']
> >    for kw in keywords:
> > diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-even=
ts/metric_test.py
> > index ee22ff43ddd7..8acfe4652b55 100755
> > --- a/tools/perf/pmu-events/metric_test.py
> > +++ b/tools/perf/pmu-events/metric_test.py
> > @@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
> >      after =3D before
> >      self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
> >
> > +    before =3D r'a + 3e-12 + b'
> > +    after =3D before
> > +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
> > +
> >    def test_IfElseTests(self):
> >      # if-else needs rewriting to Select and back.
> >      before =3D r'Event1 if #smt_on else Event2'
> > --
> > 2.44.0.278.ge034bb2e1d-goog
> >

