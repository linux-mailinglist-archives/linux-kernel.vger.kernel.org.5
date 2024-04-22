Return-Path: <linux-kernel+bounces-153959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16138AD551
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564FB2819FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC21155384;
	Mon, 22 Apr 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6gi85V2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA307155335
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815840; cv=none; b=u/YnosZThH17bhTj0CX81xRMdUmqohFDZyu9QagJ8x4U/Gia3Nu89ytx6FjK/XrYi1fRU7TFJVcuDgMtCc4j/uonJ1r7C48GeGQKXwMw7z2PzaPdnh50Y4CDpT1M67YGQNq84I1uW/x4P9FhxL554hIOwcoehlczFpa+qe6+/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815840; c=relaxed/simple;
	bh=PKVHfqHJ27bSwUKMRBAbit7T+O5dPyann/zHf+lfiDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAwC4UcGDDRMvZOE6MlWPqQtz+dTZkdqEV2WfcI/JD4B1R7oOgtx+neOjQMLxqeqmVAG1MkmcHYtVbz0p27PRRsF4t3T4ZhjcE8R/Ul3W1CX2B5Tu2NCtrm8NOY5ShIcec3rKrL8ORmveQxFmvIGuc4xtJPXPErIAaTOQvz9v1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6gi85V2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db13ca0363so76116061fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713815837; x=1714420637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUZCvgfKswXHZZfz34CDi4hoPT+ow62zr2X4ddEH2SI=;
        b=U6gi85V2gFUzUL3RjzAJUK7fkx/dzkuL57KR3SlUoS2fdj+CZfofCvHlAkoeNLdn1S
         T3qdv+2LFHyREDNfUZI/73KXz4yIg3QNARvke5WNzslrKgF3EdlAiPZ/4OkrNqzOl9VN
         l+IpXEBm2weDuBVhdn/yKcjogOzQJhF7rbneZsNF0b5jA3G/30CICPAXP/Y8qM4TDvRl
         gXIF57H6RIThih8tseHVgWFOCosIlNycR62ShGAs+9MSVKKG0/6aXNcV+j7xhHi0OeD4
         mbkzfduiSrWCIipyeLelQiLcxz0kWK6t1qUNteYN1Qxz3BpsaX6bcR3WofvTrzshsPgQ
         lx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815837; x=1714420637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUZCvgfKswXHZZfz34CDi4hoPT+ow62zr2X4ddEH2SI=;
        b=QZDv55jg6TIclCM4kTyUl6Lmcw8RLRHgigULT20T2W/b+UmZSjRJCnVLMlqCdNmfV/
         cMaiOZHUZe0iMw9ItRYRtOmRgJ0868ghD7erQGmR50FOeRW9iLhA0C0z2HkDjOGZRAsi
         IB4xS+U7cWknsn4aMHT3pWKg8/LiCilPNUhIvak4Qx67ThyTGX4xgmWOgEQeDa0aPpWL
         xsWybW/8/QDyA7K4rjy+TwFa9+xJFX7j/vr3YvNv8jKCtNKzklpF7nl2eS7Co1/+mEu0
         8dGOMNzmLtV0NANLC7DPHm0oZi5fAzi716J0p4PuI/K6oHnctsSpMCqfDyUfIDr7Lj0C
         VyKg==
X-Forwarded-Encrypted: i=1; AJvYcCU8pXn6jav8sV83CL14I+3JOVya/3ygbg0EQANXnJsbf1y9s5mEXZoupPQLbS5WSQl/8xtIRNTpqYDkm7IIziunC43mahhsTgMY4gsw
X-Gm-Message-State: AOJu0YwtF95J2Elo6E5Uout0iM+o6XKeoBFKkBMfg/pFFeuDfJHgpXNM
	4oZgoLBXbPUo5Rxb4efURcmf/80d8oWw7ggJyTUenDcZJM8XOOlPdB7DvG5/Wy6J6fbtO+EmAt3
	KXVH1hjNTe4k10IpSsY1Cb+QBXPc=
X-Google-Smtp-Source: AGHT+IHlAzbUrjE9o+f3VNAPUK//VnKIFcgd3dscEqsAFtPF4Ox+2jXrTQSybveOSkZw1DYlLql/uOQ4XdeZK1elnwM=
X-Received: by 2002:a05:651c:1046:b0:2d8:6ca7:2165 with SMTP id
 x6-20020a05651c104600b002d86ca72165mr8702112ljm.46.1713815836561; Mon, 22 Apr
 2024 12:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422151752.53997-1-ubizjak@gmail.com> <Zia-VeObR-m6Bf39@boqun-archlinux>
In-Reply-To: <Zia-VeObR-m6Bf39@boqun-archlinux>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 22 Apr 2024 21:57:04 +0200
Message-ID: <CAFULd4ZhTAY9irw8V=MLZpjQK+q0AM_Aw8g2E=ivHjv7+5m9Zg@mail.gmail.com>
Subject: Re: [PATCH] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in
 PV_UNLOCK_ASM macro
To: Boqun Feng <boqun.feng@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:45=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:

> > diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/inclu=
de/asm/qspinlock_paravirt.h
> > index 466af57b8ed6..0a985784be9b 100644
> > --- a/arch/x86/include/asm/qspinlock_paravirt.h
> > +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> > @@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_s=
lowpath, ".spinlock.text");
> >  #define PV_UNLOCK_ASM                                                 =
       \
> >       FRAME_BEGIN                                                     \
> >       "push  %rdx\n\t"                                                \
> > -     "mov   $0x1,%eax\n\t"                                           \
> > +     "mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"                \
> >       "xor   %edx,%edx\n\t"                                           \
> >       LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"                            \
> >       "jne   .slowpath\n\t"                                           \
>
> There is also a "cmp $0x1,%al" afterwards.

Not anymore. Please note that the patch is against -tip, where we have:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D91=
095666125a666c8f20c2323b742c53165c0325

Thanks,
Uros.

