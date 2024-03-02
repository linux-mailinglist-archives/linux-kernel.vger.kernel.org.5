Return-Path: <linux-kernel+bounces-89543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3786F1CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF0B22B64
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F5364B6;
	Sat,  2 Mar 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wh/jWORG"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586B2C6B3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402838; cv=none; b=HZ51p0wLg8TObQ6UZVxVsZdFotRTABQgcxiHQ3nkBlPqWbHpDKWV7xFrEmyQRBvqL3YG+E6PbHIwrTSHuQ63/FYNa1SMlbW9nO8SiccZJIUa0V0wndSLjWCoWtsUFzFZ+aTt+mstRy1nLcklZoyh8Oo6nN64II1ygmRhm2NNq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402838; c=relaxed/simple;
	bh=oPp+kEJm2yuQWRduHCnpZa6W+Rr0cKGzx+MpiFA+B7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaKGSSiFHlSGBFaDaL9mC0oaZ6yFBCEVPPu3p0XsgDFoSdZaCcdDG932d7KbBoDzGZFxJ250B+wG7LzPOORLv6fCCyOBxUiuqZ5tkj/195fQO8XBJPLTBw4iibT9oUEwooRrJ2LjgfkXnnCdUpZrkrPwhpaqQP4hS7NIQBlY9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wh/jWORG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5132181d54bso3394987e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709402835; x=1710007635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tgHiAUIVGDD+1DgrVyftk8s8h5JugoTCX2MAvO9xGEU=;
        b=Wh/jWORGx7nG2fLYaVIuzhWcnwjSYYueizRf/R+Drp+3l6X985YI77UnPwgupYN6Xg
         v3eVSgw2mJRw8MowCgYoEh2vAv9DVkGjrzur+YISvlnnhZ/j+RXFun7ho3nMHOmTWwaB
         jDPV9F6/4rVBIQmXpe6a2OcQ5QWjbNidmzvUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709402835; x=1710007635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgHiAUIVGDD+1DgrVyftk8s8h5JugoTCX2MAvO9xGEU=;
        b=Zo+WWXhOfBq1koBbadpm/cnV5wdlWvQDoMauiIrP59/F3yy+53K7uZMvoW3YQ8ejhy
         QF7K4Phc2TIOt5trY0Zc8V6br4oIkCOyImf59sOnVGq6nalbscpJHq5+nk0tcnaE6WKG
         vyKYSympCNefQafmTNRZHNnL9e9KwnmgvPe7/z9rqPnWKEerbu1u4P/SjoyclVLN7sCB
         D2CHoKt621cAtMO5GsjTUnHv40djsu6wZ9j1U4SHM7fGTiSJwDhlyKElOSheyBsggyXN
         KHN/o+wz0j8x1ek+R0mPGAk7U4HaY7BShhN2ZxcM8Tu5HXxhoRpLT9oP0WSSiOj3899c
         vlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgypEFC+DcgBAMyvBegTPH7gQRJf40utf0BGcPSQxXTAW5LPQ6+hwmzIicqzzOMSJiqoND5v4up6mRcIbZTi5nHA67x17tRXTnLD3/
X-Gm-Message-State: AOJu0YxSSLVV5fixslDpH8+rRqptG1D3kUhHm4aD63J9QbFAf/iYw1kx
	X4mcgqLjrn6PjUrm3MqMgfRUhVZs9QTDOK96jGGBl7169Rpsml4RtRaOTm0B/+abRedoJBHQ5n9
	rK0oPPA==
X-Google-Smtp-Source: AGHT+IGXgGbmOVRId+p+1apQDhRRhRlpqUVAPZ9wXCr3qhzVX4yji8aWv0F/+0/WynELEHHzhA7Fbw==
X-Received: by 2002:a05:6512:4027:b0:513:2992:bda2 with SMTP id br39-20020a056512402700b005132992bda2mr4789318lfb.5.1709402835062;
        Sat, 02 Mar 2024 10:07:15 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id mp7-20020a1709071b0700b00a440ceb4110sm2952095ejc.183.2024.03.02.10.07.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:07:14 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a445587b796so338444766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 10:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWJZkn5UpMKepT0brgRIBd+JC4mYYJM7HQ+GsAa0xcD5lpF8T7KvL2kGcAIy2JJxtLjgu1K8TnOiZdix/1l4es+QCoLe+gUN+p0EhT
X-Received: by 2002:a17:906:2c53:b0:a44:f370:e2ce with SMTP id
 f19-20020a1709062c5300b00a44f370e2cemr785292ejh.16.1709402832627; Sat, 02 Mar
 2024 10:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
In-Reply-To: <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:06:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Message-ID: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 01:37, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> I think this solution has two impacts:
> 1. Although it is not a performance-critical path, the CPU usage may be
> affected by one more memory copy in some large-memory applications.

Compared to the IO, the extra memory copy is a non-issue.

If anything, getting rid of the "copy_mc" flag removes extra code in a
much more important path (ie the normal iov_iter code).

> 2. If a hardware memory error occurs in "good location" and the
> ".copy_mc" is removed, the kernel will panic.

That's always true. We do not support non-recoverable machine checks
on kernel memory. Never have, and realistically probably never will.

In fact, as far as I know, the hardware that caused all this code in
the first place no longer exists, and never really made it to wide
production.

The machine checks in question happened on pmem, now killed by Intel.
It's possible that somebody wants to use it for something else, but
let's hope any future implementations are less broken than the
unbelievable sh*tshow that caused all this code in the first place.

The whole copy_mc_to_kernel() mess exists mainly due to broken pmem
devices along with old and broken CPU's that did not deal correctly
with machine checks inside the regular memory copy ('rep movs') code,
and caused hung machines.

IOW, notice how 'copy_mc_to_kernel()' just becomes a regular
'memcpy()' on fixed hardware, and how we have that disgusting
copy_mc_fragile_key that gets enabled for older CPU cores.

And yes, we then have copy_mc_enhanced_fast_string() which isn't
*that* disgusting, and that actually handles machine checks properly
on more modern hardware, but it's still very much "the hardware is
misdesiged, it has no testing, and nobody sane should depend on this"

In other words, it's the usual "Enterprise Hardware" situation. Looks
fancy on paper, costs an arm and a leg, and the reality is just sad,
sad, sad.

               Linus

