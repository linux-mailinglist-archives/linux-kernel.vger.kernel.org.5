Return-Path: <linux-kernel+bounces-159097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98508B296C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372C21F222F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D7F15350B;
	Thu, 25 Apr 2024 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hluguHNa"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB8152DF1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075694; cv=none; b=h0UhBwaIYH2q2ucOhRq80Pgp/6g95f2vUqsVWmCdt9wBg/2NC/cvAlDMVNZiF0k6qsVVggjnRXl9hl/Z6ZJnTMiH2p+wAyXeUROWPecx/B6mq2PPVUoFujARKwvqDp19U7q8OvJgv/yKopfb3iSNRY1aDiZJEk1wT2jjoWmkMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075694; c=relaxed/simple;
	bh=7ciCYviadDCESvkbbfYYDhcw4dNfYDHt5C6Yzrv1psw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqlkein48q7K/jnCHLOe/JZ8yBKefvvq0LMJvq2HBhEraWnASYVS6j9q91fkChuDjfbMzrAi6W6n/TIr8ZihLsOZw8CWu9TZEoE06A5iiOE3p+zFZvf5Lf9nRJzVbwAXopJjz8jHhXZAzAr9w6mnzK0r76zG9QkEDULKzQ5jnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hluguHNa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b137d666so10827235ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714075692; x=1714680492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekH2ncVU5TU90wC0+JU7SiT8D9UwcwiJNzKzOJmDUPE=;
        b=hluguHNa3+jkYTvirKPnwbb3PspgFmPQQGCw/CuEWwz+SVTO/L29pZdZUmQO+VxrUs
         LttNGPjwNt40efzj/jw6YvmYY4yhLWqHnZgQPSytBqfAuRuf5ee4Z4AOFcGQ0lUX1d9a
         uxlivsYYYN1hCwCwMvshFk6gOFPYelyrJ6FQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075692; x=1714680492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekH2ncVU5TU90wC0+JU7SiT8D9UwcwiJNzKzOJmDUPE=;
        b=eBOge8tGu8lH+vV4GXkpAmje4oyEjl0AxefEtfsZ+t7UJeB9iFHke1ovlDBVqx+rLQ
         se2HCh7EZbKvJA9G/8aw/1zdVnlMHGduxsis9+dS67XXFlDrq7T/CBW3L677mbfsybD+
         ZomIKFdN3MBI1EUwMEkm+MlLXOuUdf5wFBYjPimK+tAmues/ZTgutqCpTAuavllRsjHr
         ICLTI6uR1VUdRZkSViMNtWVHvYIKvZhOX9nBcfTdtczr2xTewH4Af4xnOkkaLYJ3VD7N
         RkJcxopOZNvjGiDHyHzgdGnv3lWEylfKBQ75jVcUaI4+/6uU7+zBcubLFkHHgZ6cL5VZ
         dJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCIEh0GP3PYd5dN0r2tchSHzT4bnRXJsNy44Gf0qWsyX0sYGneLjOhMnRA2cj8mFJ2U7Hsvo9zAIbsq0XT7pBuYlUSe5ySbvSRd/b3
X-Gm-Message-State: AOJu0YyGGQu8MxnYhRhmEE6IZyAMXaPWS0IIaWl8YLUcLjlcYUuOEGaz
	UnEDEJ3UVpx1Oby57q3nMIz0CmaXvL0/7OAOMKuZidpPzkcK6pPq3f436/rJEg==
X-Google-Smtp-Source: AGHT+IENLaRsnHeJ8vPQA0HMTgbKv7kjkvunXKY2OsqKLXqA91N5TvqvgatgH/rNiBbiRYXFmTuk2w==
X-Received: by 2002:a17:902:6548:b0:1e9:519:d464 with SMTP id d8-20020a170902654800b001e90519d464mr560628pln.65.1714075691780;
        Thu, 25 Apr 2024 13:08:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709026bc600b001e99ffdbe56sm8266309plt.215.2024.04.25.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:08:11 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:08:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-ID: <202404251307.FD73DE1@keescook>
References: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> Overview:
> Low overhead [1] per-callsite memory allocation profiling. Not just for
> debug kernels, overhead low enough to be deployed in production.

A bit late to actually _running_ this code, but I remain a fan:

Tested-by: Kees Cook <keescook@chromium.org>

I have a little tweak patch I'll send out too...

-- 
Kees Cook

