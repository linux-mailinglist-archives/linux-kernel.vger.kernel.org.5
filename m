Return-Path: <linux-kernel+bounces-43769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB938418B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905FC1C23822
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B536AE9;
	Tue, 30 Jan 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVF17mhD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8504364A1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579460; cv=none; b=qfa2BLm0FHOwsQHcG8O6W3+NfNodc9YCqhiJu1bychufQHjg/QQy9eh5f2T+L0KXNZHGet26qYKrON6Slaa8HeA6Jz9h3sijzXp8t2Q9fDxdIer1huEwERjtoYTmI+HVgcqzJY2+cDTXfGYpxnGXnXeLmXu6Q2pj7EZGT7AkY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579460; c=relaxed/simple;
	bh=zyDZ08Jamx3NYeGqhVvbunwn56jBnGzJ3cGlRkrcSRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU90xOn6dHCroyaalnGWCQcY/mFgAKDTR8ubKytYxUSbkUa+00GZb2n/Gpod0EAsTKoygFwN+h7qwNjBxu4RLKhzXuYxk6T8B1alpqm9Og5//vszJ/8NB95HFBlgGxQU3ztd6kskUdxUxeCmRfXGEaa4Kzvy4IijdG6ZWboUryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bVF17mhD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3871537a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706579457; x=1707184257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JiXyOYVlI6BSEdoNtzDGECSezeX6jIOydJh3gzKSfA=;
        b=bVF17mhDhNj6ABQr/QpFyJm3YAMJnklVu0o1QMOB3EK/5WiPsGI8mG7iKNTRDJp5DA
         vf62jU9sn+GbH3yFbJF9hn+lTjKMoF9EpjIEQcMHnO8cI9Z7py61CloaAHv28kW1Xeba
         bPh9AT6/N/7Ue9rXxEAi49YnTKGjvbv3ih9ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579457; x=1707184257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JiXyOYVlI6BSEdoNtzDGECSezeX6jIOydJh3gzKSfA=;
        b=LqScWxTOFcv8K68gSh8gXyUGRZGG8mX+cERh3UVKQTONhxjF5EnuDfsXybtv6IX9SS
         KRnFsiRLpEUMPxzhVVwelVIJzANI0XNJBl2wCDe4OQ7MDw254OepM4a9fuILJGc1OdB/
         oqsrxb2OBtYn87JOHNhDNbN6o4VDHO61lTc/Dzl5rL6d4hhUr5ZM86fK1t9CS73KOiSh
         e7PBxItK7GHubtbFS7zbdkTuIb+wZNM8goZ85qc5eGYTEEwFTYy/COZWNI50KJfoJOsv
         cW5kpeFMJaJf/Di2md39OW3In1PZ5Pd+4bxAIFnB1+R3NTKBzdsI3x0Y2MqmU+HEwueS
         R4XQ==
X-Gm-Message-State: AOJu0Yzehm1dTJ9UBbNROn3S/xxzox0BDXqWkgWmCqev46YRJvJfPJmi
	FDslJ0Msg8Qt36ODvU5q/lhucZ23UPf9V8E23rpH+rIu9vdLmUfTJ/ySUCnX+DSBRAMkRj2r5vu
	YI5cuSQ==
X-Google-Smtp-Source: AGHT+IFnlo3OJn38kUVckKix/vW5pQ3q/R/dJ3ITqS8/ZY08AuJ4FHhgnMvGJnBJMaetDNeP5idl8A==
X-Received: by 2002:a05:6402:416:b0:55c:20f7:4ef8 with SMTP id q22-20020a056402041600b0055c20f74ef8mr4787804edv.23.1706579456979;
        Mon, 29 Jan 2024 17:50:56 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id x6-20020a056402414600b0055d36e6f1a7sm4163160eda.82.2024.01.29.17.50.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 17:50:55 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3335928a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:50:55 -0800 (PST)
X-Received: by 2002:a05:6402:3514:b0:55e:e22c:c1fd with SMTP id
 b20-20020a056402351400b0055ee22cc1fdmr4283813edd.4.1706579455285; Mon, 29 Jan
 2024 17:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home>
In-Reply-To: <20240129193549.265f32c8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 17:50:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
Message-ID: <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 16:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  # echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events
>  # ls -l events/kprobes/
> ls: cannot access 'events/kprobes/': No such file or directory
>
> Where it should now exist but doesn't. But the lookup code never triggered.
>
> If the lookup fails, does it cache the result?

I think you end up still having negative dentries around.

The old code then tried to compensate for that by trying to remember
the old dentry with 'ei->dentry' and 'ei->d_children[]', and would at
lookup time try to use the *old* dentry instead of the new one.

And because dentries are just caches and can go away, it then had that
odd dance with '.d_iput', so that when a dentry was removed, it would
be removed from the 'ei->dentry' and 'ei->d_children[]' array too.

Except that d_iput() of an old dentry isn't actually serialized with
->d_lookup() in any way, so you end up with the whole race that I
already talked about earlier, where you could still have an
'ei->dentry' that pointed to something that had already been unhashed,
but d_iput() hadn't been called *yet*, so d_lookup() is called with a
new dentry, but the tracefs code then desperately tries to use the old
dentry pointer that just isn't _valid_ any more, but it doesn't know
that because d_iput() hasn't been called yet...

And as I *also* pointed out when I described that originally, you'll
practically never hit this race, because you just need to be *very*
unlucky with the whole "dentry is freed due to memory pressure".

But basically, this is why I absolutely *HATE* that "ei->dentry"
backpointer. It's truly fundamentally broken.

You can't reference-count it, since the whole point of your current
tracefs scheme is to *not* keep dentries and inodes around forever,
and doing a "dget()" on that 'ei->dentry' would thus fundamentally
screw that up.

But you also cannot keep it in sync with dentries being released due
to memory pressure, because of the above thing.

See why I've tried to tell you that the back-pointer is basically a
100% sign of a bug.

The *only* time you can have a valid dentry pointer is when you have
also taken a ref to it with dget(), and you can't do that.

So then you have all that completely broken code that _tries_ to
maintain consistency with ->d_children[] etc, and it works 99.9% in
practice, because the race is just so hard to hit because dentries
only normally get evicted either synchronously (which you do under the
eventfs_mutex) or under memory pressure (which is basically never
going to be something you can test).

And yes, my lookup patch removed all the band-aids for "if I have an
ei->dentry, I'll reuse it". So I think it ends up exposing all the
previous bugs that the old "let's reuse the old dentry" code tried to
hide.

But, as mentioned, that ei->dentry pointer really REALLY is broken.

NBow, having looked at this a lot, I think I have a way forward.
Because there is actually *one* case where you actually *do* do the
whole "dget()" to get a stable dentry pointer. And that's exactly the
"events" directory creation (ie eventfs_create_events_dir()).

So what I propose is that

 - ei->dentry and ei->d_children[] need to die. Really. They are
buggy. There is no way to save them. There never was.

 - but we *can* introduce a new 'ei->events_dir' pointer that is
*only* set by eventfs_create_events_dir(), and which is stable exactly
because that function also does a dget() on it, so now the dentry will
actually continue to exist reliably

I think that works. The only thing that actually *needs* the existing
'ei->dentry' is literally the eventfs_remove_events_dir() that gets
rid of the stable events directory. It's undoing
eventfs_create_events_dir(), and it will do the final dput() too.

I will try to make a patch for this. I do think it means that every
time we do that

    dentry->d_fsdata = ei;

we need to also do proper reference counting of said 'ei'. Because we
can't release 'ei' early when we have dentries that point to it.

Let me see how painful this will be.

             Linus

