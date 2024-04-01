Return-Path: <linux-kernel+bounces-127024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F608945F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0031C219A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B26B53E01;
	Mon,  1 Apr 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvEmbmnW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053E2E410
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003106; cv=none; b=GYekaxP4WzW2rp53ck3zswwYj3TpNUN4/T4fkyjXMG4uUFhGrfBsqeUwo3xbEeElvGsaHVYxHhWjKQToaMp7r5rfJORbu25dEi6F9D5Mr1I4PJvbyhsLN2DDZ55N/yeCpHe7IlXq/l4esNrBXgZ7GlLmxTDQyjwqldWqQih21W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003106; c=relaxed/simple;
	bh=vZUfNjaqaDySW1XWidGq+0ExudpJPYSAIJstHMBKzg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlBmQWuj4KJiy+0swBn3LoD1Dm8ewz8WftpKXXwGbh4sqWVBg4JyxEH1Cj89jrA6I2eUwvEGzphaErMvIozU3ykk5bk/E7lLdO8Lg80WrKmDXGGkqscQIzqQOUMndB4aF3vTqhwooe+9ogdsP27MUuRR36nnKMYHJz9+k5n22IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvEmbmnW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712003103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aR8tu4wboUlsoHy6XspKQ2R0ZstTV8oFxNJ4vNDsKA=;
	b=QvEmbmnWvFiuSvNN3YJ/2f3Zlq7d8rzRvG6T8q+2Fzza/E4lcwUvOy/lmap/R3CngEw6NO
	8A4/gIybl0AfeeOwn8tDDSdmuKrk8z2LNkjrfPtwDv6pqA4ks0AWQd2Y8wb51GHlR0ODrW
	/pmF8x4yW2OGe+ASGJHGplSXKSANJ9I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-UblUx4WdNu2aYo28lfo-6Q-1; Mon, 01 Apr 2024 16:25:01 -0400
X-MC-Unique: UblUx4WdNu2aYo28lfo-6Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d70ae79294so18102981fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003100; x=1712607900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aR8tu4wboUlsoHy6XspKQ2R0ZstTV8oFxNJ4vNDsKA=;
        b=JgRgTMJmV3U0WnOqwdpMtXZod7t8N1q5iJaVFPUX+DK4NtmojRPgG6rgnyDKFw5N9W
         tiX5SsMxdf5qtTVUp6weMxADWAIOTz2eHvW1nl+MVoZIzEb+SYLyUgSMeGYs3SocjVQ3
         Zhdkqn98hMLbgRL9eWM9DCwbx7sPydPSKXQQxyQBPgZ/wsub1PyOYT+KJ59xoFW2ZqMi
         nfpIt2FEGED/l0lhzDoyWxxH9pGzpmC98yO0VL2eMXPGiv2zkbfl7VEm47R0BT5H9rsz
         PsZ894pvbQTSy0P/rVKkw4NbAPlZnjHCM8AMqL59O/WL7r2v4MtPt79BM19syK2+a6fj
         OwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNDWmoW0Dq/v39PcPmgtTQp3rZzCTs3LjPTn2fkZ3GfXXIzLZCF8afLaxoIzkt+TOBRpjotLcoPWLTXiTjJZzv+DFwJ94qAnnOQQ4A
X-Gm-Message-State: AOJu0YxuB2GditJPCG6yz0UeNT2EI7rV/IWjQtIv++5HvbAIR3j+YKuT
	F4wciFIuI3FhKkn0RET2sF3R587U0Tv45ePzDVU370GwfAJLqyY2enkb1ztes+2bypUlEKWjhNw
	rO7dfxNBsUYr29s5c6qcZkYZntA/PTr7aS3tg+5nIlREiB1wm5jY9Y6MrZ2gBIXnv0Sv+Jac8Y0
	VgcFkqvHJ3BMdWk0h9rMG3NjDiXP5MkYzhQF4V
X-Received: by 2002:a2e:b710:0:b0:2d5:9f6f:1df2 with SMTP id j16-20020a2eb710000000b002d59f6f1df2mr4746446ljo.0.1712003100456;
        Mon, 01 Apr 2024 13:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGrlx83gDucXYd5tNhFA6A9txYt0fd8myzWmrJS7RF+7WMfFVj9hO57z1sOVv5nPhDo/lcwmnJC1ezsnlGvqk=
X-Received: by 2002:a2e:b710:0:b0:2d5:9f6f:1df2 with SMTP id
 j16-20020a2eb710000000b002d59f6f1df2mr4746444ljo.0.1712003100065; Mon, 01 Apr
 2024 13:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfwv2y7P7BneKqMZ@kroah.com> <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>
 <2024032709-grunt-eskimo-55a2@gregkh>
In-Reply-To: <2024032709-grunt-eskimo-55a2@gregkh>
From: Chris Leech <cleech@redhat.com>
Date: Mon, 1 Apr 2024 13:24:49 -0700
Message-ID: <CAPnfmXK50enZiRbJyoUJJ1jcwfc3BDSeVeQqq9-YJN5hGiLaDg@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nilesh Javali <njavali@marvell.com>, 
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Mar 27, 2024 at 09:56:43AM -0700, Linus Torvalds wrote:
> > On Thu, 21 Mar 2024 at 06:02, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> > >
> > > Char/Misc and other driver subsystem updates for 6.9-rc1
> > [...]
> > > Chris Leech (4):
> > >       uio: introduce UIO_MEM_DMA_COHERENT type
> > >       cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
> > >       uio_pruss: UIO_MEM_DMA_COHERENT conversion
> > >       uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
> >
> > So this was all broken, and doesn't even build on 32-bit architectures
> > with 64-bit physical addresses as reported by at least Guenter.
> > Notably that includes i386 allmodconfig.
> >
> > I fixed up the build, but I did it the mindless way. I noted in the
> > commit message that I think the correct fix is likely to make
> > 'uio_mem.mem' be a union of 'physaddr_t' and 'void *' and just always
> > use the right member. UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL should
> > probably use the pointer thing too.
> >
> > I also *suspect* that using 'physaddr_t' is in itself pointless,
> > because I *think* the physical addresses are always page-aligned
> > anyway, and it would be better if the uio_mem thing just contained the
> > pfn instead. Which could just be 'unsigned long pfn'.
> >
> > So there are proper cleanups that could be done in that area.
> >
> > That's not what I did, though. I just fixed up the bad casts.
> >
> > There may be other fixes pending out there, but I didn't want to delay
> > the 32-bit build fixes any more.
> >
> > It turns out that the cnic,bnx2,bnx2x conversion avoided the problems,
> > almost by accident. That driver had used UIO_MEM_LOGICAL before and
> > had existing casts. That doesn't make it good, but at least it made it
> > not fail to build.
> >
> > See commit 498e47cd1d1f ("Fix build errors due to new
> > UIO_MEM_DMA_COHERENT mess")
>
> Ick, ok, those casts work :)
>
> I was waiting to hear back from Chris before applying the patches from
> Guenter, but yours work for me for now, thanks!

My apologies, I was away for a bit and missed the emails from Guenter
and Greg in my backlog.  Sorry about the mess.

- Chris


