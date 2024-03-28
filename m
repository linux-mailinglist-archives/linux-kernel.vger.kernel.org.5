Return-Path: <linux-kernel+bounces-95886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26FF875493
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07698B23EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F312FF87;
	Thu,  7 Mar 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkztrEiL"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051012FF8F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830284; cv=none; b=IJoRDUeGm/TYwvBaLhdFK4LEt6jYr/gDSXbVEL8xPDcFn+oYUSCNcBGlPar1F2weTgVa8QF1Hx1vuSiKfOUZhY6+wws2q1IEr5hacXk/7hzCygp+bsmKtn3iO1hhe5DYXRIB5EP25kBcOhzexbGA9gaJRjMciCs4SABLZalPtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830284; c=relaxed/simple;
	bh=oAlVnpZg9Cvtgh25NJi4Ni8v3PGC2OnHmgro+J0U4EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGlHtrI1qWXCdbTIl3cAln8e6T3EPCWAjNOUmIOkdD5YlFNQZ3PIyNP3/XDsgsV44QR6ZhOP/RUchrWIstWJljLfc9PsYlMnWRMpvntEI05myuPQBsjXZevpqEDhlctWlUw9nFfKz11dXca+LYLOo+TPv1IPj7YczguHackJ2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkztrEiL; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609fc742044so4970367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709830281; x=1710435081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Yc7CaZYI+aOfiJp3dG8X2zo4+LoYMopU2pW1vALF2c=;
        b=EkztrEiLLhIOUJAAYPUWgEaHi7EV5QB6yZwuWNupjVhqNS8TscCRjHMf6o1etvQsSh
         wGyt4T2DH4dQg67h7AGYzeTzzY49AIXHRBjmggC74JwdlPnb31QZ6/SA10tM1amNyWPt
         5s53/u3FO62hGqkq7eO6oMRbo5X/tr+Wk6s9LvTsdb05RmnaTLwWcq7OciJWa/2SLHvT
         CLxY8mnK4ldNW5snCcUUacbwVrFfnkmgQ3hG+DIZwlq7rRyq9fYG8yxFcOtAhsTVmwFx
         rCODHfjmwhAzTIeFtXx6JF3mm9jqBXHkhCm85LjrDPTYPMByKBubU0UFDP39ELBc3tXB
         eKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830281; x=1710435081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Yc7CaZYI+aOfiJp3dG8X2zo4+LoYMopU2pW1vALF2c=;
        b=qHVxJ5PyoFcVZpjNWWG5jpm3jqOhAKYggUczEmxdC3OtI72+nG4SBp8DcwagGtgSEW
         bKHimDlumGveLiEFZuoev1qenBFEn/QICJbFcDf/7OEzFcz1LXLqqfXd2rmnWxO5eHwD
         Xjb1iVuJlZRa2Bayrt93fM7Ty/uJ+KG5KXB8IIovfCXuVwN+z5+4nR/OBfW0zyH3ndPG
         //QHNJd/toS2G05K4O0xvCaMB+KqJqrcL6l4J/JK2FZKpKUBL+SSiJuG6h+Jv2FIuU8s
         yLWj71+ksJHtIU/o/Sbsurhs3c5WUOBTie4DNQ/qBdViLewCrRuGpj0W09bzu/KR3cn8
         Lx3w==
X-Forwarded-Encrypted: i=1; AJvYcCU+sX73p4T/A71dgrj/wfUyXO6wwH4+eqM8GOdWhKLPzCTdiQrszvteYje+Pt9D3bXLguUs3WbyxNW3bsuTir0T7tYPBGxMUZv8ryqO
X-Gm-Message-State: AOJu0YwJgVTQXZ0XJeEo0KU+5WdxZYE8hlFcM13IiqUh/jXwZHuPY3eW
	THNlI7Ax1kiT9whDjKfA0NK3VRC8UXF8gQqVqsuX5b4ONxlgilHPaWOP9tlVp3LC2faFpFLVDHa
	rbzV+qkkoN2p0Osr48NwkXPXcv+N2BD1SRmjN
X-Google-Smtp-Source: AGHT+IETO+uYsXBHUav01bdbNnbA53xxjR6usX/j/Y4xXR7KlOH6v3HVx5uc93IkxR9q2hK67467LC5KnM+ZNqEyIOk=
X-Received: by 2002:a05:6902:160d:b0:dcf:56c3:336e with SMTP id
 bw13-20020a056902160d00b00dcf56c3336emr17705298ybb.35.1709830280572; Thu, 07
 Mar 2024 08:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-38-surenb@google.com>
 <10a95079-86e4-41bf-8e82-e387936c437d@infradead.org>
