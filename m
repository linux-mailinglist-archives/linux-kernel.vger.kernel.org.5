Return-Path: <linux-kernel+bounces-168250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9A8BB5AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73491C23ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B1B56457;
	Fri,  3 May 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S0vunfap"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA915915C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771507; cv=none; b=YGaRT/sxIDkmECuVpIyBCLtanWNwjlqB7HzlYBemzSBpgmUAiHloL/Z8MySVO/GAYeir1mpSRSJeBGrT6NTFS8eennxCo/+U2NJqSeaWU/azGO0Yp11um3uQpOaIk4P5ZO1z24ggcudSBVMfTHWfq5uzh/hoyx/anfRIjOOtNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771507; c=relaxed/simple;
	bh=N4MV6W6kLCjF7hioiCGBWf5TZPj+wehXzH5NmRppkU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/JMlZvekX8d/D57U+jKkFFLOUcTwRHZtVK/cl38dfSRe6RMJJT7D9/i20Ty+I2EDWZ4891iJ4P5NeIBej/IidbwSvtB8kdlu9DnCIPzCG8HpKr9m2l2XcOSK89iUYCQpBhzMT3OMqrBqSCRqS4d0DlCxogDmuIvPC6wM4e3PvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S0vunfap; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f300b318cso79000e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714771503; x=1715376303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhxz4aHpmXZJ6K0C5hNTESMtOJDx3oTLGnKkbndye9Q=;
        b=S0vunfapGZrfyWb8cs4gm4MDwD5hFZLlWm10XHyrLw9LIYzuUzQEcfmetydymLFBVC
         q/dYgQHGwDlmzjZdANFqhKvfChtpO3DCNmVxwsq5qRXvAEysz7yJPRT4LoDLUd+w6d4J
         gMS/QtZ6XqzGRjBYPuIDsMGbMqkSS2UL6WhFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771503; x=1715376303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhxz4aHpmXZJ6K0C5hNTESMtOJDx3oTLGnKkbndye9Q=;
        b=w6K9i3g/p/rPv3Aoo4d3QZNDOl9V5E6bGul/IVyS54i3p1oazhQ0n6j7IEOBlJM77b
         wbFmPxlsFLWtvgIerGF7NGC3ujRnpSIvVLlJ2YcUS17XQWj1ehmAQ6CNm/HNfwJWnvmT
         wI0BInxgs+pzjYs2F9cYUyDg7EodDq5NnyDZIChAYx42DQBIAsX6NVtv6YU3HZOQ6G19
         G/QG20EpocgxDoNrQUP4qhR0IgItIwwD0zoHTd2GfTifVMe7BDm9RlMYvpTSUxzQg/mJ
         UURqE9jTa78Ox36Qiv95pkvmph8zw8Cn/jSnZXPax2DqmgdrdNpa+RlTIplZx1WXHQsS
         WTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzWyuoibLX0iePBO34Eoo69ZK4l8fvvFrl7rXwWCV4Crh3Ac5X927E0LMmKtunjVkV4uwM49hpRJrnHUhJof+0tyzX2XrqyUVdykrP
X-Gm-Message-State: AOJu0Ywff63NHjhzSP6k1ztj3VnFHVbIk/STARlTxQDDXTYBJF6ED5rL
	4epO317bQDBoBcwMjkIG03JezMFnodn19pBbuby14DmAKIPP69omMr0g1f6iULX9n7j5F8GOryn
	fRPiynA==
X-Google-Smtp-Source: AGHT+IG+QaLA6sMCzrZWX3kcyuri7uFcgS2s0iXgNztqdALF3gT54Jrw4de10Ln1PiJmUyCXl2120Q==
X-Received: by 2002:a05:6512:4898:b0:51f:6223:2205 with SMTP id eq24-20020a056512489800b0051f62232205mr2541988lfb.44.1714771503233;
        Fri, 03 May 2024 14:25:03 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00516dc765e00sm653754lfr.7.2024.05.03.14.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:25:02 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so1256141fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:25:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9uU42OutnuQMXoAAOdor6gsOswV41rQewVI3u1iO26KcXSVoaV+q3k0VJhksaa5X/hJRBwu/L4uVs1FS63xuTmS51Q2xYwf4BgxGi
X-Received: by 2002:a19:381a:0:b0:51c:68a3:6f8e with SMTP id
 f26-20020a19381a000000b0051c68a36f8emr2449065lfa.31.1714771502428; Fri, 03
 May 2024 14:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002d631f0615918f1e@google.com> <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook> <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook> <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
 <202405031237.B6B8379@keescook> <202405031325.B8979870B@keescook> <20240503211109.GX2118490@ZenIV>
In-Reply-To: <20240503211109.GX2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:24:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0de-P2Q=Gz2uyrWBHagT25arLbN0Lyg=U6fT7psKnQA@mail.gmail.com>
Message-ID: <CAHk-=wj0de-P2Q=Gz2uyrWBHagT25arLbN0Lyg=U6fT7psKnQA@mail.gmail.com>
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

On Fri, 3 May 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What we need is
>         * promise that ep_item_poll() won't happen after eventpoll_release_file().
> AFAICS, we do have that.
>         * ->poll() not playing silly buggers.

No. That is not enough at all.

Because even with perfectly normal "->poll()", and even with the
ep_item_poll() happening *before* eventpoll_release_file(), you have
this trivial race:

  ep_item_poll()
     ->poll()

and *between* those two operations, another CPU does "close()", and
that causes eventpoll_release_file() to be called, and now f_count
goes down to zero while ->poll() is running.

So you do need to increment the file count around the ->poll() call, I feel.

Or, alternatively, you'd need to serialize with
eventpoll_release_file(), but that would need to be some sleeping lock
held over the ->poll() call.

> As it is, dma_buf ->poll() is very suspicious regardless of that
> mess - it can grab reference to file for unspecified interval.

I think that's actually much preferable to what epoll does, which is
to keep using files without having reference counts to them (and then
relying on magically not racing with eventpoll_release_file().

                Linus

