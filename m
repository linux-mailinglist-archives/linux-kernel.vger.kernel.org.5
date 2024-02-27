Return-Path: <linux-kernel+bounces-83329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2D86934C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31539B2DDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1C13B7AA;
	Tue, 27 Feb 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9i/VkyK"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693478B61
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041186; cv=none; b=ISukO8unwL+RpXMHPaA/j3OAxgpaIn0KGMuPJvyx7OMe1qi4vZ68oLnmn+2ceUiGwNiLwZRIx6AY2NrULVoA8RcFo5uKyrJnpD0Tj0Fl2NVQRNUF3sLd3uRO2uDkSM+2p5d/EQdeS1PzitO49jtmGPqLH7SMxwoZ8XtoiKr0r9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041186; c=relaxed/simple;
	bh=8iPufcibBCJKG0q1/qGL+A/Ni1lovHs1ZR0Ajl86BBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7LLe05tdZmfIBkAjCn/p3wvJIZJIaX3eqnb39Ej6wu43nEKqPXAVAxUSNnWZCPAHNGzwHmzaAAgdV/Z3nfekgdKVJl3As1+FiiWVIXg7KMG1LAZcLEWEX/+m3nAzgCdzU/giKhT45V4ytOD4Jsnx3rhNlbc9a3Yzx6J506pW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9i/VkyK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3259484276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709041184; x=1709645984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOWeidPv0GTdG2qvAOJJXPCS/uUkxL4qtXAn43lMC7g=;
        b=h9i/VkyKODKVyT3q1RsX+zHm90unQ65F+/+Im5lYXh/aDcZfhQuk0r2hRPr6k7Tf6t
         1dp5Pr8RXo4pVoJ0tl1YDaSwU/TEzbfFB/sO6ALUmpK9teqgmNAqFwlHK5br6+pM3NIz
         840l3XuJ4CIVFPTqP+RznQ+wEHHsgtAljlFVc5lM2iLLOf8ZD0PnJAKccUO9TB4xZvA0
         JJUYeyX29n/vq7eL9XT0gsnZgbns87eVkS/3821R1p92dBBxQNLAumteWyazSXsz7VIU
         MXrDDlOKY+Jqei3pDgJWD4Lv0V8deRAlX/aDxcQPKFYfgm3CmwbS5m2Xpzq0xLo4r3+0
         mZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709041184; x=1709645984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOWeidPv0GTdG2qvAOJJXPCS/uUkxL4qtXAn43lMC7g=;
        b=SziZNXw1usMeot6xjdTIey53w0Errhjm4g4kaL2kGljZt+F0P+KGagIOb11MAHHlFJ
         I83Y8k7LpZoRQ+QTG2ADrQTNw8j7WNNQmRBY21Z95wMEDWWhFBwOy1MhVNMPa0otLwR2
         2AZjYdPVdzB7GoUhcFKQFYQt93ZqJjDESRRSwz9TUeB18dpxcaF7nbY7NAt1X4C4cnM8
         rm+p7P1iuETZ+t7R1TIlMdHZOdYjDU30bo0hFfkU0ZYkRBoAwKhG9S6sBadzmvrF9gki
         1xY82gce6cfzR7w25uUGUYZT+P+mC4syaSydBNby5ZNyKkELAu6hvlPEq/yaorfgv21v
         GuiA==
X-Forwarded-Encrypted: i=1; AJvYcCUemQ7FoizGG5b5p6k0dZ8QtofmlDoCFY4WJ8n+SUoRqOnRW1MrOaezF3hg4HvSXFvT/XyS0NdLONvkN9QyV7zykeA5xsstD7hggSFj
X-Gm-Message-State: AOJu0YyAA5lL702nfmAySZgfi4nXxc4G35gCoqUISbHYw2tzxCf//0o9
	5yC9ua6I4yXEemUmlluCg4u5HjtoUO8MqrOpD3xUYoPRQYjUfMgVckFoV0KlPSdZXA+n7I+VOle
	oTZTMGuIVRWO918IKamOaWFaHjw7inEK/oo4l
X-Google-Smtp-Source: AGHT+IFK/VVwUhiGT2OlyOZOTeeMQ2mEbLEw6tyIu3zG0QccGmUrTQRKql4uWibkgraBEtRrXBYGwjqLNKKTY1ZiYWM=
X-Received: by 2002:a25:d8d3:0:b0:dbf:23cd:c05c with SMTP id
 p202-20020a25d8d3000000b00dbf23cdc05cmr2126143ybg.13.1709041183917; Tue, 27
 Feb 2024 05:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de> <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
 <20240223063723.GB11004@lst.de>
In-Reply-To: <20240223063723.GB11004@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Tue, 27 Feb 2024 21:39:07 +0800
Message-ID: <CAJDAHvZ4-mh8uMyq0NiPgWKGt=pS3teoJ0=ofCKZmLeqLXUVgA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:37=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Feb 21, 2024 at 05:27:58PM +0800, Howard Yen wrote:
> > The reason why I tried to propose this patch is that in the system I'm
> > working on, where the driver utilizes the coherent reserved memory in
> > the subsystem for DMA, which has limited memory space as its primary
> > usage. During the execution of the driver, there is a possibility of
> > encountering memory depletion scenarios with the primary one.
> >
> > To address this issue, I tried to create a patch that enables the
> > coherent reserved memory driver to support multiple coherent reserved
> > memory regions per device. This modification aims to provide the
> > driver with the ability to search for memory from a secondary region
> > if the primary memory is exhausted, and so on.
>
> This all seems pretty vague.  Can you point to your driver submission
> and explain why it can't just use a larger region instead of multiple
> smaller ones?
>

The reason why it needs multiple regions is that in my system there is
an always-on subsystem which includes a small size memory, and several
functions need to run and occupy the memory from the small memory if
they need to run on the always-on subsystem. These functions must
allocate the memory from the small memory region, so that they can get
benefit from the always-on subsystem. So the small memory is split for
multiple functions which are satisfied with their generic use cases.
But in specific use cases, they required more memory than their
pre-allocated memory region, so I tried to propose this patch to give
it the ability to get the memory from another larger memory to solve
the issue.

I'll upload the next version to show the modification in the driver.

---
Best Regards,

Howard

