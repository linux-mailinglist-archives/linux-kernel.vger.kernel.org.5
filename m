Return-Path: <linux-kernel+bounces-49187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A818466EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEC928D723
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D51EAEA;
	Fri,  2 Feb 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tk6fk9wE"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9CE55E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847661; cv=none; b=a+AwfVw2933kf2CFgcqcKO7ZDbZqUKt9wryG4ew1V8RdRu+rJDYtZuOxKK4zrQNAf1wLZqEmJhAkWkC4yrOWx/WpmJ/KsX1cDsrZrp2xjNBL7luuYNj/tKwe6hneYiYUOIYBPscEk+bX19S5Ptj+LBdrxVFUOi7jNOwanajz+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847661; c=relaxed/simple;
	bh=movor5SOK1YCGaemU5NcPrMpeBw24uX6AzjqtNRNno0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn8/+gOX2FTAPGgSL0UKTtlqaKGHDaVR2o4u2+IhVLWXZPdu18OA4NqI7v1MFQ3y4DPIz+mJNWVai9Us6c7PVE9mfO3+IsqRspn++TLFgOMBhtJmcV6GFqRFSZ2rNSettz7dLqEk9HCeO/kQsQZoXP+j18D3D12SpaxwtxP6roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tk6fk9wE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a7765511bso111751cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 20:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706847657; x=1707452457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxVaowWCAd+qKhsyvfF75fNUxRPD2KHSUhvz+7A+I0Y=;
        b=Tk6fk9wECqysYWUAbz07C3RpNYlS6TJGmgy5aKb5QDy0kuvHDhYpBqzfbZGy0fVPty
         h6L8XFix96tXBa8EyNsgjA5QkgdBciTdegm5gQWi1js1FItAJcSDB3OrwKDNomWETJWs
         crQC5fpPce6UWHYEyiVHkdObfLBbszYzRKWzqmazG2DUI8QmhJLn5AdaZZkjrbPerkl3
         YzisMjGMPnXCkbOUSsf/xS9jy9PK1G4E3K/j5sLeAkyOjVLgXTN1ZLBc7f9uHT7a4HMt
         fxr5jaqZLjL9gI2BlISJwT3nY/wm7IM7IVyDac8EkFOLilg/B4QqsEyWKtcAX9FlmOIe
         /thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706847657; x=1707452457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxVaowWCAd+qKhsyvfF75fNUxRPD2KHSUhvz+7A+I0Y=;
        b=ltOkrTWqUGE+kePFuc9I32cHTnhT2nSDYVf7+ljS/XZlnWM0MTjnfOmz36gqVmuT1u
         Nb+9V/gnU+QdpxT3ATuUEO7ETcCwNHJ7X5cnx9CzLlR0BDVqIh04kfNPz+ARmKq+/1CN
         J9MaqofhvI+gY17CTrYEuf2q+BLpFUw+JU2w0yoguHzHTLXWp4PVP4Wd7XAs1TwJVmRT
         Az8DqZ5yRR97aZX6Zg/weR7yRMkZIhJ77CsRfWBQvmbi6WYyc+9rEViA2suv7f2ZefrJ
         6SIVWvKVHHTA2FpwnqzHp/CtnGNO04F0Q7DIDnq81hKpOHuVdbye3SGEIAL83RdWuhiC
         bjPA==
X-Gm-Message-State: AOJu0YxPNOiM+tV67jm2i2EhK0G7k7uB1PQlpZ4Dp/Tr2ltd5K55Q/VP
	Rm95TlQ5PTuubCpIYC0HrccIcyjHaXGqAbsiBugUdJFm+ryFY1dv0BMoqdxdf1sQlPbDK+wCLr/
	Hi8AXWfNefpv7Oi9jraznBy+mLR0DHX90m+E1
X-Google-Smtp-Source: AGHT+IEpVniFnBpsH0dGiO9VsIipJjeMNVhjmsL6OaP4vRxcjop9kBRy+a/X2gOqvb94qDe0AdvZ2dVgLgAf0KaWbZM=
X-Received: by 2002:ac8:4d04:0:b0:42b:f8cf:8de4 with SMTP id
 w4-20020ac84d04000000b0042bf8cf8de4mr60982qtv.29.1706847656134; Thu, 01 Feb
 2024 20:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com> <20240103050635.391888-2-irogers@google.com>
 <CAM9d7chUnXOFXsz-gdK4V=RX4DfJMdBOzfzso_uKSj=00xNeZg@mail.gmail.com>
