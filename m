Return-Path: <linux-kernel+bounces-41953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436483F9EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DF71C21B68
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B855633CFB;
	Sun, 28 Jan 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h5vuX8Ys"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516C3C087
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706475233; cv=none; b=Nd2KUnOfPUSfAoYBgSE1vC/KByGpVJLT2Rvn5kA+Gz/hlUUwac+EC5/9Kivx7a/Qitl2gfIrP0TyHb51KAS9RDytH2tjUUIwdxfjej9R8h4yCQa//LDSQQFFG/9a6/nWq03RjINxMDEzpkMQGdaPOorTsvisIw3wzv/1d9lDWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706475233; c=relaxed/simple;
	bh=OPL25mOEMBzNyt0G9tcDF3mdQkqE/LMmusy0WyFodYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4LNCigEycQWY1yNJGocPK7F5CvB0iK6E1Hz/w+yIhPKENBj5npPScCzj+gZjnT2659BwWQPO0mr6vHKwb2w4Z9iNymZMHy/fg8SkNjC5A7iHzcZzmyXNDlUR+zsG+dr0VTpm7fq/npMDNQNekirvFewUKcyZ+UQ8GHIklE8bGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h5vuX8Ys; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f082c2c92so51788a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706475230; x=1707080030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BrezTTnj7N/Ys+Vw7pUL8AQ9OmNzc9NBDGdrHuRcsMA=;
        b=h5vuX8YsxB/SLHF3J9Gl0lWlYe3aBqPcZkUAwo0C0csow47/EE/MPhMB3FBCQDgWA8
         H60bx22CnjYB09c2KtCI6oagzPRAnoCjrb9kgXMVaQKQHfW+vH1pAK152BfzWMDn0JDh
         u8Md++6eBnW2c+EL3ZubZAXq050CBBE4cfmYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706475230; x=1707080030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrezTTnj7N/Ys+Vw7pUL8AQ9OmNzc9NBDGdrHuRcsMA=;
        b=WJojcvVy6pE3voDkr/TnZq3/XNcqurt+O2o/X119b0G7ygSSiO5rh6TBfQ5zu3g9EH
         o2ldMLduELvIaB2wJcsFOQeWoCcOyy7ZQq8MPqDQ5tmGI5tg0bh88NOu0VzYFFEoACV4
         riQ0WWVhjpUd8X/5cJxcIn1xWp/GEStsLJMIOLb6KbdLpoGbRPnG8qkxlQyJxdhFU2nD
         1+FQBVrMj2G9VbwqAJBEFOeXEFY2dwzUtYCQilR6sAMZzR6b9LW5jPBuVBVhne8nGcJn
         mlyouyqVWPLdXVO4xaZsmNfe6WThc7clzhGFCBGGFd8C/zLYzw1fxUyuRZHnn1yOtWT2
         hRYQ==
X-Gm-Message-State: AOJu0YyjozU5uRIv/TpGFAZ/owA0e0H6etUu0uN9y3FiDYme9DHcdovU
	wCbo1ZjUwdE7VvqiOeTDu9d1LpZOYbewtXIF5nurTdKlK1REKBkiA3yyv+eW8ZEKk02i5hkfF4W
	rv4w=
X-Google-Smtp-Source: AGHT+IHM2ehph8LsZhd41eARYESLIrNrgzL1XJCJrVNya6p4BfPPc6BDHeMJA5L3Zqedt+sHeEiWIQ==
X-Received: by 2002:a17:906:da03:b0:a31:543b:1279 with SMTP id fi3-20020a170906da0300b00a31543b1279mr3249382ejb.76.1706475229893;
        Sun, 28 Jan 2024 12:53:49 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a2b608ad048sm3149545ejc.28.2024.01.28.12.53.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 12:53:49 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f082c2c92so51776a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:53:48 -0800 (PST)
X-Received: by 2002:a05:6402:88f:b0:55f:8fb:f41a with SMTP id
 e15-20020a056402088f00b0055f08fbf41amr54301edy.8.1706475228498; Sun, 28 Jan
 2024 12:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com> <20240128151542.6efa2118@rorschach.local.home>
In-Reply-To: <20240128151542.6efa2118@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 12:53:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
Message-ID: <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 12:15, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I have to understand how the dentry lookup works. Basically, when the
> ei gets deleted, it can't be freed until all dentries it references
> (including its children) are no longer being accessed. Does that lookup
> get called only when a dentry with the name doesn't already exist?

