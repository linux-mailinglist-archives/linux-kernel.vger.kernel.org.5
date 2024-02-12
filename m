Return-Path: <linux-kernel+bounces-62485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C5852182
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5DB284ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298951028;
	Mon, 12 Feb 2024 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrILMhsZ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4834E1CC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777071; cv=none; b=FjczA3yBOP5meaIRltX1GXuxdNOwdtDAutV4vprJ0abYDHSENI9rU4tHEK2Deo4J63LtQRkzUVHB5zxgd9ijyI4/epkv+YaNFiohxCbQnhkd8phoK0Qn7y0oIJpbIsHQFcFGGP41nIc9zsAwf/04btC21BdLL1+u17VOEmM7QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777071; c=relaxed/simple;
	bh=OMjB46gs2wW9dar/91UoPpBUG+X9qus0cmG6eJvNhs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ek/CTdFXKBTHZg0qB902+sT6zBlGusN4OOYAglk+LA2sezy1g8DC5iQF5rFVbiRTUfsTRkLa/LGuTcBIH9c5py34gzhh5gWRWHPDpJ2QJgFN5AVB45fIZatLeEmbG/79mLdTgZujLx17GII5lyarz7AW7ZHZNaLzWZFaWfFEZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrILMhsZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410ec928b83so7620385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707777068; x=1708381868; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9mO69PHSXpV4KszXXC4FO0K4MGQhMEHtnBuaX2b1wA=;
        b=xrILMhsZe+Zg2w/xQ5ese8QL9tTX2Vooc/yrQ4r2hBhmVFw/fF4nNeymXlW7gUjWYk
         mXS4Qo6mLJEBICQB1IBkpngVR0ivuoBznUpftvW4PHlIE6BNgpFZFu2rGfcuMSw4Y9kt
         OuKRe5cesh72hF2WaDSr0IurdSDESVpwrrojtTlfm3FbUQNE9JTWCFDGdaTl0N7BV4O0
         fYnI+LO1tcan4GUOk0PzzdCqfXX3EGYI4fUUQ/AmOOXXc8xCgAG51j5OV/y3U400TC8f
         EXSR4h2ssiW6FCVu7VppeOEOssi3StexXTE4Ciu2Luo/5jdxFlysY1G7k25nSD6RR4FB
         zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777068; x=1708381868;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9mO69PHSXpV4KszXXC4FO0K4MGQhMEHtnBuaX2b1wA=;
        b=iFgt44aP3I9WbwJrvV82HbJlFZEkpL45Ix31MMrBvzu5PnnhwyzmzKV4lRKysd7aIB
         XyOLf8ANT7DxCyIdW73Pfib+0FYwsKeJpYUETvveinR/Ijs2uwt/9G1GfqHcM43YywSF
         MQ5vgehHccRduD8X6F05ZmvfkRk8lrtQL6YQ7kTu3dWWhzq5NgCgsrIcdrq+Gm7KjFUQ
         DT+zU039IuQcpXTw1fbWN9yf4coOWCFs6ntA9ZbLWTlfSmyFOUZHs1IXy6f/1QgtRbao
         n4qeGUv8q+hCwPLyqi3y27oX3xQ8AWWNHgsTW236q2cd4Zpo8V5DQRMPofEbVfBSa3ps
         5Uew==
X-Forwarded-Encrypted: i=1; AJvYcCW94mY56XQDNvz7CshuRBdSteMH6tM/MM29bOSoxkVlJogmqueVDJt6peWA6BUtOYMfF7R4lCnUe9b+q/Qt1zS6MzH1eB8a6ej3dOxQ
X-Gm-Message-State: AOJu0YyWMm2/uLyUt1mP99Gfkv0SZd6Gdu9+pz5JqyoFT82lfiXp1miy
	6A70CPkBQQkAeDtwbKbbM9lyVznuOVVJuvWbZwhUFZ0dp2/YGvT7kdYBCNHB1baR411qfMfUWih
	u6LgzUdYxVdCn8QGSGNaq4j/jeRSpnCZjomfxbrdwNYMO0OvYRQ74
