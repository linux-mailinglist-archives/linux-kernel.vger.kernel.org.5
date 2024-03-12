Return-Path: <linux-kernel+bounces-100681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC1879BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571E01C20B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF3142621;
	Tue, 12 Mar 2024 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jm2PPML8"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012013E7DD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268906; cv=none; b=YTUFjdZa8Jd9jI6B3BViAKyQqdAE5StWfAaZw9ZYxoFs4g1x/IP1D6sbQQtz9xu6L+vUbhxUveAJbeQlxrDomIKo2hPmYTfOtBLZrjy1RHnxvm5s8PGNVcb0TeJ/ZzcU+ds5eHIsSAc8J/wtZ53cGWZ25tCvjzqkNsMjCkJSKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268906; c=relaxed/simple;
	bh=sqOb2aVxWzIRPNIud0HwvwVM+i0sQ6GOvRIk6ilU6Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abVxH28VMODjBQDVdY64T1SpWdsGkfiC6CXJSXLSwFaS6iUJABiEm2EPz7Juzyfk4rugqzLz97tmtyCM+jHqbC1X9N1FK5LAzByvXq6qx0/iSSaN7x509QwZHseQwXXG6RLFbXo92Q5TO/GVqJWgHBOY1Z41u4l8G99LoT1pMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jm2PPML8; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0a54869bso1393997b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710268903; x=1710873703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2MYgtHOHaU2CXGG9+oDczn4RM3zU0YZuyP5JPwAa+g=;
        b=Jm2PPML8v5quH3bfe9rqbFYY9G4GwVlCaraY/tLSQM7HjpeuXe1zxebYDAZ8wBAw6+
         kDr/TlcLRq1qk8yRwpnjK7CrCtepwcPhUeYeqk56n3XSf12jHS/KZnnxU+jainbKNqeo
         q5S7ybj8JKvWJwLW5I1Z7fmdAA0bGQkoO15gRuaYgH89HkolkZAiXS2Tn6JbxRg0f3e6
         ZAuBhgYERIlEIVfDRQMShMGpGTwPG+z4AcgqKLlEZmMpwNiRlE3HTtijk+0evSokROYG
         juZVO4fapxEkTUhAneKAa36gQvOZJlqp+xgF4OU4G8AdYdnJviV1bGUDZrZAFdIO4eGR
         0F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268903; x=1710873703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2MYgtHOHaU2CXGG9+oDczn4RM3zU0YZuyP5JPwAa+g=;
        b=bc17sQ/CID6NzmoyHEJjq03QX9Bu6Xub/BT8oUoqIiAvkHs3DkyISBL3pz6D6Av/RD
         ypaeI05Qn2ERek2ZwDDCSxjiJWWgDOT/ehv/uc5twI1ZmzyBHeZAP2lvx8c0v0i0H7+U
         WjVzG7B5Ug3lIEl+dEVeQtZzbBDBfpP4QtdufgcxhjgYNvo6clF35U+b6u+IvrCoSDrg
         HH7gI7kGxqckBSM800vsA+JcRa5YrHfCKyINX9GKPUvwatWOZtdg2gPhc6E7OwyS5mHU
         gE7ztnnqDZXfxZDrTQR76rGRbs/dHyujI3v8JFz+i/U+3UOcJRiYWN7KtYuE3wb0ZyVf
         4iRw==
X-Forwarded-Encrypted: i=1; AJvYcCU4EhhqLApVIJykghakPkHW4G4utSXJKIP5+9VIXNokuwJpU7Vf72BpFQlRfIIV6WTLh3+d/WIn3MmXSdK6U5tykGujWKbaGdchC4Qx
X-Gm-Message-State: AOJu0Yy2sqxv8Gviitp4Z4u3kraBpGD76Eo13yW8BsTlOXf4zZ6b2M8t
	ivj0nvXWaKH300DnPaMnuCdoeqmfwFUNBQvFTpMSJmr6uLmCj51xvClSsJtGia/AJzoyimZC5WT
	SK+A5/2ZG1MFQ9CBYTTUE/YetQPOXElAULlrV
X-Google-Smtp-Source: AGHT+IFJU+9YjFiJTRhIakZAUDsKxb4Ab6oaUlbKzNsmoW2Guyxj/oh9l2zNaCTqGzmRWVRumjgqHOm+DPQj+f7k6/8=
X-Received: by 2002:a81:e546:0:b0:609:c64a:f34b with SMTP id
 c6-20020a81e546000000b00609c64af34bmr292571ywm.22.1710268902597; Tue, 12 Mar
 2024 11:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-13-surenb@google.com>
 <ZfCdVI464EqeI9YP@bombadil.infradead.org>
In-Reply-To: <ZfCdVI464EqeI9YP@bombadil.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Mar 2024 11:41:28 -0700
Message-ID: <CAJuCfpFDY=+gmVytYY6iCYds5OW0gVfwrXguWWq0B0G1qq7hYQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] lib: prevent module unloading if memory is not freed
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:22=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Wed, Mar 06, 2024 at 10:24:10AM -0800, Suren Baghdasaryan wrote:
> > Skip freeing module's data section if there are non-zero allocation tag=
s
> > because otherwise, once these allocations are freed, the access to thei=
r
> > code tag would cause UAF.
>
> So you just let them linger?

Well, I think this is not a normal situation when a module allocated
some memory and then is being unloaded without freeing that memory,
no?

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
>
> >  /* Free a module, remove from lists, etc. */
> >  static void free_module(struct module *mod)
> >  {
> > +     bool unload_codetags;
> > +
> >       trace_module_free(mod);
> >
> > -     codetag_unload_module(mod);
> > +     unload_codetags =3D codetag_unload_module(mod);
> > +     if (!unload_codetags)
> > +             pr_warn("%s: memory allocation(s) from the module still a=
live, cannot unload cleanly\n",
> > +                     mod->name);
> > +
>
> Because this is not unwinding anything. Should'd we check if we can
> free all tags first, if we can't then we can't free the module. If we
> can then ensure we don't enter a state where we can't later?

unload_codetags already indicates that someone has a live reference to
one or more tags of that module, so we can't free them. Maybe I
misunderstood your suggestion?

>
>   Luis

