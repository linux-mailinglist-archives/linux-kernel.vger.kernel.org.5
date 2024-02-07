Return-Path: <linux-kernel+bounces-56972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB584D202
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C30F28A80E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C88E85624;
	Wed,  7 Feb 2024 19:08:28 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823C8289E;
	Wed,  7 Feb 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332908; cv=none; b=en0sy9cWSAo8WUQ4LhI0gvjd8qmRtlRTdSb+8P5ww7gAcgt1dZK4oZ9iH+jO+/5W+Ri+TjJJpnh0XRzTymrJowuiUU3tmekHBiqgf146qWtsD8R3+Ammfd051qjsT7weXcETPIU2lrKKsv5UgFCs++kYxYijchthTv8h/63VmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332908; c=relaxed/simple;
	bh=gppkMTLUZP2M0ir4y57co003yRnpqCBQwMrit6QAMRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXDKTMpsa5nlQXTBWUu66zTguCcdtUKZIWl/6nYq0KAIXO7vsF8y4bwQ8bs8CoeDhOqU0262IAXKvnj5vmRI5bv2BKGbTaXgsEDaZQj6K7VP4i+aVFj8Ts3RT+B9zBj+vbyGWXpUaoh5G+OtEfYtvgC2n7szQed4IpmhcHMYqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e06c06c0f6so111581b3a.0;
        Wed, 07 Feb 2024 11:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332906; x=1707937706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5NAyJJk2M6nTouAkFWsG1u5nlnAwfDcNyiH/8GXd1c=;
        b=C/4YYI5y9POb1PY8NMjbEC3mSjf2OBAwSBTqXjBZAnEYUiwPn1wPPFVWMi7FR9Lqjg
         /MorQX9dPOW96VdhGztqQytC2RIL0eQOwtiMqm7ZrYriFW/ww3qaZ+XSur6TMC5xCfcC
         PaWMVlvr6OLT0Dm2dhy6pLIIXrUot+3rv4T8JdK+0eW9t21sQeX0iEFalPf9b4nGiRat
         Z1wWA7jDS2NO2tFhIIUrMytNUg8VtaETPB7T7p/UKqFY2DrlOBmjkjHcz3KaurYljpxT
         uYA3BSRZhspXpTpNgwO8KNp7JeYZxitl2/U7tE4xjVBX0YbIaG04WbuMPy3EsSUefccY
         OkBg==
X-Gm-Message-State: AOJu0Yyp2kgXdPl6+Qgru1Jw8Dv8XlLP4tmVvE/FsEILSxWllwMqU5ll
	LlhobANgiLzHTjHCEzGXjqR4Gh+Ga80rLd4Z+dfOCPw4wOPEFStHmm1kJBXtpoAKhVc+vT4Q9Ww
	bZW19QDQH7e2yoGxJFD12HYDbjZ0=
X-Google-Smtp-Source: AGHT+IFbDa1MkIhin+YrCea3UDRAWki+bDn7OQtqgtmEhvXnmb3mzN9FOwFGws3FiO87xF1vQI6cvCXFaGKdkJVwvJA=
X-Received: by 2002:a05:6a20:438f:b0:19c:9e7d:3f4e with SMTP id
 i15-20020a056a20438f00b0019c9e7d3f4emr891189pzl.1.1707332906015; Wed, 07 Feb
 2024 11:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-15-namhyung@kernel.org>
 <CAP-5=fUWaKW7d6_YkET0o26=fjBwX6PPJ1gXQ9wndQM_Oi2O3A@mail.gmail.com>
 <CAM9d7cgF_PYm2fG1Vgu25u1hVZUK0wmFBqY7DHW2eVpRV=iERA@mail.gmail.com> <CAP-5=fV7fWHM53roUJOU+0vAYQJAbhdE1EkgzHLv7jPgeLc2HQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV7fWHM53roUJOU+0vAYQJAbhdE1EkgzHLv7jPgeLc2HQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Feb 2024 11:08:15 -0800
Message-ID: <CAM9d7cgV-c2bLE9KGSA2qTHNbzGriQo9NqYD5k177+46e51pJA@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf annotate-data: Add stack canary type
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:40=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Feb 6, 2024 at 3:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Fri, Feb 2, 2024 at 7:21=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > >
> > > > When the stack protector is enabled, compiler would generate code t=
o
> > > > check stack overflow with a special value called 'stack carary' at
> > > > runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.
> > > >
> > > > While there's a definition of fixed_percpu_data in asm/processor.h,
> > > > it seems that the header is not included everywhere and many places
> > > > it cannot find the type info.  As it's in the well-known location (=
at
> > > > %gs:40), let's add a pseudo stack canary type to handle it speciall=
y.
> > >
> > > I wonder if cases like this can be handled by debug info rather than
> > > special cases in the tool. Special cases are fine too, but are
> > > potentially less portable.
> >
> > Agreed, but I couldn't find anything special in DWARF.
>
> The fs and gs selectors are commonly used for thread local storage, so
> could something like DW_OP_form_tls_address be used?
> https://dwarfstd.org/issues/110803.1.html

I'm not sure if it's the same thing.  Maybe it's for variables with
__thread annotation.  I don't know if compilers generate a
(pseudo) variable for stack canary.

Thanks,
Namhyung

