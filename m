Return-Path: <linux-kernel+bounces-168422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89D8BB864
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253431C20A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C6383CCA;
	Fri,  3 May 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TBq5xg1s"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943584A57
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779701; cv=none; b=b0yElgQa9+2+bWjdSGg0aFDTdRV39iR4gPNecch27Z5NSA1JyzcEVnvePg0w6GPBnzAXhYyRL4Z6Af9lxkK10K8f+zFA+X5ajX0h1t0mh3bM32Elj2IckHfFfdgOO3KxXO+uYqo55M3p7xe8AWgS6mj7ioZInbH4/hIBanwO+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779701; c=relaxed/simple;
	bh=MSsbpnKLBIIDiyb/Z/B6yI6NHQlm2qNPMZwpsoocZ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOyQsoJcrbXQSG1bz5Xn2J7iSL15tvrr3y1M3sM/SfJ4zFbrBVnjL2f7WX+iQro6uPur+Q3soxq8GYyFSRbL0McXvy+P7/weDtdcekbIG67Mib0Fkh3f4VD/e2a2esXU+oUZKlZcf/UqI8Onr/8UmoreEfkCOmXRUw5/nJxkR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TBq5xg1s; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so2386131fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714779697; x=1715384497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ap01jwoCR0DRWLobuG8Czpgd5Vwn2tKoOeVWkObJWkg=;
        b=TBq5xg1sBA8zV/mvmOtoPryVJZTi1gB6j+vWmIwg2mEE/pSua3tBUv1us7XB29RnWw
         tO3hPqZl9jXu58oSPTQz5waCBbsxXHKxVPXBISdIW55YhIZRm4XspJxonoxzkfJh/U2y
         jk39reGIDIaKeKhO7uFyt9Wk7pkjLAnOWM51c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779697; x=1715384497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap01jwoCR0DRWLobuG8Czpgd5Vwn2tKoOeVWkObJWkg=;
        b=HcT2hdZFL571lo6rTSAS4DPxOflES/DtJH3dvGfNoblCHpmhnsVVk0Rb9khIguPDih
         iARXc9cRYDxZsBG7xxnvvl6iLLVDy2QEvBAmZLT6c4b9WgyA4LiKutelP4wT/axO4pvl
         sigDmc4IH7vE9SsdQnbs/+yhDyt/gkFdwVzNCOPM/EQNAwr8LGe8h0u28AEZrLymImN4
         Yq9HsYjdoMPyydLykinkRJ7kmdp3MKTXR2D6pz5vdoB6DKhUOgCAt6mzv/cDsgj6t2YV
         3Q3mPbIe6osOWJupBuDwf/elydiWcpB1UieOjnLU4K5hV6mLt1JaSPh7G32lEoQXeX9n
         PVdA==
X-Forwarded-Encrypted: i=1; AJvYcCVe/AKIxqUd1TS09kQx2D6U2BvoomBlnjkrnsBKlgZQwos3inNzT3RNC9XGRpY/5mfQcsInMvjksb4AGDBYMsluHTRwhCOoGy6xXwNG
X-Gm-Message-State: AOJu0Yz/8WHt8JxPlodpBQ4U30wr5YBmTFoLmiCoINTZE+kQCCDsmoRM
	t3y7jllwMC5LZ1XmIB44++MswnVZjHmjMPfA2RZoNCew5Pm+Q1bcF3uiBZHbwi1NFgWrLkyufES
	qpqDGjQ==
X-Google-Smtp-Source: AGHT+IFJGzl0tjhrcNL2hDugB4Jtj+k975jskCX3HhBlAjfcwPHk4e//7+8GSzVQm5H/bLWo5EVFqg==
X-Received: by 2002:a2e:9857:0:b0:2e2:142e:80d3 with SMTP id e23-20020a2e9857000000b002e2142e80d3mr2668814ljj.10.1714779697456;
        Fri, 03 May 2024 16:41:37 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z35-20020a2ebe23000000b002e1aafceba3sm52397ljq.43.2024.05.03.16.41.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 16:41:36 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ff65b1e14so84429e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4bIMSaRESkjCL4Vlfe4P/8IPt7ODKfUX42NMiHiwKN6xGtYn1P3wSaGsSOFg7UVnyapnd95dWTd+cKjj62UFfOx2ZZrNVSaLC6UCt
X-Received: by 2002:ac2:488d:0:b0:51b:fc6c:cbf6 with SMTP id
 x13-20020ac2488d000000b0051bfc6ccbf6mr2434386lfc.16.1714779695990; Fri, 03
 May 2024 16:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV> <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
 <202405031529.2CD1BFED37@keescook> <20240503230318.GF2118490@ZenIV> <202405031616.793DF7EEE@keescook>
In-Reply-To: <202405031616.793DF7EEE@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 16:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoXgm=j=vt9S2dcMk3Ws6Z8ukibrEncFZcxh5n77F6Dg@mail.gmail.com>
Message-ID: <CAHk-=wjoXgm=j=vt9S2dcMk3Ws6Z8ukibrEncFZcxh5n77F6Dg@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 16:23, Kees Cook <keescook@chromium.org> wrote:
>
> static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
> {
>         return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
> }
>
> If we end up adding epi_fget(), we'll have 2 cases of using
> "atomic_long_inc_not_zero" for f_count. Do we need some kind of blessed
> helper to live in file.h or something, with appropriate comments?

I wonder if we could try to abstract this out a bit more.

These games with non-ref-counted file structures *feel* a bit like the
games we play with non-ref-counted (aka "stashed") 'struct dentry'
that got fairly recently cleaned up with path_from_stashed() when both
nsfs and pidfs started doing the same thing.

I'm not loving the TTM use of this thing, but at least the locking and
logic feels a lot more straightforward (ie the
atomic_long_inc_not_zero() here is clealy under the 'prime->mutex'
lock

IOW, the tty use looks correct to me, and it has fairly simple locking
and is just catching the the race between 'fput()' decrementing the
refcount and and 'file->f_op->release()' doing the actual release.

You are right that it's similar to the epoll thing in that sense, it
just looks a _lot_ more straightforward to me (and, unlike epoll,
doesn't look actively buggy right now).

Could we abstract out this kind of "stashed file pointer" so that we'd
have a *common* form for this? Not just the inc_not_zero part, but the
locking rule too?

              Linus

