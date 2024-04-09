Return-Path: <linux-kernel+bounces-136886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7989D963
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C1A28995C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62012D772;
	Tue,  9 Apr 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+HTgcql"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95A12D744
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667034; cv=none; b=GM/eoMvTnVmPtPCAXkU/XoQkjYkqITEurXKoe6mFcE58m6WY8JmiHr8tgZcIvIRj51WB8x07EdxdT736mUM5GBbmoXRlyPw9SZzJeexoC8QjwFO9b/Fm6oUD+jSHC47ueF2lWYkXFOFWzzd7HObr8r1IuyvXfEZqXj2Ydt75OzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667034; c=relaxed/simple;
	bh=kkrJls9AZ6P6TC/PK3zxI8CWQsctApJC6bIKDV6tTHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQxN/nFPOTxFE6Pqiv8JDwUYBTfV0z7Mbwqk22LQt0daPdIpsGNMKBhsrUxeI8jSV1DE8QkPYszuBUq6E2y0aRJwL/FR5zyRyiJZfOYzG8z9l2tIuACiPFb4KptiWLqtBkQRPWvlxtl1o51rpXUcESZplEjEIXLUqw93Q6EXizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+HTgcql; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d715638540so66532101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712667031; x=1713271831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/TqT7biLre9+WjLuYwGEFT96KO4NUZqoOC5JGcGMdE=;
        b=V+HTgcqlCxzsDhMtzZIAN69mABY8VCmlO3i9n+uvvYLjvpRRSpR4lQ3LORFd83+5iM
         BqUsmU8wHR+52RcZqHcjU7wPToaeWzGEFU8nXx9Hkowx3AEKCg85iFligjrV+zJQBN+Q
         9ZOZ4XrsUH+ywfOQ/9xfGRB9iVhd2QzkHPhmu07Rh3S3MIPB5XJSE08gyJvftV4WGEkr
         LfHJqGXHGwRTtJxMjFMOoecCAP4+FrHlO3PdjWj1y4c+pQbiJvKkvpdHjiQ+sX1XhPvI
         pIweJWruStNSJgjjj3PefzXTB8idHQmrUon/fCheNvC81l3hQY/iEwbVAZwQ26GovgzT
         BXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667031; x=1713271831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/TqT7biLre9+WjLuYwGEFT96KO4NUZqoOC5JGcGMdE=;
        b=vp2nItd5RfRNQYdN/ppsDhrK2CjZGiU87dGzafJFHyxxiNJRKRgCTbYcv+UIVgUoiS
         ONZHG9AN8ICJYjXYIQT0Nbm9VOgqRmySw+ZzTDt7c3j/MpHA2mbe6Isqh//XUEIN8GwS
         2HnAdeGb9RNFD4KB3Kc9pi1Kf/LbuQdoZ/OPMbvDnJCO2GG5je/cWA3RZLoFcuJ/44YG
         SGSNhIsxXKJyNim0p/EtlUL3RuQMK+qhIYLxJuYCHAtHqUhZKpP9wBisc0RayZL4xxX0
         0n+iF4Oqlr0fThXhQs3Fz7UJzsO4FLFUpM92QGOrUamn8fCGeXuOEgflJkt/6PUy9fbd
         +5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Uhaa89gsJWTXF3TWN4h4ueUxbATqt0BIzG3VzoCRgxsGG2Dl5B/fQ3TvrGtuL0E5DS21avyQBAQR/7bRqAgIVQkncIwTcXeNRsCD
X-Gm-Message-State: AOJu0Yw7yeYAK9xyZQVAY/7B6V4yCVMedYBBGTltuxv95Roa1Hl3XCP/
	aymmUESvC+sSP1foYaAYO9A5sGiDhbaQxuSC1yqZWrmTifm9jKv2Uk02cn7Lyi9oxMyuZzjI/Fk
	J/15mhFADY9SzhI75AXmt3nkULU8=
X-Google-Smtp-Source: AGHT+IFnHPHGhhtmBWFzgQa45pnjSJu9pSpTY4EwgrmLyruVQ4LHSmn3LYuKCy/4jrXeS3HGxC41DkRNRE9zOvMFHsU=
X-Received: by 2002:a2e:878d:0:b0:2d7:7c0:b077 with SMTP id
 n13-20020a2e878d000000b002d707c0b077mr7681756lji.43.1712667031256; Tue, 09
 Apr 2024 05:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100503.274629-1-ubizjak@gmail.com> <20240409100503.274629-3-ubizjak@gmail.com>
 <ZhUixk5I_n53dbBb@FVFF77S0Q05N> <CAFULd4bBmQ85UsPOOEA+5dj-_JOBNWeyM-jipM7Zov2V484quQ@mail.gmail.com>
In-Reply-To: <CAFULd4bBmQ85UsPOOEA+5dj-_JOBNWeyM-jipM7Zov2V484quQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 9 Apr 2024 14:50:19 +0200
Message-ID: <CAFULd4Z8JTc_5p8apO680es0fYO5ke9yYPpPUfp=15XrRbKESQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
To: Mark Rutland <mark.rutland@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:03=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Tue, Apr 9, 2024 at 1:13=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
>
> > >  static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
> > >  {
> > > -     s64 old, c =3D 0;
> > > +     s64 val =3D __READ_ONCE(v->counter);
> >
> > I reckon it's worth placing this in a helper with a big comment, e.g.
> >
> > static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
> > {
> >         /*
> >          * TODO: explain that this might be torn, but it occurs *once*,=
 and can
> >          * safely be consumed by atomic64_try_cmpxchg().
> >          *
> >          * TODO: point to the existing commentary regarding why we use
> >          * __READ_ONCE() for KASAN reasons.
> >          */
> >         return __READ_ONCE(v->counter);
> > }
> >
> > ... and then use that in each of the instances below.
> >
> > That way the subtlety is clearly documented, and it'd more clearly alig=
n with
> > the x86_64 verions.
>
> This is an excellent idea. The separate definitions needs to be placed
> in atomic64_32.h and atomic_64_64.h (due to use of atomic64_t
> typedef), but it will allow the same unification of functions between
> x64_32 and x64_64 as the approach with __READ_ONCE().

Something like this:

--cut here--
/*
 * This function is intended to preload the value from atomic64_t
 * location in a non-atomic way. The read might be torn, but can
 * safely be consumed by the compare-and-swap loop.
 */
static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
{
    /*
     * See the comment in arch_atomic_read() on why we use
     * __READ_ONCE() instead of READ_ONCE_NOCHECK() here.
     */
    return __READ_ONCE(v->counter);
}
--cut here--

Thanks,
Uros.

