Return-Path: <linux-kernel+bounces-12281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520881F24C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F171F22F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B75481C8;
	Wed, 27 Dec 2023 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="djtb3RQw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A2481A3;
	Wed, 27 Dec 2023 22:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36D5C433C7;
	Wed, 27 Dec 2023 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703715006;
	bh=IsNop+8agQGKkYo5eY0cj9pIaFJSRadegBPPU7K7vBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djtb3RQwHbPOU168xGDiQ8WhknSl4qCpB3Dv5B2/0wTgBHtMmISEw4rF3MGjEPt0R
	 QA0He0895rEtX5IBfbdy2LI/LlFvrnjJryGTDKw6dWQ5LkbRh/deDbJR+wQ3+ZArd0
	 7Qb8LvIurV67ebK/j5NSgPR+5c+BqVHFk0pbNnEo=
Date: Wed, 27 Dec 2023 14:10:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: kernel test robot <lkp@intel.com>, andrey.konovalov@linux.dev, Marco
 Elver <elver@google.com>, oe-kbuild-all@lists.linux.dev, Linux Memory
 Management List <linux-mm@kvack.org>, Alexander Potapenko
 <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] kasan: stop leaking stack trace handles
Message-Id: <20231227141005.14e278c3f08dd0d64004dbf7@linux-foundation.org>
In-Reply-To: <CA+fCnZfZMhkqOvsvavJ-YTddY4kniP+sWFZRYy+nd3+8_C9hPA@mail.gmail.com>
References: <20231226225121.235865-1-andrey.konovalov@linux.dev>
	<202312280213.6j147JJb-lkp@intel.com>
	<20231227132311.557c302e92bdc9ffb88b42d5@linux-foundation.org>
	<CA+fCnZfZMhkqOvsvavJ-YTddY4kniP+sWFZRYy+nd3+8_C9hPA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Dec 2023 22:42:40 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> On Wed, Dec 27, 2023 at 10:23 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > Thanks, I added this fix:
> >
> > --- a/mm/kasan/generic.c~kasan-stop-leaking-stack-trace-handles-fix
> > +++ a/mm/kasan/generic.c
> > @@ -503,7 +503,7 @@ void kasan_init_object_meta(struct kmem_
> >          */
> >  }
> >
> > -void release_alloc_meta(struct kasan_alloc_meta *meta)
> > +static void release_alloc_meta(struct kasan_alloc_meta *meta)
> >  {
> >         /* Evict the stack traces from stack depot. */
> >         stack_depot_put(meta->alloc_track.stack);
> > @@ -514,7 +514,7 @@ void release_alloc_meta(struct kasan_all
> >         __memset(meta, 0, sizeof(*meta));
> >  }
> >
> > -void release_free_meta(const void *object, struct kasan_free_meta *meta)
> > +static void release_free_meta(const void *object, struct kasan_free_meta *meta)
> >  {
> >         /* Check if free meta is valid. */
> >         if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
> > _
> >
> 
> Could you mark them as "static inline" even?

That's rather old-fashioned.  Nowadays gcc is supposed to work out
whether or not to inline things, and we override that with noinline and
__always_inline.


