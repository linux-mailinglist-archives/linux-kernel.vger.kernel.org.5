Return-Path: <linux-kernel+bounces-44167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C21841E38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D4A28E2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A557874;
	Tue, 30 Jan 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XIDbMRj4"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44B60B9A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604248; cv=none; b=FeFgkUP5QPoJWYgWghzFSVxyT0u8fKItehwpoRyRIvuKEuB3R3/J/wS3LQqh6cGD0Ijb4j2kneLMvGz0iT4qZcgfMuaMN6STMwH84jZMHyWhZJZTYoN+z3r6lQyWvyjt8Ky7090jffXU1VR05KXD+4OeIV+SqEmOEOul+j9mqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604248; c=relaxed/simple;
	bh=fh3Oobbo3ozn7qKP0JOFPHWneqBQFpX8St5WanXUNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzxuB4/b/1LZWBjUAP/Fkvb4qqHVWpycADNf/nyf6fcq//+K1St6XX09Y1KKCn1gYFxRWTsZmz08X2zA3l21URKWFn8UKdSauIlaQVhTE+2wyCqHVIfTolgGtmtGax1UHNPr56rq/fsiqHF2dsZGtQ1QEJfhEmkb0N9qOyLl1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XIDbMRj4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51032e62171so3678810e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706604244; x=1707209044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ+AzAqTf7hVYM2GdeV6bNXU4qpra1WyPgLqP0lu0rA=;
        b=XIDbMRj4izd9gl0jo4t8nQXTTaKJExMQaxEcvvdCIdvC6aYg7aL2qaukKV44NYOA90
         e17m1Ssm6i2oABh4501vIeExdkthrQK2jg5fse6s9fSRLiyGQ3MBi3rzKDAGBOGNe4on
         Kuv6uKaXFkn74fPBaq+XFUHgBOfuZzopWUpQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604244; x=1707209044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ+AzAqTf7hVYM2GdeV6bNXU4qpra1WyPgLqP0lu0rA=;
        b=TLBikAZpwuRxdxigM9mwYvL2IB1lYzIBmejzQsfAXVDFQ4ieEKfHUCK1hFeV2EfGAT
         y4cv2cBrpY3Aar8c+p+C6RGQXKM+th/Bu5BG/VLLymKfAIaAwmInUJbJJmYfzzh2O0xq
         vqBCR8tZUkidGnV6nYsf+lxcqIlBCE+jdWrqgtYmv7hTIpV3uLx1IagDug+OmTnp8y2A
         BsJB7DIIk7lJy0NyEui0QL836lWxf6P1gctLol1M8hmKBPQSSHzUEAIlFAZQvFXbBq3c
         xYixiGCnEbLiQg9zOwK1+jm7Y3UJmIH6Ab7X6tKjYZ1iLR9CJ0d3a857fnuN5K/5EEOQ
         rPaw==
X-Gm-Message-State: AOJu0Yza7iEnmc3jwam4PhoyCWfvgtQj77bUcHwgtTgFCMJT3550481n
	hqhNKace1CIYHeBiq5qI5PQajXidKsglIBs7HxMmWJcC7aTzYrAsg/IryE6u5VCqczV+Z5Hrwol
	BSJo=
X-Google-Smtp-Source: AGHT+IH7gGnaok755k/8RxKfHftIX3EDDpzqJqLiaZw8Q0sB4v9n1hSsDHU+akRCS8/wvNyKin8rSg==
X-Received: by 2002:a19:4f05:0:b0:50e:74ea:525c with SMTP id d5-20020a194f05000000b0050e74ea525cmr5753245lfb.3.1706604244219;
        Tue, 30 Jan 2024 00:44:04 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z11-20020ac25deb000000b0050ecbfa6eeasm1369531lfq.305.2024.01.30.00.44.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:44:02 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf1288097aso49219851fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:44:02 -0800 (PST)
X-Received: by 2002:a05:651c:1cc:b0:2d0:4ef8:3472 with SMTP id
 d12-20020a05651c01cc00b002d04ef83472mr3848048ljn.47.1706604241691; Tue, 30
 Jan 2024 00:44:01 -0800 (PST)
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
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
In-Reply-To: <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 00:43:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
Message-ID: <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 19:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I've been staring at this code for too long, so I'm posting this
> just as a "it's broken, but _something_ like this", because I'm taking
> a break from looking at this.

Bah. I literally woke up and realized what the problem is.

We're caching negative dentries, but eventfs_create_dir() has no way
to invalidate the old negative dentry when it adds a new entry.

The old "try to reuse dentry" ended up hiding that issue, because it
would look up the negative dentry from the 'ei' and turn it into a
positive one.

And I was stupidly staring at the wrong code - all these functions
with almost the same names.

eventfs_create_events_dir() is fine, because it gets the parent as a
dentry, so looking up the new dentry is trivial.

But eventfs_create_dir() doesn't get a dentry at all. It gets the parent as a

  struct eventfs_inode *parent

which is no good.

So that explains why creating an event after deleting an old one - or
after just looking it up before it was created - ends up with the
nonsensical "ls" output - it gets listed by readdir() because the
entry is there in the eventfs data structures, but then doing a
"stat()" on it will just hit the negative dentry. So it won't actually
look up the dentry.

The simple solution is probably just to not cache negative dentries
for eventfs.  So instead of doing the "d_add(dentry, NULL);" we should
just return "ERR_PTR(ENOENT)".

Which is actually what /proc/<pid> lookups do, for the same reason.

I'll go back to bed, but I think the fix is something trivial like this:

  --- a/fs/tracefs/event_inode.c
  +++ b/fs/tracefs/event_inode.c
  @@ -517,9 +517,8 @@ static struct dentry *eventfs_root_lookup(
        }

    enoent:
  -     /* Nothing found? */
  -     d_add(dentry, NULL);
  -     result = NULL;
  +     /* Don't cache negative lookups, just return an error */
  +     result = ERR_PTR(ENOENT);

    out:
        mutex_unlock(&eventfs_mutex);

I just wanted to write it down when the likely solution struck me.

               Linus

