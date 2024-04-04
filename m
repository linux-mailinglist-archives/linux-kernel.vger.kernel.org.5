Return-Path: <linux-kernel+bounces-132112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F11898FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E341C22D22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD813A265;
	Thu,  4 Apr 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="slPncXJr"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D27172F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263554; cv=none; b=A04q5j6vpgSfEqi/Q1u7CdiszmvrpFKGLp5wXubcI5Pea21Ya7rqwH2AlYBnCfNDo8tuOOmITHyZkS/2OJwfnP0fQfjEFJdiS2D1lmBgLxNrVAKLSymJ4GX7KiIonSYTQYSBUkYLzwIslDTLthozF/wE1RhlX4kvtqMRNVBaLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263554; c=relaxed/simple;
	bh=jJ4lt84nlriIBigN6u6Q0toWYdo1Bp3mHPQgfFYLzxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYcn4rEVTkpNJwMGR693hhaDwBm4iEghwNhsNVg5VojqGVwDMv7ScsYfxBodL9cv9Tm2k/AX53sv1sV1zu7XQaAsYfKF9nVh1jfW7LsRRiFYxG0UyqxnV03ihwf7PI/tlR5+Ib9dt2HbSuZAAb/3TbLxlOEYTnPWfuCyPV+RTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slPncXJr; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e389d74dcaso795277241.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712263552; x=1712868352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUZ0p+Ue/75jmeZXFOqw4kseULn4epKX5Ah0EefA2h8=;
        b=slPncXJr+JjvcRgWnWCugZ0HZ19Mf3xtlVneFcd/uRebrvGEk4/e9lFe3flreZL8Da
         t2PTnPhuVSocVJJjcnD3Zzk2wWBQ+K65tlhDXHP9NYwEQZ2fEJZB2WMH/+xQLUcHFd0P
         RxW03CTYRckFp1PnWOS4PfHXVoL+Uxt5nW58Yp/SryKmeciIVQI6R7AW9G1D+nCcqH5m
         QCJeKy4bc8r1TEyJ2g1DdSOBMl8LS0xO9o3+2OljevuTT7xL87pmw8wo23a7X4YzBQEO
         aIEDZbsqcIcdCkk69Y/iHcRpy2PWITyskIhO6LsVZTr0AjZEWZclgRU9akPfcNKnWtuI
         vP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263552; x=1712868352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUZ0p+Ue/75jmeZXFOqw4kseULn4epKX5Ah0EefA2h8=;
        b=QsFhpioDr9nGD6GYpOCbyFNOHshL785yuT0x/30UAwAdw+9XmV+G+/b9OvUSBG/BNb
         xCyz3fS4/1SEhdIWzxrhoYLD/RndqQGLeMj2bsb+DjDUWjpkhFdSo1aHAL6sL3OBH4J3
         BbYtpZKpymXOxhDE2zgORVpXuumQZ6/zWVndRVYd3x3WIdKZxpP/0ZIhX5DoSgA322PD
         z3j7QIp4UVPb0e+PgUE73xz6zrYajz/a4NtECGJOV1eTPKrqE+AF3UX+IkOQMQDil/4d
         P8NcfP2xBwxpVofvY+SK1bDHZO5Hex6WQZpd8YINM6SkYoz5QfF70mKYAyODIhzFzCQ+
         NDUw==
X-Forwarded-Encrypted: i=1; AJvYcCXIUkLZqHlclLph1iVgRS9yujl0OTGowgaZfghyWo6nPx3X+k/zQe/uuDVTaNPxO7bSwc99R+qmvlCKcb6oUeiXy/euF8wG/wXbtvK+
X-Gm-Message-State: AOJu0YyiFp9FDF0RTnqoX0W8PA+Z6J/4RhjeWdMCXyNXkdJF4ULWSh9I
	Ip+iPkB6dudh51BQXS+KQZ/GbAZOQSTVNLiqw106zxzsipYVHxjFr1TxNnkpPWaw3V/ZMOtu+qc
	SG2JfmEUGRU3r5+6NGxS9T+FhLIXvHuNKHmGm
X-Google-Smtp-Source: AGHT+IH6JnAs6pKBFGMucdu4CQhH7Bd8YoRbdeWrlbylG2132MRem+dx1xoV5aG16vKG9qaoCthjPHZ5bo2LhEsXSxw=
X-Received: by 2002:a05:6102:1897:b0:478:4d51:82ec with SMTP id
 ji23-20020a056102189700b004784d5182ecmr709470vsb.4.1712263551722; Thu, 04 Apr
 2024 13:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <20240404131549.27a454072f7e96530dce2d62@linux-foundation.org>
In-Reply-To: <20240404131549.27a454072f7e96530dce2d62@linux-foundation.org>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 13:45:40 -0700
Message-ID: <CAPTztWaXXuP3uiJDBHEZR-WDrs8pzOBC0v7Mb5fz3sbK+zweEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: drop incorrect alignment check in cma_init_reserved_mem
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:15=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Thu,  4 Apr 2024 16:25:14 +0000 Frank van der Linden <fvdl@google.com>=
 wrote:
>
> > cma_init_reserved_mem uses IS_ALIGNED to check if the size
> > represented by one bit in the cma allocation bitmask is
> > aligned with CMA_MIN_ALIGNMENT_BYTES (pageblock size).
> >
> > However, this is too strict, as this will fail if
> > order_per_bit > pageblock_order, which is a valid configuration.
> >
> > We could check IS_ALIGNED both ways, but since both numbers are
> > powers of two, no check is needed at all.
>
> What are the userspace visible effects of this bug?

None that I know of. This bug was exposed because I made the hugetlb
code correctly pass the right order_per_bit argument (see the
accompanying hugetlb cma fix), which then tripped this check when I
backported it to an older kernel, passing an order of 30 (1G hugetlb
page) as order_per_bit. This actually won't happen for 6.9-rc, since
the (intended) order_per_bit was reduced to HUGETLB_PAGE_ORDER because
of hugetlb page demotion.

So, no user visible effects. However, if the other fix is going to be
backported, this one is a prereq.

- Frank

