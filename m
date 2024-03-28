Return-Path: <linux-kernel+bounces-123048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E3890175
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01521C26F69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8B7EF07;
	Thu, 28 Mar 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxYK6BZS"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10554BCB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635419; cv=none; b=pV7zhEUQKbP4jh3cWaIMiy376oR0jGpxwG6+r+YnOkqAzrvcyY6R62jGanuSDgfbVJVFO3KC7pnlpA+CTRe8jx1HnHjGvANdDHKP+uA59knNAcQ+E1pEBiT0nouo8L5QyF02TtwxfhIXrtCYzUX93VZ9SgSHaa7qrwU/o5ryakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635419; c=relaxed/simple;
	bh=h4pyAfpzD/813Nb4OhgzyPI/dG83mPiaUM72PzINltY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc5jG1KFlQnXLPyg8QbYf2L51iLGgnbXAT7blK2gyOue2OCIQiCY7oRBmrBu+0aG5ZPAdzolNRxAzcj3ceFtNh9m3TmVjKwcvEP7zaknHj0UGc5rq1wFnkY9nwmJnGTi99gabYhn2dYPjtbSlsSJaCMvG/ikGpzMkzdR3hFaw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dxYK6BZS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430dcd64e58so5639481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711635415; x=1712240215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZkkr+8BMbOQbcHkSO5h3H5iApjHoCs8BFl7+oRwVKE=;
        b=dxYK6BZSqs5SX3No9PRJHrTZe7TLTca2W61Oo4gix7rhceQQkKQRA50wz8azz01Maj
         h5fdgwMlWduCSNQXBI/TafK3vZP9wGFT+SayQSxXihIy7zPrRS4P/YG0J4KzljYYkJy3
         aka+Npz4Uy/zgS8JWye+a54h6QaW9Xe/Wdge4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635415; x=1712240215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZkkr+8BMbOQbcHkSO5h3H5iApjHoCs8BFl7+oRwVKE=;
        b=sOMscSXA3y59NxwbtmuMeUo/4KqEfZZ7wvWBJkf4xIJ2AjP0+tG4QqDUD9NQZz8BCI
         QD3uo9E6j3t0wZnN1XhJjbETsWRn2eZ8KKA1OtgTfgAwBqQWebvyOp6v4Z9FhyQP3ts3
         6Se+3oYpKij0A+smxaTKqUEK5mDoB3pHjDI+gN3m4pjZA+McwpxsSXYWbjy+pF35qCn7
         Ezsbmbxe0qo9r4Q0AVihtrZ8MjS53Fu7aJan+O+WIYZI45SgcfUujtMWPaZHwsq9yRXe
         f+AalLWH1LVBRQjLdbVqNm9wIl3afa+r0r1uU3k5sLULADjEMCBr/uMvSv1wHTZREwgb
         ZOIg==
X-Forwarded-Encrypted: i=1; AJvYcCWoBo1eAVqlmiFLLxLLq0vtI/lNeQz9CcB16xWrzcGkE/2PQKISHfMHnfBgnPf7JDlmyi/ey4jIu7S5nvKZAjVwwmB34g7nkFFlhAq6
X-Gm-Message-State: AOJu0YzlXf+O42T9LJhI9ItmGa+PkCShYTS720uP7jOj/jTinqACr+1A
	OuuVPXvV11PMqY7MK7O64qpjXoNUj69hnR4XfP3HXBRIYbQSqvnnNBrKFZP7ZWgTj/4pJNmOjN8
	=
X-Google-Smtp-Source: AGHT+IHeqtHQyNU8WGYE1tTENrU8guTbSA2FDJhZIg+Wo2N1s4tOz6Ad05Txg8uhHi7yjiqi7rA/OQ==
X-Received: by 2002:a05:622a:47ce:b0:431:f7fc:dd08 with SMTP id dp14-20020a05622a47ce00b00431f7fcdd08mr3102063qtb.22.1711635415357;
        Thu, 28 Mar 2024 07:16:55 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84dc8000000b0043167d8c57dsm650980qtw.56.2024.03.28.07.16.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:16:54 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-428405a0205so342621cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnrTvVgyzDpPtN2iUDnmGkhG2Tg90sbwKgt6DzJRr8woxYvCDNNwctC9F2KglYerYKxRhoanAA3xtc0uEYqpZw3LBwKjDio+N7zX3E
