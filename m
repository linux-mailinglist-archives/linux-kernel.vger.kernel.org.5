Return-Path: <linux-kernel+bounces-110483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD500885F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A871F2132E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B256768;
	Thu, 21 Mar 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQGswcMD"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40FB132C37
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041583; cv=none; b=Of8Nvz30L/vdNNfCNr56bfoGOAwrA50eGLLOLJDfyWkfaqbj7Pb1tIgWz2onX1I7uu/vtA3/hl+FH6DKkljKE9zFboQpeEFMayAhhEq1bzKNHfqdHX23WQwMvDZJiQtnTx+yQYrsf+S+w01aYcPueURK76dbMnSTjyCjZV3Z3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041583; c=relaxed/simple;
	bh=H+LJEeBQNsEayEy62NES0fpvH5c8qtUySXf9WjZsL7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU6bpo8bkQYYIV90womA7wHCGo5zYPOtAPPTLQFtk2a9VnRxT+OssaNlxPS0xSfG0LoJTN+/p9vj7iPBtrF7AukrUnTlKz1kV64OgQuDINy4igli5nDKVPs2qKx9BReUqQoo5J7PQNLum8nRJhj+CJh/5iCnQzwBVeajPG4sVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQGswcMD; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc73148611so1351008276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711041581; x=1711646381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqvfQSGh+Xzm8qjoxKwBWCT5Q1J0hViT+VZ+PA5jO/g=;
        b=wQGswcMDuplyRs8fUGwaOmGwqP4mg/LWEXFC8ArimCNwJDM+AN5v9S0xWnckBn0jk8
         UxqKp7QvM/RCvybCB0nL8IghAOSh6pPPc5flnZHOxIi3oS0qIFM/vX/GhEOZmV0vKSqf
         mIgHHK4zqQdRHGVqjgW7FF2HNkdsg8yHHp50lmbqURSFPylRlmaCEvgqJNAWffpiiJbU
         8X52om8QSE2Sm1Q3lQD0PE3FHALTwhYilwJ0SK6BLYDJrwvFestuWd7Un0QefYLohj2j
         PXDnP/+iBba3Y7kqD0gRUqnetLQaKGYWxaCyZsYmmazdgsNKXt5CQVg2pgOCfz5lWphV
         r/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041581; x=1711646381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqvfQSGh+Xzm8qjoxKwBWCT5Q1J0hViT+VZ+PA5jO/g=;
        b=pWisxHtWf0mKxR26StVsIZBrX0k4UV8M58m8RfM/FAawDjIYb+nFs4kn5narmBhnLI
         P7Su0OlyfEQAIeixg+XLouzH/OCrcXQJLgGp1HIqyMpK7KrPmlgvS+eMtzQR7uWMIIwY
         8TFQsYdp5iV+6Ippv/0f//QzD3MqRm8V62Mo7ozE3rQBS1y8HVnZapiotOhiI42s0HnX
         5Bd7Po9/nW+mLIh3APvujX2WCxeR4rSLmY+XHMqVMl9Nbod4HkqJH+/4DomS9K4W63WN
         SIUbuYa7m/RsrhQQnzOnbhxj6lVn8vOWvA9M602KHHOz/dnsMkpUd+pGYsAjRBJspkat
         tsTw==
X-Forwarded-Encrypted: i=1; AJvYcCUVexj7mtVgghmQzVGuWKphfSKQLoF74QJ2PN2P/UFp8xJBmeMQW4YnPY4q5jYaTjg4F6hM+Vo/gjfWfVutBEXE/QWp186sF5pZjmhz
X-Gm-Message-State: AOJu0YxjQKsplShsNQnSSbT935KAw/heNbCtzZM6uBwhO/gZTZFR+WND
	ncoZdRJ3/fcZbufMIBGK8vXiLRElduVkmwGMGAZo6EYaPLiwzL0bQph+PZTeO8J+R2Y9ilDJQp/
	2oUnqnZP0n9SpXioCRG0pPGj+4xPjXAPK1xJK
X-Google-Smtp-Source: AGHT+IFQSVcpwYKqTi4u5vLJp+bH/Ul0qxjQJHN69s16T75E6/ejSMbPrhKw6oCEZl5ggVcRzfP6qAeH1y6UeIwfGAA=
X-Received: by 2002:a25:dc4a:0:b0:dcd:4e54:9420 with SMTP id
 y71-20020a25dc4a000000b00dcd4e549420mr19795790ybe.5.1711041580565; Thu, 21
 Mar 2024 10:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-21-surenb@google.com>
 <Zfxk9aFhF7O_-T3c@casper.infradead.org> <ZfxohXDDCx-_cJYa@casper.infradead.org>
In-Reply-To: <ZfxohXDDCx-_cJYa@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Mar 2024 10:19:28 -0700
Message-ID: <CAJuCfpHjfKYNyGeALZzwJ1k_AKOm_qcgKkx5zR+X6eyWmsZTLw@mail.gmail.com>
Subject: Re: [PATCH v6 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
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

On Thu, Mar 21, 2024 at 10:04=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Mar 21, 2024 at 04:48:53PM +0000, Matthew Wilcox wrote:
> > On Thu, Mar 21, 2024 at 09:36:42AM -0700, Suren Baghdasaryan wrote:
> > > +++ b/mm/page_alloc.c
> > > @@ -4700,12 +4700,15 @@ void __free_pages(struct page *page, unsigned=
 int order)
> > >  {
> > >     /* get PageHead before we drop reference */
> > >     int head =3D PageHead(page);
> > > +   struct alloc_tag *tag =3D pgalloc_tag_get(page);
> > >
> > >     if (put_page_testzero(page))
> > >             free_the_page(page, order);
> > > -   else if (!head)
> > > +   else if (!head) {
> > > +           pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > >             while (order-- > 0)
> > >                     free_the_page(page + (1 << order), order);
> > > +   }
> >
> > Why do you need these new functions instead of just:
> >
> > +     else if (!head) {
> > +             pgalloc_tag_sub(page, (1 << order) - 1);
> >               while (order-- > 0)
> >                       free_the_page(page + (1 << order), order);
> > +     }
>
> Actually, I'm not sure this is safe (I don't fully understand codetags,
> so it may be safe).  What can happen is that the put_page() can come in
> before the pgalloc_tag_sub(), and then that page can be allocated again.
> Will that cause confusion?

So, there are two reasons I unfortunately can't reuse pgalloc_tag_sub():

1. We need to subtract `bytes` counter from the codetag but not the
`calls` counter, otherwise the final accounting will be incorrect.
This is because we effectively allocated multiple pages with one call
but freeing them with separate calls here. pgalloc_tag_sub_pages()
subtracts bytes but keeps calls counter the same. I mentioned this in
here: https://lore.kernel.org/all/CAJuCfpEgh1OiYNE_uKG-BqW2x97sOL9+AaTX4Jct=
3=3DWHzAv+kg@mail.gmail.com/
2. The codetag object itself is stable, it's created at build time.
The exception is when we unload modules and the codetag section gets
freed but during module unloading we check that all module codetags
are not referenced anymore and we prevent unloading this section if
any of them are still referenced (should not normally happen). That
said, the reference to the codetag (in this case from the page_ext)
might change from under us and we have to make sure it's valid. We
ensure that here by getting the codetag itself with pgalloc_tag_get()
*before* calling put_page_testzero(), which ensures its stability.

>

