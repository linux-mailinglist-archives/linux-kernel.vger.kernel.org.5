Return-Path: <linux-kernel+bounces-82459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D944C8684D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678911F22706
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F511C27;
	Tue, 27 Feb 2024 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e+/WSWYb"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BE1366
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708992139; cv=none; b=PUFIl485mYSpfQYm2dv9tXMlJSg/Ghucsk3pADYXcuYrE6twNiZGitqeI5wA3GN5SPMwVXJ10h2wkbUvEgI2sdcv1HMXsp5scuHnmOnYDNsusrMIavBvu9xSxs+WIww/7JgLfTSi0P2gDxs+hGmAEDTkruCzz9SVpgaEdnWy2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708992139; c=relaxed/simple;
	bh=pd6yrnTC+hRr0/Z0yLyCvqH0hBN/UOqqiHViIEB2PNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCos0lY4TAOorQZvqPES0YcySIBlB1fvD10GgGTPWIY8UhMOKZJHbxq6bmp9ZMibZTJKLcWbey5ZayNDf0GVaHQA8DybvkjZECtYhKSIfw78gqzYf4HMT7PjI9PXkngByFYa2nojQozg26nd30T/hyQNIVx3wiiyJGmcJ/muuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e+/WSWYb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26fa294e56so627886366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708992136; x=1709596936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra7j2veHt8ckgDfEUqJ6n9hg5jJXbYYJjjFPbVavXog=;
        b=e+/WSWYb/DzBJ9b7k+Hpf5I6r/XPurn7d50AnX7ML1wRPAPjEhxBuMFYB1kE6qtJ0A
         v7pfCtufGdnaeGDme7Uxe5R7UC9ROWbr0ZG/rGOooa1d84b7lxWA8ky2N5TODDtmgncA
         tYwYLftxJLuiiQZ+IZMbg6WKZm6R6gCXNwVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708992136; x=1709596936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra7j2veHt8ckgDfEUqJ6n9hg5jJXbYYJjjFPbVavXog=;
        b=O0MOnSRsqMq3Q07MwMad30PfbWkHtxsY1zcQdVu8CIuQhDkUZint8fmyzKXPgl7KVx
         yDnUewnMe511rc9rYXHgK2sMf/74l+GolmJv2U8jvJbg/Wpo1Qo84aOI0q0a4SAQoSLR
         z+f/c16YtXAyY5JMKDlRcnr9C3LNhsPkH2i7vvSPxHeWq2MgSlrQA6Qvjlr8+5ZifGFu
         HlxO1bfTDb6+xp9Vzw0Vj8FTfJwRNhXGKY+u92tvO8RzaYEpVMSEz7MbD0RwrXlyXwxO
         ZQQ3IcIyhmtRvkluUhEWVrWdGyBWO7klZscp61ihs4EOtftLg17LgaNVxdbAw2m8WIjc
         mIQg==
X-Forwarded-Encrypted: i=1; AJvYcCVzzbgtU2sGf+PLyrZATucHCrZywq8T9fLq1G/qIFUycl/bRLqGC2oHsIrz7fLiDBZ6pngvl8Ue+To6YwxZcNfUOz4Lx2b4hid+PmxW
X-Gm-Message-State: AOJu0YxgAQjPK0rMAiLQi3wP4G7epRl9ulcmcqdjAgxP21tQe6ChnnSG
	CViLiamNEx9PD175eb4AfOUDG6r1avpGtIpO/JIK3/3Fj9b6KM1S/gFyB2S/zuVcV4BifYAIZet
	Lim1Y
X-Google-Smtp-Source: AGHT+IHmTBAl0RCeGmgdikm0kdhd6bgLLQo+EV+iIRMa726ot8UULm8FJJGset2mN/VAB0RkJKC+uQ==
X-Received: by 2002:a17:906:a046:b0:a43:35f1:944e with SMTP id bg6-20020a170906a04600b00a4335f1944emr3971959ejb.22.1708992135707;
        Mon, 26 Feb 2024 16:02:15 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906235000b00a3d153fba90sm205910eja.220.2024.02.26.16.02.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 16:02:15 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so20565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:02:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYXp5FNslpCq5eqEo8AUDTTR2kznCjAZtnF5UdBQkXI4zfgbCvBdcIZ1odtueJAulB0P7YsDctDHrDO9HMwm9xoU6fMIrkNKJk/8+N
X-Received: by 2002:a05:600c:501f:b0:412:5616:d3d with SMTP id
 n31-20020a05600c501f00b0041256160d3dmr41903wmr.7.1708991743417; Mon, 26 Feb
 2024 15:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
In-Reply-To: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 15:55:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
Message-ID: <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 5, 2024 at 9:27=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> While browsing through ChromeOS crash reports, I found one with an
> allocation failure that looked like this:
>
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
>           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>   CPU: 7 PID: 3295 Comm: chrome Not tainted
>           5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
>   Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
>   Call trace:
>   ...
>   warn_alloc+0x104/0x174
>   __alloc_pages+0x5f0/0x6e4
>   kmalloc_order+0x44/0x98
>   kmalloc_order_trace+0x34/0x124
>   __kmalloc+0x228/0x36c
>   __regset_get+0x68/0xcc
>   regset_get_alloc+0x1c/0x28
>   elf_core_dump+0x3d8/0xd8c
>   do_coredump+0xeb8/0x1378
>   get_signal+0x14c/0x804
>   ...
>
> An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> a surprise that this allocation failed on a system that's been running
> for a while.
>
> More digging showed that it was fairly easy to see the order 7
> allocation by just sending a SIGQUIT to chrome (or other processes) to
> generate a core dump. The actual amount being allocated was 279,584
> bytes and it was for "core_note_type" NT_ARM_SVE.
>
> There was quite a bit of discussion [1] on the mailing lists in
> response to my v1 patch attempting to switch to vmalloc. The overall
> conclusion was that we could likely reduce the 279,584 byte allocation
> by quite a bit and Mark Brown has sent a patch to that effect [2].
> However even with the 279,584 byte allocation gone there are still
> 65,552 byte allocations. These are just barely more than the 65,536
> bytes and thus would require an order 5 allocation.
>
> An order 5 allocation is still something to avoid unless necessary and
> nothing needs the memory here to be contiguous. Change the allocation
> to kvzalloc() which should still be efficient for small allocations
> but doesn't force the memory subsystem to work hard (and maybe fail)
> at getting a large contiguous chunk.
>
> [1] https://lore.kernel.org/r/20240201171159.1.Id9ad163b60d21c9e56c2d686b=
0cc9083a8ba7924@changeid
> [2] https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-1-=
2c3ba1386b9e@kernel.org
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Use kvzalloc() instead of vmalloc().
> - Update description based on v1 discussion.
>
>  fs/binfmt_elf.c | 2 +-
>  kernel/regset.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Just wanted to check in to see if there's anything else that I need to
do here. Mark's patch to avoid the order 7 allocations [1] has landed,
but we still want this kvzalloc() because the order 5 allocations
can't really be avoided. I'm happy to sit tight for longer but just
wanted to make sure it was clear that we still want my patch _in
addition_ to Mark's patch and to see if there was anything else you
needed me to do.

Thanks!

[1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-c7=
600ca74b9b@kernel.org

