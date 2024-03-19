Return-Path: <linux-kernel+bounces-106986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BFB87F652
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BFC1C21AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338B7C090;
	Tue, 19 Mar 2024 04:19:05 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DA1D540;
	Tue, 19 Mar 2024 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821945; cv=none; b=WkOFD5zH5wUTpKtFpTKDIvF1djCTbIoeWSbBVgN5/p2zrKKA2jeFdDCdmVKImgih3N5qmrixflUQpao8wHEYh5o1Tca+hF9EmgmQ2uRLb8QwSUzAv3NPj8gcC1mXQdUxdMy/pIf5C0jxm78zxR1RmuNaW8tcp15j5BdgtFO9yIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821945; c=relaxed/simple;
	bh=exHMqg7ickwwb5Rk29OIXejwQmnRJaOjOa7LfvyI65M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqomxxDPgU2JTT6jzBkb3wpZA/dsn+urdM6UrgeGjvdIYye8RUE4o4sTAttK0WPbHzAzjYHIY5nIX7Yg8lXMrMVlvDv7vYLTtPGZcLjSdukptb95QfH5OIp81h0fE9st90vKQx4QXGG81GtKMubtP+wpzlXmb10PcrSB3dhL3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so4629046b3a.0;
        Mon, 18 Mar 2024 21:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710821942; x=1711426742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgW4DmXI0kNiY/rl9Qkr5feefQ8+Vq38v1bD2ufKIVI=;
        b=kHSALl5bI+Qte9CJczvwjqepgT/l6/yA4iuqaGq4dx7QRvWcvjBTaTTp6MZCiHzZkf
         EFhnjxZaTLp6M5lJClhFp28RRt+1IZuNlYYMBKiCTxB1tvPI+VR4YwLE56GFleXdJ9mA
         t3EiFUw7O93NJIsRggqmI9sz/hfWtOWRasej5gv9EYRqSoq2hDy7ZMSZh/tlisD0cVkN
         YPGlqy4jMpLVghRRLqGzDHfiICkcVCamWwsCbWzd+vBHdM5G4MKPu/N1wZav6FXcCjq0
         o+X52mX9R5NfQiWR2vQ/6/YU4UHhAxyV7gLNHoNzZCWNtE6j1LvjdrbrujOIc97Nvd06
         WKvw==
X-Forwarded-Encrypted: i=1; AJvYcCUvx+pzIZJkYgiBDGjP6MXZV+/5rW8uTaxFWbOA2K/YkqHIKzqo/wr+5jXpZWWCGWJdNvpwXuz2pSEXUSkcgXTR3llftaXEWxR7IikjQitwdmCFfYPkSxvhGiwlcJlsIvNeVg/CYyv85SL/Pcb8ugU59GS0/tFRd0CtkE7iUaz2ttkzyw==
X-Gm-Message-State: AOJu0YwROynF9mB7iZlfnoUJwFi/h5yzQBijbS1ocei/HGL33vs7UCTU
	mO8E+OSB/M/aRSiWFYOZC1n3+OovSkntKDEqalqfp2W1ftq92uVB/1fwgpJi6ALfJVVyOB8mlG5
	fpxYCCOlSDCIsnmCbpAKU0H2OuqI=
X-Google-Smtp-Source: AGHT+IFXLjhVkx7WgKBhbzRCSxQWGWWgaBadHRVGM50RAHgFRsU1xXuP336jq2Ijh9SBYvYnOKxkauqh2VsoLKHG8yA=
X-Received: by 2002:a05:6a21:3390:b0:1a3:5465:f98 with SMTP id
 yy16-20020a056a21339000b001a354650f98mr1713631pzb.44.1710821941646; Mon, 18
 Mar 2024 21:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <CAP-5=fVjAHqAHHLqE=3v2bP6S6k98psiuZds7TUTFCT7RgMFdQ@mail.gmail.com>
 <CAM9d7ciPYMd4zckrcgnPtradZ_bvaNOHji1tkkYQu_TTF5=eYw@mail.gmail.com>
 <CAM9d7cgbxHZoaq4ZLCda-6TW5A+b+-8dSrRApk+AjcTVNC5hNA@mail.gmail.com> <Zfi0IJV-OKwyDK0r@x1>
In-Reply-To: <Zfi0IJV-OKwyDK0r@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Mar 2024 21:18:50 -0700
Message-ID: <CAM9d7cj+AzPwH8pjG+_HGfmMSMJm6XjkTgxRBWHNW4LF+XJomw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Clean up libperf cpumap's empty function
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:37=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Mar 07, 2024 at 03:47:00PM -0800, Namhyung Kim wrote:
> > Hi Ian,
> >
> > Sorry for the late reply.
> >
> > On Fri, Feb 16, 2024 at 5:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Feb 14, 2024 at 2:03=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > > >
> > > > > Rename and clean up the use of libperf CPU map functions particul=
arly
> > > > > focussing on perf_cpu_map__empty that may return true for maps
> > > > > containing CPUs but also with an "any CPU"/dummy value.
> > > > >
> > > > > perf_cpu_map__nr is also troubling in that iterating an empty CPU=
 map
> > > > > will yield the "any CPU"/dummy value. Reduce the appearance of so=
me
> > > > > calls to this by using the perf_cpu_map__for_each_cpu macro.
> > > > >
> > > > > v3: Address handling of "any" is arm-spe/cs-etm patch.
> > > > > v2: 6 patches were merged by Arnaldo. New patch added ensure empt=
y
> > > > >     maps are allocated as NULL (suggested by James Clark). Hopefu=
lly a
> > > > >     fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".
> > > > >
> > > > > Ian Rogers (8):
> > > > >   libperf cpumap: Add any, empty and min helpers
> > > > >   libperf cpumap: Ensure empty cpumap is NULL from alloc
> > > > >   perf arm-spe/cs-etm: Directly iterate CPU maps
> > > > >   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is=
_empty
> > > > >     use
> > > > >   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_em=
pty
> > > > >   perf arm64 header: Remove unnecessary CPU map get and put
> > > > >   perf stat: Remove duplicate cpus_map_matched function
> > > > >   perf cpumap: Use perf_cpu_map__for_each_cpu when possible
> > > >
> > > > Ping. Thanks,
> > > > Ian
>
> > > Adrian and James, are you ok with this now?
>
> > I think James is fine now and the Intel-pt part seems straight-forward
> > so I'd like to merge this change.  Please tell me if you have any conce=
rns.
>
> Namhyung,
>
>         I noticed this hasn't been merged and applies cleanly, so I'm
> adding it to perf-tools-next, from your comment above can I take it as
> an Acked-by or even Reviewed-by?

Oh, I thought I did it already, but I probably missed pushing it. :(

Sure you can add it,  I'll do that for the sake of b4.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

