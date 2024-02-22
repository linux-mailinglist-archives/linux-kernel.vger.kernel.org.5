Return-Path: <linux-kernel+bounces-76280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14B85F526
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EBD2839A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AAE39FFC;
	Thu, 22 Feb 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlrfBg04"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879838DF9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596014; cv=none; b=QgeVaqQ+gQaOhFqoC6/7xopZb+xkRow9sjiOZKNyTEfbWPQY2R/dbd6DdDPEfFFjD+e+JAQ8Sf60Mp2IfeBm8mQLLDyKdNNK/LUcDBKgIu3PuJ//EvQAfTxdceMJnTG8tUr3p9FvlVgRRweuH4fUYdTrJ0NMDbapTjbwbC6L8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596014; c=relaxed/simple;
	bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwuSxQMkGXYyi+tm7WxNKSQRsJHOC4JFN518JMD63zVzuetnFLdngkLz7/cf21iduOiWIXBNWJ42oR36c9JwNjmSmLWM8j8SZApDx/VYyLUv2VYx6rabLQ9RiH9BOsgxjt4+yfvTzG4QMebwwhZAiK/bDXgdHrwyVBU5Lba7Lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlrfBg04; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4706de5227aso713108137.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708596010; x=1709200810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=zlrfBg04Kyxp5cU/S+Rbn4i0cNrs6fdhkV+J1L6Ak7MObIRgzDD5LTI5LuNGF2wntu
         8q4hCTwDAmLxRhzeMirRlwx0DKzhFbo9x/Y5uQw2oOyNgEAMRmCJphDpNHe9e6POG2Iv
         1RTVfp7AB3h8VKhekGPVT75ZpLxsY4navma8mHg5u2kqQswLFgJ9zMltf/uQfkmsLNWq
         F77rBkVMysLYOEAhZGradAofoWCU5IAU/b5p0v8645xs7xwEWIJfzMg0rtXSIhSR4oGM
         lIE3lNUNHsiZs+VbLbs3KQXmutYvhf0mdMOIwE5L4OKmG86wC5usgZlhfU1kxRUtryLU
         Ok2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596010; x=1709200810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=I8cRFbFJZDnuO+WXtDk41dVsxUz1zstEVgAybrE5xbSlaGUBOZ1UA3WRFOindQ5duz
         P+lin/BVrYQ1/wsMOpkAgcSigo5+1FNhnzxiroxnajvt7oLVb6ihlLbO5euFAdowwgVn
         fKgxYJFNT0OZD5kfw7m0f16yVPFoxVYs6kuWAx+NT3CeXma2ioLcaAHWKr2KarGKI7cO
         +zLJm1zNAW3/5rCTRRtCpotMATisQ3YGcPMdwfzSnt0j+6DA3HQYAlnzdxIs/g+qt/ym
         1kIbhfw9ahwyR/Cbqltnj36Mke18TRxgvuquPwygFTpQKDag/VvpUEBTGSs1LiT/Zzxn
         Lahw==
X-Forwarded-Encrypted: i=1; AJvYcCWbsMQZXl1zvLuI8Me4y/lMbqpKUeT6TvOlNBWliM7WO20PLDCjr+pCQXuR5XEWAP9R70T3PIuoAB8l7kVXr75/fiCLMpPZhcEjzuTy
X-Gm-Message-State: AOJu0YygvjB/qW1ISXz8g1J8vLXFawffAowYdrfoFrimI8Waz2nyvNN4
	qNOPYXXyE3MPP4VQ5pGyiWBVDcFDcemD8SFmOJImW4MgQx2rS6LjtKH1ZV+wGUxt066XA7N82m2
	BOO9nDaamgaeVHwLnlzT8LN+KPSyxgV1BNDEB
X-Google-Smtp-Source: AGHT+IHtNH9SG5kviHG0Zp4ObgcElY0QaPwq/WKIrJZZn0CRZo740etRowxrv/bo9NQSJHSXY5Ib9q+PDO3ajLn3tTQ=
X-Received: by 2002:a05:6102:1626:b0:470:4a6e:4a4e with SMTP id
 cu38-20020a056102162600b004704a6e4a4emr14352031vsb.29.1708596009136; Thu, 22
 Feb 2024 02:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-25-surenb@google.com>
In-Reply-To: <20240221194052.927623-25-surenb@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 22 Feb 2024 10:59:57 +0100
Message-ID: <CAH5fLgiyouEuDGkbm3fB6WTOxAnTiDx=z6ADx7HN3BTMAO851g@mail.gmail.com>
Subject: Re: [PATCH v4 24/36] rust: Add a rust helper for krealloc()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
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
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Memory allocation profiling is turning krealloc() into a nontrivial
> macro - so for now, we need a helper for it.
>
> Until we have proper support on the rust side for memory allocation
> profiling this does mean that all Rust allocations will be accounted to
> the helper.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <benno.lossin@proton.me>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: rust-for-linux@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Currently, the Rust build doesn't work throughout the entire series
since there are some commits where krealloc is missing before you
introduce the helper. If you introduce the helper first before
krealloc stops being an exported function, then the Rust build should
work throughout the entire series. (Having both the helper and the
exported function at the same time is not a problem.)

With the patch reordered:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

