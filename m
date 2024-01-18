Return-Path: <linux-kernel+bounces-30379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FEC831DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A1528AA09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6A2C6BA;
	Thu, 18 Jan 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qdf5Pmc2"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9E2C6AB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597052; cv=none; b=UhiVplOEcdfk13ObFHbLxGuc8C0pnmTuYlDAKG9qCvjGkZrn9wWaB/7BF0qGTei72vCHyL0MSqVDR8EI2j5HODi1/Lb+4PiEc9xNZmPUkh5ukucq4iZ4j/NxNsSYd3mnsHFjkvuU0YBlnSJVQwOMg9g8Lij4qpvaVpqxhbR1ToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597052; c=relaxed/simple;
	bh=cmZn+BROv+sMREBkau20U4T/TQEgObsLAqinfuULAyg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=U7H5biFI73EaTpHQj86pRh3L+b8OEjDExj0V3eHIoVyx0M2GhcykqC0KaW8eEW8tQCY4z3mtjsZLuvc0EXK8hUtSRm7vHtEE46jsVQuibDawebzvWeCu00DWO7MFfWn6DDyP4dFQIyEmQIx+nmXMB8Jp+OTk3fRPXJCPB1TYbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qdf5Pmc2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbedb1ee3e4so10623700276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705597049; x=1706201849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmZn+BROv+sMREBkau20U4T/TQEgObsLAqinfuULAyg=;
        b=Qdf5Pmc2E9Lqn0tozQlEd+MJF6I8HkxjgbELP5HQzYJyByJIDwRerqRpDZKSjbi1Xm
         7NRpa7rRO87l/DR9gFXw7S/V+yhmiaCTUzlIzZC7h5rANmLgDIepigio3gUWYvVj/j/g
         uyr1KO5cMnMINt8PaB0/m/mneKHYI/YkEgKox+b6CeEz8h6KWtHz2QFAeWy6vKIQoyFg
         dNnyC9KEpUJ2N25XRyRTIifpgIZbD7mhLGdbrE5e88CGz2WABdg3hLi2THDiPSDbfL8q
         cgLdBqD/1kuMSEWyW60uR15aDeQHswAhqejXaOu4FcKYnhfumKNYs+hy8iXlHhcJd78Z
         HKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597049; x=1706201849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmZn+BROv+sMREBkau20U4T/TQEgObsLAqinfuULAyg=;
        b=BopI9EVR3OWF4S0iZVSthSTmYdEWPYI9EzvfMIHxQQ2mnQoM7uHfehyycKA4JQI+Iu
         rpuBJXJziujrXvAKqi9q8d3GEtCgQVSexjtBoqx790f2FdIPupVRA7K5mkVBOO0x0zHB
         ID0+rZ+lxZ3m/icW1uiafm/WLdFo8QF760tbz90ETX5QZMoF5KBgAImEZTeVGkudg4tw
         9x8RrAQJx70tofxjzYjF9qflwWHy1pvtq77pPy5khko/Q23tKG3CxrFo7XCDhM7j1/Zm
         SiTiXsmWYWSpfxagKVnj6oJ8lLF9eBRj6104tz6JMZ3hfOGoqRdY+ziAJ6PjzMlHnKk0
         RYcg==
X-Gm-Message-State: AOJu0Yzmqsptakc9l20sPzEXnP+dF1qEnvFiUyofaYx/aHL9Ja7IM06Q
	zY9OpjafAnSML7sZIfWEzmV7S2Ma7nC8mD2yS8QLR+9l0hnRT3PIc3PmKcRbTU3RVN1vhGb4W8L
	S+OlvnkNjuffx7XbWXgKytLBPZ7Tmumm4aKbB
X-Google-Smtp-Source: AGHT+IGdm+3tzpwneR3Std891dkepC+HcM/F/QU4NLlUSQFVDjEWUf46RxO8DdQGNQYUp4EkO2YYs2e+Vx5E/WIMRrc=
X-Received: by 2002:a25:748c:0:b0:dbd:7743:77cb with SMTP id
 p134-20020a25748c000000b00dbd774377cbmr856586ybc.128.1705597048380; Thu, 18
 Jan 2024 08:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117181141.286383-1-tjmercier@google.com> <20a68f86-27f0-48f4-a066-7dcf0092858e@amd.com>
 <Zak6iW8lktml7f2H@phenom.ffwll.local>
In-Reply-To: <Zak6iW8lktml7f2H@phenom.ffwll.local>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 18 Jan 2024 08:57:16 -0800
Message-ID: <CABdmKX10zz6bk4VVDgsosJbA8_7WOxuCnkyYFiL1FPwtZ-C+WQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Don't track CMA dma-buf pages under RssFile
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
	Laura Abbott <labbott@redhat.com>, android-mm@google.com, minchan@google.com, 
	John Stultz <john.stultz@linaro.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 6:49=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Thu, Jan 18, 2024 at 11:02:22AM +0100, Christian K=C3=B6nig wrote:
> > Am 17.01.24 um 19:11 schrieb T.J. Mercier:
> > > DMA buffers allocated from the CMA dma-buf heap get counted under
> > > RssFile for processes that map them and trigger page faults. In
> > > addition to the incorrect accounting reported to userspace, reclaim
> > > behavior was influenced by the MM_FILEPAGES counter until linux 6.8, =
but
> > > this memory is not reclaimable. [1] Change the CMA dma-buf heap to se=
t
> > > VM_PFNMAP on the VMA so MM does not poke at the memory managed by thi=
s
> > > dma-buf heap, and use vmf_insert_pfn to correct the RSS accounting.
> > >
> > > The system dma-buf heap does not suffer from this issue since
> > > remap_pfn_range is used during the mmap of the buffer, which also set=
s
> > > VM_PFNMAP on the VMA.
> >
> > Mhm, not an issue with this patch but Daniel wanted to add a check for
> > VM_PFNMAP to dma_buf_mmap() which would have noted this earlier.
> >
> > I don't fully remember the discussion but for some reason that was neve=
r
> > committed. We should probably try that again.
>
> Iirc the issue is that dma_mmap is not guaranteed to give you a VM_SPECIA=
L
> mapping, at least on absolutely all architectures. That's why I defacto
> dropped that idea, but it would indeed be really great if we could
> resurrect it.

I actually had it in my head that it was a BUG_ON check for VM_PFNMAP
in dma_buf_mmap and it was merged, so I was surprised to discover that
it wasn't set for these CMA buffers.

> Maybe for x86 only? Or x86+armv8, I'm honestly not sure anymore which
> exact cases ended up with a VM_NORMAL mapping ... Would need a pile of
> digging.

Looking back at the patch, the CI email at the end of the thread lists
a bunch of now-broken links to DMESG-WARN test failures I assume
pointed at a large chunk of them.

https://lore.kernel.org/all/166919750173.15575.2864736980735346730@emeril.f=
reedesktop.org/

> >
> > > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/mm/vmscan.c?id=3Dfb46e22a9e3863e08aef8815df9f17d0f4b9aede
> > >
> > > Fixes: b61614ec318a ("dma-buf: heaps: Add CMA heap to dmabuf heaps")
> > > Signed-off-by: T.J. Mercier<tjmercier@google.com>
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks Christian.

