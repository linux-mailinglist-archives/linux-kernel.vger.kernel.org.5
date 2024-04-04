Return-Path: <linux-kernel+bounces-132176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4D8990A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F58F1F23249
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F813C3D1;
	Thu,  4 Apr 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="csZBnmct"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949B82C63
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267908; cv=none; b=pe8OCZ93i+P+InB18ju63MwEaAJx7l0pcP4YKnvR3g/eTIy4dzidj3ZAPm6ikM/qFqfpwSlE12C8Zx2lrGSVB3YbDwI0uaAegii0ilqadvb0jqSxbrFcz88gnd04CsIRQUxVgtPi6x44+hXvbKr6AZZl3qahybqXgaZKZ6bPMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267908; c=relaxed/simple;
	bh=WBWlamtwS0qil/q1Kd5kZ2gzDyToW3Fk8jnydEwHJJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRxzg+amBa3B2IiFKP3tI3u68F8K8QY8cO5qa+1rc7NCedkVjvnoCK5mEXwuO2jGs3hxmeyqoBxcEAEWRz5lKTumeM7v9xfYNjoetOZ/qdr9xH3CabNC+ScuTxfJz130sKFkBFtGvLJAhbjFfwgPS8ECNc38gj7ezU78n/dnwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csZBnmct; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e3ffa8eccfso597592241.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712267906; x=1712872706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXA1Pawcw6q7MhE7VT/TIjcbej+/bkiKTDfv32P6Hrg=;
        b=csZBnmctfE2WxFuQMJb9Cmo3zeKEICav5r14l6XHXQIal4ze+re01Ue65whF/sKF7I
         NSl6Y0xu2jzxKttW4mEql/1KoIIm6z+uRzeMuijT4FShqtCLVhos1tZwpc92A+HiJOB8
         SkcgLlgBMbn+6ceuBc0MhRd90sjYjEdzSto/9XgXgsTu726rtcWjUY8qTF/nfhhDv5mR
         atQQEEzcumNUJLuXYbkJ6Lk/nc4DAgq7yC5z7v0jiigSEzFn2NJuE5qeUVtRoHpsaP2W
         I99RFRUBFFisd4KAWat7pzFwot3oBYQ30hEGIpPe/EjGx9xk6MKPkqiLDcbob+rOaV6k
         cPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712267906; x=1712872706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXA1Pawcw6q7MhE7VT/TIjcbej+/bkiKTDfv32P6Hrg=;
        b=eSNapnal9aKr9I8O3QxVK6HGAgKFJL5IX26UqE1G/2Bl7Da79/aIA4qUhU2BrwnvQi
         wx3I7CA0S2LCXrecc6QcCUJukB6OtvuWVlMFX0v+4mEaESBSoi69vKP3Jdjm1vcexwZz
         OWr2TWmz5nHJphE8n1K6KW7rtruL4wubKQ2VjaUbMm9WSYPJj8aUuch/TfwDvbor/ZAd
         UnlIqFiPr3SRbZCD0zqc9BjfPSCEDZsAFjcDgfGUIzs63aaL9J3Pomzs9nu1rdVBGC8i
         0aiKP3gzQ/fP460Oy2ac+ES/8uh1xurWn5MvrU9N/hZIlxFtPa/mG+fjOIwiqAJMlZum
         EfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfTYMQvjOJryGXvszNwNHbeqwyLpdkX9pNAQ57t7gjSBMugVicTpRoozKgyzqy19h1B1JtCUvTW1O2Lfqcj1+A9pj+ApxYKnCx42Vb
X-Gm-Message-State: AOJu0YxRkcUeWubs894I77NYiv/W61dzUKDNMQGOyAeprY87YKm7lu4T
	nH9jBaK6chx21k+LJuMbmJRvniOcihbM6E6Nec9hunxX4MTqh/ptkkSKgfR1cju6EXRFXaassyg
	XMzLzC5ronrovG9AnQ4gwm6DZnheUTk+yYcn+6HgkdKR9pdtfOZEw
X-Google-Smtp-Source: AGHT+IHcGcVynOrCwd5GKEjNJxBR+DIwyhJJZMcY9Ci43m9rDIAmEzoFo7afNlAdZFC8NZt3fpMFw0EFs9yKchDPiG4=
X-Received: by 2002:a67:ad04:0:b0:478:763c:1869 with SMTP id
 t4-20020a67ad04000000b00478763c1869mr749494vsl.7.1712267905791; Thu, 04 Apr
 2024 14:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <20240404162515.527802-2-fvdl@google.com>
 <20240404131734.5fdd7380202cafcdc44a4d2a@linux-foundation.org>
In-Reply-To: <20240404131734.5fdd7380202cafcdc44a4d2a@linux-foundation.org>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 14:58:14 -0700
Message-ID: <CAPTztWZ4GCPX7d1KqnBjtfi-kzcjnWibn6Ohj+=p47vBHep=SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:17=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Thu,  4 Apr 2024 16:25:15 +0000 Frank van der Linden <fvdl@google.com>=
 wrote:
>
> > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > cma_declare_contiguous_nid (the alignment, computed using the
> > page order, is correctly passed in).
> >
> > This causes a bit in the cma allocation bitmap to always represent
> > a 4k page, making the bitmaps potentially very large, and slower.
> >
> > So, correctly pass in the order instead.
>
> Ditto.  Should we backport this?   Can we somewhat quantify "potentially =
very",
> and understand under what circumstances this might occur?

It would create bitmaps that would be pretty big. E.g. for a 4k page
size on x86, hugetlb_cma=3D64G would mean a bitmap size of (64G / 4k) /
8 =3D=3D 2M. With HUGETLB_PAGE_ORDER as order_per_bit, as intended, this
would be (64G / 2M) / 8 =3D=3D 4k. So, that's quite a difference :)

Also, this restricted the hugetlb_cma area to ((PAGE_SIZE <<
MAX_PAGE_ORDER) * 8) * PAGE_SIZE (e.g. 128G on x86) , since
bitmap_alloc uses normal page allocation, and is thus restricted by
MAX_PAGE_ORDER. Specifying anything about that would fail the CMA
initialization.

- Frank

