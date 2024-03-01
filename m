Return-Path: <linux-kernel+bounces-87806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21386D946
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC0F1C22757
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B138DFA;
	Fri,  1 Mar 2024 01:58:23 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42437170;
	Fri,  1 Mar 2024 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258303; cv=none; b=fyvsDEMwpeMs8PTdqhsy2oI/zpBzfe4xiOd6iUKxRkcZQNNIWk9RL62He/8BOlunigYM8KfxbT4Itaa6JxG4imKdgeYES++FF3ZJY0baba/S+Hi7qB0ztYk/ZUkPA/WVsD1wz++idyB+rUp2RMrIuSALav93GiQQ6dH1qgsg3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258303; c=relaxed/simple;
	bh=eZfBHYPQbzyr6htmGPo+G4dWIZmVpiVWcBLyYoqFi+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn5ChBa1RbL8Q4nWl3BKpdOUUAGgft+EN3fbZ8/CGLBF7pWAZonc0C+fClUa8jtIrIjP5qrGFOWSRJT+cAysmnx01IeLhS6e90qyDkjaOiE5LjQcpZ85ZvWqoscgLpa8PxwobcQAkiTEUVXCwX9WbxTyKeAtCJS/KowWxdeFTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e59bbdd8c7so1069019b3a.3;
        Thu, 29 Feb 2024 17:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709258301; x=1709863101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCciYHd42E4g6ZjxWDiBUw82i6fON/6oZmSRriGXxDI=;
        b=dwivpVfkltt6npLevvmMxXL/5UgTsC4UZI6BJFx79xnAo7dNH4IDo6eSY4kM62Zs6B
         8YBIXCDbmoVz1kCPVUBlDVeblOnRb3ZtwqSSRIjfxm91pA2J7K6ohrztUNF2cFL2howA
         u0q1bwTQlPtp418g/UYD6hjoAmVRh3sXeWrI6NiX5eaVnky0o6nkT9Sv6+VlTX0zMMJ6
         nisJJQSNWQpdJdnyt9Uf+motxryR8m6MdSlc6/TyyHAYP9fr5YMAmkD/RXNSpB44pvGT
         dqI+18yaaUgOB2WeHgG/450fTLRBC3qRKeiFHkZezRnlI5RPuvdzjoiaawjC3hoD14ZW
         4xtA==
X-Forwarded-Encrypted: i=1; AJvYcCW4t0kDSCBLjrtnGs1T2gtjjHsgkup0fYZ2v9XPGCd9QpDsmmozVAi3yAKUQhJ4OLIvJVpBdo3bVojJYxrTPpb7CppMtdBZ8S6kUx7gvQ1OZ8/5cN4PpZg/C8B+4prY8R6lfFRXXtUCi/wArWMZtw==
X-Gm-Message-State: AOJu0YzEp+qek2EpLcCIiWxiBL78wTJLo9Umg3Qlam1Qx9IFVy9pUIqH
	zGlxjUnbGDK43XeA7zL8Qy5/S29+79fOffFVHientLY6HM3hx+QPaKJXjinjXXpUel9QoKVtS0E
	bMvYJ3G/Ms5hgoPtYfzYgDrXpNLw=
X-Google-Smtp-Source: AGHT+IGhpni+tcpLva4QkWqGpffSbO9Peq7uPGxoTeoQ4Q5KyOCV/QplsTat5Z/hSqlF1u3fLUTrpbcxqMsfKoUXSuk=
X-Received: by 2002:a05:6a20:5483:b0:1a0:9117:5892 with SMTP id
 i3-20020a056a20548300b001a091175892mr252723pzk.15.1709258300815; Thu, 29 Feb
 2024 17:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070757.796244-1-irogers@google.com> <CAM9d7chNekmdJyPbOOzZVhR+cBWajscSg3pVFKN4A4evKwFXjg@mail.gmail.com>
 <CAP-5=fVWC+MeeUcNmofkQi766se4P0ERGz_+L+7uTFUXocwVvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVWC+MeeUcNmofkQi766se4P0ERGz_+L+7uTFUXocwVvQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Feb 2024 17:58:09 -0800
Message-ID: <CAM9d7civC_xYw11pJc-4T2R1D=Enf0mvjLtdU5qXxfS+zB2qJQ@mail.gmail.com>
Subject: Re: [PATCH v1] libperf evlist: Avoid out-of-bounds access
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:06=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Feb 29, 2024 at 1:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, Feb 28, 2024 at 11:08=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Parallel testing appears to show a race between allocating and settin=
g
> > > evsel ids. As there is a bounds check on the xyarray it yields a segv
> > > like:
> > >
> > > ```
> > > AddressSanitizer:DEADLYSIGNAL
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > =3D=3D484408=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x=
000000000010
> > >
> > > =3D=3D484408=3D=3DThe signal is caused by a WRITE memory access.
> > >
> > > =3D=3D484408=3D=3DHint: address points to the zero page.
> > >
> > >     #0 0x55cef5d4eff4 in perf_evlist__id_hash tools/lib/perf/evlist.c=
:256
> > >     #1 0x55cef5d4f132 in perf_evlist__id_add tools/lib/perf/evlist.c:=
274
> > >     #2 0x55cef5d4f545 in perf_evlist__id_add_fd tools/lib/perf/evlist=
c:315
> > >     #3 0x55cef5a1923f in store_evsel_ids util/evsel.c:3130
> > >     #4 0x55cef5a19400 in evsel__store_ids util/evsel.c:3147
> > >     #5 0x55cef5888204 in __run_perf_stat tools/perf/builtin-stat.c:83=
2
> > >     #6 0x55cef5888c06 in run_perf_stat tools/perf/builtin-stat.c:960
> > >     #7 0x55cef58932db in cmd_stat tools/perf/builtin-stat.c:2878
> > > ...
> > > ```
> > >
> > > Avoid this crash by early exiting the perf_evlist__id_add_fd and
> > > perf_evlist__id_add is the access is out-of-bounds.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > While I'm ok with this change, the real fix would be changing
> > evsel_store__ids() to use xyarray__max_{x,y} for fd instead
> > of cpu and thread map numbers.
>
> So I'm not sure on how to code that fix. Could you take over looking
> at this? It reproduces for me with "perf test -v -p" when built with
> "-fsanitize=3Daddress".

Ok, but now I think that the fd array should have the same dimension
with the id array.  I'm not sure where it can change but I'll take a look
later.  Let's apply this one first.

Thanks,
Namhyung

