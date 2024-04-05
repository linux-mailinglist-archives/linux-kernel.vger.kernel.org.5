Return-Path: <linux-kernel+bounces-133232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5489A0F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35A1B20E96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336416F91D;
	Fri,  5 Apr 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SXKGA+GZ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CF16F8F4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330463; cv=none; b=tTvhDmHVP9i/j2wQWw+xX+5hL5ZapzPptdvw16ygrKyaEaTQ2YCCjZmzkE1uRbTn6Ky40JZHFKyQz944kqAc3Bjc5EL3oXFhrgfY8PeLtCR10KJS84S82ciHy4Fi1mIF4wPOSVvpHuAPvq95ktpfZJkt67dFMMQo/cu/nwucW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330463; c=relaxed/simple;
	bh=v2LZLmJjwZiX/Av/VtBl/rfMd2QhhbkrVc7py92eGo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIeSsQy8TCex56WkZWzXlFnKoSqs+7nuKt9aFYVCUqX2NNiAlqHY37QL1/DaABHQGGNIUVTySFG51rV3J2BXrapEOl3fWnZjjFNUjDx1fmoKb+OMrl3R1Fmx2j4cjNd2r4X6bdDWopZrLrV8p3vd4oS0NfMebRkh2mp3ya0k3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXKGA+GZ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1740723276.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712330459; x=1712935259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfDVWiPNFB4hCGgsx7SCawcdvp63A70UKMWvRcHoJQg=;
        b=SXKGA+GZwNrphgd7e0RtYhr+EJx5qRVK0fYdxJEvQtDKQopI6RDlP1YVIhzVUu+GBS
         IsCDFx8FDHWZDrt1aHQvEQ8wnH/bM3Kui+J4iWRxtf3l9hYXObTwy64YrCFA2ws+UQ2D
         eG5mM4zY15xcHfGLZeWK1AC67+h2Jx/4hu7RqE+ekwbzEauID+yn7tsqpp0ztuKG158z
         o6Byo/b0FVHbTYOHB+c9wm65ICoJOsA4HgAMD92+TkT76K26mzttEVneGjZtpLcZrmmR
         zLbw4NQZlbbp6CvbeMtdecci1kQ8YWGO9KAmhdLp3hxEL+Z/ejB9GQMvrLzgxGBpv59w
         uTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330459; x=1712935259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfDVWiPNFB4hCGgsx7SCawcdvp63A70UKMWvRcHoJQg=;
        b=kiS0/WtmvE8jNh15gAwkUCNQwTtwcXVKtbDnncDjmvdELYZPhow4U5Yoxav17UrIMf
         BLX86BAe03zuJohs08soQuNFZx8LxjXGrZAN+RdjPPAJSKV2RcxZRbYLx5oY5+WIxBoJ
         nn1u6N8HmvF1WVF3svESgBtY026q+dfi75X/ZV07T9JWLmhekAEwNkySGz6r5EVonxz4
         e+3Lvjs88E/65M7Uzp+M/wydSuKbw7acbKgWO6zokPnDGL8LmXS5WQsFo0tUVqE02gkm
         GUA8EMt6FWnFPcWNpcDCVhIfhgDDh0MI41N2JtNVEdtmgX2tDNOxgnuK0pb+Mwo3gPan
         BHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTR4TT6XJu0Zdkno69q+EdBohM173Reqf3LYoHoCorqqSJPd+Em8ATLh9nDB9yQKANDdehOCdQxHlqxhNJc38qWZxnR0eafsJOBoVs
X-Gm-Message-State: AOJu0YztDf6+I7WKhvjldniw8f7mewwqaO+mKUZCYSqJ5ZG5tLqABWyd
	RwebQ4CjEItqEZkQK/Brfoho0qIcv8iFOLsOxRGQL2SIlVJVp2LIytiu9IsB468OQu2OgL7Lf8D
	f9u8rDtg/RYG4/WPNSDHiscW7q7G1ujIejbsX
X-Google-Smtp-Source: AGHT+IFEI5zu5AiOteuhDQ2sEIS5wB7/bvXsQ5XrghDRi0ac0xrycb3LZS7XKg1pBjRTjmrFbQ1PTicmGSgIyMm6syU=
X-Received: by 2002:a25:6ec3:0:b0:dc6:d258:c694 with SMTP id
 j186-20020a256ec3000000b00dc6d258c694mr2014282ybc.19.1712330458412; Fri, 05
 Apr 2024 08:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <c14cd89b-c879-4474-a800-d60fc29c1820@gmail.com>
 <CAJuCfpHEt2n6sA7m5zvc-F+z=3-twVEKfVGCa0+y62bT10b0Bw@mail.gmail.com> <41328d5a-3e41-4936-bcb7-c0a85e6ce332@gmail.com>
In-Reply-To: <41328d5a-3e41-4936-bcb7-c0a85e6ce332@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 5 Apr 2024 08:20:44 -0700
Message-ID: <CAJuCfpERj52X8DB64b=6+9WLcnuEBkpjnfgYBgvPs0Rq7kxOkw@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 7:30=E2=80=AFAM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
> On 2024-04-05 16:14, Suren Baghdasaryan wrote:
> > On Fri, Apr 5, 2024 at 6:37=E2=80=AFAM Klara Modin <klarasmodin@gmail.c=
om> wrote:
> >> If I enable this, I consistently get percpu allocation failures. I can
> >> occasionally reproduce it in qemu. I've attached the logs and my confi=
g,
> >> please let me know if there's anything else that could be relevant.
> >
> > Thanks for the report!
> > In debug_alloc_profiling.log I see:
> >
> > [    7.445127] percpu: limit reached, disable warning
> >
> > That's probably the reason. I'll take a closer look at the cause of
> > that and how we can fix it.
>
> Thanks!

In the build that produced debug_alloc_profiling.log I think we are
consuming all the per-cpu memory reserved for the modules. Could you
please try this change and see if that fixes the issue:

 include/linux/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index a790afba9386..03053de557cf 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -17,7 +17,7 @@
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-#define PERCPU_MODULE_RESERVE (8 << 12)
+#define PERCPU_MODULE_RESERVE (8 << 13)
 #else
 #define PERCPU_MODULE_RESERVE (8 << 10)
 #endif

>
> >
> >   In qemu-alloc3.log I see couple of warnings:
> >
> > [    1.111620] alloc_tag was not set
> > [    1.111880] WARNING: CPU: 0 PID: 164 at
> > include/linux/alloc_tag.h:118 kfree (./include/linux/alloc_tag.h:118
> > (discriminator 1) ./include/linux/alloc_tag.h:161 (discriminator 1)
> > mm/slub.c:2043 ...
> >
> > [    1.161710] alloc_tag was not cleared (got tag for fs/squashfs/cache=
c:413)
> > [    1.162289] WARNING: CPU: 0 PID: 195 at
> > include/linux/alloc_tag.h:109 kmalloc_trace_noprof
> > (./include/linux/alloc_tag.h:109 (discriminator 1)
> > ./include/linux/alloc_tag.h:149 (discriminator 1) ...
> >
> > Which means we missed to instrument some allocation. Can you please
> > check if disabling CONFIG_MEM_ALLOC_PROFILING_DEBUG fixes QEMU case?
> > In the meantime I'll try to reproduce and fix this.
> > Thanks,
> > Suren.
>
> That does seem to be the case from what I can tell. I didn't get the
> warning in qemu consistently, but it hasn't reappeared for a number of
> times at least with the debugging option off.
>
> Regards,
> Klara Modin

