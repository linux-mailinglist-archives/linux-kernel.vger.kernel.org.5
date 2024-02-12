Return-Path: <linux-kernel+bounces-62464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208D85212C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40161F215B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BA4D9F8;
	Mon, 12 Feb 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YxoUJYcu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AE4D9F1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776074; cv=none; b=AoEN5vy8EjeUyLS7anlbXmznbxyVzVInMZARIoOmfEBViDwKj/A9pWt6+sgXQgJrc/9ODAhNClReN/MDXkQ/ncuv09PR9E1tJrMdBISf8Resl6jQEM27/4s+Dcg4ZNOd7v7rb9sN2Iv4vC/0e0extl4BIMx93JwWNp4F3K1S+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776074; c=relaxed/simple;
	bh=h3lvxY7RwFA2qmllpedkHyA1V2cF2YBOaMy0Y3HF4OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHYpgVa1EnALkhmF/pfkLFRYvqgayRKB+RvQEAAkFuTERJygsGW7S8GaWCtRyZRSO9gedONv9u8g9gX/pCQ5ulYRRCVGC0zIUb9riagkq+NiK/4KGABGwLX8IphwPWJF48laSOSlBhLNtSrvzdvzqo2knO5PAKl0s+lSbi/zFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YxoUJYcu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2670488a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776072; x=1708380872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIxrgJSE63hrU/LEeVrXgeewq/cIy3PkJ41qNbyzIVA=;
        b=YxoUJYcu2FANQw0aSKgB63e9dtx3sHo+EHRknIB2cIYTMgemXRjmcjc3vir3t5KVad
         aJSH6PYizqDnjHhDSmUnzgZcezvQcONFX3lbBCxSerbvr+MVQLvcBv/2v5X95WYry3et
         lBR/nHNgt84byjcYrbG1aqktz8uUO7dGWXQVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776072; x=1708380872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIxrgJSE63hrU/LEeVrXgeewq/cIy3PkJ41qNbyzIVA=;
        b=D5UYCQZTzza4r47zYN6EQ4TOdFwWnT3V7lvQih3QZf5Z+6dGW4mVElx5YshLnsrc+d
         3A95Ea8Ucjs4J7W5GeCXDeJV1XCmEXOu5AO0DtUt5d4kHJMLbFdDN6IOuF16yOLZ2i8Q
         4PaM/X7pw4Vi8KByJ01yi6zz9BUgHib6HBw5WUI0qu5AgSGCJRexdCMnwXrac2J4rdQZ
         P0pgz/jv6j4K6HfHde1frEZbfW7nfV+AQVJ1j3/U8ZQk2lD4fvsCkyf7RrGrbA0u1BdR
         Vy4hQrWXd73zh/vn6EhZF9i5wcmAwFuyZSnrSG/MSqDdPn6yu5lyKA16YPuHXIK5uinC
         6HUA==
X-Forwarded-Encrypted: i=1; AJvYcCWDIdQpvzNOsEXDg8ZVc4AG4Wd9+JlzYZ/CFQVC6/TXZNUs6NIppSxnMXu7+uaKk2vl/Y3P8LqwnAxDnxWYMTkWeJK9BzCvmAHEbzfq
X-Gm-Message-State: AOJu0YzZR4d5s4s0a+zK8pq017PW9TLWrGi17ItncM+nt9Sx6tONJpTl
	KO4mdJkdBx73GDzF0mdu+mNi0IlNupJnFKrcqS9asyE9wDYHeyxX1yJzxJXLFg==
X-Google-Smtp-Source: AGHT+IFiqvYFTcqWnH4OIf/1Dh8kKaLyS7c6HZ8FWCh2Bts+fuw53yU8/1Sv6ViBQjb2otqFVY6FxA==
X-Received: by 2002:a17:90b:f0a:b0:297:202a:3ba6 with SMTP id br10-20020a17090b0f0a00b00297202a3ba6mr5321895pjb.0.1707776072170;
        Mon, 12 Feb 2024 14:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsNU/8NsDmZt/wglKpjvkWUqHuMmKfr1qDw7hshzseGvRlVn91OWfIWbwPNUldThoFCWHouAaiCcJaR42pa2ZOj+4fu2K/RLpokhW/LHNcfv2bpUoorqtQmMzzcr2uE77OUtmraZBpl3sk2+0JkP3q2aqFPvO8/oCz10/YOwXZph6krxIzkBVwaNb3wv/BrgWTPxyHhkA/nJZtQbzZAwr7loqQ/pCv/14+512lJkj6b5pedTy1UYbPe8fCvkg/xo7qb21F+hs+Z375s58m1Yaqt2RqOXotKP+i3q2TaHpNYX7+Qm1cOW+PXXl0zvf9L5VQfmLrwbCN3rKQhZW/nxd+mxJsLIzrBbjLbMZ0pkF3X38ElFtwskqogWZO17OXKEFqsMjg8CcNd+OrzYfm8i/+GWQ2aoFnvE/VOIsG/Ftpg1X8Xjb9NUgZKHW9NcJAKH9ypNH/EyYK1p4u4VLqY9iriSV6bAxOqn6+QslEU1mHLsLSoMCDXP9iT2o9sZPWgMHL2KdE2sxLxLDrmrAQw82/6vIDTAiOP+gfpX5103QSU+zIn09beoujZ5rXZoEFP2EV4cXNa2fOMDgr7UNTZOyXZY5zdYF8ty4SkdCJI3+tJOtPvCNSgNrNGfOVWTOKs9FTVkNVt8KD/AR23yzqYgL3hH9cLzUNzLgthNx3j8FdaGaJuMjOB+oaxAvuEuwe4ekk5L+mT0ksuIbsY55UWlDcgj1J1Ekfcl8tppAS5UCbJ6oiNYA73Q==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a752200b002970cb0c22dsm1120551pjk.49.2024.02.12.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:14:31 -0800 (PST)
Date: Mon, 12 Feb 2024 14:14:31 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 06/35] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
Message-ID: <202402121414.EACBD205@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-7-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-7-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:52PM -0800, Suren Baghdasaryan wrote:
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