In-Reply-To: <CAM9d7chUnXOFXsz-gdK4V=RX4DfJMdBOzfzso_uKSj=00xNeZg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Feb 2024 20:20:42 -0800
Message-ID: <CAP-5=fW=Ov8hZ3qfYnTVAqV87bzYpS6jrPpxstdY3JdHx=pBGw@mail.gmail.com>
Subject: Re: [PATCH v7 01/25] perf maps: Switch from rbtree to lazily sorted
 array for addresses
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Tue, Jan 2, 2024 at 9:07=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Maps is a collection of maps primarily sorted by the starting address
> > of the map. Prior to this change the maps were held in an rbtree
> > requiring 4 pointers per node. Prior to reference count checking, the
> > rbnode was embedded in the map so 3 pointers per node were
> > necessary. This change switches the rbtree to an array lazily sorted
> > by address, much as the array sorting nodes by name. 1 pointer is
> > needed per node, but to avoid excessive resizing the backing array may
> > be twice the number of used elements. Meaning the memory overhead is
> > roughly half that of the rbtree. For a perf record with
> > "--no-bpf-event -g -a" of true, the memory overhead of perf inject is
> > reduce fom 3.3MB to 3MB, so 10% or 300KB is saved.
> >
> > Map inserts always happen at the end of the array. The code tracks
> > whether the insertion violates the sorting property. O(log n) rb-tree
> > complexity is switched to O(1).
> >
> > Remove slides the array, so O(log n) rb-tree complexity is degraded to
> > O(n).
> >
> > A find may need to sort the array using qsort which is O(n*log n), but
> > in general the maps should be sorted and so average performance should
> > be O(log n) as with the rbtree.
> >
> > An rbtree node consumes a cache line, but with the array 4 nodes fit
> > on a cache line. Iteration is simplified to scanning an array rather
> > than pointer chasing.
> >
> > Overall it is expected the performance after the change should be
> > comparable to before, but with half of the memory consumed.
>
> I don't know how much performance impact it would have but I guess
> search/iteration would be the most frequent operation.  So I like the
> memory saving it can bring.
>
> >
> > To avoid a list and repeated logic around splitting maps,
> > maps__merge_in is rewritten in terms of
> > maps__fixup_overlap_and_insert. maps_merge_in splits the given mapping
> > inserting remaining gaps. maps__fixup_overlap_and_insert splits the
> > existing mappings, then adds the incoming mapping. By adding the new
> > mapping first, then re-inserting the existing mappings the splitting
> > behavior matches.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/maps.c |    3 +
> >  tools/perf/util/map.c   |    1 +
> >  tools/perf/util/maps.c  | 1183 +++++++++++++++++++++++----------------
> >  tools/perf/util/maps.h  |   54 +-
> >  4 files changed, 757 insertions(+), 484 deletions(-)
> >
> > diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> > index bb3fbfe5a73e..b15417a0d617 100644
> > --- a/tools/perf/tests/maps.c
> > +++ b/tools/perf/tests/maps.c
> > @@ -156,6 +156,9 @@ static int test__maps__merge_in(struct test_suite *=
t __maybe_unused, int subtest
> >         TEST_ASSERT_VAL("merge check failed", !ret);
> >
> >         maps__zput(maps);
> > +       map__zput(map_kcore1);
> > +       map__zput(map_kcore2);
> > +       map__zput(map_kcore3);
> >         return TEST_OK;
> >  }
> >
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 54c67cb7ecef..cf5a15db3a1f 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -168,6 +168,7 @@ struct map *map__new(struct machine *machine, u64 s=
tart, u64 len,
> >                 if (dso =3D=3D NULL)
> >                         goto out_delete;
> >
> > +               assert(!dso->kernel);
> >                 map__init(result, start, start + len, pgoff, dso);
> >
> >                 if (anon || no_dso) {
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index 0334fc18d9c6..6ee81160cdab 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -10,286 +10,477 @@
> >  #include "ui/ui.h"
> >  #include "unwind.h"
> >
> > -struct map_rb_node {
> > -       struct rb_node rb_node;
> > -       struct map *map;
> > -};
> > -
> > -#define maps__for_each_entry(maps, map) \
> > -       for (map =3D maps__first(maps); map; map =3D map_rb_node__next(=
map))
> > +static void check_invariants(const struct maps *maps __maybe_unused)
> > +{
> > +#ifndef NDEBUG
> > +       assert(RC_CHK_ACCESS(maps)->nr_maps <=3D RC_CHK_ACCESS(maps)->n=
r_maps_allocated);
> > +       for (unsigned int i =3D 0; i < RC_CHK_ACCESS(maps)->nr_maps; i+=
+) {
> > +               struct map *map =3D RC_CHK_ACCESS(maps)->maps_by_addres=
s[i];
> > +
> > +               /* Check map is well-formed. */
> > +               assert(map__end(map) =3D=3D 0 || map__start(map) <=3D m=
ap__end(map));
> > +               /* Expect at least 1 reference count. */
> > +               assert(refcount_read(map__refcnt(map)) > 0);
> > +
> > +               if (map__dso(map) && map__dso(map)->kernel)
> > +                       assert(RC_CHK_EQUAL(map__kmap(map)->kmaps, maps=
));
> > +
> > +               if (i > 0) {
> > +                       struct map *prev =3D RC_CHK_ACCESS(maps)->maps_=
by_address[i - 1];
> > +
> > +                       /* If addresses are sorted... */
> > +                       if (RC_CHK_ACCESS(maps)->maps_by_address_sorted=
) {
> > +                               /* Maps should be in start address orde=
r. */
> > +                               assert(map__start(prev) <=3D map__start=
(map));
> > +                               /*
> > +                                * If the ends of maps aren't broken (d=
uring
> > +                                * construction) then they should be or=
dered
> > +                                * too.
> > +                                */
> > +                               if (!RC_CHK_ACCESS(maps)->ends_broken) =
{
> > +                                       assert(map__end(prev) <=3D map_=
_end(map));
> > +                                       assert(map__end(prev) <=3D map_=
_start(map) ||
> > +                                              map__start(prev) =3D=3D =
map__start(map));
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +       if (RC_CHK_ACCESS(maps)->maps_by_name) {
> > +               for (unsigned int i =3D 0; i < RC_CHK_ACCESS(maps)->nr_=
maps; i++) {
> > +                       struct map *map =3D RC_CHK_ACCESS(maps)->maps_b=
y_name[i];
> >
> > -#define maps__for_each_entry_safe(maps, map, next) \
> > -       for (map =3D maps__first(maps), next =3D map_rb_node__next(map)=
; map; \
> > -            map =3D next, next =3D map_rb_node__next(map))
> > +                       /*
> > +                        * Maps by name maps should be in maps_by_addre=
ss, so
> > +                        * the reference count should be higher.
> > +                        */
> > +                       assert(refcount_read(map__refcnt(map)) > 1);
> > +               }
> > +       }
> > +#endif
> > +}
> >
> > -static struct rb_root *maps__entries(struct maps *maps)
> > +static struct map **maps__maps_by_address(const struct maps *maps)
> >  {
> > -       return &RC_CHK_ACCESS(maps)->entries;
> > +       return RC_CHK_ACCESS(maps)->maps_by_address;
> >  }
> >
> > -static struct rw_semaphore *maps__lock(struct maps *maps)
> > +static void maps__set_maps_by_address(struct maps *maps, struct map **=
new)
> >  {
> > -       return &RC_CHK_ACCESS(maps)->lock;
> > +       RC_CHK_ACCESS(maps)->maps_by_address =3D new;
> > +
> >  }
> >
> > -static struct map **maps__maps_by_name(struct maps *maps)
> > +/* Not in the header, to aid reference counting. */
> > +static struct map **maps__maps_by_name(const struct maps *maps)
> >  {
> >         return RC_CHK_ACCESS(maps)->maps_by_name;
> > +
> >  }
> >
> > -static struct map_rb_node *maps__first(struct maps *maps)
> > +static void maps__set_maps_by_name(struct maps *maps, struct map **new=
)
> >  {
> > -       struct rb_node *first =3D rb_first(maps__entries(maps));
> > +       RC_CHK_ACCESS(maps)->maps_by_name =3D new;
> >
> > -       if (first)
> > -               return rb_entry(first, struct map_rb_node, rb_node);
> > -       return NULL;
> >  }
> >
> > -static struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
> > +static bool maps__maps_by_address_sorted(const struct maps *maps)
> >  {
> > -       struct rb_node *next;
> > -
> > -       if (!node)
> > -               return NULL;
> > -
> > -       next =3D rb_next(&node->rb_node);
> > +       return RC_CHK_ACCESS(maps)->maps_by_address_sorted;
> > +}
> >
> > -       if (!next)
> > -               return NULL;
> > +static void maps__set_maps_by_address_sorted(struct maps *maps, bool v=
alue)
> > +{
> > +       RC_CHK_ACCESS(maps)->maps_by_address_sorted =3D value;
> > +}
> >
> > -       return rb_entry(next, struct map_rb_node, rb_node);
> > +static bool maps__maps_by_name_sorted(const struct maps *maps)
> > +{
> > +       return RC_CHK_ACCESS(maps)->maps_by_name_sorted;
> >  }
> >
> > -static struct map_rb_node *maps__find_node(struct maps *maps, struct m=
ap *map)
> > +static void maps__set_maps_by_name_sorted(struct maps *maps, bool valu=
e)
> >  {
> > -       struct map_rb_node *rb_node;
> > +       RC_CHK_ACCESS(maps)->maps_by_name_sorted =3D value;
> > +}
> >
> > -       maps__for_each_entry(maps, rb_node) {
> > -               if (rb_node->RC_CHK_ACCESS(map) =3D=3D RC_CHK_ACCESS(ma=
p))
> > -                       return rb_node;
> > -       }
> > -       return NULL;
> > +static struct rw_semaphore *maps__lock(struct maps *maps)
> > +{
> > +       /*
> > +        * When the lock is acquired or released the maps invariants sh=
ould
> > +        * hold.
> > +        */
> > +       check_invariants(maps);
> > +       return &RC_CHK_ACCESS(maps)->lock;
> >  }
> >
> >  static void maps__init(struct maps *maps, struct machine *machine)
> >  {
> > -       refcount_set(maps__refcnt(maps), 1);
> >         init_rwsem(maps__lock(maps));
> > -       RC_CHK_ACCESS(maps)->entries =3D RB_ROOT;
> > +       RC_CHK_ACCESS(maps)->maps_by_address =3D NULL;
> > +       RC_CHK_ACCESS(maps)->maps_by_name =3D NULL;
> >         RC_CHK_ACCESS(maps)->machine =3D machine;
> > -       RC_CHK_ACCESS(maps)->last_search_by_name =3D NULL;
> > +#ifdef HAVE_LIBUNWIND_SUPPORT
> > +       RC_CHK_ACCESS(maps)->addr_space =3D NULL;
> > +       RC_CHK_ACCESS(maps)->unwind_libunwind_ops =3D NULL;
> > +#endif
> > +       refcount_set(maps__refcnt(maps), 1);
> >         RC_CHK_ACCESS(maps)->nr_maps =3D 0;
> > -       RC_CHK_ACCESS(maps)->maps_by_name =3D NULL;
> > +       RC_CHK_ACCESS(maps)->nr_maps_allocated =3D 0;
> > +       RC_CHK_ACCESS(maps)->last_search_by_name_idx =3D 0;
> > +       RC_CHK_ACCESS(maps)->maps_by_address_sorted =3D true;
> > +       RC_CHK_ACCESS(maps)->maps_by_name_sorted =3D false;
> >  }
> >
> > -static void __maps__free_maps_by_name(struct maps *maps)
> > +static void maps__exit(struct maps *maps)
> >  {
> > -       /*
> > -        * Free everything to try to do it from the rbtree in the next =
search
> > -        */
> > -       for (unsigned int i =3D 0; i < maps__nr_maps(maps); i++)
> > -               map__put(maps__maps_by_name(maps)[i]);
> > +       struct map **maps_by_address =3D maps__maps_by_address(maps);
> > +       struct map **maps_by_name =3D maps__maps_by_name(maps);
> >
> > -       zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
> > -       RC_CHK_ACCESS(maps)->nr_maps_allocated =3D 0;
> > +       for (unsigned int i =3D 0; i < maps__nr_maps(maps); i++) {
> > +               map__zput(maps_by_address[i]);
> > +               if (maps_by_name)
> > +                       map__zput(maps_by_name[i]);
> > +       }
> > +       zfree(&maps_by_address);
> > +       zfree(&maps_by_name);
> > +       unwind__finish_access(maps);
> >  }
> >
> > -static int __maps__insert(struct maps *maps, struct map *map)
> > +struct maps *maps__new(struct machine *machine)
> >  {
> > -       struct rb_node **p =3D &maps__entries(maps)->rb_node;
> > -       struct rb_node *parent =3D NULL;
> > -       const u64 ip =3D map__start(map);
> > -       struct map_rb_node *m, *new_rb_node;
> > -
> > -       new_rb_node =3D malloc(sizeof(*new_rb_node));
> > -       if (!new_rb_node)
> > -               return -ENOMEM;
> > -
> > -       RB_CLEAR_NODE(&new_rb_node->rb_node);
> > -       new_rb_node->map =3D map__get(map);
> > +       struct maps *result;
> > +       RC_STRUCT(maps) *maps =3D zalloc(sizeof(*maps));
> >
> > -       while (*p !=3D NULL) {
> > -               parent =3D *p;
> > -               m =3D rb_entry(parent, struct map_rb_node, rb_node);
> > -               if (ip < map__start(m->map))
> > -                       p =3D &(*p)->rb_left;
> > -               else
> > -                       p =3D &(*p)->rb_right;
> > -       }
> > +       if (ADD_RC_CHK(result, maps))
> > +               maps__init(result, machine);
> >
> > -       rb_link_node(&new_rb_node->rb_node, parent, p);
> > -       rb_insert_color(&new_rb_node->rb_node, maps__entries(maps));
> > -       return 0;
> > +       return result;
> >  }
> >
> > -int maps__insert(struct maps *maps, struct map *map)
> > +static void maps__delete(struct maps *maps)
> >  {
> > -       int err;
> > -       const struct dso *dso =3D map__dso(map);
> > -
> > -       down_write(maps__lock(maps));
> > -       err =3D __maps__insert(maps, map);
> > -       if (err)
> > -               goto out;
> > +       maps__exit(maps);
> > +       RC_CHK_FREE(maps);
> > +}
> >
> > -       ++RC_CHK_ACCESS(maps)->nr_maps;
> > +struct maps *maps__get(struct maps *maps)
> > +{
> > +       struct maps *result;
> >
> > -       if (dso && dso->kernel) {
> > -               struct kmap *kmap =3D map__kmap(map);
> > +       if (RC_CHK_GET(result, maps))
> > +               refcount_inc(maps__refcnt(maps));
> >
> > -               if (kmap)
> > -                       kmap->kmaps =3D maps;
> > -               else
> > -                       pr_err("Internal error: kernel dso with non ker=
nel map\n");
> > -       }
> > +       return result;
> > +}
> >
> > +void maps__put(struct maps *maps)
> > +{
> > +       if (maps && refcount_dec_and_test(maps__refcnt(maps)))
> > +               maps__delete(maps);
> > +       else
> > +               RC_CHK_PUT(maps);
> > +}
> >
> > +static void __maps__free_maps_by_name(struct maps *maps)
> > +{
> >         /*
> > -        * If we already performed some search by name, then we need to=
 add the just
> > -        * inserted map and resort.
> > +        * Free everything to try to do it from the rbtree in the next =
search
> >          */
> > -       if (maps__maps_by_name(maps)) {
> > -               if (maps__nr_maps(maps) > RC_CHK_ACCESS(maps)->nr_maps_=
allocated) {
> > -                       int nr_allocate =3D maps__nr_maps(maps) * 2;
> > -                       struct map **maps_by_name =3D realloc(maps__map=
s_by_name(maps),
> > -                                                           nr_allocate=
 * sizeof(map));
> > +       for (unsigned int i =3D 0; i < maps__nr_maps(maps); i++)
> > +               map__put(maps__maps_by_name(maps)[i]);
> >
> > -                       if (maps_by_name =3D=3D NULL) {
> > -                               __maps__free_maps_by_name(maps);
> > -                               err =3D -ENOMEM;
> > -                               goto out;
> > -                       }
> > +       zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
> > +}
> >
> > -                       RC_CHK_ACCESS(maps)->maps_by_name =3D maps_by_n=
ame;
> > -                       RC_CHK_ACCESS(maps)->nr_maps_allocated =3D nr_a=
llocate;
> > +static int map__start_cmp(const void *a, const void *b)
> > +{
> > +       const struct map *map_a =3D *(const struct map * const *)a;
> > +       const struct map *map_b =3D *(const struct map * const *)b;
> > +       u64 map_a_start =3D map__start(map_a);
> > +       u64 map_b_start =3D map__start(map_b);
> > +
> > +       if (map_a_start =3D=3D map_b_start) {
> > +               u64 map_a_end =3D map__end(map_a);
> > +               u64 map_b_end =3D map__end(map_b);
> > +
> > +               if  (map_a_end =3D=3D map_b_end) {
> > +                       /* Ensure maps with the same addresses have a f=
ixed order. */
> > +                       if (RC_CHK_ACCESS(map_a) =3D=3D RC_CHK_ACCESS(m=
ap_b))
> > +                               return 0;
> > +                       return (intptr_t)RC_CHK_ACCESS(map_a) > (intptr=
_t)RC_CHK_ACCESS(map_b)
> > +                               ? 1 : -1;
> >                 }
> > -               maps__maps_by_name(maps)[maps__nr_maps(maps) - 1] =3D m=
ap__get(map);
> > -               __maps__sort_by_name(maps);
> > +               return map_a_end > map_b_end ? 1 : -1;
> >         }
> > - out:
> > -       up_write(maps__lock(maps));
> > -       return err;
> > +       return map_a_start > map_b_start ? 1 : -1;
> >  }
> >
> > -static void __maps__remove(struct maps *maps, struct map_rb_node *rb_n=
ode)
> > +static void __maps__sort_by_address(struct maps *maps)
> >  {
> > -       rb_erase_init(&rb_node->rb_node, maps__entries(maps));
> > -       map__put(rb_node->map);
> > -       free(rb_node);
> > +       if (maps__maps_by_address_sorted(maps))
> > +               return;
> > +
> > +       qsort(maps__maps_by_address(maps),
> > +               maps__nr_maps(maps),
> > +               sizeof(struct map *),
> > +               map__start_cmp);
> > +       maps__set_maps_by_address_sorted(maps, true);
> >  }
> >
> > -void maps__remove(struct maps *maps, struct map *map)
> > +static void maps__sort_by_address(struct maps *maps)
> >  {
> > -       struct map_rb_node *rb_node;
> > -
> >         down_write(maps__lock(maps));
> > -       if (RC_CHK_ACCESS(maps)->last_search_by_name =3D=3D map)
> > -               RC_CHK_ACCESS(maps)->last_search_by_name =3D NULL;
> > -
> > -       rb_node =3D maps__find_node(maps, map);
> > -       assert(rb_node->RC_CHK_ACCESS(map) =3D=3D RC_CHK_ACCESS(map));
> > -       __maps__remove(maps, rb_node);
> > -       if (maps__maps_by_name(maps))
> > -               __maps__free_maps_by_name(maps);
> > -       --RC_CHK_ACCESS(maps)->nr_maps;
> > +       __maps__sort_by_address(maps);
> >         up_write(maps__lock(maps));
> >  }
> >
> > -static void __maps__purge(struct maps *maps)
> > +static int map__strcmp(const void *a, const void *b)
> >  {
> > -       struct map_rb_node *pos, *next;
> > -
> > -       if (maps__maps_by_name(maps))
> > -               __maps__free_maps_by_name(maps);
> > +       const struct map *map_a =3D *(const struct map * const *)a;
> > +       const struct map *map_b =3D *(const struct map * const *)b;
> > +       const struct dso *dso_a =3D map__dso(map_a);
> > +       const struct dso *dso_b =3D map__dso(map_b);
> > +       int ret =3D strcmp(dso_a->short_name, dso_b->short_name);
> >
> > -       maps__for_each_entry_safe(maps, pos, next) {
> > -               rb_erase_init(&pos->rb_node,  maps__entries(maps));
> > -               map__put(pos->map);
> > -               free(pos);
> > +       if (ret =3D=3D 0 && RC_CHK_ACCESS(map_a) !=3D RC_CHK_ACCESS(map=
_b)) {
> > +               /* Ensure distinct but name equal maps have an order. *=
/
> > +               return map__start_cmp(a, b);
> >         }
> > +       return ret;
> >  }
> >
> > -static void maps__exit(struct maps *maps)
> > +static int maps__sort_by_name(struct maps *maps)
> >  {
> > +       int err =3D 0;
> >         down_write(maps__lock(maps));
> > -       __maps__purge(maps);
> > +       if (!maps__maps_by_name_sorted(maps)) {
> > +               struct map **maps_by_name =3D maps__maps_by_name(maps);
> > +
> > +               if (!maps_by_name) {
> > +                       maps_by_name =3D malloc(RC_CHK_ACCESS(maps)->nr=
_maps_allocated *
> > +                                       sizeof(*maps_by_name));
> > +                       if (!maps_by_name)
> > +                               err =3D -ENOMEM;
> > +                       else {
> > +                               struct map **maps_by_address =3D maps__=
maps_by_address(maps);
> > +                               unsigned int n =3D maps__nr_maps(maps);
> > +
> > +                               maps__set_maps_by_name(maps, maps_by_na=
me);
> > +                               for (unsigned int i =3D 0; i < n; i++)
> > +                                       maps_by_name[i] =3D map__get(ma=
ps_by_address[i]);
> > +                       }
> > +               }
> > +               if (!err) {
> > +                       qsort(maps_by_name,
> > +                               maps__nr_maps(maps),
> > +                               sizeof(struct map *),
> > +                               map__strcmp);
> > +                       maps__set_maps_by_name_sorted(maps, true);
> > +               }
> > +       }
> >         up_write(maps__lock(maps));
> > +       return err;
> >  }
> >
> > -bool maps__empty(struct maps *maps)
> > +static unsigned int maps__by_address_index(const struct maps *maps, co=
nst struct map *map)
> >  {
> > -       return !maps__first(maps);
> > +       struct map **maps_by_address =3D maps__maps_by_address(maps);
> > +
> > +       if (maps__maps_by_address_sorted(maps)) {
> > +               struct map **mapp =3D
> > +                       bsearch(&map, maps__maps_by_address(maps), maps=
__nr_maps(maps),
> > +                               sizeof(*mapp), map__start_cmp);
> > +
> > +               if (mapp)
> > +                       return mapp - maps_by_address;
> > +       } else {
> > +               for (unsigned int i =3D 0; i < maps__nr_maps(maps); i++=
) {
> > +                       if (RC_CHK_ACCESS(maps_by_address[i]) =3D=3D RC=
_CHK_ACCESS(map))
> > +                               return i;
> > +               }
> > +       }
> > +       pr_err("Map missing from maps");
> > +       return -1;
> >  }
> >
> > -struct maps *maps__new(struct machine *machine)
> > +static unsigned int maps__by_name_index(const struct maps *maps, const=
 struct map *map)
> >  {
> > -       struct maps *result;
> > -       RC_STRUCT(maps) *maps =3D zalloc(sizeof(*maps));
> > +       struct map **maps_by_name =3D maps__maps_by_name(maps);
> > +
> > +       if (maps__maps_by_name_sorted(maps)) {
> > +               struct map **mapp =3D
> > +                       bsearch(&map, maps_by_name, maps__nr_maps(maps)=
,
> > +                               sizeof(*mapp), map__strcmp);
> > +
> > +               if (mapp)
> > +                       return mapp - maps_by_name;
> > +       } else {
> > +               for (unsigned int i =3D 0; i < maps__nr_maps(maps); i++=
) {
> > +                       if (RC_CHK_ACCESS(maps_by_name[i]) =3D=3D RC_CH=
K_ACCESS(map))
> > +                               return i;
> > +               }
> > +       }
> > +       pr_err("Map missing from maps");
> > +       return -1;
> > +}
> >
> > -       if (ADD_RC_CHK(result, maps))
> > -               maps__init(result, machine);
> > +static int __maps__insert(struct maps *maps, struct map *new)
> > +{
> > +       struct map **maps_by_address =3D maps__maps_by_address(maps);
> > +       struct map **maps_by_name =3D maps__maps_by_name(maps);
> > +       const struct dso *dso =3D map__dso(new);
> > +       unsigned int nr_maps =3D maps__nr_maps(maps);
> > +       unsigned int nr_allocate =3D RC_CHK_ACCESS(maps)->nr_maps_alloc=
ated;
> > +
> > +       if (nr_maps + 1 > nr_allocate) {
> > +               nr_allocate =3D !nr_allocate ? 32 : nr_allocate * 2;
> > +
> > +               maps_by_address =3D realloc(maps_by_address, nr_allocat=
e * sizeof(new));
> > +               if (!maps_by_address)
> > +                       return -ENOMEM;
> > +
> > +               maps__set_maps_by_address(maps, maps_by_address);
> > +               if (maps_by_name) {
> > +                       maps_by_name =3D realloc(maps_by_name, nr_alloc=
ate * sizeof(new));
> > +                       if (!maps_by_name) {
> > +                               /*
> > +                                * If by name fails, just disable by na=
me and it will
> > +                                * recompute next time it is required.
> > +                                */
> > +                               __maps__free_maps_by_name(maps);
> > +                       }
> > +                       maps__set_maps_by_name(maps, maps_by_name);
> > +               }
> > +               RC_CHK_ACCESS(maps)->nr_maps_allocated =3D nr_allocate;
> > +       }
> > +       /* Insert the value at the end. */
> > +       maps_by_address[nr_maps] =3D map__get(new);
> > +       if (maps_by_name)
> > +               maps_by_name[nr_maps] =3D map__get(new);
> >
> > -       return result;
> > +       nr_maps++;
> > +       RC_CHK_ACCESS(maps)->nr_maps =3D nr_maps;
> > +
> > +       /*
> > +        * Recompute if things are sorted. If things are inserted in a =
sorted
> > +        * manner, for example by processing /proc/pid/maps, then no
> > +        * sorting/resorting will be necessary.
> > +        */
> > +       if (nr_maps =3D=3D 1) {
> > +               /* If there's just 1 entry then maps are sorted. */
> > +               maps__set_maps_by_address_sorted(maps, true);
> > +               maps__set_maps_by_name_sorted(maps, maps_by_name !=3D N=
ULL);
> > +       } else {
> > +               /* Sorted if maps were already sorted and this map star=
ts after the last one. */
> > +               maps__set_maps_by_address_sorted(maps,
> > +                       maps__maps_by_address_sorted(maps) &&
> > +                       map__end(maps_by_address[nr_maps - 2]) <=3D map=
__start(new));
> > +               maps__set_maps_by_name_sorted(maps, false);
> > +       }
> > +       if (map__end(new) < map__start(new))
> > +               RC_CHK_ACCESS(maps)->ends_broken =3D true;
> > +       if (dso && dso->kernel) {
> > +               struct kmap *kmap =3D map__kmap(new);
> > +
> > +               if (kmap)
> > +                       kmap->kmaps =3D maps;
> > +               else
> > +                       pr_err("Internal error: kernel dso with non ker=
nel map\n");
> > +       }
> > +       check_invariants(maps);
>
> Probably not needed as it's checked when you get the lock below.

Ack. Will remove in v3.

>
> > +       return 0;
> >  }
> >
> > -static void maps__delete(struct maps *maps)
> > +int maps__insert(struct maps *maps, struct map *map)
> >  {
> > -       maps__exit(maps);
> > -       unwind__finish_access(maps);
> > -       RC_CHK_FREE(maps);
> > +       int ret;
> > +
> > +       down_write(maps__lock(maps));
> > +       ret =3D __maps__insert(maps, map);
> > +       up_write(maps__lock(maps));
> > +       return ret;
> >  }
> >
> > -struct maps *maps__get(struct maps *maps)
> > +static void __maps__remove(struct maps *maps, struct map *map)
> >  {
> > -       struct maps *result;
> > +       struct map **maps_by_address =3D maps__maps_by_address(maps);
> > +       struct map **maps_by_name =3D maps__maps_by_name(maps);
> > +       unsigned int nr_maps =3D maps__nr_maps(maps);
> > +       unsigned int address_idx;
> > +
> > +       /* Slide later mappings over the one to remove */
> > +       address_idx =3D maps__by_address_index(maps, map);
> > +       map__put(maps_by_address[address_idx]);
> > +       memmove(&maps_by_address[address_idx],
> > +               &maps_by_address[address_idx + 1],
> > +               (nr_maps - address_idx - 1) * sizeof(*maps_by_address))=
;
> > +
> > +       if (maps_by_name) {
> > +               unsigned int name_idx =3D maps__by_name_index(maps, map=
);
> > +
> > +               map__put(maps_by_name[name_idx]);
> > +               memmove(&maps_by_name[name_idx],
> > +                       &maps_by_name[name_idx + 1],
> > +                       (nr_maps - name_idx - 1) *  sizeof(*maps_by_nam=
e));
> > +       }
> >
> > -       if (RC_CHK_GET(result, maps))
> > -               refcount_inc(maps__refcnt(maps));
> > +       --RC_CHK_ACCESS(maps)->nr_maps;
> > +       check_invariants(maps);
>
> Ditto.

Ack.

> > +}
> >
> > -       return result;
> > +void maps__remove(struct maps *maps, struct map *map)
> > +{
> > +       down_write(maps__lock(maps));
> > +       __maps__remove(maps, map);
> > +       up_write(maps__lock(maps));
> >  }
> >
> > -void maps__put(struct maps *maps)
> > +bool maps__empty(struct maps *maps)
> >  {
> > -       if (maps && refcount_dec_and_test(maps__refcnt(maps)))
> > -               maps__delete(maps);
> > -       else
> > -               RC_CHK_PUT(maps);
> > +       return maps__nr_maps(maps) =3D=3D 0;
> >  }
> >
> >  int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, v=
oid *data), void *data)
> >  {
> > -       struct map_rb_node *pos;
> > +       bool done =3D false;
> >         int ret =3D 0;
> >
> > -       down_read(maps__lock(maps));
> > -       maps__for_each_entry(maps, pos) {
> > -               ret =3D cb(pos->map, data);
> > -               if (ret)
> > -                       break;
> > +       /* See locking/sorting note. */
> > +       while (!done) {
> > +               down_read(maps__lock(maps));
> > +               if (maps__maps_by_address_sorted(maps)) {
> > +                       struct map **maps_by_address =3D maps__maps_by_=
address(maps);
> > +                       unsigned int n =3D maps__nr_maps(maps);
> > +
> > +                       for (unsigned int i =3D 0; i < n; i++) {
> > +                               struct map *map =3D maps_by_address[i];
> > +
> > +                               ret =3D cb(map, data);
> > +                               if (ret)
> > +                                       break;
> > +                       }
> > +                       done =3D true;
> > +               }
> > +               up_read(maps__lock(maps));
> > +               if (!done)
> > +                       maps__sort_by_address(maps);
> >         }
> > -       up_read(maps__lock(maps));
> >         return ret;
> >  }
> >
> >  void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, =
void *data), void *data)
> >  {
> > -       struct map_rb_node *pos, *next;
> > -       unsigned int start_nr_maps;
> > +       struct map **maps_by_address;
> >
> >         down_write(maps__lock(maps));
> >
> > -       start_nr_maps =3D maps__nr_maps(maps);
> > -       maps__for_each_entry_safe(maps, pos, next)      {
> > -               if (cb(pos->map, data)) {
> > -                       __maps__remove(maps, pos);
> > -                       --RC_CHK_ACCESS(maps)->nr_maps;
> > -               }
> > +       maps_by_address =3D maps__maps_by_address(maps);
> > +       for (unsigned int i =3D 0; i < maps__nr_maps(maps);) {
> > +               if (cb(maps_by_address[i], data))
> > +                       __maps__remove(maps, maps_by_address[i]);
> > +               else
> > +                       i++;
> >         }
> > -       if (maps__maps_by_name(maps) && start_nr_maps !=3D maps__nr_map=
s(maps))
> > -               __maps__free_maps_by_name(maps);
> > -
> >         up_write(maps__lock(maps));
> >  }
> >
> > @@ -300,7 +491,7 @@ struct symbol *maps__find_symbol(struct maps *maps,=
 u64 addr, struct map **mapp)
> >         /* Ensure map is loaded before using map->map_ip */
> >         if (map !=3D NULL && map__load(map) >=3D 0) {
> >                 if (mapp !=3D NULL)
> > -                       *mapp =3D map;
> > +                       *mapp =3D map; // TODO: map_put on else path wh=
en find returns a get.
> >                 return map__find_symbol(map, map__map_ip(map, addr));
> >         }
> >
> > @@ -348,7 +539,7 @@ int maps__find_ams(struct maps *maps, struct addr_m=
ap_symbol *ams)
> >         if (ams->addr < map__start(ams->ms.map) || ams->addr >=3D map__=
end(ams->ms.map)) {
> >                 if (maps =3D=3D NULL)
> >                         return -1;
> > -               ams->ms.map =3D maps__find(maps, ams->addr);
> > +               ams->ms.map =3D maps__find(maps, ams->addr);  // TODO: =
map_get
> >                 if (ams->ms.map =3D=3D NULL)
> >                         return -1;
> >         }
> > @@ -393,24 +584,28 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
> >   * Find first map where end > map->start.
> >   * Same as find_vma() in kernel.
> >   */
> > -static struct rb_node *first_ending_after(struct maps *maps, const str=
uct map *map)
> > +static unsigned int first_ending_after(struct maps *maps, const struct=
 map *map)
> >  {
> > -       struct rb_root *root;
> > -       struct rb_node *next, *first;
> > +       struct map **maps_by_address =3D maps__maps_by_address(maps);
> > +       int low =3D 0, high =3D (int)maps__nr_maps(maps) - 1, first =3D=
 high + 1;
> > +
> > +       assert(maps__maps_by_address_sorted(maps));
> > +       if (low <=3D high && map__end(maps_by_address[0]) > map__start(=
map))
> > +               return 0;
> >
> > -       root =3D maps__entries(maps);
> > -       next =3D root->rb_node;
> > -       first =3D NULL;
> > -       while (next) {
> > -               struct map_rb_node *pos =3D rb_entry(next, struct map_r=
b_node, rb_node);
> > +       while (low <=3D high) {
> > +               int mid =3D (low + high) / 2;
> > +               struct map *pos =3D maps_by_address[mid];
> >
> > -               if (map__end(pos->map) > map__start(map)) {
> > -                       first =3D next;
> > -                       if (map__start(pos->map) <=3D map__start(map))
> > +               if (map__end(pos) > map__start(map)) {
> > +                       first =3D mid;
> > +                       if (map__start(pos) <=3D map__start(map)) {
> > +                               /* Entry overlaps map. */
> >                                 break;
> > -                       next =3D next->rb_left;
> > +                       }
> > +                       high =3D mid - 1;
> >                 } else
> > -                       next =3D next->rb_right;
> > +                       low =3D mid + 1;
> >         }
> >         return first;
> >  }
> > @@ -419,171 +614,249 @@ static struct rb_node *first_ending_after(struc=
t maps *maps, const struct map *m
> >   * Adds new to maps, if new overlaps existing entries then the existin=
g maps are
> >   * adjusted or removed so that new fits without overlapping any entrie=
s.
> >   */
> > -int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> > +static int __maps__fixup_overlap_and_insert(struct maps *maps, struct =
map *new)
> >  {
> > -
> > -       struct rb_node *next;
> > +       struct map **maps_by_address;
> >         int err =3D 0;
> >         FILE *fp =3D debug_file();
> >
> > -       down_write(maps__lock(maps));
> > +sort_again:
> > +       if (!maps__maps_by_address_sorted(maps))
> > +               __maps__sort_by_address(maps);
> >
> > -       next =3D first_ending_after(maps, new);
> > -       while (next && !err) {
> > -               struct map_rb_node *pos =3D rb_entry(next, struct map_r=
b_node, rb_node);
> > -               next =3D rb_next(&pos->rb_node);
> > +       maps_by_address =3D maps__maps_by_address(maps);
> > +       /*
> > +        * Iterate through entries where the end of the existing entry =
is
> > +        * greater-than the new map's start.
> > +        */
> > +       for (unsigned int i =3D first_ending_after(maps, new); i < maps=
__nr_maps(maps); ) {
> > +               struct map *pos =3D maps_by_address[i];
> > +               struct map *before =3D NULL, *after =3D NULL;
> >
> >                 /*
> >                  * Stop if current map starts after map->end.
> >                  * Maps are ordered by start: next will not overlap for=
 sure.
> >                  */
> > -               if (map__start(pos->map) >=3D map__end(new))
> > +               if (map__start(pos) >=3D map__end(new))
> >                         break;
> >
> > -               if (verbose >=3D 2) {
> > -
> > -                       if (use_browser) {
> > -                               pr_debug("overlapping maps in %s (disab=
le tui for more info)\n",
> > -                                        map__dso(new)->name);
> > -                       } else {
> > -                               pr_debug("overlapping maps:\n");
> > -                               map__fprintf(new, fp);
> > -                               map__fprintf(pos->map, fp);
> > -                       }
> > +               if (use_browser) {
> > +                       pr_debug("overlapping maps in %s (disable tui f=
or more info)\n",
> > +                               map__dso(new)->name);
> > +               } else if (verbose >=3D 2) {
> > +                       pr_debug("overlapping maps:\n");
> > +                       map__fprintf(new, fp);
> > +                       map__fprintf(pos, fp);
> >                 }
> >
> > -               rb_erase_init(&pos->rb_node, maps__entries(maps));
> >                 /*
> >                  * Now check if we need to create new maps for areas no=
t
> >                  * overlapped by the new map:
> >                  */
> > -               if (map__start(new) > map__start(pos->map)) {
> > -                       struct map *before =3D map__clone(pos->map);
> > +               if (map__start(new) > map__start(pos)) {
> > +                       /* Map starts within existing map. Need to shor=
ten the existing map. */
> > +                       before =3D map__clone(pos);
> >
> >                         if (before =3D=3D NULL) {
> >                                 err =3D -ENOMEM;
> > -                               goto put_map;
> > +                               goto out_err;
> >                         }
> > -
> >                         map__set_end(before, map__start(new));
> > -                       err =3D __maps__insert(maps, before);
> > -                       if (err) {
> > -                               map__put(before);
> > -                               goto put_map;
> > -                       }
> >
> >                         if (verbose >=3D 2 && !use_browser)
> >                                 map__fprintf(before, fp);
> > -                       map__put(before);
> >                 }
> > -
> > -               if (map__end(new) < map__end(pos->map)) {
> > -                       struct map *after =3D map__clone(pos->map);
> > +               if (map__end(new) < map__end(pos)) {
> > +                       /* The new map isn't as long as the existing ma=
p. */
> > +                       after =3D map__clone(pos);
> >
> >                         if (after =3D=3D NULL) {
> > +                               map__zput(before);
> >                                 err =3D -ENOMEM;
> > -                               goto put_map;
> > +                               goto out_err;
> >                         }
> >
> >                         map__set_start(after, map__end(new));
> > -                       map__add_pgoff(after, map__end(new) - map__star=
t(pos->map));
> > -                       assert(map__map_ip(pos->map, map__end(new)) =3D=
=3D
> > -                               map__map_ip(after, map__end(new)));
> > -                       err =3D __maps__insert(maps, after);
> > -                       if (err) {
> > -                               map__put(after);
> > -                               goto put_map;
> > -                       }
> > +                       map__add_pgoff(after, map__end(new) - map__star=
t(pos));
> > +                       assert(map__map_ip(pos, map__end(new)) =3D=3D
> > +                              map__map_ip(after, map__end(new)));
> > +
> >                         if (verbose >=3D 2 && !use_browser)
> >                                 map__fprintf(after, fp);
> > -                       map__put(after);
> >                 }
> > -put_map:
> > -               map__put(pos->map);
> > -               free(pos);
> > +               /*
> > +                * If adding one entry, for `before` or `after`, we can=
 replace
> > +                * the existing entry. If both `before` and `after` are
> > +                * necessary than an insert is needed. If the existing =
entry
> > +                * entirely overlaps the existing entry it can just be =
removed.
> > +                */
> > +               if (before) {
> > +                       map__put(maps_by_address[i]);
> > +                       maps_by_address[i] =3D before;
> > +                       /* Maps are still ordered, go to next one. */
> > +                       i++;
> > +                       if (after) {
> > +                               __maps__insert(maps, after);
> > +                               map__put(after);
> > +                               if (!maps__maps_by_address_sorted(maps)=
) {
> > +                                       /*
> > +                                        * Sorting broken so invariants=
 don't
> > +                                        * hold, sort and go again.
> > +                                        */
> > +                                       goto sort_again;
> > +                               }
> > +                               /*
> > +                                * Maps are still ordered, skip after a=
nd go to
> > +                                * next one (terminate loop).
> > +                                */
> > +                               i++;
> > +                       }
> > +               } else if (after) {
> > +                       map__put(maps_by_address[i]);
> > +                       maps_by_address[i] =3D after;
> > +                       /* Maps are ordered, go to next one. */
> > +                       i++;
> > +               } else {
> > +                       __maps__remove(maps, pos);
> > +                       /*
> > +                        * Maps are ordered but no need to increase `i`=
 as the
> > +                        * later maps were moved down.
> > +                        */
> > +               }
> > +               check_invariants(maps);
> >         }
> >         /* Add the map. */
> > -       err =3D __maps__insert(maps, new);
> > -       up_write(maps__lock(maps));
> > +       __maps__insert(maps, new);
> > +out_err:
> >         return err;
> >  }
> >
> > -int maps__copy_from(struct maps *maps, struct maps *parent)
> > +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> >  {
> >         int err;
> > -       struct map_rb_node *rb_node;
> >
> > +       down_write(maps__lock(maps));
> > +       err =3D  __maps__fixup_overlap_and_insert(maps, new);
> > +       up_write(maps__lock(maps));
> > +       return err;
> > +}
> > +
> > +int maps__copy_from(struct maps *dest, struct maps *parent)
> > +{
> > +       /* Note, if struct map were immutable then cloning could use re=
f counts. */
> > +       struct map **parent_maps_by_address;
> > +       int err =3D 0;
> > +       unsigned int n;
> > +
> > +       down_write(maps__lock(dest));
> >         down_read(maps__lock(parent));
> >
> > -       maps__for_each_entry(parent, rb_node) {
> > -               struct map *new =3D map__clone(rb_node->map);
> > +       parent_maps_by_address =3D maps__maps_by_address(parent);
> > +       n =3D maps__nr_maps(parent);
> > +       if (maps__empty(dest)) {
> > +               /* No existing mappings so just copy from parent to avo=
id reallocs in insert. */
> > +               unsigned int nr_maps_allocated =3D RC_CHK_ACCESS(parent=
)->nr_maps_allocated;
> > +               struct map **dest_maps_by_address =3D
> > +                       malloc(nr_maps_allocated * sizeof(struct map *)=
);
> > +               struct map **dest_maps_by_name =3D NULL;
> >
> > -               if (new =3D=3D NULL) {
> > +               if (!dest_maps_by_address)
> >                         err =3D -ENOMEM;
> > -                       goto out_unlock;
> > +               else {
> > +                       if (maps__maps_by_name(parent)) {
> > +                               dest_maps_by_name =3D
> > +                                       malloc(nr_maps_allocated * size=
of(struct map *));
> > +                       }
> > +
> > +                       RC_CHK_ACCESS(dest)->maps_by_address =3D dest_m=
aps_by_address;
> > +                       RC_CHK_ACCESS(dest)->maps_by_name =3D dest_maps=
_by_name;
> > +                       RC_CHK_ACCESS(dest)->nr_maps_allocated =3D nr_m=
aps_allocated;
> >                 }
> >
> > -               err =3D unwind__prepare_access(maps, new, NULL);
> > -               if (err)
> > -                       goto out_unlock;
> > +               for (unsigned int i =3D 0; !err && i < n; i++) {
> > +                       struct map *pos =3D parent_maps_by_address[i];
> > +                       struct map *new =3D map__clone(pos);
> >
> > -               err =3D maps__insert(maps, new);
> > -               if (err)
> > -                       goto out_unlock;
> > +                       if (!new)
> > +                               err =3D -ENOMEM;
> > +                       else {
> > +                               err =3D unwind__prepare_access(dest, ne=
w, NULL);
> > +                               if (!err) {
> > +                                       dest_maps_by_address[i] =3D new=
;
> > +                                       if (dest_maps_by_name)
> > +                                               dest_maps_by_name[i] =
=3D map__get(new);
> > +                                       RC_CHK_ACCESS(dest)->nr_maps =
=3D i + 1;
> > +                               }
> > +                       }
> > +                       if (err)
> > +                               map__put(new);
> > +               }
> > +               maps__set_maps_by_address_sorted(dest, maps__maps_by_ad=
dress_sorted(parent));
> > +               if (!err) {
> > +                       RC_CHK_ACCESS(dest)->last_search_by_name_idx =
=3D
> > +                               RC_CHK_ACCESS(parent)->last_search_by_n=
ame_idx;
> > +                       maps__set_maps_by_name_sorted(dest,
> > +                                               dest_maps_by_name &&
> > +                                               maps__maps_by_name_sort=
ed(parent));
> > +               } else {
> > +                       RC_CHK_ACCESS(dest)->last_search_by_name_idx =
=3D 0;
> > +                       maps__set_maps_by_name_sorted(dest, false);
> > +               }
> > +       } else {
> > +               /* Unexpected copying to a maps containing entries. */
> > +               for (unsigned int i =3D 0; !err && i < n; i++) {
> > +                       struct map *pos =3D parent_maps_by_address[i];
> > +                       struct map *new =3D map__clone(pos);
> >
> > -               map__put(new);
> > +                       if (!new)
> > +                               err =3D -ENOMEM;
> > +                       else {
> > +                               err =3D unwind__prepare_access(dest, ne=
w, NULL);
> > +                               if (!err)
> > +                                       err =3D maps__insert(dest, new)=
;
>
> Shouldn't it be __maps__insert()?

On entry the read lock is taken on parent but no lock is taken on dest
so the locked version is used.

> > +                       }
> > +                       map__put(new);
> > +               }
> >         }
> > -
> > -       err =3D 0;
> > -out_unlock:
> >         up_read(maps__lock(parent));
> > +       up_write(maps__lock(dest));
> >         return err;
> >  }
> >
> > -struct map *maps__find(struct maps *maps, u64 ip)
> > +static int map__addr_cmp(const void *key, const void *entry)
> >  {
> > -       struct rb_node *p;
> > -       struct map_rb_node *m;
> > -
> > +       const u64 ip =3D *(const u64 *)key;
> > +       const struct map *map =3D *(const struct map * const *)entry;
> >
> > -       down_read(maps__lock(maps));
> > -
> > -       p =3D maps__entries(maps)->rb_node;
> > -       while (p !=3D NULL) {
> > -               m =3D rb_entry(p, struct map_rb_node, rb_node);
> > -               if (ip < map__start(m->map))
> > -                       p =3D p->rb_left;
> > -               else if (ip >=3D map__end(m->map))
> > -                       p =3D p->rb_right;
> > -               else
> > -                       goto out;
> > -       }
> > -
> > -       m =3D NULL;
> > -out:
> > -       up_read(maps__lock(maps));
> > -       return m ? m->map : NULL;
> > +       if (ip < map__start(map))
> > +               return -1;
> > +       if (ip >=3D map__end(map))
> > +               return 1;
> > +       return 0;
> >  }
> >
> > -static int map__strcmp(const void *a, const void *b)
> > +struct map *maps__find(struct maps *maps, u64 ip)
> >  {
> > -       const struct map *map_a =3D *(const struct map **)a;
> > -       const struct map *map_b =3D *(const struct map **)b;
> > -       const struct dso *dso_a =3D map__dso(map_a);
> > -       const struct dso *dso_b =3D map__dso(map_b);
> > -       int ret =3D strcmp(dso_a->short_name, dso_b->short_name);
> > -
> > -       if (ret =3D=3D 0 && map_a !=3D map_b) {
> > -               /*
> > -                * Ensure distinct but name equal maps have an order in=
 part to
> > -                * aid reference counting.
> > -                */
> > -               ret =3D (int)map__start(map_a) - (int)map__start(map_b)=
;
> > -               if (ret =3D=3D 0)
> > -                       ret =3D (int)((intptr_t)map_a - (intptr_t)map_b=
);
> > +       struct map *result =3D NULL;
> > +       bool done =3D false;
> > +
> > +       /* See locking/sorting note. */
> > +       while (!done) {
> > +               down_read(maps__lock(maps));
> > +               if (maps__maps_by_address_sorted(maps)) {
> > +                       struct map **mapp =3D
> > +                               bsearch(&ip, maps__maps_by_address(maps=
), maps__nr_maps(maps),
> > +                                       sizeof(*mapp), map__addr_cmp);
> > +
> > +                       if (mapp)
> > +                               result =3D *mapp; // map__get(*mapp);
> > +                       done =3D true;
> > +               }
> > +               up_read(maps__lock(maps));
> > +               if (!done)
> > +                       maps__sort_by_address(maps);
> >         }
> > -
> > -       return ret;
> > +       return result;
> >  }
> >
> >  static int map__strcmp_name(const void *name, const void *b)
> > @@ -593,126 +866,113 @@ static int map__strcmp_name(const void *name, c=
onst void *b)
> >         return strcmp(name, dso->short_name);
> >  }
> >
> > -void __maps__sort_by_name(struct maps *maps)
> > -{
> > -       qsort(maps__maps_by_name(maps), maps__nr_maps(maps), sizeof(str=
uct map *), map__strcmp);
> > -}
> > -
> > -static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
> > -{
> > -       struct map_rb_node *rb_node;
> > -       struct map **maps_by_name =3D realloc(maps__maps_by_name(maps),
> > -                                           maps__nr_maps(maps) * sizeo=
f(struct map *));
> > -       int i =3D 0;
> > -
> > -       if (maps_by_name =3D=3D NULL)
> > -               return -1;
> > -
> > -       up_read(maps__lock(maps));
> > -       down_write(maps__lock(maps));
> > -
> > -       RC_CHK_ACCESS(maps)->maps_by_name =3D maps_by_name;
> > -       RC_CHK_ACCESS(maps)->nr_maps_allocated =3D maps__nr_maps(maps);
> > -
> > -       maps__for_each_entry(maps, rb_node)
> > -               maps_by_name[i++] =3D map__get(rb_node->map);
> > -
> > -       __maps__sort_by_name(maps);
> > -
> > -       up_write(maps__lock(maps));
> > -       down_read(maps__lock(maps));
> > -
> > -       return 0;
> > -}
> > -
> > -static struct map *__maps__find_by_name(struct maps *maps, const char =
*name)
> > +struct map *maps__find_by_name(struct maps *maps, const char *name)
> >  {
> > -       struct map **mapp;
> > +       struct map *result =3D NULL;
> > +       bool done =3D false;
> >
> > -       if (maps__maps_by_name(maps) =3D=3D NULL &&
> > -           map__groups__sort_by_name_from_rbtree(maps))
> > -               return NULL;
> > +       /* See locking/sorting note. */
> > +       while (!done) {
> > +               unsigned int i;
> >
> > -       mapp =3D bsearch(name, maps__maps_by_name(maps), maps__nr_maps(=
maps),
> > -                      sizeof(*mapp), map__strcmp_name);
> > -       if (mapp)
> > -               return *mapp;
> > -       return NULL;
> > -}
> > +               down_read(maps__lock(maps));
> >
> > -struct map *maps__find_by_name(struct maps *maps, const char *name)
> > -{
> > -       struct map_rb_node *rb_node;
> > -       struct map *map;
> > -
> > -       down_read(maps__lock(maps));
> > +               /* First check last found entry. */
> > +               i =3D RC_CHK_ACCESS(maps)->last_search_by_name_idx;
> > +               if (i < maps__nr_maps(maps) && maps__maps_by_name(maps)=
) {
> > +                       struct dso *dso =3D map__dso(maps__maps_by_name=
(maps)[i]);
> >
> > +                       if (dso && strcmp(dso->short_name, name) =3D=3D=
 0) {
> > +                               result =3D maps__maps_by_name(maps)[i];=
 // TODO: map__get
> > +                               done =3D true;
> > +                       }
> > +               }
> >
> > -       if (RC_CHK_ACCESS(maps)->last_search_by_name) {
> > -               const struct dso *dso =3D map__dso(RC_CHK_ACCESS(maps)-=
>last_search_by_name);
> > +               /* Second search sorted array. */
> > +               if (!done && maps__maps_by_name_sorted(maps)) {
> > +                       struct map **mapp =3D
> > +                               bsearch(name, maps__maps_by_name(maps),=
 maps__nr_maps(maps),
> > +                                       sizeof(*mapp), map__strcmp_name=
);
> >
> > -               if (strcmp(dso->short_name, name) =3D=3D 0) {
> > -                       map =3D RC_CHK_ACCESS(maps)->last_search_by_nam=
e;
> > -                       goto out_unlock;
> > +                       if (mapp) {
> > +                               result =3D *mapp; // TODO: map__get
> > +                               i =3D mapp - maps__maps_by_name(maps);
> > +                               RC_CHK_ACCESS(maps)->last_search_by_nam=
e_idx =3D i;
> > +                       }
> > +                       done =3D true;
> >                 }
> > -       }
> > -       /*
> > -        * If we have maps->maps_by_name, then the name isn't in the rb=
tree,
> > -        * as maps->maps_by_name mirrors the rbtree when lookups by nam=
e are
> > -        * made.
> > -        */
> > -       map =3D __maps__find_by_name(maps, name);
> > -       if (map || maps__maps_by_name(maps) !=3D NULL)
> > -               goto out_unlock;
> > -
> > -       /* Fallback to traversing the rbtree... */
> > -       maps__for_each_entry(maps, rb_node) {
> > -               struct dso *dso;
> > -
> > -               map =3D rb_node->map;
> > -               dso =3D map__dso(map);
> > -               if (strcmp(dso->short_name, name) =3D=3D 0) {
> > -                       RC_CHK_ACCESS(maps)->last_search_by_name =3D ma=
p;
> > -                       goto out_unlock;
> > +               up_read(maps__lock(maps));
> > +               if (!done) {
> > +                       /* Sort and retry binary search. */
> > +                       if (maps__sort_by_name(maps)) {
> > +                               /*
> > +                                * Memory allocation failed do linear s=
earch
> > +                                * through address sorted maps.
> > +                                */
> > +                               struct map **maps_by_address;
> > +                               unsigned int n;
> > +
> > +                               down_read(maps__lock(maps));
> > +                               maps_by_address =3D  maps__maps_by_addr=
ess(maps);
> > +                               n =3D maps__nr_maps(maps);
> > +                               for (i =3D 0; i < n; i++) {
> > +                                       struct map *pos =3D maps_by_add=
ress[i];
> > +                                       struct dso *dso =3D map__dso(po=
s);
> > +
> > +                                       if (dso && strcmp(dso->short_na=
me, name) =3D=3D 0) {
> > +                                               result =3D pos; // TODO=
: map__get
> > +                                               break;
> > +                                       }
> > +                               }
> > +                               up_read(maps__lock(maps));
> > +                               done =3D true;
> > +                       }
> >                 }
> >         }
> > -       map =3D NULL;
> > -
> > -out_unlock:
> > -       up_read(maps__lock(maps));
> > -       return map;
> > +       return result;
> >  }
> >
> >  struct map *maps__find_next_entry(struct maps *maps, struct map *map)
> >  {
> > -       struct map_rb_node *rb_node =3D maps__find_node(maps, map);
> > -       struct map_rb_node *next =3D map_rb_node__next(rb_node);
> > +       unsigned int i;
> > +       struct map *result =3D NULL;
> >
> > -       if (next)
> > -               return next->map;
> > +       down_read(maps__lock(maps));
> > +       i =3D maps__by_address_index(maps, map);
> > +       if (i < maps__nr_maps(maps))
> > +               result =3D maps__maps_by_address(maps)[i]; // TODO: map=
__get
> >
> > -       return NULL;
> > +       up_read(maps__lock(maps));
> > +       return result;
> >  }
> >
> >  void maps__fixup_end(struct maps *maps)
> >  {
> > -       struct map_rb_node *prev =3D NULL, *curr;
> > +       struct map **maps_by_address;
> > +       unsigned int n;
> >
> >         down_write(maps__lock(maps));
> > +       if (!maps__maps_by_address_sorted(maps))
> > +               __maps__sort_by_address(maps);
> >
> > -       maps__for_each_entry(maps, curr) {
> > -               if (prev && (!map__end(prev->map) || map__end(prev->map=
) > map__start(curr->map)))
> > -                       map__set_end(prev->map, map__start(curr->map));
> > +       maps_by_address =3D maps__maps_by_address(maps);
> > +       n =3D maps__nr_maps(maps);
> > +       for (unsigned int i =3D 1; i < n; i++) {
> > +               struct map *prev =3D maps_by_address[i - 1];
> > +               struct map *curr =3D maps_by_address[i];
> >
> > -               prev =3D curr;
> > +               if (!map__end(prev) || map__end(prev) > map__start(curr=
))
> > +                       map__set_end(prev, map__start(curr));
> >         }
> >
> >         /*
> >          * We still haven't the actual symbols, so guess the
> >          * last map final address.
> >          */
> > -       if (curr && !map__end(curr->map))
> > -               map__set_end(curr->map, ~0ULL);
> > +       if (n > 0 && !map__end(maps_by_address[n - 1]))
> > +               map__set_end(maps_by_address[n - 1], ~0ULL);
> > +
> > +       RC_CHK_ACCESS(maps)->ends_broken =3D false;
> >
> >         up_write(maps__lock(maps));
> >  }
> > @@ -723,117 +983,92 @@ void maps__fixup_end(struct maps *maps)
> >   */
> >  int maps__merge_in(struct maps *kmaps, struct map *new_map)
> >  {
> > -       struct map_rb_node *rb_node;
> > -       struct rb_node *first;
> > -       bool overlaps;
> > -       LIST_HEAD(merged);
> > -       int err =3D 0;
> > +       unsigned int first_after_, kmaps__nr_maps;
> > +       struct map **kmaps_maps_by_address;
> > +       struct map **merged_maps_by_address;
> > +       unsigned int merged_nr_maps_allocated;
> > +
> > +       /* First try under a read lock. */
> > +       while (true) {
> > +               down_read(maps__lock(kmaps));
> > +               if (maps__maps_by_address_sorted(kmaps))
> > +                       break;
> >
> > -       down_read(maps__lock(kmaps));
> > -       first =3D first_ending_after(kmaps, new_map);
> > -       rb_node =3D first ? rb_entry(first, struct map_rb_node, rb_node=
) : NULL;
> > -       overlaps =3D rb_node && map__start(rb_node->map) < map__end(new=
_map);
> > -       up_read(maps__lock(kmaps));
> > +               up_read(maps__lock(kmaps));
> > +
> > +               /* First after binary search requires sorted maps. Sort=
 and try again. */
> > +               maps__sort_by_address(kmaps);
> > +       }
> > +       first_after_ =3D first_ending_after(kmaps, new_map);
> > +       kmaps_maps_by_address =3D maps__maps_by_address(kmaps);
> >
> > -       if (!overlaps)
> > +       if (first_after_ >=3D maps__nr_maps(kmaps) ||
> > +           map__start(kmaps_maps_by_address[first_after_]) >=3D map__e=
nd(new_map)) {
> > +               /* No overlap so regular insert suffices. */
> > +               up_read(maps__lock(kmaps));
> >                 return maps__insert(kmaps, new_map);
> > +       }
> > +       up_read(maps__lock(kmaps));
> >
> > -       maps__for_each_entry(kmaps, rb_node) {
> > -               struct map *old_map =3D rb_node->map;
> > +       /* Plain insert with a read-lock failed, try again now with the=
 write lock. */
> > +       down_write(maps__lock(kmaps));
> > +       if (!maps__maps_by_address_sorted(kmaps))
> > +               __maps__sort_by_address(kmaps);
> >
> > -               /* no overload with this one */
> > -               if (map__end(new_map) < map__start(old_map) ||
> > -                   map__start(new_map) >=3D map__end(old_map))
> > -                       continue;
> > +       first_after_ =3D first_ending_after(kmaps, new_map);
> > +       kmaps_maps_by_address =3D maps__maps_by_address(kmaps);
> > +       kmaps__nr_maps =3D maps__nr_maps(kmaps);
> >
> > -               if (map__start(new_map) < map__start(old_map)) {
> > -                       /*
> > -                        * |new......
> > -                        *       |old....
> > -                        */
> > -                       if (map__end(new_map) < map__end(old_map)) {
> > -                               /*
> > -                                * |new......|     -> |new..|
> > -                                *       |old....| ->       |old....|
> > -                                */
> > -                               map__set_end(new_map, map__start(old_ma=
p));
> > -                       } else {
> > -                               /*
> > -                                * |new.............| -> |new..|       =
|new..|
> > -                                *       |old....|    ->       |old....=
|
> > -                                */
> > -                               struct map_list_node *m =3D map_list_no=
de__new();
> > +       if (first_after_ >=3D kmaps__nr_maps ||
> > +           map__start(kmaps_maps_by_address[first_after_]) >=3D map__e=
nd(new_map)) {
> > +               /* No overlap so regular insert suffices. */
> > +               up_write(maps__lock(kmaps));
> > +               return maps__insert(kmaps, new_map);
>
> I think it could be:
>
>         ret =3D __maps__insert(kmaps, new_map);
>         up_write(maps__lock(kmaps));
>         return ret;

Ack. Will change in v3.

> > +       }
> > +       /* Array to merge into, possibly 1 more for the sake of new_map=
 */
> > +       merged_nr_maps_allocated =3D RC_CHK_ACCESS(kmaps)->nr_maps_allo=
cated;
> > +       if (kmaps__nr_maps + 1 =3D=3D merged_nr_maps_allocated)
> > +               merged_nr_maps_allocated++;
> > +
> > +       merged_maps_by_address =3D malloc(merged_nr_maps_allocated * si=
zeof(*merged_maps_by_address));
> > +       if (!merged_maps_by_address) {
> > +               up_write(maps__lock(kmaps));
> > +               return -ENOMEM;
> > +       }
> > +       RC_CHK_ACCESS(kmaps)->maps_by_address =3D merged_maps_by_addres=
s;
> > +       RC_CHK_ACCESS(kmaps)->maps_by_address_sorted =3D true;
> > +       zfree(&RC_CHK_ACCESS(kmaps)->maps_by_name);
> > +       RC_CHK_ACCESS(kmaps)->maps_by_name_sorted =3D false;
> > +       RC_CHK_ACCESS(kmaps)->nr_maps_allocated =3D merged_nr_maps_allo=
cated;
>
> Why not use the accessor functions?

Ack. I've been holding back on accessors that are used once, but I
will add them here.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > -                               if (!m) {
> > -                                       err =3D -ENOMEM;
> > -                                       goto out;
> > -                               }
> > +       /* Copy entries before the new_map that can't overlap. */
> > +       for (unsigned int i =3D 0; i < first_after_; i++)
> > +               merged_maps_by_address[i] =3D map__get(kmaps_maps_by_ad=
dress[i]);
> >
> > -                               m->map =3D map__clone(new_map);
> > -                               if (!m->map) {
> > -                                       free(m);
> > -                                       err =3D -ENOMEM;
> > -                                       goto out;
> > -                               }
> > +       RC_CHK_ACCESS(kmaps)->nr_maps =3D first_after_;
> >
> > -                               map__set_end(m->map, map__start(old_map=
));
> > -                               list_add_tail(&m->node, &merged);
> > -                               map__add_pgoff(new_map, map__end(old_ma=
p) - map__start(new_map));
> > -                               map__set_start(new_map, map__end(old_ma=
p));
> > -                       }
> > -               } else {
> > -                       /*
> > -                        *      |new......
> > -                        * |old....
> > -                        */
> > -                       if (map__end(new_map) < map__end(old_map)) {
> > -                               /*
> > -                                *      |new..|   -> x
> > -                                * |old.........| -> |old.........|
> > -                                */
> > -                               map__put(new_map);
> > -                               new_map =3D NULL;
> > -                               break;
> > -                       } else {
> > -                               /*
> > -                                *      |new......| ->         |new...|
> > -                                * |old....|        -> |old....|
> > -                                */
> > -                               map__add_pgoff(new_map, map__end(old_ma=
p) - map__start(new_map));
> > -                               map__set_start(new_map, map__end(old_ma=
p));
> > -                       }
> > -               }
> > -       }
> > +       /* Add the new map, it will be split when the later overlapping=
 mappings are added. */
> > +       __maps__insert(kmaps, new_map);
> >
> > -out:
> > -       while (!list_empty(&merged)) {
> > -               struct map_list_node *old_node;
> > +       /* Insert mappings after new_map, splitting new_map in the proc=
ess. */
> > +       for (unsigned int i =3D first_after_; i < kmaps__nr_maps; i++)
> > +               __maps__fixup_overlap_and_insert(kmaps, kmaps_maps_by_a=
ddress[i]);
> >
> > -               old_node =3D list_entry(merged.next, struct map_list_no=
de, node);
> > -               list_del_init(&old_node->node);
> > -               if (!err)
> > -                       err =3D maps__insert(kmaps, old_node->map);
> > -               map__put(old_node->map);
> > -               free(old_node);
> > -       }
> > +       /* Copy the maps from merged into kmaps. */
> > +       for (unsigned int i =3D 0; i < kmaps__nr_maps; i++)
> > +               map__zput(kmaps_maps_by_address[i]);
> >
> > -       if (new_map) {
> > -               if (!err)
> > -                       err =3D maps__insert(kmaps, new_map);
> > -               map__put(new_map);
> > -       }
> > -       return err;
> > +       free(kmaps_maps_by_address);
> > +       up_write(maps__lock(kmaps));
> > +       return 0;
> >  }
> >
> >  void maps__load_first(struct maps *maps)
> >  {
> > -       struct map_rb_node *first;
> > -
> >         down_read(maps__lock(maps));
> >
> > -       first =3D maps__first(maps);
> > -       if (first)
> > -               map__load(first->map);
> > +       if (maps__nr_maps(maps) > 0)
> > +               map__load(maps__maps_by_address(maps)[0]);
> >
> >         up_read(maps__lock(maps));
> >  }
> > diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> > index d836d04c9402..df9dd5a0e3c0 100644
> > --- a/tools/perf/util/maps.h
> > +++ b/tools/perf/util/maps.h
> > @@ -25,21 +25,56 @@ static inline struct map_list_node *map_list_node__=
new(void)
> >         return malloc(sizeof(struct map_list_node));
> >  }
> >
> > -struct map *maps__find(struct maps *maps, u64 addr);
> > +/*
> > + * Locking/sorting note:
> > + *
> > + * Sorting is done with the write lock, iteration and binary searching=
 happens
> > + * under the read lock requiring being sorted. There is a race between=
 sorting
> > + * releasing the write lock and acquiring the read lock for iteration/=
searching
> > + * where another thread could insert and break the sorting of the maps=
 In
> > + * practice inserting maps should be rare meaning that the race should=
n't lead
> > + * to live lock. Removal of maps doesn't break being sorted.
> > + */
> >
> >  DECLARE_RC_STRUCT(maps) {
> > -       struct rb_root      entries;
> >         struct rw_semaphore lock;
> > -       struct machine   *machine;
> > -       struct map       *last_search_by_name;
> > +       /**
> > +        * @maps_by_address: array of maps sorted by their starting add=
ress if
> > +        * maps_by_address_sorted is true.
> > +        */
> > +       struct map       **maps_by_address;
> > +       /**
> > +        * @maps_by_name: optional array of maps sorted by their dso na=
me if
> > +        * maps_by_name_sorted is true.
> > +        */
> >         struct map       **maps_by_name;
> > -       refcount_t       refcnt;
> > -       unsigned int     nr_maps;
> > -       unsigned int     nr_maps_allocated;
> > +       struct machine   *machine;
> >  #ifdef HAVE_LIBUNWIND_SUPPORT
> > -       void                            *addr_space;
> > +       void            *addr_space;
> >         const struct unwind_libunwind_ops *unwind_libunwind_ops;
> >  #endif
> > +       refcount_t       refcnt;
> > +       /**
> > +        * @nr_maps: number of maps_by_address, and possibly maps_by_na=
me,
> > +        * entries that contain maps.
> > +        */
> > +       unsigned int     nr_maps;
> > +       /**
> > +        * @nr_maps_allocated: number of entries in maps_by_address and=
 possibly
> > +        * maps_by_name.
> > +        */
> > +       unsigned int     nr_maps_allocated;
> > +       /**
> > +        * @last_search_by_name_idx: cache of last found by name entry'=
s index
> > +        * as frequent searches for the same dso name are common.
> > +        */
> > +       unsigned int     last_search_by_name_idx;
> > +       /** @maps_by_address_sorted: is maps_by_address sorted. */
> > +       bool             maps_by_address_sorted;
> > +       /** @maps_by_name_sorted: is maps_by_name sorted. */
> > +       bool             maps_by_name_sorted;
> > +       /** @ends_broken: does the map contain a map where end values a=
re unset/unsorted? */
> > +       bool             ends_broken;
> >  };
> >
> >  #define KMAP_NAME_LEN 256
> > @@ -102,6 +137,7 @@ size_t maps__fprintf(struct maps *maps, FILE *fp);
> >  int maps__insert(struct maps *maps, struct map *map);
> >  void maps__remove(struct maps *maps, struct map *map);
> >
> > +struct map *maps__find(struct maps *maps, u64 addr);
> >  struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct m=
ap **mapp);
> >  struct symbol *maps__find_symbol_by_name(struct maps *maps, const char=
 *name, struct map **mapp);
> >
> > @@ -117,8 +153,6 @@ struct map *maps__find_next_entry(struct maps *maps=
, struct map *map);
> >
> >  int maps__merge_in(struct maps *kmaps, struct map *new_map);
> >
> > -void __maps__sort_by_name(struct maps *maps);
> > -
> >  void maps__fixup_end(struct maps *maps);
> >
> >  void maps__load_first(struct maps *maps);
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
> >

