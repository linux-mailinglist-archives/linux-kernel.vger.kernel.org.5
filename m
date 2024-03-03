Return-Path: <linux-kernel+bounces-89896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3186F702
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE6B1C20AF5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E979DBE;
	Sun,  3 Mar 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnc8fUOw"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03F2AE90;
	Sun,  3 Mar 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709497297; cv=none; b=mtFAxJiKpZRGIpt0JUvhL0GXtZFRG55nMKevO+Y4hA1Pz6mZM8BhfYHVgkMKaGOKIGwztVbu35sdlCyMizoFc04KrHEIqyGCVamBo3X96UpRiPwmupGOisdYcZYMId2wvUaDUnWYoq8MzT/zP44skClexDnfuASRgZRdW7ZNjno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709497297; c=relaxed/simple;
	bh=Q35YAZglOxYGDpRSAGOwZwk3SdJ6ZQoJ/uPZMfRrgyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eedFUwbZCxBmt3Cph042/QbNkrMpM4qyTftt9pAr/lmXbnERDFrVtK5Y4e68VMuQUK2vwDszrh5Y9UuZ7rz1Kouvpd/c76uTaBDcZhHhePJMnAcL3ze8n7ssod2jbWAnW233T34DIayUEamxnHFSJPoJ5/I1xT8RYt+LBzEdyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnc8fUOw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2305589a2so55692851fa.1;
        Sun, 03 Mar 2024 12:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709497294; x=1710102094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7rADcp8cd3a5Ybe7Fit1F3MeRi+39WRSfwok0lZWxA=;
        b=Qnc8fUOwIh5TXmZWqH03PBSWVqpsWAsEWRZaay/TKHmgU/FWKSRmTJO09AStv9VlJn
         EKkdFP7s4gQ4OTGECRp+J/8uDPbKSGqVPs5dB08SWJOMIGZvhU5MRmiatxbQU5+De+33
         vPE4cPnEcIpOZeOV7plRW/cIlswm8nNg/83NY4h5ngYzwV5SvbBmMaaY9lOYmN7KQLcf
         pqSZUcR5cMyE5DP9Go3Y2R1z4JQygJJOgiu0BfGxX1uTmbgT+dKiO/TD4/gi+rlY1A44
         48BmzXo9FRPnlW9GmrucZJpN9h4DPGpvFM4lE9Lq3NlYY9HTpm4NeBsFtiFP453xb9LH
         AN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709497294; x=1710102094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7rADcp8cd3a5Ybe7Fit1F3MeRi+39WRSfwok0lZWxA=;
        b=QoTW/JHMFJ/ob1Z1UDlP2Yk44IlUg4iN18nGl7xJjudBOPdMKHZYuvMQAnyUyjrMjh
         Q4frvF0EE6fAyNJv+uU1V51KpSm8UEfgvjJOvwQ/YAcLlKjg24AhmFxOKgTN34HlcmXU
         JEQVV7H0asAR5aMQP08aFUVHtxPTvhw8SBQen9rvfEvUlDkPWbNZ1J6gb6wUp3bX86UL
         ZO5zlEfkMHxDwK7EdZaWxFt6CH4TCoHCwJ4cv4yWKgmnc6Zt/B08GzUJzueDsqYljcuM
         XQtrOEKpoDx9fV7kh89152D6sPR0g48pJhWdVzFJ65rg+48BJCgrnDacswrHbkfXCl9p
         kPWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVHdFtB8ACs/C4wucMVjok4r3icK1ZR7pDoBxcFfz2l9d/BigTIiC+AoppJ9rYqqv11bPzsC9OKHTLwRli3qFyta3dcMUGcQW3YX5gs6HT2hExYCRZ7MbwNopCKIOMIzBDm0Gc+I1woVD9
X-Gm-Message-State: AOJu0YxrdqygoMT+456ey9daHNfNPerLMST8mqq56RJc4DndxhGZC8+L
	g/9k5VvXNx/4ZXCrguaHvGjsEY/runRM3wz2hM0ZQPXjw+NBAahuIL2mpCgRDkGbbmkMTWF70YE
	UZw5kuJdoAWiuANr88kNLoUOKp/k=
X-Google-Smtp-Source: AGHT+IFxzrAqNk8fA92YYJpvZJNt/kHy1rRa4DBkd0uvc3IOknUgd6d0DvxW55b7IB8ZEWE4u9x76ucY5Uij8msbFv8=
X-Received: by 2002:a2e:92d0:0:b0:2d3:93dd:c54b with SMTP id
 k16-20020a2e92d0000000b002d393ddc54bmr1606888ljh.25.1709497293411; Sun, 03
 Mar 2024 12:21:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx> <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx> <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx>
In-Reply-To: <87bk7vuldh.ffs@tglx>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 3 Mar 2024 21:21:21 +0100
Message-ID: <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Sun, Mar 03 2024 at 20:03, Uros Bizjak wrote:
> > On Sun, Mar 3, 2024 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
de> wrote:
> >> I did not follow the __set_gs work closely, so I don't know whether Ur=
os
> >> ever tried to actually mark the per CPU variable __set_gs right away,
> >> which would obviously catch the above 'foo' nonsense.
> >
> > No, because [1]:
> >
> > "gcc does not provide a way to remove segment qualifiers, which is need=
ed
> > to use typeof() to create local instances of the per-cpu variable. For
> > this reason, do not use the segment qualifier for per-cpu variables, an=
d
> > do casting using the segment qualifier instead."
>
> Right. I just figured that out myself when playing with it in user
> space.
>
> That's so sad because it would provide us compiler based __percpu
> validation.

Unfortunately, the c compiler can't strip qualifiers, so typeof() is
of limited use also when const and volatile qualifiers are used.
Perhaps some extension could be introduced to c standard to provide an
unqualified type, e.g. typeof_unqual().

Uros.

> Right now this simply does not work and __verify_pcp_ptr(ptr) is not
> doing anything except when sparse looks at it.
>
> Sigh.
>
>         tglx
>

