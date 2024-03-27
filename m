Return-Path: <linux-kernel+bounces-121658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F488EBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF951C2718F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459914D422;
	Wed, 27 Mar 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d0vjn7kN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189614D29E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558625; cv=none; b=n3hmmqZPBn9Xpm4Cm18OBsXyMIHJEEHqZbp9vqDU7MHJHAt47OtO9o7G9EFSfUI5rjx+ZBfgw4ZFdF35nl80IqUvn9ZgL/ggnl8raK74XahIs3MY21mcbpbiwzFOE9xZD6q9shgtAvdpMDrEZlxleqdX4sD57hHXZS/NHc2pa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558625; c=relaxed/simple;
	bh=tmLpSzyxJf1bump+PTd5PHsMrvseHbupr6ZAVdaKn2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+7OeqpK/yEpLEcqrPTag2BDpxCt5dYWkwkrfbTa9MLiHalp+i7uXE+tZFdN9Krk9b+kzYRf2/YrZYKuBwd2dOYLjiZG67byi/qUYNszpQeY2QKxAk71ixa77xluIAbfXzwrwUPEg5t0W/kgkSZv03e1z+3XRSFTWKhFLpwYxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d0vjn7kN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46d0a8399aso191573966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711558621; x=1712163421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4rZuSF+pi31EXHxuJfITjpENhO2rcyue7XuCH9Tj1c=;
        b=d0vjn7kN+CM3THj/wegX8qJ/M925ME1KJI9p1eTJyleZ8cWflivYrjSd4e3WnAjRw9
         5ziwjSbmmwVVQ2IPVJ8hYRnzJ5YRn/wB7hS2H1Yk10ELsGCGgTEISXF5C4iB+spntdYI
         h2WMEwKU/rsVBfMiSdjmq581Az+YM0iUxnCxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558621; x=1712163421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4rZuSF+pi31EXHxuJfITjpENhO2rcyue7XuCH9Tj1c=;
        b=C0YQfEFuzBmkzQ8PDxumZajkIfOqOdl92Spg/+85DxsEDPWTbqwD0W5TjS93tJeAPg
         mMpavwN7xS1vXRFP7oHt+rV6hi1uh55X9ICQIGDJu9seE96ZxpuN+0EUYGYeGttaxKXc
         paVLV3mSMCUBvUp207pHb26AuSKd67ppq2o2095eo6PqMPT9266bqZnbMpQoumvHNgyg
         t3fzr0DJ2mF+GGh4+sGIxWQhgyjzi06DfljR0RPEHYMrD2ufGqbz1haFmvVJ608wZe9t
         rUShyYxmXFzfsUxTJGFA0xxHyKKS5NmYFG+f733mUibu6wNhq+dB9jIX2UF4ZxIgRKaN
         PApQ==
X-Gm-Message-State: AOJu0YxnCsHhsRDrd8+8K/bfkNC1SqEULZ8L2o0MnTx134y3o+lMG5uQ
	Yr5t/oI37Pp0czCfDb36uxrQ60eYhtqZcj+u6hmsN5Bd8znPw5vHOnKjIaCW4WX0ivfXKHwBR4I
	4fu4=
X-Google-Smtp-Source: AGHT+IGKzay4OILiqlXhoR+7CaeMC8r4HauP1XaX79x0Siu8vpshsLx/NIT6r3Y5nFYFUqvGDiIsqw==
X-Received: by 2002:a17:906:f754:b0:a4e:fab:ec5f with SMTP id jp20-20020a170906f75400b00a4e0fabec5fmr135104ejb.23.1711558621004;
        Wed, 27 Mar 2024 09:57:01 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id b17-20020a170906709100b00a46a9c38b16sm5601421ejk.138.2024.03.27.09.57.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:57:00 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c36f8f932so2049899a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:57:00 -0700 (PDT)
X-Received: by 2002:a17:906:f18b:b0:a47:3cd5:b3f1 with SMTP id
 gs11-20020a170906f18b00b00a473cd5b3f1mr106976ejb.35.1711558620065; Wed, 27
 Mar 2024 09:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfwv2y7P7BneKqMZ@kroah.com>
In-Reply-To: <Zfwv2y7P7BneKqMZ@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 09:56:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>
Message-ID: <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
To: Greg KH <gregkh@linuxfoundation.org>, Chris Leech <cleech@redhat.com>, 
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 06:02, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Char/Misc and other driver subsystem updates for 6.9-rc1
[...]
> Chris Leech (4):
>       uio: introduce UIO_MEM_DMA_COHERENT type
>       cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
>       uio_pruss: UIO_MEM_DMA_COHERENT conversion
>       uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion

So this was all broken, and doesn't even build on 32-bit architectures
with 64-bit physical addresses as reported by at least Guenter.
Notably that includes i386 allmodconfig.

I fixed up the build, but I did it the mindless way. I noted in the
commit message that I think the correct fix is likely to make
'uio_mem.mem' be a union of 'physaddr_t' and 'void *' and just always
use the right member. UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL should
probably use the pointer thing too.

I also *suspect* that using 'physaddr_t' is in itself pointless,
because I *think* the physical addresses are always page-aligned
anyway, and it would be better if the uio_mem thing just contained the
pfn instead. Which could just be 'unsigned long pfn'.

So there are proper cleanups that could be done in that area.

That's not what I did, though. I just fixed up the bad casts.

There may be other fixes pending out there, but I didn't want to delay
the 32-bit build fixes any more.

It turns out that the cnic,bnx2,bnx2x conversion avoided the problems,
almost by accident. That driver had used UIO_MEM_LOGICAL before and
had existing casts. That doesn't make it good, but at least it made it
not fail to build.

See commit 498e47cd1d1f ("Fix build errors due to new
UIO_MEM_DMA_COHERENT mess")

                    Linus

