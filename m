Return-Path: <linux-kernel+bounces-168434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162608BB88D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABDEB2187F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410985639;
	Fri,  3 May 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZGjV9bOJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9A5CDE6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780506; cv=none; b=T14TVGGqvlBSGkDn3EwHtaKzRMAWYL/5AI+FV4UYeHCSyPPJbwCw0sJZHJH9eO6yqdfhtDnCNhJo89JzZwMhbWwZLNEADRT9thTnbf8W3YNy+GWBESXs3B2x2xbGsw1kkRWovxVcp65GhYmqNEeRLGHyZmp83lgadKHZwAcBwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780506; c=relaxed/simple;
	bh=tf8gPRKnHuj1S8RN72oCYha0zRiI+Zqb52T37Eym2SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0NqODA3tS9RS8eIsy7/vRgcUS3hB6xulrCuduglM+4rOOjdmV0HJZ/LgOZfmMTYcNo0xKfNnNsrIWAZHLef7ljM17VZmmOUjxml7rtmjbozTkzofQGk/+cgAIh7y7W0M8hMDMxyKHKtRuOBXqS6fMAJyUENTmO3y46h3Df5vaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZGjV9bOJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso2358661fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714780503; x=1715385303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxPhlO3npeMKaw71dXY38r1VkXmdKnYRPE7+RntnY6E=;
        b=ZGjV9bOJtsx4vpIPOC+jl/xOHEhJ7ml4JgIzgS1AsIh9S5KtVKfqLKs5lLGdXsqdqf
         rWkxV9dUaT0DUgXtI/DlRGk7Nc6D3XFWtZVWDF3oll1MHPi3o8BiJMn9wp/AQUXXjouJ
         RyC5Ror5S88Byqw9QIUO/60WEA9J8Zz0r3ca4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714780503; x=1715385303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxPhlO3npeMKaw71dXY38r1VkXmdKnYRPE7+RntnY6E=;
        b=pH3TbkoomEEXDC/HY4peJulQuL9/bEb82Od1nQmG0MRns/rmqM4Q4n6wyWilXll8ve
         fJqrobWQFvNTmatmu1OMzEvfsGwatL0dUOlNLor4EWqsN1WjMy59GdNQXGdowc76WYxa
         nwtsl3uKVlckcfKgUvrk2JCxMEZ7xayijoR8vmhAAJUT1vHl5PeXG97LvdoKewgZX/nD
         UQfApEuUFKKsOYFoUL7LW0ew6az/jBgdWLsPtZE7pnJbWc3pmXrUahTL8rTWrv1k8lOB
         QJEqzOUfpqBRTLxEExft74X/ItajZJpVE/k0pSgqbXP/X+FB82GuXAnHTrLZ9irF+IHP
         5bXw==
X-Forwarded-Encrypted: i=1; AJvYcCVCbNC2e4YYhwFHsTZQJ54P1t4x5sdacnMmbJFlenB0Y7UcHKU0VI+qsDqmkvkwUhOHacvFJL+RnI/J5J2NQ5W2A4v7jtLVaiXmMBqE
X-Gm-Message-State: AOJu0YybScNfCBsSRrcP4FvEO04f8+b5Clr2572pmYD0gXqjroSr6y5B
	z01Db9BS9zspPVz/ww22ILk4BgFrkGTv3fli75Z84mT/2BP/M7T640pV7u5nfm/JXtGbpFRCcac
	+0s5d9w==
X-Google-Smtp-Source: AGHT+IEwaCD6OLDQvfYNGEc61mDX9qkuPQrhiK+i7ZlsRKgVXhIXMk3g6RkT2wuC6XkUmv2NvUzVRg==
X-Received: by 2002:a05:6512:3f1a:b0:51e:1264:8435 with SMTP id y26-20020a0565123f1a00b0051e12648435mr3202897lfa.27.1714780503124;
        Fri, 03 May 2024 16:55:03 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id jt21-20020a170906ca1500b00a526e6f5cbdsm2261694ejb.47.2024.05.03.16.55.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 16:55:02 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a387fbc9so29679766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:55:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3YQayQosnJLQ5hA71BScfNZqNuoCkpM8R31hWrInDbt3yD2HmxGyMVrBlQQv/8l4mqdueojNFGR6p1AKJJ79Hp8pXmwAAKbvx2at/
X-Received: by 2002:a17:906:3e4e:b0:a59:a64c:9a26 with SMTP id
 t14-20020a1709063e4e00b00a59a64c9a26mr202788eji.23.1714780501707; Fri, 03 May
 2024 16:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV> <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
 <20240503220145.GD2118490@ZenIV> <20240503220744.GE2118490@ZenIV>
 <CAHk-=whULchE1i5LA2Fa=ZndSAzPXGWh_e5+a=YV3qT1BEST7w@mail.gmail.com> <20240503233900.GG2118490@ZenIV>
In-Reply-To: <20240503233900.GG2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 16:54:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjjsm=f+ZJRe3dXebBQS8PzpYmHjAJnk-9-2FAj3-QoQ@mail.gmail.com>
Message-ID: <CAHk-=wjjjsm=f+ZJRe3dXebBQS8PzpYmHjAJnk-9-2FAj3-QoQ@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: keescook@chromium.org, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 16:39, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> *IF* those files are on purely internal filesystem, that's probably
> OK; do that with something on something mountable (char device,
> sysfs file, etc.) and you have a problem with filesystem staying
> busy.

Yeah, I agree, it's a bit annoying in general. That said, it's easy to
do: stash a file descriptor in a unix domain socket, and that's
basically exactly what you have: a random reference to a 'struct file'
that will stay around for as long as you just keep that socket around,
long after the "real" file descriptor has been closed, and entirely
separately from it.

And yes, that's exactly why unix domain socket transfers have caused
so many problems over the years, with both refcount overflows and
nasty garbage collection issues.

So randomly taking references to file descriptors certainly isn't new.

In fact, it's so common that I find the epoll pattern annoying, in
that it does something special and *not* taking a ref - and it does
that special thing to *other* ("innocent") file descriptors. Yes,
dma-buf is a bit like those unix domain sockets in that it can keep
random references alive for random times, but at least it does it just
to its own file descriptors, not random other targets.

So the dmabuf thing is very much a "I'm a special file that describes
a dma buffer", and shouldn't really affect anything outside of active
dmabuf uses (which admittedly is a large portion of the GPU drivers,
and has been expanding from there...). I

So the reason I'm annoyed at epoll in this case is that I think epoll
triggered the bug in some entirely innocent subsystem. dma-buf is
doing something differently odd, yes, but at least it's odd in a "I'm
a specialized thing" sense, not in some "I screw over others" sense.

             Linus

