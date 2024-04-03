Return-Path: <linux-kernel+bounces-129465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A847F896B30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356172813C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6E1350D7;
	Wed,  3 Apr 2024 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WFwtZqb0"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21689134CEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138241; cv=none; b=BDjq5QPFB5KSfxvVlHaRjouP3JGZBe/EdiP0de2GvAmSbDsZ6QgZcoHOR3WrYd/kJLh3orJ5eseRHl4215aCA7Wyy7c4xAgDc8AWguh3ra/4aXi94sus7X5plNsJegVCxXNvunY9OL+SWRSBSTvmSw+e2F36EQPj9ekBOH26SXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138241; c=relaxed/simple;
	bh=hsY8vdvALd9mllqZJPG0q6gvzkR5NuFBfzXk8bK0SSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCNAi5sT6HKjo8lQG3MX+4ljYfbeCRHDIyDnN8A8ZGKu8zJQwJU+VEwT01jysb6r3E0cGSjOXL7fyG+88Gb6Ec1yV0aT/WiF1geWyQObcHK03PP+5HXf8Vnc4G52MPUbDHEia5GC+P7l4S1tg/ApsbrhXIQwl4CEdh3VWAPemdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WFwtZqb0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d48f03a8bbso6895711fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712138238; x=1712743038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/Iap6Ckpc7gnYDeHu4z6nTWkkkUTqEUIw+VC+egTdI=;
        b=WFwtZqb0IOikx8EUZ6anrClSWUTprcMuexkOmIKwkwH6T4HFaTcuC1hdbzI2//j6VD
         Yb9J6aAi4i0CVYRsDmWnG16saR00SvXL5d5UsFoeL/WSTREiIF0WdCgvjUaaJyUrScPr
         NQWfyMMflmWLrLtt+OGgoKTsXbZ2wYwM8GMJse1TeFHvkSCa3nalVFbvmfoKfnP0OSWZ
         /ZtJCT838ISWDT6aK9BUvuUNQzywdq5pcz+p871E+Ehnc8O4y1xA0H5VVVyOps72GzM7
         vNK76vBg/104oC+VlwY/iYOXp0hAV0TiOndLBIClM8uQ/c3yPPewCbXp/qdGXEHDO9kK
         gq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712138238; x=1712743038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/Iap6Ckpc7gnYDeHu4z6nTWkkkUTqEUIw+VC+egTdI=;
        b=MFQOfqNZaS7Pvy5rDxxiPu6eVfEAzgWG1n7FZoXqaxxGsJ1XaqLyiRdJw+4zxedVft
         /ONorOdkSme60fG4JvEtYTqUySxMqTJj+Paqzmsb0QFP8c1vZzEl04XJT/eKLBvvSVFK
         tBZm6xuB9zDJkUPpElFMzsl/O5pCRYp7CI1QkDQ1QI75Vtzhex29cfOaV/x/7KrP3sCj
         FCz0qqCCKhVTsKfFtZ1pyGafOM4FS4MRMeH1byB7BqYk86VQnB4pPkp3xKLMzdzB8DUq
         M1JMmGJaTcHhyhzLfFuJpXMAAlOARODmhutE+oaChUwqUbBFlgVuPUkb+eYXBOM48XZ9
         jYiA==
X-Forwarded-Encrypted: i=1; AJvYcCX7em95NQnY7UitPPdLT9dW7+fTNqGJOGiB0GJhSCKkuMyv+K2R1pihrdrtRi+QB843pPddc274mb5qDgEEPB2+OzmLgD1MuzL2F9k7
X-Gm-Message-State: AOJu0YwFpWn52+7wSYXEKMEbpxHoYrnMFhBRAExsla4tIZAuwiW7aMh0
	KyrFjRsggdY4GK4NkLJ3oXHqe67KuwucU+p2ecCfLCXK4vwdda2aJuyOLSslV2xKcMVLzdhO9Vh
	jrabKLB/onfoHvGgXOTaOlm/F0elCd1drruvhEA==
X-Google-Smtp-Source: AGHT+IGN419LcaWsNIQm0EXU4px3i4LNqOSzT+9stPHxFmHNZq8t1sxU4/AHC2Q7Tdn0p2VU0n1Z13oPGMJ1EP4VEEM=
X-Received: by 2002:a05:651c:1a2b:b0:2d6:e110:700f with SMTP id
 by43-20020a05651c1a2b00b002d6e110700fmr932725ljb.11.1712138238422; Wed, 03
 Apr 2024 02:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
 <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
 <347bb21e-98db-4bd5-9ca1-550eac5be9f8@app.fastmail.com> <277decf7-d9cb-451c-a105-6ecc998f9f46@intel.com>
In-Reply-To: <277decf7-d9cb-451c-a105-6ecc998f9f46@intel.com>
From: Anton Protopopov <aspsk@isovalent.com>
Date: Wed, 3 Apr 2024 11:57:07 +0200
Message-ID: <CAPyNcWeXpidnVsXgt4XpwXiA0CRFdZYFN9O2ys5oq9FQKXNxsw@mail.gmail.com>
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed:
 "struct bpf_fib_lookup size check"
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:39=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 03 Apr 2024 10:45:36 +0200
>
> > On Wed, Apr 3, 2024, at 10:10, Anton Protopopov wrote:
> >> On Wed, Apr 3, 2024 at 10:03=E2=80=AFAM Naresh Kamboju
> >> <naresh.kamboju@linaro.org> wrote:
> >>>
> >>> The arm footbridge_defconfig failed with gcc-13 and gcc-8 on Linux ne=
xt
> >>> starting from next-20240328..next-20240402.
> >>>
> >>> arm:
> >>>   build:
> >>>     * gcc-8-footbridge_defconfig - Failed
> >>>     * gcc-13-footbridge_defconfig - Failed
> >>>
> >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>
> >>> In file included from include/linux/bitfield.h:10,
> >>>                  from arch/arm/include/asm/ptrace.h:13,
> >>>                  from arch/arm/include/asm/processor.h:14,
> >>>                  from include/linux/prefetch.h:15,
> >>>                  from arch/arm/include/asm/atomic.h:12,
> >>>                  from include/linux/atomic.h:7,
> >>>                  from net/core/filter.c:20:
> >>> include/linux/build_bug.h:78:41: error: static assertion failed:
> >>> "struct bpf_fib_lookup size check"
> >>>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, =
msg)
> >>>       |                                         ^~~~~~~~~~~~~~
> >>
> >> Thanks, I will take a look today
>
> Naresh,
>
> Could you please remove that static_assert() and dump bpf_bif_lookup
> layout from pahole?
>
> Anton unionized { smac, dmac } with __u32 mark. On x86_64, the offset of
> smac was 52 (aligned to 4) already, so I don't really get what AEABI
> does here. IIRC it aligns every structure to 8 bytes?
>
> Maybe we could just add __attribute__((__packed__))
> __attribute__((__aligned__(4))) to that anonymous union at the end.

Yeah, I am sending a patch for this right now. Better not to depend on
compiler options