X-Google-Smtp-Source: AGHT+IFZvGus6qBaDKHVpEnYLxBVaPb/kTrQZBtuxYaA/mFQXqriiKZKEZmpVs+/oJ+VH2Y/q/TlTzvux7Yi7IHL9oc=
X-Received: by 2002:adf:ed90:0:b0:33b:47d0:52ce with SMTP id
 c16-20020adfed90000000b0033b47d052cemr6385336wro.25.1707777068103; Mon, 12
 Feb 2024 14:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com> <20240209030654.lxh4krmxmiuszhab@revolver>
 <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
 <20240209190605.7gokzhg7afy7ibyf@revolver> <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
 <20240209193110.ltfdc6nolpoa2ccv@revolver> <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
 <20240212151959.vnpqzvpvztabxpiv@revolver> <CA+EESO706V0OuX4pmX87t4YqrOxa9cLVXhhTPkFh22wLbVDD8Q@mail.gmail.com>
 <20240212201134.fqys2zlixy4z565s@revolver>
In-Reply-To: <20240212201134.fqys2zlixy4z565s@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 12 Feb 2024 14:30:55 -0800
Message-ID: <CA+EESO6=tVK6xUGTHG+6yCUGarXb_vHmjOuqEQ_d4gCe8V3=xA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:11=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240212 13:08]:
> > On Mon, Feb 12, 2024 at 7:20=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> ...
>
> > > >
> > > > The current implementation has a deadlock problem:
> ...
>
> > > On contention you will now abort vs block.
> >
> > Is it? On contention mmap_read_trylock() will fail and we do the whole
> > operation using lock_mm_and_find_vmas() which blocks on mmap_lock. Am
> > I missing something?
>
> You are right, I missed the taking of the lock in the function call.
>
> > >
> > > >               }
> > > >               return 0;
> > > > }
> > > >
> > > > Of course this would need defining lock_mm_and_find_vmas() regardle=
ss
> > > > of CONFIG_PER_VMA_LOCK. I can also remove the prepare_anon conditio=
n
> > > > in lock_vma().
> > >
> > > You are adding a lot of complexity for a relatively rare case, which =
is
> > > probably not worth optimising.
> > >
> ...
>
> >
> > Agreed on reduced complexity. But as Suren pointed out in one of his
> > replies that lock_vma_under_rcu() may fail due to seq overflow. That's
> > why lock_vma() uses vma_lookup() followed by direct down_read() on
> > vma-lock.
>
> I'd rather see another function that doesn't care about anon (I think
> src is special that way?), and avoid splitting the locking across
> functions as much as possible.
>
Fair point about not splitting locking across functions.
>
> > IMHO what we need here is exactly lock_mm_and_find_vmas()
> > and the code can be further simplified as follows:
> >
> > err =3D lock_mm_and_find_vmas(...);
> > if (!err) {
> >           down_read(dst_vma...);
> >           if (dst_vma !=3D src_vma)
> >                        down_read(src_vma....);
> >           mmap_read_unlock(mm);
> > }
> > return err;
>
> If we exactly needed lock_mm_and_find_vmas(), there wouldn't be three
> lock/unlock calls depending on the return code.
>
> The fact that lock_mm_and_find_vmas() returns with the mm locked or
> unlocked depending on the return code is not reducing the complexity of
> this code.
>
> You could use a widget that does something with dst, and a different
> widget that does something with src (if they are different).  The dst
> widget can be used for the lock_vma(), and in the
> lock_mm_and_find_vmas(), while the src one can be used in this and the
> lock_mm_and_find_vmas(). Neither widget would touch the locks.  This way
> you can build your functions that have the locking and unlocking
> co-located (except the obvious necessity of holding the mmap_read lock
> for the !per-vma case).
>
I think I have managed to minimize the code duplication while not
complicating locking/unlocking.

I have added a find_vmas_mm_locked() handler which, as the name
suggests, expects mmap_lock is held and finds the two vmas and ensures
anon_vma for dst_vma is populated. I call this handler from
lock_mm_and_find_vmas() and find_and_lock_vmas() in the fallback case.

I have also introduced a handler for finding dst_vma and preparing its
anon_vma, which is used in lock_vma() and find_vmas_mm_locked().

Sounds good?

> I've also thought of how you can name the abstraction in the functions:
> use a 'prepare() and complete()' to find/lock and unlock what you need.
> Might be worth exploring?  If we fail to 'prepare()' then we don't need
> to 'complete()', which means there won't be mismatched locking hanging
> around.  Maybe it's too late to change to this sort of thing, but I
> thought I'd mention it.
>
Nice suggestion! But after (fortunately) finding the function names
that are self-explanatory, dropping them seems like going in the wrong
direction. Please let me know if you think this is a missing piece. I
am open to incorporating this.

> Thanks,
> Liam

