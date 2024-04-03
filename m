Return-Path: <linux-kernel+bounces-130662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD3897B65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA961F22224
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD1156895;
	Wed,  3 Apr 2024 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPNvnxrz"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5A155A46
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181721; cv=none; b=s/32J4F0TJHDXsN6Cl9h+kBJEP/MasGD6On3E/jPCDKFRVtwGj+x2KVpqn85uQUvr5hFvMSvlryKVW0yLrJcwUmhSEobAcFbnGnUyqcERY3sCZUzuA+bRJQKifz7Z2WovXowKlBepuWtp1ybfZ8InuhBUem1wuAuVAAhGjOXgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181721; c=relaxed/simple;
	bh=+h6c9e8vY7S5gEy5iyD10DodVMddraJYwQPYxHqB5ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiohgZ9Yp4j09GG7vG8PgrsRm0V2jWLc1GhaqalmosFHxZlXbGgCvj/zH68T+Ty8fV9vi42ySRiCNjT9M50u+ClPYfULUBRAxFSKFQE/H21NrtM1Gx5GYDXb+fqJt5HBEt4OPN9ZbQDTvaCuQc2IcGRKv0gxp6MI7NRIciBHbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPNvnxrz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-431347c6c99so99481cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712181718; x=1712786518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x7hewo1kwhmqVtWofFCVH/uh8qXO7SPEG9obywMj+s=;
        b=sPNvnxrzrTopBOhEULoySfVdyd1igsItKWqnRmrSGn4HbMpeOI6iI8/Yuk+0rcRMSk
         KfTi2AnmC0VdNJASow2XbrRS6KzlokcbW1vuGrkdiilKmNC8bcClQRrjTs81zWDNh6H5
         Xw/mUce6PQhm5oeBhX4ScBX45g8rbMO4hfEV3z8F8vUm9WLYcrpJtDy7r5DgchzwX6R9
         prXFaLotqoJNIZjZMk5AoCc5xiRQn4e/u9JSVEbHxl6NBk9wqguKhfQr7TJYLQQy9/7u
         MmjfMK0dhFolkhhNmDnnw5VzLZ6ZQnyLr0lEfeLtIhTZTHCjqrUYYbN3Mfe9ULvidz6U
         B74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181718; x=1712786518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0x7hewo1kwhmqVtWofFCVH/uh8qXO7SPEG9obywMj+s=;
        b=t+VBJYvNBsXJj7Ald4lRQxeKu/Ns1JgtQLWvPGVhrsMIum/XiQ3l/AzvV31xY1lGPX
         zzLCk50/zC3F+r/n6uLUyFnngQ2PTEnkWtjxEJ0cbgfPPpcEiSWyOrP3z3CMbB+CW2Re
         iKjkrdpP/dpU4y5SogY4PeagNIAYVnVJ7G36FIOcqQe5xPEnHQirUtIrfk/k6j5ag0c1
         IK5ZlPFAg8HzPQtxzfixSlGeXJZbHxvr9V62UIMIq4+6q9islrtV+IxoPUuW11BytUgS
         YICbtEz+6PjhSYJ6v4NV2nIFgoxImQsOMEcST1/WdVoW8dVY6UhilQZ1OQmc3zZlua0d
         ff/A==
X-Forwarded-Encrypted: i=1; AJvYcCXN2qesERLnU7z0xzH+2KGJycEOyob6rcFHZtNVtc9DzC0gx1twHm2yRObgFESV+tyzPUL6L1DgtdYFILcvSQzf8PxMuFeDMbV60G2K
X-Gm-Message-State: AOJu0YzpRss8PExl8XMkJfQH4JfkvleL0NIL4QZXZ7mtRk+yUw1VTBIa
	lHIg3U2iT4xMdO5OQnsK8bBTjutgk6Tihydyi+NHE8svco6lBm1VQ1NjUnE+7mlhRA6nxe0F3n9
	CbU5zzUROWMSTgXxLHYNXNxQI82qJ/hzWmurN
X-Google-Smtp-Source: AGHT+IGN011iXAKkcNnHrYIwpC1awCFVmvQoNNSO8UUp009WjP1q4o+iZL9d3R4LvPef88SbaNm6/JeIOBxY1QQ1nw0=
X-Received: by 2002:a05:622a:18a6:b0:432:bda4:45aa with SMTP id
 v38-20020a05622a18a600b00432bda445aamr512949qtc.12.1712181718505; Wed, 03 Apr
 2024 15:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zg1ywF7uRsfXYfYS@x1> <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>
 <Zg3EOP7ovDge_F-I@x1>
In-Reply-To: <Zg3EOP7ovDge_F-I@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 15:01:43 -0700
Message-ID: <CAP-5=fWKUb=ftSOo-U5NVYsP1WZewnrcYJ9EJPHfO8j_4evm1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf annotate: Initialize 'arch' variable not to trip
 some -Werror=maybe-uninitialized
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:03=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Apr 03, 2024 at 09:01:56AM -0700, Ian Rogers wrote:
> > On Wed, Apr 3, 2024 at 8:16=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > In some older distros the build is failing due to
> > > -Werror=3Dmaybe-uninitialized, in this case we know that this isn't t=
he
> > > case because 'arch' gets initialized by evsel__get_arch(), so just in=
it
> > > it to NULL to silence those cases.
> > >
> > > E.g.:
> > >
> > >     32    17.12 opensuse:15.5                 : FAIL gcc version 7.5.=
0 (SUSE Linux)
> > >         util/annotate.c: In function 'hist_entry__get_data_type':
> > >     util/annotate.c:2269:15: error: 'arch' may be used uninitialized =
in this function [-Werror=3Dmaybe-uninitialized]
> > >       struct arch *arch;
> > >                    ^~~~
> > >     cc1: all warnings being treated as errors
> > >
> > >       43     7.30 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.=
5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> > >     util/annotate.c: In function 'hist_entry__get_data_type':
> > >     util/annotate.c:2351:36: error: 'arch' may be used uninitialized =
in this function [-Werror=3Dmaybe-uninitialized]
> > >        if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
> > >                                         ^~~~~~~~~~~~~~~~~~~~~
> > >     cc1: all warnings being treated as errors
> > >
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > This looks fine but I couldn't line up the errors with code in the
> > tree. I was curious why the "maybe-uninitialized" was failing. Perhaps
> > evsel__get_arch should set the out argument to NULL when an error
> > occurs. This fix is also good but may potentially need repeating for
> > other evsel__get_arch cases, so a fix in evsel__get_arch may be
> > preferable.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Yeah, your suggestion is better and I just tested, satisfies the
> compilers that were emitting this warning.
>
> I stamped a:
>
> Suggested-by: Ian Rogers <irogers@google.com>
>
> and kept your Reviewed-by, ok?

Sure :-)

Thanks,
Ian

> - Arnaldo

