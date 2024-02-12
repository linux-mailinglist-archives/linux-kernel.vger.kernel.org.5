Return-Path: <linux-kernel+bounces-62343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA9851EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D711F226BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250341C93;
	Mon, 12 Feb 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDI/nHXU"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B01EB20
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770253; cv=none; b=oT9XWL0lPfJOo3S6XD1QdYYlj1xQ2iwT/oZ8Ysk2XPyXmw9KMu9pcsfGOVTHIovlasNYF3UFjp//0oQvS6VAv6Vnfxo/T4lyCsVwr+4MGqTLjthLmk9OKu8C04kW9es3GpKEoui4y5CXJXv5Gb+eT/i+JNro6kpq/5amyAaqGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770253; c=relaxed/simple;
	bh=0Xsn62CHAwZfzPgXua85w1HrUgM+rk5dPEmDrbkfjcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vme8o64VBxGPgm4SDBZVko8hfoOS9qMRJOTUSf2elwTGvhNCTVUhSvY5TX+CQi/ucqWnawze2f79BKLMNa9uoAe4lCkvUKkPeaQpTeBR3Un33nH0Dpp4pRHQarCK7oyJzEDrxeaqa1kA7GNANH0TtFhaesQRLQz3YwqFdPoHjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDI/nHXU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93b982761so1825ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707770250; x=1708375050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxAo8wnRkMugY5yAL0/bzNXwLaeP7jnxmRa56P+AWYU=;
        b=GDI/nHXUyCkPU+WL3CQJs4lztrv31b7i5c7vMkhGEGedJ3apYBd8nUjuXj9wNCwsIe
         tkZS0Ie7ktLy8Nj5gbJID9OQoWUjlKJSuc/B5vY8RmQzVGTxDVBgvUWXJV2UkTtJqIZX
         cA2uFFDmtWPnbLdnlXd+VbUgOAkTOQe8oyogBpj4XxkiWWSiH7EI9ChGjhRna7NC0hbE
         JyJ7hSYqLN8/HxiKtasjF1EkmtsVaGlOd6M2SCGoOr4ho6eeu9xlWuuixJNGMMjECh4w
         P90hS1GbVQkcMX3iX7BEznXW5WQ8NOYo/QLxa/WOYzngcs/bCQgHFQyPJkYGlraMioB5
         vv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770250; x=1708375050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxAo8wnRkMugY5yAL0/bzNXwLaeP7jnxmRa56P+AWYU=;
        b=Ki0NSLgRYn8YGSUll/Kj4iEu83XwN1AucpaJo78nu+0KNfWTwLKTDDbAAGfT/ypKIw
         s3Rp3tsT+L1Uq5xPTgn3UajmKCyaS2ct8dwpP+s/Tta5hMXEB8RM7qD+xNhJNKZGxfXY
         rUpHF8q7HVd32IK+111Pwiioowax0cq4u5/0da7DcO0d1Ue92RdCgX5MdkiSDzuJ0kRE
         vId0KQhXTYvhyuUVV/pubvijDHGW8JpBJ5DjXy2tsFXdU2BI06wVgA4NOk7csjmHBjJm
         A0k0jEp6dweguY6u2rMOQHAeX+/jidYrnWgcuicVYHhwDbmszKw/GDZ0MvC6bQPjrN2j
         6W9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa1qO0KLmJVEFi9Hyq8dPpdt1HmOWJeBt0Om+p5uP4nrc5dogqcV8BmRHTytOpiz9qBKzKnRCI4+CDJD9r4xnkgVXIQxeWaIkhcQgL
X-Gm-Message-State: AOJu0YxDEC6irI++duOBYOdm86YOON1NGAwEoWlzTSayM5iE+YG755vl
	LSPVB0mmTta5idnXK45J0a9bqfR3iV5OuNhWoA6xj5BcRi1QXycCBd57iobSipkLboUTJizAtF/
	QY6Gdo4zObplsXE1WE0269j0fVislm6L8G58g
X-Google-Smtp-Source: AGHT+IEer4Atvf7yBwurVXB4it6Jv8vd8j7pxJ/jYY9O7cLB6w+4DaI6YHHdG9i9PGa/IQLZ+ItAt598y2Kq+wtSkCo=
X-Received: by 2002:a17:902:9a94:b0:1d9:3524:3db2 with SMTP id
 w20-20020a1709029a9400b001d935243db2mr340700plp.11.1707770249632; Mon, 12 Feb
 2024 12:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com> <20240210031746.4057262-2-irogers@google.com>
 <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com>
 <CAP-5=fX7h9ku-XgjYe+3B5NWOJnapLnuJ_JqxywPaTu76VxazA@mail.gmail.com> <CAM9d7cgGAd7xEzwRxQFXoxpY9_gWduqYpy5jpp1zDTFjJqSxbw@mail.gmail.com>
