Return-Path: <linux-kernel+bounces-67945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D396857377
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8142823A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83508FC08;
	Fri, 16 Feb 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itXYy/Rq"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D51EAC2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047118; cv=none; b=q1IvLg9qud2v++V7Dw0YmExKu7SlI8jHp9mFf0e27PbrCBMRidxzusXNdLX90z5PY2OdWoRPygT38WzQAIa/O+2bNLZuo1nJtbKVwEpFVJIPuvDm2Opve8VOJR481qgGcf3RWpZCrb4lq/Ah1k6bIYdDgnWkxETRCBXE8PrM65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047118; c=relaxed/simple;
	bh=vQYZ59CBPJ0zZaKxUafJy9oOl819GTZex04PI7LYJTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhN8ktvuoSr/IzuvS9hWgD9zeI68r8K+8YfzTST3RhifgHG6lypPAN4r4sGMH/pytU34lJ92KLIHAu3MxQaGv4RWVSolZpJpAgYSuR1y6hFJxz5VqobKc09mPxiIbtxRtHZuZ5Z11yZJAYz0GtxPd2ymLrxU9cC61I3zmXf68cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itXYy/Rq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-604a1581cffso15131487b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708047116; x=1708651916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQYZ59CBPJ0zZaKxUafJy9oOl819GTZex04PI7LYJTI=;
        b=itXYy/Rq5xR2dZ0SWwxmNbF050Kt7ZGc+CuoSlhuVOrM09B5CzBzr/pKW48C+IleC1
         Ni6TcNW/dgOGwS8zIuXIoyPovegCfX4484HfAcRmsyH/xXC/MwCP7bXHiQS33BzHbnvO
         jJ2RqPp+8J7XMIzxwjTro3d/vjfIsSCSMxMcC5y3KcjZFgLcyNepZuYsfx9L7DCFUs42
         YndcgXzcwCUozf5IF09tonQE0uZi8MO1wqigD3esitbGlGMdFeD696PiO5Q0/+14tWVd
         llLA9gufIaSzLK6IWTV1MG3b10DekrEKi+A4MEJGrw2KlCkFhNA8CXGdlQ6Mi6xYoX2+
         nlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708047116; x=1708651916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQYZ59CBPJ0zZaKxUafJy9oOl819GTZex04PI7LYJTI=;
        b=GM44meqp1vu/unLKv41QLntZaHqalqz86JqXV10Z1LWi9Wt0FD6D506dgScaZREG41
         R2p5waPBO/9jXx6f1mGoygi5gO5QqubR2UCcc8lrUye09hgVMVanQ3EhFtejul79GL5B
         kQCDpUXxLh21px/WTcOHoMnNyd1aZ7nchKjAciqkxI3oixZ5SQ82t9mXSiZfJh6Btkse
         eCqNjSwpRAlV0nPPhI4cWb4ZgiK05Ca90Q8uPxX9wGx3FxxfnPhKbGw/HLwnR5QMVSbO
         jyhh8J4fA02Y5j8QXkv1Qfg2XiMWy2WvIxPkweYHw/obZgnV85qibYqJiDBu8mNQuNla
         cFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVs0kb51QgUdHzoj2A1oHeTSId5Ia8to5RYrIF61jzuJVlA2EGlhBff+NwuWkFDMyx/suVi+Rwz+aeVfRYnyUZSehVdtpjfvg4RJiZd
X-Gm-Message-State: AOJu0Yy4phv4pudCEAYCRMPfTuI24tqY6++spf4J5fTN6eSpxS+yRAky
	svWTf3IwiyzhF8Li5fNfs84BZ+f0drljIzYUeowEh4DGnKXgMkPwxJn4rBPvm+v/Q8ohXZWdtNM
	FtbJ3OoP8UN/AIUcvIW/4IeyrACvl51AgInYt
X-Google-Smtp-Source: AGHT+IF+os+iVX+7zsmj7iVNhReDfjBM+88HnPVkAqSYQi8klRBhu58CiKhLghxzSpctP7q1yEcL/Br5ckIrQQwfWyg=
X-Received: by 2002:a0d:d905:0:b0:5ff:9aa1:8970 with SMTP id
 b5-20020a0dd905000000b005ff9aa18970mr3787864ywe.34.1708047115685; Thu, 15 Feb
 2024 17:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz> <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home> <jpmlfejxcmxa7vpsuyuzykahr6kz5vjb44ecrzfylw7z4un3g7@ia3judu4xkfp>
 <20240215192141.03421b85@gandalf.local.home> <uhagqnpumyyqsnf4qj3fxm62i6la47yknuj4ngp6vfi7hqcwsy@lm46eypwe2lp>
 <20240215193915.2d457718@gandalf.local.home> <a3ha7fchkeugpthmatm5lw7chg6zxkapyimn3qio3pkoipg4tc@3j6xfdfoustw>
 <20240215201239.30ea2ca8@gandalf.local.home> <wcvio3ad2yfsmqs3ogfau4uiz5dqc6aw6ttfnvocub7ebb2ziw@streccxstkmf>
In-Reply-To: <wcvio3ad2yfsmqs3ogfau4uiz5dqc6aw6ttfnvocub7ebb2ziw@streccxstkmf>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 17:31:41 -0800
Message-ID: <CAJuCfpE9gys=A8A+A9ie92uJXLeYVNyZGGVgxizjEjmRGtjdvg@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Feb 15, 2024 at 08:12:39PM -0500, Steven Rostedt wrote:
> > On Thu, 15 Feb 2024 19:50:24 -0500
> > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > > > All nice, but where are the benchmarks? This looks like it will hav=
e an
> > > > affect on cache and you can talk all you want about how it will not=
 be an
> > > > issue, but without real world benchmarks, it's meaningless. Numbers=
 talk.
> > >
> > > Steve, you're being demanding. We provided sufficient benchmarks to s=
how
> > > the overhead is low enough for production, and then I gave you a
> > > detailed breakdown of where our overhead is and where it'll show up. =
I
> > > think that's reasonable.
> >
> > It's not unreasonable or demanding to ask for benchmarks. You showed on=
ly
> > micro-benchmarks that do not show how cache misses may affect the syste=
m.
> > Honestly, it sounds like you did run other benchmarks and didn't like t=
he
> > results and are fighting to not have to produce them. Really, how hard =
is
> > it? There's lots of benchmarks you can run, like hackbench, stress-ng,
> > dbench. Why is this so difficult for you?

I'll run these benchmarks and will include the numbers in the next cover le=
tter.


>
> Woah, this is verging into paranoid conspiracy territory.
>
> No, we haven't done other benchmarks, and if we had we'd be sharing
> them. And if I had more time to spend on performance of this patchset
> that's not where I'd be spending it; the next thing I'd be looking at
> would be assembly output of the hooking code and seeing if I could shave
> that down.
>
> But I already put a ton of work into shaving cycles on this patchset,
> I'm happy with the results, and I have other responsibilities and other
> things I need to be working on.

