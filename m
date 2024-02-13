Return-Path: <linux-kernel+bounces-63195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C744852C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D46286863
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8B224D6;
	Tue, 13 Feb 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Biyh9VrN"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76533224C6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816114; cv=none; b=RKgDfTsIGxldChFJCbGaCZLpxf91NdsTD4qEyFSSX002R2fGOMes/4aLQHv9UfGjOlrakGh7NfS7PGP47tz2oJGzADgETTKV1WR9+oAahRCBp+w3mLJq4RYGK0DrdDB+29KQU5/maGaNI3EObPje0laLe7uTIkuU9XU2srqheiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816114; c=relaxed/simple;
	bh=jN5ASTlliFLWUbLhxuX4S44/mDVAL2oYKUSjLSrsi8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0lih+BAm4WgLZxWGpGTMTIZ/9lb6XXHYkCmSOImcKUyqVuUfcvW/3w+PGscjyNOVvU3/83inc/nEOmV166c0M/c3pEiOUbMJmORLm+eM/ok618kMAqztgzVKl3iFCnj/Q1L2XdYptLjxoqWxMNTetAvG4vE07v5Iu8i8JFHwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Biyh9VrN; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso2004304241.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707816111; x=1708420911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BljRftqO+MfcFjCEAz03kydOwq7rbFyh2ciaeRJBXcY=;
        b=Biyh9VrNgm4JF09E8kPXdqa9sNQZePzLRcLK2TRya2Oe28V62on/l8pFZgxnN8gj+M
         oKgkQMzYnBjWtmyhIx3EvV5SoYSMXdlJJX3KKPl7qJByoUud0Bxx0eovQD+3JvuCS2WY
         O46ZFVf3bI/WFp/9/Qz2uR5HrOklIYtZr/bCBMzfGwM5bq1ZHkO63ewU6xgzSstSft5J
         VVnPDv58eAGDUc51DGjOsON4wAFzMdA6LtiLd1rS3QMJIihA7MdhXZlrcUiCA6HxWtMZ
         G+VVBDtgJPD3Z4JZRGbfm8jhC0y+MqguxEieh28cuDR4F7DWD1nNZxQLv1BsZ8AmNt9X
         VYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816111; x=1708420911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BljRftqO+MfcFjCEAz03kydOwq7rbFyh2ciaeRJBXcY=;
        b=pUMxnK3X7/MQ6Qzcd6X70sheAUjRb20x1pskkYkT3x8kltJklvxOyyVPXKlLlgWEo8
         SWPvzB1PviCHO5jCUaydA1CEgeyuNf6fJzywqgpuywlc036Oc10gLuyE38l3Vn6zHiHG
         5hm2hZ7VdLh6H/7kyKL48tqU5UeII7Z0O9JvPAIx/ORmQVGe1MKhLjXozJ5VCe29Z9qz
         GUcq4rJqYHx25EKBEuTG6DiiK7fdwhAlue40P5xLtaKIToWArhQsKBH+tMHOIzzmhZvq
         gm6jgrDyp8LRczsgOAmgTMPBtZI5PWalK6G6i4PMU62WGW2nwtZL4zjWJHSKFM+GUjD6
         t3rg==
X-Gm-Message-State: AOJu0YxsZmnB4txDX7FpT1XfTxzYD4cryfIJWnhhT9qF5s5TEGmi9KC0
	6j42iT5MuxfKFEU06BU2vhk3f4cGm/T+OxLWnpVI6TDtNIDD+NnQJU6MFOILVxlMK3qlnri7k3i
	OJhsT+4n/S1sdSPwgRH0tEGLJt8yqeCefHm1L
X-Google-Smtp-Source: AGHT+IED0rD2PlqDCn3KWB8HVjF3tQRSmZ/ILb/KSKI4IGZUcO0P4QZ5jXV0sM4w0SM9dimXmpC9iD9DB0dXWqsyFec=
X-Received: by 2002:a1f:df42:0:b0:4c0:3000:8b26 with SMTP id
 w63-20020a1fdf42000000b004c030008b26mr5619300vkg.4.1707816111112; Tue, 13 Feb
 2024 01:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-3-osalvador@suse.de>
 <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
