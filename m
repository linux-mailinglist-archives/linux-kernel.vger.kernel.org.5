Return-Path: <linux-kernel+bounces-137366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6789E132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03657B2628F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623715382A;
	Tue,  9 Apr 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MaLvLzRw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A715380F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682466; cv=none; b=YmUgtz9Jh91FtSzl5Sj8FjYchz7+cnt1OZDiv6EbnudKtQzAh3xn5ZTLIxYACd5H0BN0kJu3GyrSPRPqGCkhvY19K7fbkyo37Tat6BWbyCpS6uFbvVReXggK7NKhhHkpTjtohmtluB0Eyuqsh+E9Yq3lgu9Hoixf0JpzdvX7Sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682466; c=relaxed/simple;
	bh=ue+OGUqfOmLNbIUTamEItS+snMKGV7KZJW+7KVOECcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqUtA+8Z0YyCCs2eYlbvw/a4iOR804bZa9BNxc6cbXlHD1G4EEf+I/hPub91EQE1dPwQd09iWyUPm4rHGH12O+VpeVO9Bu2krt3zigummyaXcWMqqoGqDOcZHo+hrQicLz+pKcLcds9CMG/iM+ndMrAAKG8JSndXrAL/bss9tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaLvLzRw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so4245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712682463; x=1713287263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsBq0cy8GlGyTLsFzDWh0JUEGzZ8zL8Mw/WsALeBfxM=;
        b=MaLvLzRwsNqMtgMawlV7zeMp+juP7zR9WXy0Jm4OWZTfvbgp4XI2/j8yKW7i8hECJK
         fbCeB+D+wqStiwLFxOW/qtdPZ2ZPI/zMlq9pRPOhWytAWIfWPSoiz4RIqmVqMVHy8AmD
         N+kTiPixd+GouoRy5LQF5Dx1LcsWJ+iayHPQgCa1hUgi5bni+d+ARNAaXXefq0MFfDsA
         s2zhA2S8Zf1QexcsIeXmMNHvGy1J1/dM62U0wKWvGZrTdyxibGz4EzOQ6NthPz+5zhRq
         T/4KjLWMYcro1FZ82b9Wrm2xV3RU4QBWaYZCrStiZiuA0UIdk5cKFAFjSGv1N2BbQ4X5
         J/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712682463; x=1713287263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsBq0cy8GlGyTLsFzDWh0JUEGzZ8zL8Mw/WsALeBfxM=;
        b=YCQZuAmd0HvNbB4g+uhbjIHt8EXSXYRcuAf1BPulR7DRDqrjIHonQjwv0imNU1XhHi
         Nt+WL366EmnWeKV2LrFYvk07enoZ/0OatPM9DYVEeiPhIPsjGnPWykz2MCwRjkjn5Xhi
         GNY/F9Oyifm+REcn+zY0W46emsU5nM5o8ySSZD1y1rtbFO4Cuak7frJxRkA17duq55AA
         edzo6zIBpQGS05DWk7yV6LmkgwYUCfyp/aKQ9OMv6kdPaF56CAodTbTSvZ2sWzRnbK7g
         HM/T9bBUz8xUUjNFQ0q2Jv48Ej2PSjgMAaa2FkV/jiH2oonMvtVXNyRBATtPFilOuq6a
         tmUA==
X-Forwarded-Encrypted: i=1; AJvYcCWTzTgKQoIoiUmrNeJHrlXA+mERg2nYHHAyL9CDdicRQkKr6ayi3GAjU+VKhbNzot/svnZXRb7mN2P85V6HA2URAqTBlIB06v7aqSIv
X-Gm-Message-State: AOJu0YxVjGYrrF3p5Wx1m65ka0l1QqckBcTgK3/6vUj2znwP63Dd5Jz7
	iy9tY6nBt/s8QG8zwxPukOmj/NAqUTUHI8Y6ohcNOYqp4VLPOVtKJ7tTa3kOG9hupqmGLKyJLXk
	g4YjwjEvBMxsdIhZL+Eo1HVBUddKe1M5+3e0=
X-Google-Smtp-Source: AGHT+IEEpJwqd6S7g8HTA9AUAVkouCdLTgaK8Qrafsc/GrNIeR6yWteoZFEb2wHAnEnwAyAcW7FiUqeH8KOEXFfmP5c=
X-Received: by 2002:a05:600c:1987:b0:416:57f5:b426 with SMTP id
 t7-20020a05600c198700b0041657f5b426mr184824wmq.1.1712682462632; Tue, 09 Apr
 2024 10:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409062639.3393-1-adrian.hunter@intel.com>
In-Reply-To: <20240409062639.3393-1-adrian.hunter@intel.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 9 Apr 2024 10:07:30 -0700
Message-ID: <CANDhNCqx14CU9TwwkWqgUY9ucgaQZ8DwNmG+m==XrOziSfOS0Q@mail.gmail.com>
Subject: Re: [PATCH] vdso: Fix powerpc build U64_MAX undeclared error
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Stephen Boyd <sboyd@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:27=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> U64_MAX is not in include/vdso/limits.h, although that isn't noticed on x=
86
> because x86 includes include/linux/limits.h indirectly. However powerpc
> is more selective, resulting in the following build error:
>
>   In file included from <command-line>:
>   lib/vdso/gettimeofday.c: In function 'vdso_calc_ns':
>   lib/vdso/gettimeofday.c:11:33: error: 'U64_MAX' undeclared
>      11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
>         |                                 ^~~~~~~
>
> Use ULLONG_MAX instead which will work just as well and is in
> include/vdso/limits.h.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240409124905.6816db37@canb.auug.org=
au/
> Fixes: c8e3a8b6f2e6 ("vdso: Consolidate vdso_calc_delta()")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: John Stultz <jstultz@google.com>