X-Received: by 2002:a05:622a:608d:b0:431:6352:80fb with SMTP id
 hf13-20020a05622a608d00b00431635280fbmr244987qtb.16.1711635413584; Thu, 28
 Mar 2024 07:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 28 Mar 2024 07:16:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com>
Message-ID: <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com>
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 3:55=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Feb 5, 2024 at 9:27=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
> > While browsing through ChromeOS crash reports, I found one with an
> > allocation failure that looked like this:
> >
> >   chrome: page allocation failure: order:7,
> >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> >           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
> >   CPU: 7 PID: 3295 Comm: chrome Not tainted
> >           5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
> >   Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
> >   Call trace:
> >   ...
> >   warn_alloc+0x104/0x174
> >   __alloc_pages+0x5f0/0x6e4
> >   kmalloc_order+0x44/0x98
> >   kmalloc_order_trace+0x34/0x124
> >   __kmalloc+0x228/0x36c
> >   __regset_get+0x68/0xcc
> >   regset_get_alloc+0x1c/0x28
> >   elf_core_dump+0x3d8/0xd8c
> >   do_coredump+0xeb8/0x1378
> >   get_signal+0x14c/0x804
> >   ...
> >
> > An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> > a surprise that this allocation failed on a system that's been running
> > for a while.
> >
> > More digging showed that it was fairly easy to see the order 7
> > allocation by just sending a SIGQUIT to chrome (or other processes) to
> > generate a core dump. The actual amount being allocated was 279,584
> > bytes and it was for "core_note_type" NT_ARM_SVE.
> >
> > There was quite a bit of discussion [1] on the mailing lists in
> > response to my v1 patch attempting to switch to vmalloc. The overall
> > conclusion was that we could likely reduce the 279,584 byte allocation
> > by quite a bit and Mark Brown has sent a patch to that effect [2].
> > However even with the 279,584 byte allocation gone there are still
> > 65,552 byte allocations. These are just barely more than the 65,536
> > bytes and thus would require an order 5 allocation.
> >
> > An order 5 allocation is still something to avoid unless necessary and
> > nothing needs the memory here to be contiguous. Change the allocation
> > to kvzalloc() which should still be efficient for small allocations
> > but doesn't force the memory subsystem to work hard (and maybe fail)
> > at getting a large contiguous chunk.
> >
> > [1] https://lore.kernel.org/r/20240201171159.1.Id9ad163b60d21c9e56c2d68=
6b0cc9083a8ba7924@changeid
> > [2] https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-=
1-2c3ba1386b9e@kernel.org
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Use kvzalloc() instead of vmalloc().
> > - Update description based on v1 discussion.
> >
> >  fs/binfmt_elf.c | 2 +-
> >  kernel/regset.c | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Just wanted to check in to see if there's anything else that I need to
> do here. Mark's patch to avoid the order 7 allocations [1] has landed,
> but we still want this kvzalloc() because the order 5 allocations
> can't really be avoided. I'm happy to sit tight for longer but just
> wanted to make sure it was clear that we still want my patch _in
> addition_ to Mark's patch and to see if there was anything else you
> needed me to do.
>
> Thanks!
>
> [1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-=
c7600ca74b9b@kernel.org

I'm not trying to be a pest here, so if this is on someone's todo list
and they'll get to it eventually then feel free to tell me to go away
and I'll snooze this for another few months. I just want to make sure
it's not forgotten.

I've been assuming that someone like Al Viro or Christian Brauner
would land this patch eventually and I know Al responded rather
quickly to my v1 [2]. I think all of Al's issues were resolved by Mark
Brown's patch [1] (which has landed in the arm64 tree) and my updating
of the patch description in v2. I see that Al and Christian are
flagged as maintainers of "fs/binfmt_elf.c" which is one of the two
files I'm touching, so that's mostly why I was assuming they would
land it.

..but I realize that perhaps my assumptions are wrong and this needs
to go through a different maintainer. In this case (if I'm reading it
correctly) Al and Christian are listed because the file is under "fs"
even though this isn't _really_ much of a filesystem-related patch.
Perhaps this needs to go through something like Andrew Morton's tree
since he often picks up patches that have nowhere else to land? If
someone else has suggestions, I'm all ears. I'm also happy to repost
this patch in case it helps with a maintainer applying it.

Thanks!

-Doug

[1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-c7=
600ca74b9b@kernel.org
[2] https://lore.kernel.org/r/20240202012249.GU2087318@ZenIV/

