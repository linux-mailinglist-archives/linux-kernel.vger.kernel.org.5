Return-Path: <linux-kernel+bounces-49127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2022846627
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1728F670
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52013C2CE;
	Fri,  2 Feb 2024 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AAt+T796"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757B8479
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842753; cv=none; b=teeAFvXNqix7d/AzX4KCdd3a8DUBwhzkppqWjNz6n76NtRiMBMzq/2N3pWqtH8F+lCKOWJcLyR1z+EuGHWCNfeh+gfhVwRf9+55GgcHuMY+wAwJ/gJmSBeKyp6BD7Pm6LThVJ+p6MgA8TgdoDbNwyhqyuhDBrPe0z1ItGSpeJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842753; c=relaxed/simple;
	bh=3z9prfnNE6KbllL7JBa22QDsRc93s+EZn8OPdvRTgtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCU1g3IkjeN2giww8qW1AVYQdHkouXm8+PcjCJKMt8J2JVtHw9Ximiaao3tu0Qc8Iku+dzDWFVWBek2rCT1KohTxmWsHFCcPhoh5r7uhFrq5hC4GNB5sXxbEgCjis4Lt/d3so71yDLU5WETmhC6G/mm95dvUamXFzVceaBqMFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AAt+T796; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51124d43943so2563978e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706842749; x=1707447549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3A/r4oKTDxJsFL1Anlh777Z6f2eiMJhC1iris26H3M=;
        b=AAt+T7961dx/lh3ikpotIzNOAKXtCzZi6W9njeBfjlqUHYoZ117CmL/l5syKzQBls8
         8ydQ6yGjn1oJT4yAfJ1veQaItmRrqGAfq/o7Pa4w88L1+B+NjYlrauLFFwjI8ZfmaJlw
         ezgnsJ6ipugqY80TIpJkvLc1XF4BfyzUa822A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706842749; x=1707447549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3A/r4oKTDxJsFL1Anlh777Z6f2eiMJhC1iris26H3M=;
        b=Vej+WCjdrM0W+nL3vD0n+SeacUoDe17wFQxRk+LRbtSXdFxrVrLOG/CYm4JpuSVIN/
         ellK6Z3OX7K2DySUBs614QqODS5oHlIrd+EKxO4XdGnwMO1s8rtZqcfwKTn298Kmh+Jm
         NB3ZNngaUrz4PMgQkSVJ9WodU/yFoa1Qh+dbRrsGMzpXetXe3eZcpRod8S1bdVc2D5QD
         HTBE8BLUVMuXLS6wAnBX9Mb7ItZl5A1uPi+i1zc4skuy/azPZVTxIJgG+j7iNDzNLiJd
         9VP4yKRsIISKIR4IUi6md2F0+t5BXRnYBoWTllXyOe+qVQSgtajbkfxKkYjIVDLcud/p
         yU+w==
X-Gm-Message-State: AOJu0YyR/SrGczjKPt8ADeCE9sfGXYTa0NPO+T9yfZwaK0WxH/eCoPdt
	eO7BRkVBowUH0Q4dvjp1KxYUaPsyrSviBNH3nTv5dsYhyPDavnicjxD0mB2jwZQXxkt+CxN1YEe
	TqA==
X-Google-Smtp-Source: AGHT+IHN7Huf1xnRkwykH5koCgNvoVFIXb1ovtS1qA7CePz8rNcOTZbmpba7cdi4ynfcUXibGYTQ1w==
X-Received: by 2002:ac2:4579:0:b0:511:975:9efe with SMTP id k25-20020ac24579000000b0051109759efemr372434lfm.44.1706842748696;
        Thu, 01 Feb 2024 18:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDdv/epS/EX/vzza+JRHELIMQsi76n7WkpqCmQAlBkWR4OnwaTTgzYv+FlQyJGJREqiEpepqa+jvg5P2v252I8kaAVk+68NLZAKBIy
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id y19-20020a170906071300b00a26d20a48dasm388085ejb.125.2024.02.01.18.59.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 18:59:07 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso15785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:59:07 -0800 (PST)
X-Received: by 2002:a05:600c:3d92:b0:40f:c436:3982 with SMTP id
 bi18-20020a05600c3d9200b0040fc4363982mr62363wmb.2.1706842747629; Thu, 01 Feb
 2024 18:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <ZbxEWyl5Zh_3VwLb@casper.infradead.org>
In-Reply-To: <ZbxEWyl5Zh_3VwLb@casper.infradead.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 1 Feb 2024 18:58:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UoF7PGSevH1+Bk04gczjCaVioq4dXaPHDSc2Bk1NcJLw@mail.gmail.com>
Message-ID: <CAD=FV=UoF7PGSevH1+Bk04gczjCaVioq4dXaPHDSc2Bk1NcJLw@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 1, 2024 at 5:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Feb 01, 2024 at 05:12:03PM -0800, Douglas Anderson wrote:
> > While browsing through ChromeOS crash reports, I found one with an
> > allocation failure that looked like this:
> >
> >   chrome: page allocation failure: order:7,
> >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> >         nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>
> That does seem bad ...
>
> > @@ -16,14 +17,14 @@ static int __regset_get(struct task_struct *target,
> >       if (size > regset->n * regset->size)
> >               size =3D regset->n * regset->size;
> >       if (!p) {
> > -             to_free =3D p =3D kzalloc(size, GFP_KERNEL);
> > +             to_free =3D p =3D vmalloc(size);
>
> It's my impression that sometimes this size might be relatively small?
> Perhaps we should make this kvmalloc so that we can satisfy it from the
> slab allocator if it is small?

Right. Sometimes it's small. It feels sad to me that somehow vmalloc()
of small sizes would be much less efficient than kvmalloc() of small
sizes, but I can change it to that if you want. It feels like we
should use kmalloc() if we need it to be contiguous, kvmalloc() if we
know that there will be big efficiency gains with things being
contiguous but we can get by with non-contiguous, and vmalloc() if we
just don't care. ;-)

..anyway, I'll spin v2 with kvmalloc().


> Also, I assume that we don't rely on this memory being physically
> contiguous; we don't, for example, do I/O on it?

As far as I can tell we don't. I had never looked at or thought about
this code before today and so all I have is ~an hour of code analysis
behind me, so if someone tells me I'm wrong then I'll believe them.

-Doug

