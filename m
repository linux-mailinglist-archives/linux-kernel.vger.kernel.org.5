Return-Path: <linux-kernel+bounces-32194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA108357F8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB49228198F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73156383A7;
	Sun, 21 Jan 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XDp3Aehf"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D58FC18
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705873664; cv=none; b=BT9qGer9TujwtGoXQEpLVFd87OykjPFTj+hm2KgWD02YYx2aUxR5Kg0sZre2NsG3W7VqMxQZjX3npBDuYr7AgCUyGNnpvm6udVp1pRuKZE7mjZM7dAbzcCqjlT38S8g1arY0DVgd4K9bG6aTtBV3FkW8det43IL8LBHDu8ilYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705873664; c=relaxed/simple;
	bh=Tnnh1Dl6oJUUWSWPAOfX3NRqOgwAqvYTn3R80PPtQRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/G0kE6wgPLjYFHAF68QDliao8lZ93W34s18e4YV+tAcdPlZjlmR47fJ9D6VgVlwd+6Thg7BxbGfM2zmoEZGcpqaP/l0A9D0bKxEI6NqiA+QOuvFrCER6ccVlzzIzEzyXhgIaoedhTZeIDrAA5c0j+I2BgHQ4y0Qb/o1SyIJmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XDp3Aehf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2702810a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 13:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705873660; x=1706478460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zv7LisHTA9mSGhG/n8JfulU91D6XN81Ar7gfs0x00I=;
        b=XDp3AehfTpu4Mgx0Sp3ZempDPzbxg/WVlaH+jlKvVuu1pChjsev7KzyyFa1RAzyrHQ
         Mn6fghT5ciuCoGwj9o3V1Gihq7v7v1l4QDmLh+qX9swCJzgEZQWG1K5Gze/J/8AK/jNI
         aOplcvhF3sKR0WvAZVMaibq0kr3EUbTfuUa4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705873660; x=1706478460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Zv7LisHTA9mSGhG/n8JfulU91D6XN81Ar7gfs0x00I=;
        b=P8Wyqp/E1w3azlJUHbzOy1icm2hD0wUjqmyuMA5wmZhFXUr1U8glcD1BQ6A0y8ZLy+
         BFzqIBdRweok8R9JK9y9NZW4cm2EnEcFkXXkm3AUsfs6l9sNxhE4qtqUyrN/ABtirILb
         1lNqSH0LdIRUmRG37z9H+MLaAwMhTxkFDlMngrpXk5erPqcsU7REy/fR88Ze3bsq7Y4h
         6KBRN6M99QUKlWxfErhdTEmRXiBtZd/8OLPTMwR4NOrTavC1zH6eEgJ1xfVVDYRmCv4d
         d+9PdDaNP3nnmFfF9u1OhZvXlh+3xPfAW2ONTB+Pvd1ogPsBSUPAXYtL60Y6EaF5MZLL
         418g==
X-Gm-Message-State: AOJu0YwwH8RKtigrQB9rCrFLIQl0lV8LlUOvmvt/CXmZkjHy20v+7R4X
	VRCxbHeX5SuVRkJRxthlMueCjZ59KjfOPIhjQ277y63Hn3Jkp8vHpLlC+zxpdcNVqmgwzyqmVM4
	PHs7RFg==
X-Google-Smtp-Source: AGHT+IEw3VMKYlnuEDC+GIqVFyMgoHg91/qfeQPZbdt6jL0T30/AAEg27B02vcLxfSZmiV6C9SoVJw==
X-Received: by 2002:aa7:c593:0:b0:559:d8eb:e443 with SMTP id g19-20020aa7c593000000b00559d8ebe443mr1236690edq.80.1705873660576;
        Sun, 21 Jan 2024 13:47:40 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id l16-20020a056402125000b0055c4ab8122esm145811edw.38.2024.01.21.13.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 13:47:38 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2702783a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 13:47:38 -0800 (PST)
X-Received: by 2002:aa7:dccd:0:b0:55c:4f0e:67b5 with SMTP id
 w13-20020aa7dccd000000b0055c4f0e67b5mr26368edu.43.1705873658306; Sun, 21 Jan
 2024 13:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZwrbDUe4VQRYv5I@yury-ThinkPad>
In-Reply-To: <ZZwrbDUe4VQRYv5I@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 13:47:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh02qG1CtiQ-pPDcpbiZUx6AEdfAYPbp0nJ7wyzdHmEkw@mail.gmail.com>
Message-ID: <CAHk-=wh02qG1CtiQ-pPDcpbiZUx6AEdfAYPbp0nJ7wyzdHmEkw@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap patches for v6.8
To: Yury Norov <yury.norov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandra Winter <wintera@linux.ibm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Dave Jiang <dave.jiang@intel.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, Guanjun <guanjun@linux.alibaba.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Kelley <mhklinux@outlook.com>, 
	Oliver Neukum <oneukum@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sean Christopherson <seanjc@google.com>, 
	Takashi Iwai <tiwai@suse.de>, Tony Lu <tonylu@linux.alibaba.com>, Vinod Koul <vkoul@kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>, 
	Wen Gu <guwen@linux.alibaba.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

So I've left this to be my last pull request, because I hate how our
header files are growing, and this part:

 include/linux/find.h | 301 ++++++++++++++++++++++++++++++-
 1 file changed, 297 insertions(+), 4 deletions(-)

in particular.

Nobody includes <linux/find.h> directly, but indirectly pretty much
*every* single kernel C file includes it.

Looking at some basic stats of my dependency files in my tree, 4426 of
4526 object files (~98%) depend on find.h because they get it through
*some* path that ends up with bitmap.h -> find.h.

And honestly, the number of files that actually want the new functions
is basically just a tiny handful. It's also not obvious how useful
those optimizations are, considering that a lot of the loops are
*tiny*. I looked at a few cases, and the size of the bitmap it was
iterating over was often in the 2-4 range, sometimes (like
RTW89_TXCH_NUM) 13, etc.

In radio-shark, you replaced a loop like this

        for (i = 0; i < 2; i++) {

with that for_each_test_and_clear_bit(), and it *really* isn't clear
that it was worth it. It sure wasn't performance-critical to begin
with.

In general, if an "optimization" doesn't have any performance numbers
attached to it, is it an optimization at all?

So I finally ended up pulling this, but after looking at the patch I
went "this is adding more lines than it removes, has no performance
numbers, and grows a core header file that is included by absolutely
everything by a third".

. and then I decided to just unpull it again.

                  Linus

