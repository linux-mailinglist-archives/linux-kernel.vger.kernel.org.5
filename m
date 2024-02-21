Return-Path: <linux-kernel+bounces-75520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043985EA17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD39286E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B51127B67;
	Wed, 21 Feb 2024 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="CD/Z8BK7"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD6126F35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550658; cv=none; b=WYbZxXnmiqcpiWbjEZUwrzwVN/LX8ROdouvD1p5p73vEhuars/9VRRJKty1qqzQZ6JgEtk+N8qNxi7lifWMsdgdZJTJovR7Cea8HkktDAeiad+mdJq3jQsx1QHv5QA2xpXyYdG7xLtNsBkp6ZeMvWzkJekhDjqQj0Ah+prN2HNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550658; c=relaxed/simple;
	bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdNXWjVHWX6BLrVXG2k6tDpZqVRViXsfTWjCo6NfkfIzfUaau0yY+5RFGLnu2Wc6x9GLsU4sWaM+Rmpj3H9KXpSYIreCbw8TLvILdZcn3oi2O6i3WAmxuttQ0k9O7gdAzgKmMDmth41YLxgixrwxv5kly2rcnj9LDwd15iXnvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=CD/Z8BK7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2ddc5f31eso3120964a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550656; x=1709155456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=CD/Z8BK7Rp9L3i5Vl3s2KolMt7yZM3Q7SV1NrREyMTfzFMVwamp0srcydy69ptyQJn
         QXSSqU31Y95owRZ167SQF3FdA3AuKMFckDCDMgq52UyBL2DglRABg7BatfCiiEhFvdrs
         50eRs7e0ctmnkZhCHUQIzE22K+8+RjFGVMUOfer6IBBrxibv9FJqB8lZLekkBAUHlrcK
         fK7XYKOrVx125m1pLAnDgz7S9JgR3h0CmVz/xvIlHXzYcZZ/DjgPKtk+CPQ9SH3PAId+
         nvooirTukSELTOSVm+fMpwLm+WfP74t0mos9xXu9O7qBhtlU34sLNfg9keaEfyE0eDHQ
         a3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550656; x=1709155456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=L2fzGIcgpJqXI4kARNY9n2aIe+iV5MUmgfbMOlJQvOqNydpnyJj4i3yLeI6X6Quz5Z
         OjXyMgMPgOS9RlZP+KtVg1E6WvsRBzU8tj0yABgvudoFjwUkWhyB7pP4LE4Wo1MYrB5B
         If3jehNXWXJFa0SnNhblYi32/B3xhVBLTJhQE6n82SI0J64WdX9KLK5zYKsDWeNGtMWT
         abqTmedD2lmATIKTWk7OT75l/ewdWuu/dgn+SXwO1fOrUY28NLSQal9VtvgjMP1sWsZS
         x3/VV2qQTpQtgVS8p+5jPN1BYSjYgs90BR8NtPfGVLK8upJpmwhVveI+Qxaw4cYBrg/+
         7rMg==
X-Forwarded-Encrypted: i=1; AJvYcCVf8qU5nboZ5aTJUWbLouFMOURAbpFlZOEWMQ0szhPw+1xB02rGbHftwsc+HTwEgHuBZ+/zKvuttwyqbpgY1sG7fmhy2xdBiaKMMPcd
X-Gm-Message-State: AOJu0YzkGrjIjTdLiD/OyNQLpLlh220ZqFyFApsNv1q7edInXnaxe5Hn
	Wt9iWe1cFmNHBqFlTyEg2CoQsNQ80mjRFO4kcuKEz6buXCDofdPDeMtYl+Xcxd0f9EHtD7+RprQ
	dcILoLT8pmMIRPrN+do1crAKzeMTZfQDSrUFP4g==
X-Google-Smtp-Source: AGHT+IFvWKjWPK3amI8VL9W53BBk35ttzb77PzRBdxcUJJDHyxRlktLp+XaDhvA82AT8l0qmpbPOUDFRSVqjGiC7KOY=
X-Received: by 2002:a05:6830:1005:b0:6e2:eba0:ec4d with SMTP id
 a5-20020a056830100500b006e2eba0ec4dmr18796951otp.33.1708550655819; Wed, 21
 Feb 2024 13:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-6-surenb@google.com>
In-Reply-To: <20240221194052.927623-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:23:39 -0500
Message-ID: <CA+CK2bAAzRfsDYG+LVvp9LAJLpJoakhTAB3i6JiGDogvz8kfHg@mail.gmail.com>
Subject: Re: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
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
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