Dentry lookup gets called with the parent inode locked for reading, so
a lookup can happen in parallel with readdir and other dentry lookup.

BUT.

Each dentry is also "self-serializing", so you will never see a lookup
on the same name (in the same directory) concurrently.

The implementation is very much internal to the VFS layer, and it's
all kinds of nasty, with a new potential lookup waiting for the old
one, verifying that the old one is still usable, and maybe repeating
it all until we find a successful previous lookup or we're the only
dentry remaining.

It's nasty code that is very much in the "Al Viro" camp, but the point
is that any normal filesystem should treat lookups as being concurrent
with non-creation events, but not concurrently multiples.

There *is* some common code with "atomic_open()", where filesystems
that implement that then want to know if it's the *first* lookup, or a
use of a previously looked up dentry, and they'll use the
"d_in_lookup()" thing to determine that. So this whole "keep track of
which dentries are *currently* being looked up is actually exposed,
but any normal filesystem should never care.

But if you think you have that issue (tracefs does not), you really
want to talk to Al extensively.

> That is, can I assume that eventfs_root_lookup() is only called when
> the VFS file system could not find an existing dentry and it has to
> create one?

Correct. For any _particular_ name, you should think of lookup as serialized.

> If that's the case, then I can remove the ei->dentry and just add a ref
> counter that it was accessed. Then the final dput() should call
> eventfs_set_ei_status_free() (I hate that name and need to change it),
> and if the ei->is_freed is set, it can free the ei.

Note that the final 'dput()' will happen *after* the dentry has been
removed, so what can happen is

   lookup("name", d1);
   ... lookup successful, dentry is used ..
   ... dentry at some point has no more users ..
   ... memory pressure prunes unused dentries ..
   ... dentry gets unhashed and is no longer visible ..
   lookup("name", d2);
   ... new dentry is created ..
   final dput(d1);
   .. old dentry - that wasn't accessible any more is freed ..

and this is actually one of the *reasons* that virtual filesystems
must not try to cache dentry pointers in their internal data
structures. Because note how the fuilesystem saw the new lookup(d2) of
the same name *before* it saw the >d_release(d1) of the old dentry.

And the above is fundamental: we obviously cannot call '->d_release()'
until the old dentry is all dead and buried (lockref_mark_dead() etc),
so pretty much by definition you'll have that ordering being possible.

It's extremely unlikely, of course. I'll be you'll never hit it in testing.

So if if you associate some internal data structure with a dentry,
just *what* happens when you haven't been told abotu the old dentry
being dead when the new one happens?

See why I say that it's fundamentally wrong for a filesystem to try to
track dentries? All the operations that can use a dentry will get one
passed down to them by the VFS layer. The filesystem has no business
trying to remember some dentry from a previous operation, and the
filesystem *will* get it wrong.

But also note how refcounting works fine. In fact, refcounting is
pretty much the *only* thing that works fine. So what you *should* do
is

 - at lookup(), when you save your filesystem data in "->d_fsdata",
you increment a refcount

 - at ->d_release(), you decrement a refcount

and now you're fine. Yes, when the above (very very unlikely)
situation happens, you'll temporarily have a refcount incremented
twice, but that's kind of the *point* of refcounts.

Side note: this is pretty much true of any kernel data structure. If
you have a kernel data structure that isn't just used within one
thread, it must be refcounted. But it'as *doubly* true when you save
references to something that the VFS maintains, because you DO NOT
CONTROL the lifetime of that entity.

> The eventfs_remove_dir() can free the ei (after SRCU) if it has no
> references, otherwise it needs to wait for the final dput() to do the
> free.

Honestly, you should just *always* do refcounting. No "free after RCU
delay" as an alternative. Just refcount it.

Now, the RCU delay may be needed if the lookup of said structure
happens under RCU, but no, saying "I use SRCU to make sure the
lifetime is at least X" is just broken.

The refcount is what gives the lifetime. Any form of RCU-delaying
should then be purely about non-refcounting RCU lookups that may
happen as the thing is dying (and said lookup should *look* at the
refcount and say "oh, this is dead, I'm not returning this".

> I think the ei->dentry was required for the dir wrapper logic that we
> removed.

I think all of this was due to the bogus readdir that created dentries
willy-nilly and without the required serialization.

And that was all horribly broken.  It wasn't even the above kind of
"really subtle race that you'll never hit in practice" broken. It was
just absolutely broken with readdir and lookup racing on the same name
and creating an unholy dentry mess.

            Linus

