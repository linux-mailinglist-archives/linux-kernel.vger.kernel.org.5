Return-Path: <linux-kernel+bounces-136833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294A89D8CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37401C2132C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285812B176;
	Tue,  9 Apr 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU3cqb3N"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782486651
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664237; cv=none; b=Zu2aXvFT+gddzXQcwpVV0vkAn3bDkCnQBehtvrUSLsvWIDmgZY2tVLXvFVBclxygIVLf1X8DekOm9R6n6cv0BUd6uBgE4bpEdjKTPJH0NlRi7HvFkXEwacc8975eU4mgQX6rvd/aR6tC1mWL5nQZf9DexYscjM6fvRKGkyiT2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664237; c=relaxed/simple;
	bh=GrDawK9B0IciTy7FWKqIbYXHR4sDP+8uNllB3M6fIxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6QJAdC4NOXnkP6cMrWVLR2/j/4KEwJTtktayLUwHzryKXUU/KTBF0cvkWmXj7wuKs+U0gVTHQy3y7bRydNM7FFfpEH18KtIXHhHaYUJUwTWDhYqJ3nmcRmaYyVlCWb/z7bk+wKTRV2+WwOXipneNnTsjRnYi9CLwqChtfIcSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU3cqb3N; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d718ee7344so63939411fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712664233; x=1713269033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF2job4/C9B1St24aO713B9KmDVXokaRVhMy4cDlD1o=;
        b=jU3cqb3NO3RrJWSLeQJHmSsauQcv8epd+4Mc9fKA14qpW+DaGZQCmPxhwEq4YG+aSc
         RJWK6Cii/rwh7CMvghxOcW3oxgIamoh0TeIuGnIBD5Q8AlaOorcy4c42sUbUJWurSMGR
         OMx3+n9ltwXfZZlvHsI/95IdL5WouSRDeZbAaj2aXC4W7bAYSNZDN9aQeHqyJBnmQtka
         yyqPOFHzQqoagXGU1nTs6iWAFyc5+g76GsvrFjv/gbJOK12GQpIGgxz6HgUDgodER8kJ
         NLuIah+ytP8KVSDN0reYh1L5bdVEk0NcXudrlrCQSwdNKR2GxhBiO+r7BP5w2nUH2pIY
         Osdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664233; x=1713269033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF2job4/C9B1St24aO713B9KmDVXokaRVhMy4cDlD1o=;
        b=q5N7SHdrLfB/HWi9+3KWDlWO3Vth4o6YxKxcBeCqAiBPhqmnaHo3CES6s4H+AsD2Ib
         9/hGkjsbcJg2Dty5+sfXOtC1Hu+6TXt9dYPPFOy9kBVLA4//XHSA1CFCr3wfy3DVuu4R
         lvj4dFQlha4gs5fSKq40D1Ux6lGxrXYsqEj5NAvOntFr0a585WJVGOLN4G1W8YllqoUV
         FwPHjhYzelE2hQeM2WxPEO5pIFhF5SUDUH71CpCUcOfMWs4v3AyXZlLGMqq4j+rw7LYn
         TKrJbJOIIb5rCvFXGY15sAaZfAC0x8l7T719OXDti3uYgqRBxvkI73xt21BzM4l282Ec
         vt+A==
X-Forwarded-Encrypted: i=1; AJvYcCVx5GDRWAzlm/KxSFG8+uKNxSvc42Mebg6yJGlJl6f8cSTrnE8ka36utAnLrkPjNC8rC2hWHPD9YiJB9iUHMZKbRY+7eg/lv5ga6jn5
X-Gm-Message-State: AOJu0YxCX2gVxbn3jUVVURVBdOI1ygMfHecyJfQdWKnJCRuJTsBLx4xF
	vgtNUKJ8D4LWXWI5rzVZs0wCZ95y35nN3tUhXFL+EzYUP/BbZqI6K2h9r+loLLt2rIVwkZqSlWc
	Agh6ZX9tLDwl2ZBsi3FbDfMCGVHM=
X-Google-Smtp-Source: AGHT+IHh9Keq7de9rRaU3EGoXhkV9bdB/C0+EoZSceMO+toKNxeuaArYa3cxqNmEfc/m0ESERNHRNlSpUlyc6GKBBH8=
X-Received: by 2002:a2e:9107:0:b0:2d7:b78:4109 with SMTP id
 m7-20020a2e9107000000b002d70b784109mr7911834ljg.53.1712664233278; Tue, 09 Apr
 2024 05:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100503.274629-1-ubizjak@gmail.com> <20240409100503.274629-3-ubizjak@gmail.com>
 <ZhUixk5I_n53dbBb@FVFF77S0Q05N>
In-Reply-To: <ZhUixk5I_n53dbBb@FVFF77S0Q05N>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 9 Apr 2024 14:03:42 +0200
Message-ID: <CAFULd4bBmQ85UsPOOEA+5dj-_JOBNWeyM-jipM7Zov2V484quQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
To: Mark Rutland <mark.rutland@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:13=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:

> >  static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
> >  {
> > -     s64 old, c =3D 0;
> > +     s64 val =3D __READ_ONCE(v->counter);
>
> I reckon it's worth placing this in a helper with a big comment, e.g.
>
> static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
> {
>         /*
>          * TODO: explain that this might be torn, but it occurs *once*, a=
nd can
>          * safely be consumed by atomic64_try_cmpxchg().
>          *
>          * TODO: point to the existing commentary regarding why we use
>          * __READ_ONCE() for KASAN reasons.
>          */
>         return __READ_ONCE(v->counter);
> }
>
> ... and then use that in each of the instances below.
>
> That way the subtlety is clearly documented, and it'd more clearly align =
with
> the x86_64 verions.

This is an excellent idea. The separate definitions needs to be placed
in atomic64_32.h and atomic_64_64.h (due to use of atomic64_t
typedef), but it will allow the same unification of functions between
x64_32 and x64_64 as the approach with __READ_ONCE().

Thanks,
Uros.