In-Reply-To: <10a95079-86e4-41bf-8e82-e387936c437d@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Mar 2024 16:51:08 +0000
Message-ID: <CAJuCfpFN3BLsFOWB0huA==LVa2pNYdnf7bT_VXgDtPuJOxvWSQ@mail.gmail.com>
Subject: Re: [PATCH v5 37/37] memprofiling: Documentation
To: Randy Dunlap <rdunlap@infradead.org>
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:19=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi,
> This includes some editing suggestions and some doc build fixes.
>
>
> On 3/6/24 10:24, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > Provide documentation for memory allocation profiling.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  Documentation/mm/allocation-profiling.rst | 91 +++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/mm/allocation-profiling.rst
> >
> > diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/=
mm/allocation-profiling.rst
> > new file mode 100644
> > index 000000000000..8a862c7d3aab
> > --- /dev/null
> > +++ b/Documentation/mm/allocation-profiling.rst
> > @@ -0,0 +1,91 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +MEMORY ALLOCATION PROFILING
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +Low overhead (suitable for production) accounting of all memory alloca=
tions,
> > +tracked by file and line number.
> > +
> > +Usage:
> > +kconfig options:
> > + - CONFIG_MEM_ALLOC_PROFILING
> > + - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> > + - CONFIG_MEM_ALLOC_PROFILING_DEBUG
> > +   adds warnings for allocations that weren't accounted because of a
> > +   missing annotation
> > +
> > +Boot parameter:
> > +  sysctl.vm.mem_profiling=3D0|1|never
> > +
> > +  When set to "never", memory allocation profiling overheads is minimi=
zed and it
>
>                                                       overhead is
>
> > +  cannot be enabled at runtime (sysctl becomes read-only).
> > +  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy, default valu=
e is "1".
> > +  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dn, default valu=
e is "never".
> > +
> > +sysctl:
> > +  /proc/sys/vm/mem_profiling
> > +
> > +Runtime info:
> > +  /proc/allocinfo
> > +
> > +Example output:
> > +  root@moria-kvm:~# sort -g /proc/allocinfo|tail|numfmt --to=3Diec
> > +        2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
> > +        3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
> > +        4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] f=
unc:ctagmod_start
> > +        4.1M        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_c=
t_alloc_hashtable
> > +        6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
> > +        8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
> > +         13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
> > +         14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
> > +         15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
> > +         55M     4887 mm/slub.c:2259 func:alloc_slab_page
> > +        122M    31168 mm/page_ext.c:270 func:alloc_page_ext
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Theory of operation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Memory allocation profiling builds off of code tagging, which is a lib=
rary for
> > +declaring static structs (that typcially describe a file and line numb=
er in
>
>                                   typically
>
> > +some way, hence code tagging) and then finding and operating on them a=
t runtime
>
>                                                                         a=
t runtime,
>
> > +- i.e. iterating over them to print them in debugfs/procfs.
>
>   i.e., iterating
>
> > +
> > +To add accounting for an allocation call, we replace it with a macro
> > +invocation, alloc_hooks(), that
> > + - declares a code tag
> > + - stashes a pointer to it in task_struct
> > + - calls the real allocation function
> > + - and finally, restores the task_struct alloc tag pointer to its prev=
ious value.
> > +
> > +This allows for alloc_hooks() calls to be nested, with the most recent=
 one
> > +taking effect. This is important for allocations internal to the mm/ c=
ode that
> > +do not properly belong to the outer allocation context and should be c=
ounted
> > +separately: for example, slab object extension vectors, or when the sl=
ab
> > +allocates pages from the page allocator.
> > +
> > +Thus, proper usage requires determining which function in an allocatio=
n call
> > +stack should be tagged. There are many helper functions that essential=
ly wrap
> > +e.g. kmalloc() and do a little more work, then are called in multiple =
places;
> > +we'll generally want the accounting to happen in the callers of these =
helpers,
> > +not in the helpers themselves.
> > +
> > +To fix up a given helper, for example foo(), do the following:
> > + - switch its allocation call to the _noprof() version, e.g. kmalloc_n=
oprof()
> > + - rename it to foo_noprof()
> > + - define a macro version of foo() like so:
> > +   #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))
> > +
> > +It's also possible to stash a pointer to an alloc tag in your own data=
 structures.
> > +
> > +Do this when you're implementing a generic data structure that does al=
locations
> > +"on behalf of" some other code - for example, the rhashtable code. Thi=
s way,
> > +instead of seeing a large line in /proc/allocinfo for rhashtable.c, we=
 can
> > +break it out by rhashtable type.
> > +
> > +To do so:
> > + - Hook your data structure's init function, like any other allocation=
 function
>
> maybe end the line above with a '.' like the following line.
>
> > + - Within your init function, use the convenience macro alloc_tag_reco=
rd() to
> > +   record alloc tag in your data structure.
> > + - Then, use the following form for your allocations:
> > +   alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
>
>
> Finally, there are a number of documentation build warnings in this patch=
.
> I'm no ReST expert, but the attached patch fixes them for me.

Thanks Randy! I'll use your cleaned-up patch in the next submission.
Cheers,
Suren.

>
> --
> #Randy

