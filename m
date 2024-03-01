Return-Path: <linux-kernel+bounces-87746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D175686D876
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093C3B22819
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB1C2C7;
	Fri,  1 Mar 2024 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aop4EUGo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98054C134
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254111; cv=none; b=ph0Se2n7TV0QHD3uZQ1LfleEYEly6LY6/PMu6sL+vR643GAFqhSYUPbiiFnwqWJNoZOi4BBcgGEp/PCW87N7TaYczI7u8iKTDqqoiiU51OAIpLXXhqBi8s0hG8Tw2+uLFJYbVkmDJ0dmUa+6oreue9VB2DvZ6YXXz8NAya7g+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254111; c=relaxed/simple;
	bh=SBRUs1L7SWjgoe78TnGDqNJlwRB1w1wl2d4Ujn1Z/hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U299qmvOKkKc3Q7tbvig2t0qGaHHIauYcoufgk4sTSxy8CWzKLPW+uFVMNZ3aisQZr76qj0YdxvuGLncboquZezpy8faU6kleGEx27DnSrS99LOX5rd+p4WIAe2DLzCU558W5rYy6ETKDlJjtchJpsMTELR1md8h0t7lbBs5QYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aop4EUGo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbe7e51f91so27665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709254109; x=1709858909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO8hdlL58lho+cQ23ggVJcM5manEQk2nVKwT7YU6wv4=;
        b=aop4EUGoBUup4rblaRolTFgeXEYQVcPBzJX8dtP81PRWpwn87EgWdgNPU6hYRYniiF
         lfSc40LfT/1FjqgpAwURskBL6/TXv1OLo4YAWu915HX+B9g5kHOfHKOAOhkY9l2UsSex
         ppejEXlp/Pk/ZyirEjG84iaxaVZgYqsmtUtRV4O7MqsLxbqY7klMlrbiKSqL1hsbu8FD
         MiGUx9mwDmSq02YeTmlq1GUkZUuLLoBGjX+0CeTo+MOogyQG7lY/eSpL/26pvZ4SlgzL
         KsbLUthQQZtp56j10INHUHEQrQ4M3OCymlLR3hDqE6CVDIJs1q3yAD7Tbs6QAmghAoNc
         o2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709254109; x=1709858909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QO8hdlL58lho+cQ23ggVJcM5manEQk2nVKwT7YU6wv4=;
        b=ikmdfy8chH7ph0wo5/WyhDc9ayp1Y3+wqIwToLMGdiDuDf2tMd/isEIDUuPq5w2s9r
         pqKh4eJMJS9I23G8QYIqNth1sRED0aTp/Od1LI23AY1sNUEoyE8+KyVpibj9m/18F7dJ
         Jt/yj3QaWiTX2cmV537dXRaij4Fswo6ZgkbpSvU6lncl49SAHcDkLDAYdr4kfr6Bxumy
         IdN8oUljYd4iNKBe5fFiM74hYeE8GHxUrx6GrtnvO/IhbpKyxWBED6pchx5fMGj/7pXO
         YtXGO+3oUdyNKyynumFQbFBuiI4LlFSA8L+B716okN3a7CjKnIdNLiH9adhsQ2lCEYCU
         6VEw==
X-Forwarded-Encrypted: i=1; AJvYcCVz/Zti2+UgHcpGkQ7d3WivRpv7UqpLQCw5pkBHJSRE6Ue2FenTXlXFYFmn85iw1+AkBKyPh3wXzSAVMA4QT4PiQCixAioCePHc+iwa
X-Gm-Message-State: AOJu0Yy/2NmWJYGhWVbS1qIyPMOHqJjO6wj5cCF+OTTTEv0TfO6MrkRG
	b5vpIVb44UD5pdBW9NGXZgdohxNhfpVTRQDCWy/dG6WHJPTMyMFpQvPyfTvfa4c2Q+Td7nJlTpX
	ybOSU+5unQuIEe7P5oIewjTffkY5hZyQYAxXq
X-Google-Smtp-Source: AGHT+IFFxmOc6k9DBxoJkuk5vhJt6IT+2D7y4mJDPfThzu5EGp+7Q6h6dIcUN8jbDoO6uDvJHzfh91pSkyjFtw56Ilw=
X-Received: by 2002:a17:903:244b:b0:1db:e78f:4ce9 with SMTP id
 l11-20020a170903244b00b001dbe78f4ce9mr83835pls.24.1709254108425; Thu, 29 Feb
 2024 16:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-14-irogers@google.com>
 <b1ec1953-2df8-4987-a7d0-4758835b5392@linux.intel.com>
In-Reply-To: <b1ec1953-2df8-4987-a7d0-4758835b5392@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 16:48:17 -0800
Message-ID: <CAP-5=fWHQthKat7SZx6P8CeMpjfsgYgp8=+nxvHBMmMVZF9_vw@mail.gmail.com>
Subject: Re: [PATCH v1 13/20] perf jevents: Add cycles breakdown metric for Intel
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:30=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> > Breakdown cycles to user, kernel and guest.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index dae44d296861..fef40969a4b8 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -26,6 +26,23 @@ core_cycles =3D Event("CPU_CLK_UNHALTED.THREAD_P_ANY=
",
> >  smt_cycles =3D Select(core_cycles / 2, Literal("#smt_on"), core_cycles=
)
> >
> >
> > +def Cycles() -> MetricGroup:
> > +  cyc_k =3D Event("cycles:kHh")
> > +  cyc_g =3D Event("cycles:G")
> > +  cyc_u =3D Event("cycles:uH")
> > +  cyc =3D cyc_k + cyc_g + cyc_u
> > +
> > +  return MetricGroup("cycles", [
> > +      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
> > +      Metric("cycles_user", "User cycles as a percentage of all cycles=
",
> > +             d_ratio(cyc_u, cyc), "100%"),
> > +      Metric("cycles_kernel", "Kernel cycles as a percentage of all cy=
cles",
> > +             d_ratio(cyc_k, cyc), "100%"),
> > +      Metric("cycles_guest", "Hypervisor guest cycles as a percentage =
of all cycles",
> > +             d_ratio(cyc_g, cyc), "100%"),
> > +  ], description =3D "cycles breakdown per privilege level (users, ker=
nel, guest)")
> > +
> > +
> >  def Idle() -> Metric:
> >    cyc =3D Event("msr/mperf/")
> >    tsc =3D Event("msr/tsc/")
> > @@ -770,6 +787,7 @@ def IntelLdSt() -> Optional[MetricGroup]:
> >
> >
> >  all_metrics =3D MetricGroup("", [
> > +    Cycles(),
>
> The metric group seem exactly the same on AMD and ARM. Maybe we can have
> tools/perf/pmu-events/common_metrics.py for all the common metrics.

Agreed. I think we can drop cycles in the three sets and then once
then do the common_metrics.py as a follow up.

Thanks,
Ian

> Thanks,
> Kan
>
> >      Idle(),
> >      Rapl(),
> >      Smi(),

