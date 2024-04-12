Return-Path: <linux-kernel+bounces-142757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B08A2FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8044E1C23E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9948A7FBB4;
	Fri, 12 Apr 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="0/bxQFHY"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946284A3B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929587; cv=none; b=tFdLXMVRJu64c1B2/ShCXNM4z+Qq/8SRDJljxVf75Zk0X2hjggqM7D+z8yUR12i3jM94d/ryUpjmLSGRWOkUxg+oFBVqw/r6oWT5fdsf0NlTjXUlIEDAOk9yQaQ1iULpA0DhrB7oTd9pIMATBxivnE+5H1jVgR1fWe92L9Ke2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929587; c=relaxed/simple;
	bh=7RSPEOIscnMm7dOTuji3aseUcvWIzTKOuJAMdoMNZCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcHgBHRfhUoonnK/jAyO2ELSEyRc2G2eYJNWOVqBVDt9SwAviklNtWIkQXsuCxQ2VMj8ulhGiOG0g2P8qAu8jYD1uO73VOoLsywsiqH9UBm2QsdJ0CbK++C17uvPxGBZS6tNoKoL6xJYI/2vlTQ51M1NGhuc73bK/0bxoSVS2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/bxQFHY; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so897098276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712929585; x=1713534385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD684C+IDzwSheJ1UHZ4hhLjZ76bWs/LZUDmR9GhUFE=;
        b=0/bxQFHY0tBNwP/YP2bzxzi1DBbbAeKUo/4iyQQZRPFiVQewY1KxIs/FwTMqD0mOT/
         eVXsNg1aEk4Iq+9+51Yj5N4tB+t0/PrKDNO2wtT+Bg32s/1v9zZrQlmDW1bspiCA9p2G
         Y80Y5Roi0zFX9TSNEioPVN4kSvqQ+aZACeREjiYrB3kwzPgMhffd2JeU3rx9SMytqKxY
         UxecYajfEqCY85puLxqRxZG/isx1ix4T5TDzt7/wf0Ma5d6GWxpbOM1RVZWWf2FABCua
         SYPwbdeDsUBeh4vCJVe73SeD0WXGy/rl7cAya8Md9NyKvea0/h+VtDQmdYVagzikDzWV
         d7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929585; x=1713534385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD684C+IDzwSheJ1UHZ4hhLjZ76bWs/LZUDmR9GhUFE=;
        b=xB+w3Bka84QcmCfuKKGqxpx0nSgpPzTuaLDngTr2iZXzrr0/VvLDD7s/ysGidzZpoR
         /NefMQgUd9aFpCc40sAXO9FaV1d4X7D9XU/QFVMGT1o0Hy2yjzsQ47TerIPcG9uc3E05
         M93eN9uF3CDHS0ycfi5faUseAhyYvFgSB54J3HPq04PcFBchDfi2MbDXsiklHksKu+4r
         z/DboQk6L/MDsMHWhMi9rwZYUuj1PcSW9RVDLKAt7GAXhWDXycbwsTFDvWfcAXLph8r3
         AQ9wXOzyYRqBD9xMHl/yVcTWHxBjq3YLC+qp0FhFgefGJYpEIVPCV61RzIqsxQnputqU
         IEdA==
X-Forwarded-Encrypted: i=1; AJvYcCX4CGj9Ifo0xLCj28/KL3fQw36ZMitfousVsHnWCqH0P+s4vMGSjrvou4aCKJ+nkM9xj/AXM7ErS5jDIvcIgOiTmTRofie6HMzzlxCC
X-Gm-Message-State: AOJu0YxdMv6i0fCQTDwAGGPh7GEI7NHWKNhgKUqlbWrXT/sZVXnBsC+w
	JN763g7/PeD2XUk75GuRkGG5EORJRU0NBColOXHX8TS/5eUxdVdsm8YJUcdd1yMuCeYxXLyqO3v
	0BzUrkCW3iEThJb/O6xZjnRUwFefZcczvP4rz
X-Google-Smtp-Source: AGHT+IEXBU3je4IuLBZr910CrfHyCWhugWPhZGKp18yXylpp2KIKtknN6Tvqq4rBkKN+CNeH7B4DeFc2KjMhtI+32PQ=
X-Received: by 2002:a05:6902:181:b0:dc6:ff32:aaea with SMTP id
 t1-20020a056902018100b00dc6ff32aaeamr2734459ybh.24.1712929585246; Fri, 12 Apr
 2024 06:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170621.2011171-1-peterx@redhat.com> <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n> <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org> <CAJuCfpHpewmiyMxyPd_A8KSyQ6tB-1wHLV-FJ7KBrpV=RY9F7w@mail.gmail.com>
 <Zhk4AKtGd-5_yK_3@casper.infradead.org>
In-Reply-To: <Zhk4AKtGd-5_yK_3@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Apr 2024 06:46:14 -0700
Message-ID: <CAJuCfpFYOrJQqyAw4wKgBS-X2iLh2+h9Hyc6mawYV+RPD8eDSA@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 6:32=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 12, 2024 at 05:46:52AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Apr 11, 2024 at 8:14=E2=80=AFPM Matthew Wilcox <willy@infradead=
org> wrote:
> > About the code, I'll take a closer look once I'm back from vacation
> > this weekend but I think you will also have to modify
> > do_anonymous_page() to use vmf_anon_prepare() instead of
> > anon_vma_prepare().
>
> Ah yes.  Also do_huge_pmd_anonymous_page().  And we should do this:
>
> +++ b/mm/rmap.c
> @@ -182,8 +182,6 @@ static void anon_vma_chain_link(struct vm_area_struct=
 *vma,
>   * for the new allocation. At the same time, we do not want
>   * to do any locking for the common case of already having
>   * an anon_vma.
> - *
> - * This must be called with the mmap_lock held for reading.
>   */
>  int __anon_vma_prepare(struct vm_area_struct *vma)
>  {
> @@ -191,6 +189,7 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
>         struct anon_vma *anon_vma, *allocated;
>         struct anon_vma_chain *avc;
>
> +       mmap_assert_locked(mm);
>         might_sleep();
>
>         avc =3D anon_vma_chain_alloc(GFP_KERNEL);
>

Yes.

> > > We could even eagerly initialise vma->anon_vma for anon vmas.  I don'=
t
> > > know why we don't do that.
> >
> > You found the answer to that question a long time ago and IIRC it was
> > because in many cases we end up not needing to set vma->anon_vma at
> > all. So, this is an optimization to try avoiding extra operations
> > whenever we can. I'll try to find your comment on this.
>
> I thought that was file VMAs that I found the answer to that question?

I'll try to find that discussion once I get back to my workstation this wee=
kend.

