Return-Path: <linux-kernel+bounces-155988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0EE8AFC66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4D31F248A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F936AFE;
	Tue, 23 Apr 2024 23:06:02 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130B2E63B;
	Tue, 23 Apr 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913562; cv=none; b=fyvYzlIZZdMr2NeFiumAMfgkU/GBkvKrcKU7tLqTAGjX4erThPKGSHjmEfC3Ir0gmf48QqGT5KiMfJPxVSJCKwNBGg193z7piGGbp4UJ+3HO5OZwLDtULKMu24Rwn1vW4YZKznRK/MCDTeJQs/TqtckwkSWkmeuvbjEizHDT8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913562; c=relaxed/simple;
	bh=pHxTJKih1qDRp89Nf/sFqg67Or1LrveJzBXmaE0kgic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAlQjrlqpEEwNwsg+ALPi+0I5Fd78BVQXsmeG95kCJYRxpfK9VOuCG7tTph3KwwDY9SuSMxCJtkc87hchudMDGz82ANpxByEywGFYnVkHpXwYqZF6RGjfp7ppcFh6I2RnuEjZ81jCkAp8ocNiBWatm6dgDr2JIx64ZSrI1jAtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so5198197a91.1;
        Tue, 23 Apr 2024 16:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713913560; x=1714518360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fesNdAlMc+WBAKd6UgQ2Xc2bJErGlYcbaUo7uByooc=;
        b=IwWnXic0zd59+ZSG+yeVa2cwm22uGWXEJm6oP5aDuABcIR7hKSFSdtrZj9rJYPFqku
         if+pVqz3z7psXX02lJeTTOHgWbgmpBXFsfLwQsvoulXUG2HeimAbN5IywNjBcM64ycqs
         Gi85ojFmbJRQF7jszq2S2L2t3wRE0LUn44APojanFX9CAFuHUYazDSF0/0vHFNkVCE7A
         4u0kmCYheo12vhqj4ORP4g/WLmhHzFYIwfeQ6EnXGdP+Z7V5xgxc1LsXDsPLdGfwbb1q
         V6y4//hulJrVH+vCLqf19EapphaM1l+RgjFOrezhPuR6rK89upfpitstfhZqO4BuvoC+
         FA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNZbWu0JkCvcXvdp74Mp3oks/aq0F51bmia7uUU3YZLgvwBrnznnvFwYPqxbHMiTUcvaoO8BgsS703w9JCkXZK4kG2p6W69M3yfeBqHesAhkkE26ZCCrs4bvpq+yb5/MWAGKKx7lksZofAKesTYg==
X-Gm-Message-State: AOJu0YzPtxYXaA3JDxxH+T9YwRFb5znQcdqfj2axyeQdSBcbRPki9bJa
	n3XRKszADkH28rqbK5wvR59MHaeFck2FSGKPc2tkKBCzg6qE8hmFPcn6hTzfJSvUcFPceSx7Kr9
	i0WD22+Eu9g1NJLhXyoHsHuKw/Zs=
X-Google-Smtp-Source: AGHT+IHwem+u3vmHJ1rceM54yBj9AQ2TqUqAXcJy3QOasANefHMiEKC94No2RktSUpGMCYTy8uNvaaCGx4qLBsiOlQQ=
X-Received: by 2002:a17:90b:30d7:b0:2ae:9a80:9065 with SMTP id
 hi23-20020a17090b30d700b002ae9a809065mr722897pjb.28.1713913560179; Tue, 23
 Apr 2024 16:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com> <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com> <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Apr 2024 16:05:48 -0700
Message-ID: <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:16=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
> > > > > -static int __run_perf_record(void)
> > > > > +static int __run_perf_record(const char **record_argv)
> > > > >  {
> > > > > +       int i =3D 0;
> > > > > +       struct tpebs_event *e;
> > > > > +
> > > > >         pr_debug("Prepare perf record for retire_latency\n");
> > > > > +
> > > > > +       record_argv[i++] =3D "perf";
> > > > > +       record_argv[i++] =3D "record";
> > > > > +       record_argv[i++] =3D "-W";
> > > > > +       record_argv[i++] =3D "--synth=3Dno";
> > > > > +
> > > > > +       if (stat_config.user_requested_cpu_list) {
> > > > > +               record_argv[i++] =3D "-C";
> > > > > +               record_argv[i++] =3D stat_config.user_requested_c=
pu_list;
> > > > > +       }
> > > > > +
> > > > > +       if (stat_config.system_wide)
> > > > > +               record_argv[i++] =3D "-a";
> > > > > +
> > > > > +       if (!stat_config.system_wide
> > && !stat_config.user_requested_cpu_list)
> > > > {
> > > > > +               pr_err("Require -a or -C option to run sampling.\=
n");
> > > > > +               return -ECANCELED;
> > > > > +       }
> > > > > +
> > > > > +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> > > > > +               record_argv[i++] =3D "-e";
> > > > > +               record_argv[i++] =3D e->name;
> > > > > +       }
> > > > > +
> > > > > +       record_argv[i++] =3D "-o";
> > > > > +       record_argv[i++] =3D PERF_DATA;
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > >
> > > > Still I think it's weird it has 'perf record' in perf stat (despite=
 the
> > > > 'perf stat record').  If it's only Intel thing and we don't have a =
plan
> > > > to do the same on other arches, we can move it to the arch
> > > > directory and keep the perf stat code simple.
> > >
> > > I'm not sure what is the proper way to solve this. And Ian mentioned
> > > that put code in arch directory could potentially cause other bugs.
> > > So I'm wondering if we could keep this code here for now. I could wor=
k
> > > on it later if we found it's better to be in arch directory.
> >
> > Maybe somewhere in the util/ and keep the main code minimal.
> > IIUC it's only for very recent (or upcoming?) Intel CPUs and we
> > don't have tests (hopefully can run on other arch/CPUs).
> >
> > So I don't think having it here would help fixing potential bugs.
>
> Do you mean by creating a new file in util/ to hold this code?

Yeah, maybe util/intel-tpebs.c (if it's better than arch/x86/...) ?

>
> Yes, this feature is for very recent Intel CPUs. It should only be trigge=
red if
> a metric uses event(s) that has the R modifier in the formula.

Can we have a test with a fake metric so that we can test
the code on non-(or old-)Intel machines?

Thanks,
Namhyung

