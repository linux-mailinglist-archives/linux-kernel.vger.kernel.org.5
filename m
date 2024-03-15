Return-Path: <linux-kernel+bounces-104590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3CA87D08A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4521C220AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C713FE47;
	Fri, 15 Mar 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuveZ4If"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9263E498
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517452; cv=none; b=Z2wapfYm/xX2me8WNA+UQ4Bb2zfqchea6b4tt7k9M2Zan1DAa5YczpkK3aP4aIK9Mqa/08y5Vvporb2spn7t3mCXaSZ+E5TmgljjeYVmFV2a9Xy0P8vcL8VApAs99SuLEy9pYHExDG/g8GHk5SWoqDlD+WD18DRU6JNFK7Vc2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517452; c=relaxed/simple;
	bh=jLfgDHVGzLGqs8bVPCHj+06YQWXtnZrPss4BVdlJYT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH0o9OPnXJbV8jgnyBQrrxJfs5J3dbfjMcgndaPjYuUCXOdcr3CFMhqJq8cfKbXzPsaqfi6iv6ysar57aR0mpJFkigkpbq3PDXKx/x/wYsqRDbhmW+SF98Tw0rvW3EAR/dzFONahmVa1HzObWTKT4nG2y5YQ1CDIG6YR8y74g0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuveZ4If; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so2072119276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710517448; x=1711122248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clGRLHEdZJU1hIbUHWzW6z0FfJkCL+OJ6aU0ekE5bnA=;
        b=CuveZ4IfV5kQDXH+CAWirCcaii3bADGJxgVLc6jqHl4FTjFyGvzddl2Ee9smHs/AHS
         5jJnqc+mlovvpWDYYeGnfnppr7WaUUJr8xLaWd/I2xtCu7W4nDTw4/keYzqErMlUIeUQ
         sKh/v3qiAhmtJTcFFrtnL9nC5FusXYg1zfYQij4XHy/UOwaOeRqOFZOUkoWlpfKPNfyY
         HOPyXxLakyA6kw496KCGvpVEtuEkKg6sSOx027xoCWK1KcnpbE81WPbzFendMPdppa45
         wPERflySncziLCUfYyClXbCakDb4p28YwUwn16DxU79D4VmRxU5Nrn8OH3OsNB7RWqvC
         18ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517448; x=1711122248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clGRLHEdZJU1hIbUHWzW6z0FfJkCL+OJ6aU0ekE5bnA=;
        b=b+wlmcnjlCQ7ap2bjwCZVZRPwcp4t7ta6kAq+xlZN6jU/oN3xc/4xPuFzF+nnQgyZg
         kLWYoTYFELCZF27OGHxXG7roQFAlm/FZzAaLaiwtPyZ270xjNDRStCgnbPNECF/nhNG0
         gocyxNTVJovyQXSVTWLUKloZvN0LPIHGikVww8g4OGOvPyHX0z+Z1FnApyadiM3r+1ON
         EReSX8Ho2Zz1iXP/Cf03fdko1g14zdvDuHqNjSIP6zZ+vrjwCvTV4663TrawtifmB6AF
         ToqICYc8MgHrU8vJc8bjvlTVF4R5aBwe48NG36UstuHsXVBbEN0YWoCvoSLtvT4QxvSw
         0OHg==
X-Forwarded-Encrypted: i=1; AJvYcCVB467tL4OrseclIY+4uOWWpivEXpTOdU3HuzjWHslVRAke3kblq9D+KlHxKxigH8SKzvBajZi56/fqqp92a4fjj6wUduea8dONi6zJ
X-Gm-Message-State: AOJu0Yxx09D+Fg+sfXHYVRpiq/+GIRcV8m2ryJQYmRNgoRVBIAWmMoi9
	78GJvQN+Y8btj0upLfmcQYk03vbfPhr0yb16i1qyC1W7ft/blKt6GRStOT5vX3rnddoNsnvDPGL
	kAuLt0iaX+56MSbnj1rweHel3H/AGksDp72D+
