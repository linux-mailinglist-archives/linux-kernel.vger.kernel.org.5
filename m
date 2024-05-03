Return-Path: <linux-kernel+bounces-168316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D48BB659
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4BEB26A57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D285C5E;
	Fri,  3 May 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BWAXnd37"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD77EEE1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772563; cv=none; b=PmP/VHA3bqTPsDodCEL/PJvbdPUsdG9PiRkA2Ka+M1pW8M7RXKtgGy/EYs6RapuIzLqKgI5ExtGBerXrR/Wb2EzLvxcYRAhrCIZB+8mr4v/0IqN6NHmJW9WG1rk6fDGykLFcT6AVp0cQe0kLVA5o+dwyUxx1D5Xp/r67fdA5x9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772563; c=relaxed/simple;
	bh=5kw/vQ2Z4GIERA/PZJO8R5H1So5ym6+6uJIhwrtRtXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUQLAZ0dWLAvhuPY9P8rbB8O2oemPBZBoiJ6ZTxXOduCntpDxPnxmyWMv50SXBQno+FtNbAaZmyP3rBNKDcQWXxD98NCkBXSVjMuQe0cneO/Zggxy1nkso5KhAkwDGD7KCLPuZCJiCot2dAUfipY6MDM0O5y5P+cj0MX/1C7ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BWAXnd37; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a5f81af4so17031566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714772560; x=1715377360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gwyBdWufoxKVrcKcsHh2OBVbUooApVD3S23GDedqB7U=;
        b=BWAXnd37oXbnZsHze4We8ZkQ2HKVHWZsPh/SWnlt/VZHjV0RmWa4S4DKTQ+NL27DM0
         nMyoXBjC0O29EriEDpUE8WaETB0t4T89h9M+RrAoO/8hwJ2k/lrg9hT4ucl70xcNtSYA
         XZNEbxPjWWleEcwSiTWkepTDqZISPhB2T2YFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772560; x=1715377360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwyBdWufoxKVrcKcsHh2OBVbUooApVD3S23GDedqB7U=;
        b=oP041RfLzEDqjdnT2CP5wM8U22kfdeeKfXXuKg2Z5bzT8DbEk4qNARJ/XonRGhy346
         J+j5ixLZCELJGJ5Kq+xupkg6eHtTUGhGqhUMG2iaKHQiCrZ7HvHISicX0o49vBoAiPXZ
         bEDEGs9ECDl7TenlqRg5K+j5jJBay3n27X7763nCt+NfwatRrRvU8ec6vNs2LHIhtwS1
         oNck3Gg1qIEKR9wMwpC4y2zqM7ox4QyEWnqnEgGbm/7Y/Ntt5WRCyUrmtTt0aUbSYTVi
         eKQZJrJNocw35T2iPVh/Pjn01ce2R1+0O/KhNMNdBxCaKyjSH3KX9lzFCKi6csGWvtFk
         afJg==
X-Forwarded-Encrypted: i=1; AJvYcCXKrJkJd4qRE3ZfKZZlGJKWCAVuCp2eKo61+YdBQGq0e+xg+UxTQcY7UtMM8wO74Ce2Hgxd2rdD+8e6zj3rv2gRXvKReaYZjp0bLr24
X-Gm-Message-State: AOJu0Ywi27RQagKBuornnk0geK2VekzDunJ6LHKbOP77PxUBxb8ImTuC
	FeaNPQHIfvELeNF5xQ+TACsQ6BMveqzbgw4KX6NOJHvd6V9tuQgfd/CQXd5nHIuDNuEsrBYpS3C
	gK3GjKQ==
X-Google-Smtp-Source: AGHT+IFYwnbZgfb9ITpTbdkTaLcMhntGfA1Rwf9ZMMW8cN7RPUKQFIpDe0mxLZO81AGeVceke1s4rQ==
X-Received: by 2002:a17:906:168e:b0:a55:b581:dca8 with SMTP id s14-20020a170906168e00b00a55b581dca8mr2460245ejd.38.1714772559914;
        Fri, 03 May 2024 14:42:39 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060e4600b00a5875dd74c2sm2169255eji.131.2024.05.03.14.42.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:42:39 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58a36008ceso15307466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:42:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3AW9cOO8pKO+fefoEGf4LxnZkb3Drk2aPBdE17NxrCi87jg9PGNHP2O1HqntgryeSQlD3+ZaJ5bOZtVH4vezCThtgoxveaQzbtgVS
X-Received: by 2002:a17:906:29d4:b0:a59:8786:3852 with SMTP id
 y20-20020a17090629d400b00a5987863852mr2658677eje.55.1714772559064; Fri, 03
 May 2024 14:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002d631f0615918f1e@google.com> <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook> <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook> <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
 <202405031237.B6B8379@keescook> <202405031325.B8979870B@keescook>
 <20240503211109.GX2118490@ZenIV> <20240503213625.GA2118490@ZenIV>
In-Reply-To: <20240503213625.GA2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:42:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRphONC5NBagypZpgriCUtztU7LCC9BzGZDEjWQbSVWQ@mail.gmail.com>
Message-ID: <CAHk-=wgRphONC5NBagypZpgriCUtztU7LCC9BzGZDEjWQbSVWQ@mail.gmail.com>
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?] [io-uring?]
 general protection fault in __ep_remove)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Bui Quang Minh <minhquangbui99@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>, 
	io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... the last part is no-go - poll_wait() must be able to grab a reference
> (well, the callback in it must)

Yeah. I really think that *poll* itself is doing everything right. It
knows that it's called with a file pointer with a reference, and it
adds its own references as needed.

And I think that's all fine - both for dmabuf in particular, but for
poll in general. That's how things are *supposed* to work. You can
keep references to other things in your 'struct file *', knowing that
files are properly refcounted, and won't go away while you are dealing
with them.

The problem, of course, is that then epoll violates that "called with
reference" part.  epoll very much by design does *not* take references
to the files it keeps track of, and then tears them down at close()
time.

Now, epoll has its reasons for doing that. They are even good reasons.
But that does mean that when epoll needs to deal with that hackery.

I wish we could remove epoll entirely, but that isn't an option, so we
need to just make sure that when it accesses the ffd.file pointer, it
does so more carefully.

              Linus

