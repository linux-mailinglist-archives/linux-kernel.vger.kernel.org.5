Return-Path: <linux-kernel+bounces-63546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC2085310D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FBB1C264F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5F448795;
	Tue, 13 Feb 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+9muNtm"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED77482C5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829141; cv=none; b=PIGZb2BoLzbno/QegriL7gBN8pNugCbr9wZswUAUHM1VfjKeFCl0b1QKNvO2hlkVyfVp23ZPhNNwGFFHYlJSusdBBwTXfxRIGu6u/syX2nH5ARmBe2cs+xdpZAuIRXOVWbY0KV9QiZk/fB66tAtX0UH7s6YucROflnwihspoSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829141; c=relaxed/simple;
	bh=HBXn8+mPI60aWGXqXtUgXSjVYMbihc5fwmExHw46ewo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qskflMktrWuhU4uBFAdzw9pncWI3e2/rNhYxnqLmL0N4WEP/DqyB54YPBZov31++YnF00roQAs3l0CXtLuRwgnXMyIMQTiAenamtI0K2oq9VWWJZZfbgmvGDafH1Ys0JoaWuOnLDpkDtnU+1c6tqegu+y5bSBYQt+T96aADGeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+9muNtm; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7ce55932330so1707150241.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707829139; x=1708433939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z882ZjxzlMo5zCfCXALkNVq7HPWFHS34A/7S9zGVAME=;
        b=F+9muNtmfxJKvyhik3RT/Nw/ro9svhjuYDIgx4rTpLPzJ3pyqTd9WROVbW59aB36mA
         /lNorJ/On5vTS2+OR321d/hJK71hGNLkwzlamGd5KWrDLJOluLJ/Q3yR4DPUitb4UabN
         pjctP3aU8FKfZQEm96b7Z0F1fQS+tYdOEU5URZ/flevkgkPwechaEJEDl5sew88MJ5os
         fu1rgkb4pZSQNBxF74egfY7ySMPoRRwy9j4UQx0njirxg5S97FS24/2SHGZJIYHU/TAY
         O7F6+qggzjTDc1hZea0omNyTKXSWRzi8B0VcknYSsy8UDNFJ32Cy2V2JaNVWchxnU5hp
         gXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829139; x=1708433939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z882ZjxzlMo5zCfCXALkNVq7HPWFHS34A/7S9zGVAME=;
        b=HJCnJ/vtQC7spcPD/jvaWo/Wd3KcJE7kKeJCnULMoQ5wsep/4QHFxJPW5rZenar1d9
         bpXTsSrRlOzdvICl7J2Szrz3RG53+QbjkmIEKwLRPGTgOyPz7ah6d4epb7gHwNnahDzC
         4CrpmfqHhbr4i5b/NxNBOhSPUsH11iFlCKDIk+JLSLU2QQRVt3LLmsRAUTvwg0IVzhzV
         612Cy/1g5FVUQiyB5jvTeJELFQxNAuGJcT0P20ptWvZ2kg88hXXI+Lu08FJfpvIYLK8T
         iEAN/S17MTdpI03nTwsPRK9ni7C4pZDaYmA7hqCC4cuWY8lQuJz6WRbOlwWsXsRag7ZD
         1i5g==
X-Forwarded-Encrypted: i=1; AJvYcCXqrVjY+WwhNWkFeDvEDfe1t50fS8u178/I3NOwFwPS0weoybYSDT32rGgcjRYruhCcEAX5MSkfoZjdBU3/jputWZ3WB2+MwpXeHMY0
X-Gm-Message-State: AOJu0Yyn6l9Skd5HRnPvORapqXG8JuXWPG5VKS1BqjjWdRE56zT1o/TE
	JsYhKJhSAUw0AI9YjCDufDSTOKp3NekFR+GYc2t2TYHwSw8C8DYGfriOZT//rxUiMPBWfLPK2r5
	hY/0q0qDu51h/FgQbfhXCpQa4Xq8F90IWhTrI
X-Google-Smtp-Source: AGHT+IGEl2/Ks/zmua8jJheJoTJ5AyEUCZITHYOQdH02hKJf5Sek673WLDYX43f2OqCRu6b/hHSfKBHURX1E2mYmIW0=
X-Received: by 2002:a05:6102:30b8:b0:46d:2b65:aa16 with SMTP id
 y24-20020a05610230b800b0046d2b65aa16mr4623538vsd.34.1707829138393; Tue, 13
 Feb 2024 04:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-3-osalvador@suse.de>
 <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz> <CANpmjNO8CHC6gSFVEOSzYsTAP-j5YvfbfzZMUwnGqSAC1Y4A8g@mail.gmail.com>
 <11cb2ac2-102f-4acd-aded-bbfd29f7269a@suse.cz> <ZctjNn7i3atRPccE@localhost.localdomain>
In-Reply-To: <ZctjNn7i3atRPccE@localhost.localdomain>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 13:58:20 +0100
Message-ID: <CANpmjNPntT0ApG6RzS--+1pou_XK+LjT+r-Qh4wvFiyWPqegYA@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
To: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 13:39, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Feb 13, 2024 at 12:34:55PM +0100, Vlastimil Babka wrote:
> > On 2/13/24 10:21, Marco Elver wrote:
> > > On Tue, 13 Feb 2024 at 10:16, Vlastimil Babka <vbabka@suse.cz> wrote:
> > >> Isn't this racy? Shouldn't we use some atomic cmpxchg operation to change
> > >> from REFCOUNT_SATURATED to 1?
> > >
> > > If 2 threads race here, both will want to add it to the list as well
> > > and take the lock. So this could just be solved with double-checked
> > > locking:
> > >
> > > if (count == REFCOUNT_SATURATED) {
> > >   spin_lock(...);
> >
> > Yeah probably stack_list_lock could be taken here already. But then the
> > kmalloc() of struct stack must happen also here, before taking the lock.
>
> I am thinking what would be a less expensive and safer option here.
> Of course, taking the spinlock is easier, but having the allocation
> inside is tricky, and having it outside could mean that we might free
> the struct once we checked __within__ the lock that the refcount
> is no longer REFCOUNT_SATURATED. No big deal, but a bit sub-optimal.
>
> On the other hand, IIUC, cmpxchg has some memory ordering, like
> store_and_release/load_acquire do, so would it be safe to use it
> instead of taking the lock?

Memory ordering here is secondary because the count is not used to
release and later acquire any memory (the list is used for that, you
change list head reads/writes to smp_load_acquire/smp_store_release in
the later patch). The problem is mutual exclusion. You can do mutual
exclusion with something like this as well:

>       if (refcount_read(&stack->count) == REFCOUNT_SATURATED) {
>               int old = REFCOUNT_SATURATED;
>               if (atomic_try_cmpxchg_relaxed(&stack->count.refs, &old, 1))
>                       add_stack_record_to_list(...);
>       }
>       refcount_inc(&stack->count);

Probably simpler.

