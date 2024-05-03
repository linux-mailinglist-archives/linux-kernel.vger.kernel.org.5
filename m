Return-Path: <linux-kernel+bounces-168396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 672308BB816
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938FC1C2270E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AC84D3F;
	Fri,  3 May 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cr6KDcwO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA183A10
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778196; cv=none; b=G1msmjLj6BvTZKm8uf80lbHN/nWCInh39chJgXf44YsQvxNpVre6oglji0CoAiygyMLwMQQz7gOdLPUiotE84cn1zZexgLBxpn2KIXRDpaoyjwWHLmEo4bhGtzkv/m6FiOFwi42pP2vyCv3Jo4zhRdVceKFUhBILqDmdHwnoFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778196; c=relaxed/simple;
	bh=10Im6Ev0hm6GCexrKsrsuAqt7UP5HFJ90hGsgvNShJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpzbZ/trUjir9le3I7Rayu7OZ0KZ2nSTnE3jxMO+80SOA1eePuI9gIOB9ZocMGBDNkpd7XgjzQJr6Wxi6ZoYOt/CxmQVJDmAbCJ1HqFuEHdjLotGdxx6x52YxKeskW/en0+iad5rXSQt1cQtdKdJoUdKpSFd42eS/QYepqC2/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cr6KDcwO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a598e483ad1so26425666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714778193; x=1715382993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGG/rn4AzL6EAyTxraRF01dNEmbt6QApJhVwyWVeemo=;
        b=cr6KDcwOBUIXzfzW+aNT6dgf8KM9w5+3PMr5OKvI6Ga+or8Tl/OQwW8KeaA6oNLpL/
         zpBaK+8FRxNloQNR4hpFVbJoQKsWtJg7hBuZZprnICOrHGrkjAWgzfCoPwj6V/tXaTie
         lVcB6kJEJs/RUNfT64DDvOdNFYBLvH2Izdegs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714778193; x=1715382993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGG/rn4AzL6EAyTxraRF01dNEmbt6QApJhVwyWVeemo=;
        b=Vu+HMbuyiyqP56s8Fotc6LaoCj8Q08OQKeROoFMQTggauSOPTEeQQA50N7JfB4I3Gf
         efBCB2DIizyo/1gnk0FBOt4mPxhkCAq+odJMwmVlaTaX73w9Na2mkhi1DUaQGa9xi1nW
         /yeAkzmDOnhBUkyRCPvni0IljDUgri++Va+ACKsV73T3RvRdwNowJs1VUaHNjbugVUKV
         DvtOejOAzX48KsruV2XKgiP+VE4YshxTg9yviHvhzZm+KQbmph/rlpaNcw4eK6apLL8g
         PSFx+do49xHy2YjAXUjX9BFj72X3p8rCQIr2HrkP099a0fZX5VoHfRdFGxvS4ddU3CuQ
         /SYw==
X-Forwarded-Encrypted: i=1; AJvYcCUWvAnfRaMuoYtTAmKtA6P+7xznMNo77zbFF+0CbMv0B+QdrXcEjg63NZm894A0qQWlqBlCjY3npsLNwbF6VFgVh2rGbaYqfJHxt/VE
X-Gm-Message-State: AOJu0YzUFE6/tK7Oqz0pqujwcjf1FQIezcjFtwnEDdtyIAW9AoOdfxzS
	C80lLYcj35nzCJOKDpERed1NGtMnXxLEITNAq7eA+lmsw5MEy8lDXOPDPfKdqv5r1CVBwSxSW5Q
	2e7uUnw==
X-Google-Smtp-Source: AGHT+IHO/dmTatTxDOZd5xGm7BcrTwyXXDQNVQGNDJ2SgRtq0V/39NzihL9pKCNRKcfbfyYlIZ7eVw==
X-Received: by 2002:a50:d581:0:b0:572:71b2:e200 with SMTP id v1-20020a50d581000000b0057271b2e200mr2506458edi.22.1714778193398;
        Fri, 03 May 2024 16:16:33 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7d788000000b00562d908daf4sm2206839edq.84.2024.05.03.16.16.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 16:16:32 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a598e483ad1so26421566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeGyU77+ieRHplaxjUlnq6w77b9+4BA4yZhmvdDm69Bs7q2t8boVtFvpDOdbwZ+/1gAzLzUajrYVwRqEZf4o0VoTjl8Hd5IPqBHOHi
X-Received: by 2002:a17:906:52c1:b0:a59:2e45:f528 with SMTP id
 w1-20020a17090652c100b00a592e45f528mr2851931ejn.38.1714778191864; Fri, 03 May
 2024 16:16:31 -0700 (PDT)
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
In-Reply-To: <20240503220744.GE2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 16:16:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whULchE1i5LA2Fa=ZndSAzPXGWh_e5+a=YV3qT1BEST7w@mail.gmail.com>
Message-ID: <CAHk-=whULchE1i5LA2Fa=ZndSAzPXGWh_e5+a=YV3qT1BEST7w@mail.gmail.com>
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

On Fri, 3 May 2024 at 15:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Suppose your program calls select() on a pipe and dmabuf, sees data to be read
> from pipe, reads it, closes both pipe and dmabuf and exits.
>
> Would you expect that dmabuf file would stick around for hell knows how long
> after that?  I would certainly be very surprised by running into that...

Why?

That's the _point_ of refcounts. They make the thing they refcount
stay around until it's no longer referenced.

Now, I agree that dmabuf's are a bit odd in how they use a 'struct
file' *as* their refcount, but hey, it's a specialty use. Unusual
perhaps, but not exactly wrong.

I suspect that if you saw a dmabuf just have its own 'refcount_t' and
stay around until it was done, you wouldn't bat an eye at it, and it's
really just the "it uses a struct file for counting" that you are
reacting to.

                Linus

