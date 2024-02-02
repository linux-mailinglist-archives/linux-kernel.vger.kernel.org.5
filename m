Return-Path: <linux-kernel+bounces-49150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629184668D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CCE1C26111
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0809D313;
	Fri,  2 Feb 2024 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLXf0gDh"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26505C8C3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844644; cv=none; b=JNVzckXodm+OttQl7UpFv1QSNnKRplsUNpuPtLYaPsq4Cx+Dm5S9EZaIRLl4mUOyzPL89CV6bn1/q6UTE0Ndu2kHpEK3pqVPeRJmKw53BkN5yH/wJO/PrcYkjMCAec+RrhcUdZfqkGa35k03DCRQX32pNMLXX9FpWiXHiithU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844644; c=relaxed/simple;
	bh=EmKjmDmXRKrnBxWdzwix5j1O1b1nVwMXkAT/mk3vi8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7hEyevsGl3HDc5WbGtllETpQpfaNXpEP1jTyVXSqTKe7UVKVQETM2cIPCB25IyUaS71s3Rv04NagJo4GSRpxd+qDeg64whydZVwzK5qXMyLUdKGvMEe04Z6lq7cW6jDxPTNOqg3iSa1gePrkTIzm9k0zieJodTIkpSVKx/KTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BLXf0gDh; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2184133da88so924646fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 19:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706844641; x=1707449441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDdYwb6bms529iTi0p0xaIF4DMRKf1eH479RkB5tVc0=;
        b=BLXf0gDhlqX9CQNr1kZBBPk/qOrFd1ie1yZdE/gDvKCIoYg4Z2ZEmW2M3skB/VFAVI
         FQ+eJf1E5khc761ns7yKe0S4bNLloXYqXShf0h+WEybB7uIM7KpXDHs+hqTxFW+LYCoj
         HzdKnS0Cz0WwpRUkLFm1VZpDP0yImt2kRj/BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844641; x=1707449441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDdYwb6bms529iTi0p0xaIF4DMRKf1eH479RkB5tVc0=;
        b=IvyLxloKg3tOHj/+tTTN9sL8zc/pYoxl2RiEcDMEF9iQ658l8qaCbRY4z15iS2/GiC
         llCi9lJ0hPjQaPQkskt+icGn9tUj4yU/GlXmQgw9BO91F2GIJkdoINxr7dy0QexwD/YO
         Dnkx9lq+Gpeyyy2crQytAbf3HYxwuichRrRtlQGKJyqk4yULkL932wF7vNueM9dD3mqA
         VPqV5yIqb6y+GzeAv3KRAbGmfiMokI3fa+cA+IrC8VRa4Jx5xLpEt2RPtI+VlzoYSEWA
         U7BtWtQFzizUIWk7W5CWgTq09ZxEMhPk7vTYYctjuxiyw6MZ+68p/rqcMA0exz7r7KMQ
         j+sg==
X-Gm-Message-State: AOJu0YzQ2MC9Loy4wr7YqFnUzanrtukqAmV77UnVcT/Ie2NfixkNXSZ1
	l3mSib9pC4E0A+rBR9qh57cis+uvd4nUng+QDgR/oPipXeFOvO2jXg5j8R3zwa9Lo7htegzUtOU
	s1sdji+RlVDi96ozOp+8UNeLHr9KYNTAwpa0Z
X-Google-Smtp-Source: AGHT+IF/r05G9r4pqnUYufTxyrklaLY34VPoujkR9dH8bcGKq2ZHmLdBhM1/R7dkd0o8lqJL0U36sbeOMj+cQAyiOs0=
X-Received: by 2002:a05:6871:7584:b0:219:2219:29d7 with SMTP id
 nz4-20020a056871758400b00219221929d7mr203072oac.48.1706844641233; Thu, 01 Feb
 2024 19:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org>
 <20240201231151.GA41472@sol.localdomain>
In-Reply-To: <20240201231151.GA41472@sol.localdomain>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 19:30:29 -0800
Message-ID: <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
To: Eric Biggers <ebiggers@kernel.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wrote:
> > [PATCH v8 2/4] mseal: add mseal syscall
> [...]
> > +/*
> > + * The PROT_SEAL defines memory sealing in the prot argument of mmap()=
.
> > + */
> > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > +
> >  /* 0x01 - 0x03 are defined in linux/mman.h */
> >  #define MAP_TYPE     0x0f            /* Mask for type of mapping */
> >  #define MAP_FIXED    0x10            /* Interpret addr exactly */
> > @@ -33,6 +38,9 @@
> >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, memory cou=
ld be
> >                                        * uninitialized */
> >
> > +/* map is sealable */
> > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
>
> IMO this patch is misleading, as it claims to just be adding a new syscal=
l, but
> it actually adds three new UAPIs, only one of which is the new syscall.  =
The
> other two new UAPIs are new flags to the mmap syscall.
>
The description does include all three. I could update the patch title.

> Based on recent discussions, it seems the usefulness of the new mmap flag=
s has
> not yet been established.  Note also that there are only a limited number=
 of
> mmap flags remaining, so we should be careful about allocating them.
>
> Therefore, why not start by just adding the mseal syscall, without the ne=
w mmap
> flags alongside it?
>
> I'll also note that the existing PROT_* flags seem to be conventionally u=
sed for
> the CPU page protections, as opposed to kernel-specific properties of the=
 VMA
> object.  As such, PROT_SEAL feels a bit out of place anyway.  If it's add=
ed at
> all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure this asp=
ect has
> been properly discussed yet, seeing as the patchset is presented as just =
adding
> sys_mseal().  Some reviewers may not have noticed or considered the new f=
lags.
>
MAP_ flags is more used for type of mapping, such as MAP_FIXED_NOREPLACE.

The PROT_SEAL might make more sense because sealing the protection bit
is the main functionality of the sealing at this moment.

Thanks
-Jeff




> - Eric

