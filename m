Return-Path: <linux-kernel+bounces-126981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C982489455D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F861282624
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B753360;
	Mon,  1 Apr 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEHstHkj"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28722085
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998998; cv=none; b=Sbji1jfXyo2nOPp1zjIb5uxQGQmLM69+9tUPlot1//nLTQeUKh8sX79XjwJjb0dPTztRreQ+soNPRlOg3STtJLdotrtaJbMTuydYInBLyyoSBEbxgZEbwIfa5NRWuvcnDnjmnaDJq6OJfFH7ESbocn40U5BgPPMW2S67GL9bngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998998; c=relaxed/simple;
	bh=9pMieTTkPWnYtRGFkviKwd4jv9x+3p1quFvqV3OiFwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExO5O2a3D41MSiAoD/7nzFIyK/Lbl0lCzpU18lrXy6jmRyT53Is4yKYSygj2q9/CBsHxyo9hWnA2DBMl0WbPnIozVwR0ehaOU3x1Uv7cbbFeyYEJZPm9MpGwcMt4oe7DAH7b38m0nkRQ/b9WdAoXcEDDUjkEQff80QTI7c/UrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEHstHkj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8129797fcso21080061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711998994; x=1712603794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz0QiZpspRBS5EUOeHUbK1fITlBlwg1jf5tqS0VXPfQ=;
        b=aEHstHkjpL8f1xKi/D/UeF142sypf7j4j/xQxy3FRsgBt3HBufd1fGS3AgzcAwqkMJ
         2+T9dvgpB2yIfht3bVXbkbbdUylJQNMhK+S9k+oGSYJT1beGnbV6sKrECChldLvr4Nrs
         331UibXk0lkGb5xYFeHcHm9hnPwGRMY4seVWXWsODS9xb0BAVZk9BD9dB+o+tfDFgBcm
         PWWCGlZ1vCgdirAy+7gz9WnWeq3u8DInUac/ePHW3DUezyQPxWd8FTjT7R9Xnuq1ahVF
         PzyuZPoPwCAab0qZKfHGhP+XYd+ysLFIRfacWXupjNt2g5W6E28TGBaCMzi97348lhlC
         dk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998994; x=1712603794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz0QiZpspRBS5EUOeHUbK1fITlBlwg1jf5tqS0VXPfQ=;
        b=qMo/z6i2sVNlr1lSv9CAFPbUg6dGHR0i7Ir3xt+ck3qQ+m/EYAPMmjiQNs4iWrlU3H
         Fg4Y1sVuWJKumloAB4x+5wKlMTr+vDojJs9hHOTWP+OkAopqNY1WwQJd4qrWO5cETHtL
         YDBX37YPV/REneKwbq0si3kHf2ipveIb76RpsaZcCMASVFoqcytTOzGWfwKzzwc00xQg
         pBd0MRnxPaE7zS9nG9z4QPRR4fVgqyK3TfL/jCaRvIcaLkAVRb8Tiy09Nt8AHNXDGq/V
         WaFFhp7LJ4SG3Ez3KYFVPKeZ6hx0sgew/B/KHWnShSf73Qbs7Lf4bxVripVAonfE8t58
         3+qA==
X-Forwarded-Encrypted: i=1; AJvYcCXdpqCQjgwM8OLlkwaxjQbsRbI2UQ42zL87tFBHkgsVGUi9HMJoKBkmbthpPH+poQbVdsmnnDHe45lMzJNfDjetwl1i0l2Vrlc1dVmb
X-Gm-Message-State: AOJu0YzNPMX1UfizKBdqEUW3at4VDto84yb0r3fVldSKChZw1g515N6G
	1iwh2TZ5F0hYx48GHvZKfeZRIQK1GF07jEHbp8gBaKtnh3yn1cWShcc0O5nyIo5yCGKse1Oep8F
	hPQJ31Iundq2rduE7zamWwZDvGd8=
X-Google-Smtp-Source: AGHT+IHv6R6x0n4MI1BkfY1Hb3c4VR5U5LCIKjv68E/eMeLLX0d22DS5/LpuypyPX9B8KNhSLKtfWV3LBeYVu+YBKqk=
X-Received: by 2002:a2e:8895:0:b0:2d6:c672:b301 with SMTP id
 k21-20020a2e8895000000b002d6c672b301mr5470866lji.50.1711998994375; Mon, 01
 Apr 2024 12:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
In-Reply-To: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 1 Apr 2024 21:16:22 +0200
Message-ID: <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 12:57=E2=80=AFAM Charlemagne Lasse
<charlemagnelasse@gmail.com> wrote:
>
> After switching to linux 6.9-rc1, I get a lot of these errors (when
> compiling with cgcc/sparse):
>
> ./include/linux/netdevice.h:4033:17: warning: cast removes address
> space '__percpu' of expression
>
> This is around code which wasn't changed and which correctly uses the
> per cpu helper. Sparse flags were -Wsparse-all for sparse 0.6.4
> (latest release). Sparse was enabled via C=3D1 parameter and sparse was
> configured using CHECK=3D"sparse -Wsparse-all"
>
> Problem was introduced between commit 8ae292c66dcb ("x86/lib: Address
> kernel-doc warnings") and 3a1d3829e193 ("x86/percpu: Avoid sparse
> warning with cast to named address space").
>
> I would even go as far as saying that 1ca3683cc6d2 ("x86/percpu:
> Enable named address spaces with known compiler version") together
> with 3a1d3829e193 ("x86/percpu: Avoid sparse warning with cast to
> named address space") triggered this problem

Are you sure this is the offending commit?

The complexity of x86 low-level code forced the whole x86 percpu
rewrite to be designed and written in such a way that it can be
disabled in a single place. So, using the attached patch will switch
x86 percpu functionality back to the previous implementation - and I
get the same warnings from the old implementation as when new named
address spaces are enabled:

security/selinux/netif.c: note: in included file:
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression
/include/linux/netdevice.h:4041:17: warning: cast removes address
space '__percpu' of expression

4037 static inline void __dev_put(struct net_device *dev)
4038 {
4039         if (dev) {
4040 #ifdef CONFIG_PCPU_DEV_REFCNT
4041                 this_cpu_dec(*dev->pcpu_refcnt);
4042 #else
4043                 refcount_dec(&dev->dev_refcnt);
4044 #endif
4045         }
4046 }

Uros.

