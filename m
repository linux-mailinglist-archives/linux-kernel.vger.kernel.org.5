Return-Path: <linux-kernel+bounces-62326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1F851E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84811C225FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13295482D4;
	Mon, 12 Feb 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11FMG5XN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F147A7A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769184; cv=none; b=qe8fuP8XrE0DQkRpNbV4iqTfd459e4mLVgQd4HcLiumnxPabW+hcJHsyf1zZc2ccz8sPnSejjjcZ+ocUlGx2fDYEr17kleFiFQd5CMXfx062N9zNh7DVG20jy+FE9RScP0/ZW5/M1V+LZ8Ic5UFobIGrDZ+vsU7rzPxuiOOtPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769184; c=relaxed/simple;
	bh=uJODUvONYUlc20hpmSj0J1uA1bYdfMjYs2on9f3uMaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMOyMYcbEH5BFlWpomDO2WzwJbYFVfLhwaPPWmedbEyClAIJFFJuINeuKpJQIxaqSJ8+qvwD7t5aKrIVpPl5TNc75v4bE+G/FnXIzwHUmM++rWLYKA+xugS6JJB4GpU/L+eQ0S3hbGjtoIc7mOJLuoYNsoUwRHh5df6IWin/OG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11FMG5XN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93b982761so49205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707769182; x=1708373982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icnm5yBA0aCxHiFxkqBy8LL31RhB/IB62tLF3Y2+Rh4=;
        b=11FMG5XNHfIstKlv1zF3fyvh+Of51VOIQ2onsVY8flJARraF4gjA5LIN+TFj2G1O5W
         JWiTYiKZ+SEZLn/+eX1i9XDfHJE+fcfUbAclkhxjoN9r6sxui/mioNKfqwkLfYqQ+lHA
         H77yyFuuYc9HakPkptohUGOu4QJ7/e3wzSYQXPcQm6A3o6wGW2MciPyiWFpIvEBBCqjj
         TI/wYJ34DXgJ6R5fHY/mLEUAuhJXGEUn2yghX4Mj2RL82+ltrj89lcoxG57yLODw4jGD
         0/dmZyZAP206IU2Bk/rFDz0iwPpsvL4FvZvmbQbPZDKX6ctgz3naW+Tl+PG6p3a/gQsg
         cRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769182; x=1708373982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Icnm5yBA0aCxHiFxkqBy8LL31RhB/IB62tLF3Y2+Rh4=;
        b=NWZdR9xqVA3cbQYUjHN/t6yjfxVnWHDoBmcKyo8Ui36DGZoWOuv5AwDNQ1ieLa0N1f
         RGMeuVdETtfMcr0TitekF1kCB0HLRpnZrvM/Oi1Q5JxiW0yBhXZknaao2erE15ipUvMF
         BNI6UzR72zd8JH6vrUOcn/fgRyX2thr5K5gu5E1oih5OYC6mNIEt6JaZAIknz28Wnifp
         YHhKgnV3/pjmmPrVdu4T9aNtHKToTFshdEgV0q5XfaIWb6/eQYTPU+hTiJw63x5cDNo/
         6OHlNhf5h+bUy4SoJZHWwrqbKq9NAsWeaAQSBg8lXnK79tc4vchavd9HbzyDNXFrSOlc
         yTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAa9Q//jHF6iVEWXHcXSxHk+QpjwaFi9yo/mBmNQoCACDa34tyI+Jn2YdtegI5/yEUjTtMyDnFy9tUeNSYxIcmt7brBtCVWvTDN5NP
X-Gm-Message-State: AOJu0YxXHPnqTRha+5Vbc9MOyUFcPJUrE46oIQrfkcZq3kCDs68sda7I
	CPJVMQYDM/NUI14/Li+UuCvT9sL/J9pD47uFTy48C1auuFQfcyFdJ1PfwrMcZlzZHzLOSuQPG/+
	J/1aq6Yd7Hof5aA1ANBI+GgbPn2VW80k45IIh
X-Google-Smtp-Source: AGHT+IFlMmc/VgL27uQvdpqBTW3rRUsQvhkAr01w85UMAaL7w4vejw2tDQTJNnyrG/NRrY5ESxZBez3SdEz5nMr0uSI=
X-Received: by 2002:a17:902:c1d4:b0:1d8:e076:21f3 with SMTP id
 c20-20020a170902c1d400b001d8e07621f3mr550plc.2.1707769181746; Mon, 12 Feb
 2024 12:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com> <20240210031746.4057262-2-irogers@google.com>
 <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com>
In-Reply-To: <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Feb 2024 12:19:26 -0800
Message-ID: <CAP-5=fX7h9ku-XgjYe+3B5NWOJnapLnuJ_JqxywPaTu76VxazA@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 12:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Feb 9, 2024 at 7:18=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
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
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> [SNIP]
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
> > +                       /*
> > +                        * maps__for_each_map callbacks may buggily/uns=
afely
> > +                        * insert into maps_by_address. Deliberately re=
load
> > +                        * maps__nr_maps and maps_by_address on each it=
eration
> > +                        * to avoid using memory freed by maps__insert =
growing
> > +                        * the array - this may cause maps to be skippe=
d or
> > +                        * repeated.
> > +                        */
> > +                       for (unsigned int i =3D 0; i < maps__nr_maps(ma=
ps); i++) {
> > +                               struct map **maps_by_address =3D maps__=
maps_by_address(maps);
>
> Any chance they can move out of the loop?  I guess not as they are
> not marked to const/pure functions..

It's not because the cb(...) call below will potentially modify
maps_by_address by inserting maps and reallocating the array. Having
it outside the loop was what caused the original bug.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
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

