Return-Path: <linux-kernel+bounces-60048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63784FF16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF711C23239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D1199B4;
	Fri,  9 Feb 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvhpMrXg"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027C63B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515102; cv=none; b=t7Se5VICWVqOjMl4nNrPlbqG/RavpzGA+q/Uo7q53QCDF7f2RdPoofXMtHEWhDBr4jWepcfC9pdNqr11rnafrm1JoK4G2SaAa5KMhiuSEtem8ihKty+zvVIZPhrJ4bRsy2cVaF0oANLlrZWju836OE6dLFm9J5uNhqt8vXDgq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515102; c=relaxed/simple;
	bh=CCcqjaOfU78XPYHHJ5BCgwHxykBoRkB3PHAnaQWoiBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSaTFqXM2oS6TxTKTfR9j+CFhWMqvDwC8rwb7ky/PMEsvSAoNps70lq9ZtIJzgCTpwwVf8ShS+zk5SY6jJ0tO0IHa6QCljqFqTP8qMsrIlfkulQHzSByN6i2Bsbb0wyHFypIzWwcHuGkDoi0QBPOyvP2C5l7kovV+9s+nbAqI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvhpMrXg; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c035b3203dso364872e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707515099; x=1708119899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=et8tU5mdHwkCQtGabHsU2uKDCRclXXg4309BFtdcuZo=;
        b=DvhpMrXgxu/rBn/F/tunogFiTATcbk5JobbMpCFDJaprG4pxTSYG642cy2ubDkduAu
         hNjyRRsd7+u+Wk6t3e+qwmRZrolwkB3VzTCG8kCmVFuZDwyGoM41vgw8y+A4DCWuYv0C
         X4LsNY6SKYzSRXAtSvkmqVSUVwK97BtUXHn9legJtZ5He42w1prI8yrVe8j3Qf/fXiUk
         bPFMRTpIKjl/n15E8sqFYXHb7ufV+AB7UYqdkqHyND0y4sVpkB9pkalveM9nAdZWipiH
         SkC3dgX4wF8DrYq973X/yqFM8JfW1HoCljNkfIHHEV8/8TwPCb6wQ3Q5hGHox4kFqOVZ
         4P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707515099; x=1708119899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et8tU5mdHwkCQtGabHsU2uKDCRclXXg4309BFtdcuZo=;
        b=Tf4zgTkX+IHJrzjl4ZV+jmrk3WAL8R3tZ7xQafwDB7ui/T7SyX+dWyQ4SsMDV1tFe4
         IzuPiEzrj6HHwAYozQpDVB6o+LZYJ9ipXXc+JDXNyqhCO84fOWaH2CpT/wr4QMUe8wem
         ryE/QEqeWUPNrCKvnGMbSSko3mXBcv5gzu8+RPgklipMyNFWGysvkPvHuluxkNzUtZ1M
         JEzVpHJlzaqt2fy6u9fvzcQO0FzaX9u4dGrEshmbDtwpkEtmOFyeNCEsKSpc9/C2qW56
         +iWbLRKNfxw5FjD2EBKG/6NbT6ICCl9oecXmNqH3X7X3NJZSTzTnTFsQCCkc6Y6W9Lyc
         3Nxg==
X-Forwarded-Encrypted: i=1; AJvYcCWbHc7CEdBdqtl0TIkt36jAayacVj+N7MTRC9yIeAgQc9thtMyknP6JtZ95RGJ+au8CJtCUV5Zgg0WQ0HFK56ON4lX0JBVej/pTAOZ5
X-Gm-Message-State: AOJu0YzmEvU3UqDgF3TzUUCGYnznUHB4LhOBK2T8A2Qe83ohHquTZVYH
	n6/59alQpYbvRS2q22Dph8QxAtzbOQq06F4bZ+w91zha4eDTxsqpHVSDXZ3o8JtnSr5Zx3SnGN/
	MeQ2BIv89FreHOyCoLTpB7Pa5lssfoSiNb25h