In-Reply-To: <CAM9d7cgGAd7xEzwRxQFXoxpY9_gWduqYpy5jpp1zDTFjJqSxbw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Feb 2024 12:37:15 -0800
Message-ID: <CAP-5=fUR7X-vyE1XgB-=B0_D59QACmKSD_gCq0Sn=dvx2GYQ4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] perf maps: Switch from rbtree to lazily sorted
 array for addresses
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, leo.yan@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Feb 12, 2024 at 12:19=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Mon, Feb 12, 2024 at 12:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Fri, Feb 9, 2024 at 7:18=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > Maps is a collection of maps primarily sorted by the starting addre=
ss
> > > > of the map. Prior to this change the maps were held in an rbtree
> > > > requiring 4 pointers per node. Prior to reference count checking, t=
he
> > > > rbnode was embedded in the map so 3 pointers per node were
> > > > necessary. This change switches the rbtree to an array lazily sorte=
d
> > > > by address, much as the array sorting nodes by name. 1 pointer is
> > > > needed per node, but to avoid excessive resizing the backing array =
may
> > > > be twice the number of used elements. Meaning the memory overhead i=
s
> > > > roughly half that of the rbtree. For a perf record with
> > > > "--no-bpf-event -g -a" of true, the memory overhead of perf inject =
is
> > > > reduce fom 3.3MB to 3MB, so 10% or 300KB is saved.
> > > >
> > > > Map inserts always happen at the end of the array. The code tracks
> > > > whether the insertion violates the sorting property. O(log n) rb-tr=
ee
> > > > complexity is switched to O(1).
> > > >
> > > > Remove slides the array, so O(log n) rb-tree complexity is degraded=
 to
> > > > O(n).
> > > >
> > > > A find may need to sort the array using qsort which is O(n*log n), =
but
> > > > in general the maps should be sorted and so average performance sho=
uld
> > > > be O(log n) as with the rbtree.
> > > >
> > > > An rbtree node consumes a cache line, but with the array 4 nodes fi=
t
> > > > on a cache line. Iteration is simplified to scanning an array rathe=
r
> > > > than pointer chasing.
> > > >
> > > > Overall it is expected the performance after the change should be
> > > > comparable to before, but with half of the memory consumed.
> > > >
> > > > To avoid a list and repeated logic around splitting maps,
> > > > maps__merge_in is rewritten in terms of
> > > > maps__fixup_overlap_and_insert. maps_merge_in splits the given mapp=
ing
> > > > inserting remaining gaps. maps__fixup_overlap_and_insert splits the
> > > > existing mappings, then adds the incoming mapping. By adding the ne=
w
> > > > mapping first, then re-inserting the existing mappings the splittin=
g
> > > > behavior matches.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > [SNIP]
> > > >  int maps__for_each_map(struct maps *maps, int (*cb)(struct map *ma=
p, void *data), void *data)
> > > >  {
> > > > -       struct map_rb_node *pos;
> > > > +       bool done =3D false;
> > > >         int ret =3D 0;
> > > >
> > > > -       down_read(maps__lock(maps));
> > > > -       maps__for_each_entry(maps, pos) {
> > > > -               ret =3D cb(pos->map, data);
> > > > -               if (ret)
> > > > -                       break;
> > > > +       /* See locking/sorting note. */
> > > > +       while (!done) {
> > > > +               down_read(maps__lock(maps));
> > > > +               if (maps__maps_by_address_sorted(maps)) {
> > > > +                       /*
> > > > +                        * maps__for_each_map callbacks may buggily=
/unsafely
> > > > +                        * insert into maps_by_address. Deliberatel=
y reload
> > > > +                        * maps__nr_maps and maps_by_address on eac=
h iteration
> > > > +                        * to avoid using memory freed by maps__ins=
ert growing
> > > > +                        * the array - this may cause maps to be sk=
ipped or
> > > > +                        * repeated.
> > > > +                        */
> > > > +                       for (unsigned int i =3D 0; i < maps__nr_map=
s(maps); i++) {
> > > > +                               struct map **maps_by_address =3D ma=
ps__maps_by_address(maps);
> > >
> > > Any chance they can move out of the loop?  I guess not as they are
> > > not marked to const/pure functions..
> >
> > It's not because the cb(...) call below will potentially modify
> > maps_by_address by inserting maps and reallocating the array. Having
> > it outside the loop was what caused the original bug.
>
> Oh, I meant if compiler can move them automatically.

The const (on the accessor) isn't sufficient for that, they'd perhaps
need to be restrict. maps here is neither const or restrict which
means the callback can modify it (even though it isn't an argument)
and the function here needs to reload its value.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > >
> > >
> > > > +                               struct map *map =3D maps_by_address=
[i];
> > > > +
> > > > +                               ret =3D cb(map, data);
> > > > +                               if (ret)
> > > > +                                       break;
> > > > +                       }
> > > > +                       done =3D true;
> > > > +               }
> > > > +               up_read(maps__lock(maps));
> > > > +               if (!done)
> > > > +                       maps__sort_by_address(maps);
> > > >         }
> > > > -       up_read(maps__lock(maps));
> > > >         return ret;
> > > >  }