X-Google-Smtp-Source: AGHT+IGAJ13N7pVvU4k2+lrRs5QxLZCCWdNXmROcACjXHKoXZPNi1NEiRR6CnqJxwRRq0iV9XWDMKjHgawP1NzMi2X0=
X-Received: by 2002:a25:2fc2:0:b0:dd0:e439:cec6 with SMTP id
 v185-20020a252fc2000000b00dd0e439cec6mr4700323ybv.18.1710517447501; Fri, 15
 Mar 2024 08:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-24-surenb@google.com>
 <1f51ffe8-e5b9-460f-815e-50e3a81c57bf@suse.cz>
In-Reply-To: <1f51ffe8-e5b9-460f-815e-50e3a81c57bf@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Mar 2024 08:43:53 -0700
Message-ID: <CAJuCfpE5mCXiGLHTm1a8PwLXrokexx9=QrrRF4fWVosTh5Q7BA@mail.gmail.com>
Subject: Re: [PATCH v5 23/37] mm/slab: add allocation accounting into slab
 allocation and free paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Fri, Mar 15, 2024 at 3:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/6/24 19:24, Suren Baghdasaryan wrote:
> > Account slab allocations using codetag reference embedded into slabobj_=
ext.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nit below:
>
> > @@ -3833,6 +3913,7 @@ void slab_post_alloc_hook(struct kmem_cache *s, s=
truct obj_cgroup *objcg,
> >                         unsigned int orig_size)
> >  {
> >       unsigned int zero_size =3D s->object_size;
> > +     struct slabobj_ext *obj_exts;
> >       bool kasan_init =3D init;
> >       size_t i;
> >       gfp_t init_flags =3D flags & gfp_allowed_mask;
> > @@ -3875,6 +3956,12 @@ void slab_post_alloc_hook(struct kmem_cache *s, =
       struct obj_cgroup *objcg,
> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >                                        s->flags, init_flags);
> >               kmsan_slab_alloc(s, p[i], init_flags);
> > +             obj_exts =3D prepare_slab_obj_exts_hook(s, flags, p[i]);
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +             /* obj_exts can be allocated for other reasons */
> > +             if (likely(obj_exts) && mem_alloc_profiling_enabled())
> > +                     alloc_tag_add(&obj_exts->ref, current->alloc_tag,=
 s->size);
> > +#endif
>
> I think you could still do this a bit better:
>
> Check mem_alloc_profiling_enabled() once before the whole block calling
> prepare_slab_obj_exts_hook() and alloc_tag_add()
> Remove need_slab_obj_ext() check from prepare_slab_obj_exts_hook()

Agree about checking mem_alloc_profiling_enabled() early and one time,
except I would like to use need_slab_obj_ext() instead of
mem_alloc_profiling_enabled() for that check. Currently they are
equivalent but if there are more slab_obj_ext users in the future then
there will be cases when we need to prepare_slab_obj_exts_hook() even
when mem_alloc_profiling_enabled()=3D=3Dfalse. need_slab_obj_ext() will be
easy to extend for such cases.
Thanks,
Suren.

>
> >       }
> >
> >       memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> > @@ -4353,6 +4440,7 @@ void slab_free(struct kmem_cache *s, struct slab =
*slab, void *object,
> >              unsigned long addr)
> >  {
> >       memcg_slab_free_hook(s, slab, &object, 1);
> > +     alloc_tagging_slab_free_hook(s, slab, &object, 1);
> >
> >       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> >               do_slab_free(s, slab, object, object, 1, addr);
> > @@ -4363,6 +4451,7 @@ void slab_free_bulk(struct kmem_cache *s, struct =
slab *slab, void *head,
> >                   void *tail, void **p, int cnt, unsigned long addr)
> >  {
> >       memcg_slab_free_hook(s, slab, p, cnt);
> > +     alloc_tagging_slab_free_hook(s, slab, p, cnt);
> >       /*
> >        * With KASAN enabled slab_free_freelist_hook modifies the freeli=
st
> >        * to remove objects, whose reuse must be delayed.
>