X-Google-Smtp-Source: AGHT+IED4iO9Yz4f9meMJbcQBWw3TJedIDM1/gAdOAcEcQ3P6BcOuVEJ/72AnyHj9NUbD2Vy7AvV7t1wpubEjOwKpk8=
X-Received: by 2002:a1f:6281:0:b0:4bd:8926:8e15 with SMTP id
 w123-20020a1f6281000000b004bd89268e15mr747476vkb.0.1707515099445; Fri, 09 Feb
 2024 13:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-3-osalvador@suse.de>
 <CANpmjNOoYC93dt5hNmWsC2N8-7GuSp2L6Lb7mNOKxTGhreceUg@mail.gmail.com>
 <ZcabeMCHCkl3Bf6q@localhost.localdomain> <CANpmjNPM4aKMWAmxWEMQ-Antq0jDFauOya2XHHX5RhnONucgrg@mail.gmail.com>
In-Reply-To: <CANpmjNPM4aKMWAmxWEMQ-Antq0jDFauOya2XHHX5RhnONucgrg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 22:44:23 +0100
Message-ID: <CANpmjNP4H+FL-Jwq6Bpf1W0Rz2ZSn-ZquWf7tz4n57r1Jq6m_g@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mm,page_owner: Implement the tracking of the
 stacks count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 22:42, Marco Elver <elver@google.com> wrote:
>
> On Fri, 9 Feb 2024 at 22:37, Oscar Salvador <osalvador@suse.de> wrote:
> >
> > On Fri, Feb 09, 2024 at 08:45:00AM +0100, Marco Elver wrote:
> > > > +/**
> > > > + * stack_depo_get_stack - Get a pointer to a stack struct
> > >
> > > Typo: "depo" -> depot
> > >
> > > I would also write "stack_record struct", because "stack struct" does not exist.
> >
> > Fixed.
> >
> > > > + * @handle: Stack depot handle
> > > > + *
> > > > + * Return: Returns a pointer to a stack struct
> > > > + */
> > > > +struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
> > >
> > > I don't know what other usecases there are for this, but I'd want to
> > > make make sure we give users a big hint to avoid unnecessary uses of
> > > this function.
> > >
> > > Perhaps we also want to mark it as somewhat internal, e.g. by
> > > prefixing it with __. So I'd call it __stack_depot_get_stack_record().
> >
> > Yes, I went with __stack_depot_get_stack_record(), and I updated its doc
> > in stackdepot.h, mentioning that is only for internal purposes.
> >
> > > > +static void inc_stack_record_count(depot_stack_handle_t handle)
> > > > +{
> > > > +       struct stack_record *stack = stack_depot_get_stack(handle);
> > > > +
> > > > +       if (stack)
> > > > +               refcount_inc(&stack->count);
> > > > +}
> > >
> > > In the latest stackdepot version in -next, the count is initialized to
> > > REFCOUNT_SATURATED to warn if a non-refcounted entry is suddenly used
> > > as a refcounted one. In your case this is intentional and there is no
> > > risk that the entry will be evicted, so that's ok. But you need to set
> > > the refcount to 1 somewhere here on the initial stack_depot_save().
> >
> > Well, I went with something like:
> >
> >  static void inc_stack_record_count(depot_stack_handle_t handle)
> >  {
> >          struct stack_record *stack = __stack_depot_get_stack_record(handle);
> >
> >          if (stack) {
> >                  /*
> >                   * New stack_records that do not use STACK_DEPOT_FLAG_GET start
> >                   * with REFCOUNT_SATURATED to catch spurious increments of their
> >                   * refcount.
> >                   * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
>
> There is no FLAG_PUT, only stack_depot_put(). Saying you do not use
> the refcount to free any entries should hopefully make it clear that
> even if the refcount saturates and you wrap around to 1, nothing
> catastrophic will happen.
>
> >                   * set a refcount of 1 ourselves.
> >                   */
> >                  if (refcount_read(&stack->count) == REFCOUNT_SATURATED)
> >                          refcount_set(&stack->count, 1);

Do you need to inc the first allocation? Should there be an "else"
here instead of always doing refcount_inc()?

> >                  refcount_inc(&stack->count);
> >          }
> >  }
>
> That looks reasonable.

