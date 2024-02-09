Return-Path: <linux-kernel+bounces-60047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450A84FF15
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A521C2307F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D7199D6;
	Fri,  9 Feb 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4zXTH2ZV"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978CD294
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515003; cv=none; b=OvFKC4hREfnlnQpe5iz44nU8WzG6ixwhZ69BYRi7gI2feEt2wn28Z76y0lac4UfLdLHXj6RYu/dJKhGOOM9YDqp3ygjXLxDV4q/5kCHsZack2IY6BE92m6Wj8VBsZVVD1hrV/hq5ldPiW5//uPjJp2DkNGBWOHmymojeUn5Twl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515003; c=relaxed/simple;
	bh=GUGVJZz0j/leAk2+9ugZERuYuLtkxaoD94izsH3FRtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWgr4xzzIyDliVz9XBoKKY0Yu09ewwpUHel0sMFSJXkIlocpj/y2q0npK4BraVtStYEbqGrCHpdUtNxAgDo6Ke4GhZWyIPTahX4G04jf4WzzBwor2FVuTjyyb8KkQpk0cEklnmBpawKOiR08rqjXJ444TS3OuyKc9Q2GognH4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4zXTH2ZV; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so490316241.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707515000; x=1708119800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj2GMNRoF22PqzMsNmTv2wpG4JIjRj0EqZfL3mgSXs8=;
        b=4zXTH2ZV5s7dHPl3SJ5574nIkBkMByxO+0hrzkIpr4rj55HGPGz5GBUgrLsJmAKg5e
         tSJ087ADLWyahGD488CxXXU0gky/pG08vm9P/DNxdPlPTEOK+qnEFsdEwalDoE35c4W0
         pbe4he459uzKXlvu7ZV2cFQ4Je0X9X8hzUKWLn2zWyqDBI2BH2vkUtkk19/wvEtUWW/b
         U/oW8AbHJAiUqoHQKHwpZ6CkXXt/rmrVS+wCGAGxyMybNoizzJY2m3RWIGfYuXGIw2Kc
         fG/yIcbKWr+qjwWB0h+uWfHTRJyxm+53w8HflW48g6EJciMWaKNaAgRukyaFS6LHxQ6t
         CyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707515000; x=1708119800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rj2GMNRoF22PqzMsNmTv2wpG4JIjRj0EqZfL3mgSXs8=;
        b=uTN7ntySsJsetdplxGeYVzUPIUJ1oWhCDT3/j+olLO79Q1pj3Jlh00kkEkHFOmPc93
         GhAaSGBK4FOD/AcC6JgKTH4F1ebUsUUvZm1Cm8nKojMljY25r70/HfjiX9w2FAItRCv1
         vbkC5suyO/+rKgvSl8BAhLoha+O6H35wexcnlmfoDQDv6dz0DijwJ5trWtrHCSLztXzG
         9kG4cLk2LGnXWE9yj2SjEYB3mjLyJALdLwxu6kNK1FyrsFr1unZ8Q9nv4yeOls6t9B/S
         8V0u5eqFGmlMDvWOUIrqJDFOVNOFcZbkNFRYeupzXWg6Gef4jx+mj0nixC2VqhB4sgQg
         O2vw==
X-Forwarded-Encrypted: i=1; AJvYcCWfqyCtnGl4HWN2d0B9NSJNc8gg2GwDQOAbYm3PJ4yaqn/kzgdeJeOd34P18MKeohz5soK1WvDmAfOgJI1nDNt31l8iaIgU7K2yrWns
X-Gm-Message-State: AOJu0YyX9fy5fibiNnLzM0gg2YjOH7XJMkWMVe3jWlo6yla77JgFdYgn
	dfzssmgfuP0nxgWmqMwB4Cobq0P1T8kFUVY1q3ylsGmj++ZvZ8pjk03nggJ7w5cp1EeF/RWjB7O
	una/kQlNcWQ43Gdv3XITGpyrUn+7f6Uw7EucQ
X-Google-Smtp-Source: AGHT+IEC4GE15ZSicloYiR5OTdQoCKEboBIAZRSXVTAf0pFkXakE3bR9TjJNdMbs+uCHLe6jHBUFjrOQqIXw3yi/NGo=
X-Received: by 2002:a67:e441:0:b0:46d:2b0f:aeb8 with SMTP id
 n1-20020a67e441000000b0046d2b0faeb8mr676184vsm.11.1707515000356; Fri, 09 Feb
 2024 13:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-3-osalvador@suse.de>
 <CANpmjNOoYC93dt5hNmWsC2N8-7GuSp2L6Lb7mNOKxTGhreceUg@mail.gmail.com> <ZcabeMCHCkl3Bf6q@localhost.localdomain>
In-Reply-To: <ZcabeMCHCkl3Bf6q@localhost.localdomain>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 22:42:42 +0100
Message-ID: <CANpmjNPM4aKMWAmxWEMQ-Antq0jDFauOya2XHHX5RhnONucgrg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mm,page_owner: Implement the tracking of the
 stacks count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 22:37, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Fri, Feb 09, 2024 at 08:45:00AM +0100, Marco Elver wrote:
> > > +/**
> > > + * stack_depo_get_stack - Get a pointer to a stack struct
> >
> > Typo: "depo" -> depot
> >
> > I would also write "stack_record struct", because "stack struct" does not exist.
>
> Fixed.
>
> > > + * @handle: Stack depot handle
> > > + *
> > > + * Return: Returns a pointer to a stack struct
> > > + */
> > > +struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
> >
> > I don't know what other usecases there are for this, but I'd want to
> > make make sure we give users a big hint to avoid unnecessary uses of
> > this function.
> >
> > Perhaps we also want to mark it as somewhat internal, e.g. by
> > prefixing it with __. So I'd call it __stack_depot_get_stack_record().
>
> Yes, I went with __stack_depot_get_stack_record(), and I updated its doc
> in stackdepot.h, mentioning that is only for internal purposes.
>
> > > +static void inc_stack_record_count(depot_stack_handle_t handle)
> > > +{
> > > +       struct stack_record *stack = stack_depot_get_stack(handle);
> > > +
> > > +       if (stack)
> > > +               refcount_inc(&stack->count);
> > > +}
> >
> > In the latest stackdepot version in -next, the count is initialized to
> > REFCOUNT_SATURATED to warn if a non-refcounted entry is suddenly used
> > as a refcounted one. In your case this is intentional and there is no
> > risk that the entry will be evicted, so that's ok. But you need to set
> > the refcount to 1 somewhere here on the initial stack_depot_save().
>
> Well, I went with something like:
>
>  static void inc_stack_record_count(depot_stack_handle_t handle)
>  {
>          struct stack_record *stack = __stack_depot_get_stack_record(handle);
>
>          if (stack) {
>                  /*
>                   * New stack_records that do not use STACK_DEPOT_FLAG_GET start
>                   * with REFCOUNT_SATURATED to catch spurious increments of their
>                   * refcount.
>                   * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us

There is no FLAG_PUT, only stack_depot_put(). Saying you do not use
the refcount to free any entries should hopefully make it clear that
even if the refcount saturates and you wrap around to 1, nothing
catastrophic will happen.

>                   * set a refcount of 1 ourselves.
>                   */
>                  if (refcount_read(&stack->count) == REFCOUNT_SATURATED)
>                          refcount_set(&stack->count, 1);
>                  refcount_inc(&stack->count);
>          }
>  }

That looks reasonable.