In-Reply-To: <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 10:21:14 +0100
Message-ID: <CANpmjNO8CHC6gSFVEOSzYsTAP-j5YvfbfzZMUwnGqSAC1Y4A8g@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 10:16, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/12/24 23:30, Oscar Salvador wrote:
> > page_owner needs to increment a stack_record refcount when a new allocation
> > occurs, and decrement it on a free operation.
> > In order to do that, we need to have a way to get a stack_record from a
> > handle.
> > Implement __stack_depot_get_stack_record() which just does that, and make
> > it public so page_owner can use it.
> >
> > Also implement {inc,dec}_stack_record_count() which increments
> > or decrements on respective allocation and free operations, via
> > __reset_page_owner() (free operation) and __set_page_owner() (alloc
> > operation).
> >
> > Traversing all stackdepot buckets comes with its own complexity,
> > plus we would have to implement a way to mark only those stack_records
> > that were originated from page_owner, as those are the ones we are
> > interested in.
> > For that reason, page_owner maintains its own list of stack_records,
> > because traversing that list is faster than traversing all buckets
> > while keeping at the same time a low complexity.
> > inc_stack_record_count() is responsible of adding new stack_records
> > into the list stack_list.
> >
> > Modifications on the list are protected via a spinlock with irqs
> > disabled, since this code can also be reached from IRQ context.
> >
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >  include/linux/stackdepot.h |  9 +++++
> >  lib/stackdepot.c           |  8 +++++
> >  mm/page_owner.c            | 73 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 90 insertions(+)
>
> ...
>
>
> > --- a/mm/page_owner.c
> > +++ b/mm/page_owner.c
> > @@ -36,6 +36,14 @@ struct page_owner {
> >       pid_t free_tgid;
> >  };
> >
> > +struct stack {
> > +     struct stack_record *stack_record;
> > +     struct stack *next;
> > +};
> > +
> > +static struct stack *stack_list;
> > +static DEFINE_SPINLOCK(stack_list_lock);
> > +
> >  static bool page_owner_enabled __initdata;
> >  DEFINE_STATIC_KEY_FALSE(page_owner_inited);
> >
> > @@ -61,6 +69,57 @@ static __init bool need_page_owner(void)
> >       return page_owner_enabled;
> >  }
> >
> > +static void add_stack_record_to_list(struct stack_record *stack_record)
> > +{
> > +     unsigned long flags;
> > +     struct stack *stack;
> > +
> > +     stack = kmalloc(sizeof(*stack), GFP_KERNEL);
>
> I doubt you can use GFP_KERNEL unconditionally? Think you need to pass down
> the gfp flags from __set_page_owner() here?
> And what about the alloc failure case, this will just leave the stack record
> unlinked forever? Can we somehow know which ones we failed to link, and try
> next time? Probably easier by not recording the stack for the page at all in
> that case, so the next attempt with the same stack looks like the very first
> again and attemps the add to list.
> Still not happy that these extra tracking objects are needed, but I guess
> the per-users stack depot instances I suggested would be a major change.
>
> > +     if (stack) {
> > +             stack->stack_record = stack_record;
> > +             stack->next = NULL;
> > +
> > +             spin_lock_irqsave(&stack_list_lock, flags);
> > +             if (!stack_list) {
> > +                     stack_list = stack;
> > +             } else {
> > +                     stack->next = stack_list;
> > +                     stack_list = stack;
> > +             }
> > +             spin_unlock_irqrestore(&stack_list_lock, flags);
> > +     }
> > +}
> > +
> > +static void inc_stack_record_count(depot_stack_handle_t handle)
> > +{
> > +     struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> > +
> > +     if (stack_record) {
> > +             /*
> > +              * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
> > +              * with REFCOUNT_SATURATED to catch spurious increments of their
> > +              * refcount.
> > +              * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
> > +              * set a refcount of 1 ourselves.
> > +              */
> > +             if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
> > +                     refcount_set(&stack_record->count, 1);
>
> Isn't this racy? Shouldn't we use some atomic cmpxchg operation to change
> from REFCOUNT_SATURATED to 1?

If 2 threads race here, both will want to add it to the list as well
and take the lock. So this could just be solved with double-checked
locking:

if (count == REFCOUNT_SATURATED) {
  spin_lock(...);
  if (count == REFCOUNT_SATURATED) {
    refcount_set(.., 1);
    .. add to list ...
  }
  spin_unlock(..);
}

