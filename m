Return-Path: <linux-kernel+bounces-85795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF386BAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E941F252BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746270053;
	Wed, 28 Feb 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Az+rB4Qq"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CB1361C4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160307; cv=none; b=cNX8Y1Nb6Za4g6oY4KZsaWJE0zAnf/SqfYeBVM/04j/LscDBudyw9bBDusfwNHOJGGNmcENQ7Wnj1azrGx95Jmij3MpB9AA7HMi7U+Og8kMIGtI6ggMqNoRFmNjPsBuy5onfTkexs93dda2w1wD/BGjQAncXWqrH28S3MUC/G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160307; c=relaxed/simple;
	bh=Cbo16Kdpdj/Sou5J9lkN1s8YVlAEB7JmVmpKJ1D3TMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UY3wBhWn6qYMucesJhddxN2sPM3lkx4SD/xYoPdQ12HnV8X8UMHQJarLtc4NtNSiLuQaXzOXTR4JInuoKyT1h91HvwXJJfcc6ngGzLLT0f2UwjlMAI1CWuuG1anXvBp2r53JQXVgxezPRBYlfjLRyQ75N/9KCivK/YFzofpDOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Az+rB4Qq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d484a58f6so45372366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709160302; x=1709765102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaIW3mETQDzZhGMK3PRFUOCtdSx2PTiCbd1xUJLaJyo=;
        b=Az+rB4QqOJcSbdh04nioxXjyjpYoQtz1UnRg0ZGmOM2XWugR0YwX+LFXTEzycCDwtD
         eLmx6y6M0gVRlgxb1hXSLJ/y2XdVkxw2snvH+qfUwl1XzXBnde8gqY7dFFogmTK95Qam
         1lqMhYWpIeBgPp8h0nM0eFlY4nI6s4ExmylLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160302; x=1709765102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaIW3mETQDzZhGMK3PRFUOCtdSx2PTiCbd1xUJLaJyo=;
        b=Oi0FKcaiqgSFuwoYDZhbeNYmXJKIQwrPfI0fAZffeGfg+fwgtJTljCPjWeVZkV2KAd
         ZdSsQOBzIMENYAs+kvuowxVBVupEWTT21h9kyY0Q7t4odRQiIhuHmFN2rnwi4cXBFp/M
         mSx8UiKkaB2tLxzdQ5AmHA6Fx+4lXiJod9oiip6jSo6kjp5XR1lap+npV1ePAP9f48Xm
         58auSPF3cFPavGnHgQNx14ImKKwsC1wtbzrl3h7toKFYvTWcgenkN15Zp9oZ6FZc3G9H
         ahyDB5cXvet9Vy3k41OuIGX+Kv9+rZE6Zc1OBzUBHo32YGr8wkKWUq0qbWvlwheRoCra
         RkaA==
X-Forwarded-Encrypted: i=1; AJvYcCViJJQ86v9v3XiJ87hch8VPODck+5dXl9+zP/iyrqq9wSjRSRz/Jz5+Hh187gGyTr4p4rDyEq+N1tK+eo9cT834YA+p2jCs3cmE4E8M
X-Gm-Message-State: AOJu0YzlxQFaK8HtLmMTC91QA1fJgfLWDVOyVOpTcD4U8plkPy+1+3vX
	0FMpH/TlmapbId2koD/6lmtBdA0vq/8MIWAVT7IpDUX8oJP3s+un9b+Om47yxAtV1okW6vB+YlA
	TJ2wT
X-Google-Smtp-Source: AGHT+IE/dysKzShwSrdTOevROS6nU6UXBkMkselPY7Z4kkKOiACKSQb4/YRYZJatQ2XlcH0QGscQqw==
X-Received: by 2002:a17:906:1307:b0:a43:3879:35e0 with SMTP id w7-20020a170906130700b00a43387935e0mr177809ejb.11.1709160302231;
        Wed, 28 Feb 2024 14:45:02 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id i25-20020a1709063c5900b00a3f596aaf9dsm2315023ejg.26.2024.02.28.14.45.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:45:01 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4129a748420so29245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeFq0reSER0EMean7cnSWu792JC3gGjDZFAgOsbZttHOllXf0VzlXWHTmfIAAYWn18Ur3dAOHT3x4tNKMPchXsoyyRie4zv8F9/Ech
X-Received: by 2002:a05:600c:4e16:b0:412:b66f:3d0a with SMTP id
 b22-20020a05600c4e1600b00412b66f3d0amr20561wmq.6.1709160300349; Wed, 28 Feb
 2024 14:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228072216.95130-1-yaoma@linux.alibaba.com> <20240228072216.95130-3-yaoma@linux.alibaba.com>
In-Reply-To: <20240228072216.95130-3-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 14:44:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
Message-ID: <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
Subject: Re: [PATCHv11 2/4] genirq: Provide a snapshot mechanism for interrupt statistics
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: tglx@linutronix.de, liusong@linux.alibaba.com, akpm@linux-foundation.org, 
	pmladek@suse.com, kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	jan.kiszka@siemens.com, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Bitao Hu <yaoma@linux.alibaba.com>=
 wrote:
>
> The soft lockup detector lacks a mechanism to identify interrupt storms
> as root cause of a lockup. To enable this the detector needs a
> mechanism to snapshot the interrupt count statistics on a CPU when the
> detector observes a potential lockup scenario and compare that against
> the interrupt count when it warns about the lockup later on. The number
> of interrupts in that period give a hint whether the lockup might be
> caused by an interrupt storm.
>
> Instead of having extra storage in the lockup detector and accessing
> the internals of the interrupt descriptor directly, convert the per CPU
> irq_desc::kstat_irq member to a data structure which contains the
> counter plus a snapshot member and provide interfaces to take a
> snapshot of all interrupts on the current CPU and to retrieve the delta
> of a specific interrupt later on.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> Reviewed-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  arch/mips/dec/setup.c                |  2 +-
>  arch/parisc/kernel/smp.c             |  2 +-
>  arch/powerpc/kvm/book3s_hv_rm_xics.c |  2 +-
>  include/linux/irqdesc.h              | 14 ++++++++++--
>  include/linux/kernel_stat.h          |  3 +++
>  kernel/irq/internals.h               |  2 +-
>  kernel/irq/irqdesc.c                 | 34 ++++++++++++++++++++++------
>  kernel/irq/proc.c                    |  5 ++--
>  scripts/gdb/linux/interrupts.py      |  6 ++---
>  9 files changed, 51 insertions(+), 19 deletions(-)

I won't insist on it, but I continue to worry about memory
implications with large numbers of CPUs. With a 4-byte int, 8192 max
CPUs, and 100 IRQs the extra "ref" value takes up over 3MB of memory
(8192 * 4 bytes * 100).

Technically, you could add a new symbol like "config
NEED_IRQ_SNAPSHOTS". This wouldn't be a symbol selectable by the end
user but would automatically be selected by "config
SOFTLOCKUP_DETECTOR_INTR_STORM". If the config wasn't defined then the
struct wouldn't contain "ref" and the snapshot routines would just be
static inline stubs.

Maybe Thomas has an opinion about whether this is something to worry
about. Worst case it wouldn't be hard to do in a follow-up patch.

Everything else looks good to me. Given that I'm not insisting on
adding the extra CONFIG, I'm OK w/:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

