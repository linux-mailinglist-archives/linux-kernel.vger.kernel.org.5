Return-Path: <linux-kernel+bounces-37818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F113683B603
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7FD285E22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D48197;
	Thu, 25 Jan 2024 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gs3U4u9k"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B87F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142005; cv=none; b=u6YokRX6UZ9buzGL+JH1P+WuM8NH4V6vMXzOr5LuX4GwaZ5B4PmRfrriZcqyms/1uua9PM/HJt++sArW7CJykOgl74IPNWyBkyrlcrAvz4j0wSw4IxKIQtpuz8LPdvdpdA5na2Atq6UlFTFRKn38GdJeF2t46O9BIdtHylbr1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142005; c=relaxed/simple;
	bh=c9/nJK5laW+kfjfBhk73NaQ/i8Xr3ZqLouB+V5e3UBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCgjRXAkRacdKbOkOCLClFIYK/Po5f5Jk9y2Mg/F7R49mM2BiglBqMmnXL670GYFo0S+9skRzo269d3RYvMcgL9WyovD5+yr6rehPlJRbIvN3PjoKHvQEXkw9SuB1Kb9UGJb5hfzcilu72dBo7shT6j2OB1/thliroKsJI8bT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gs3U4u9k; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7214539a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706142001; x=1706746801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9dFLTZ3N0TriBrErDmuqcfdECmElEFTmjFDKN9D9u0=;
        b=Gs3U4u9kK5HhbAU7Mmge2B5kBUcx/Z2tHo16rUrK4nXfANn/Ew0CeimBnDMezyS0i6
         R1eAf7sLQEEv3PX7ynjwbGxO9hJ6hIKSgfWWRx2Ogcb5tctVqUynGkgTn8nd/0cZ5gpC
         C/rZw9AfKfAvsIKLXPU0ENPKzLa32KHxefTvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142001; x=1706746801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9dFLTZ3N0TriBrErDmuqcfdECmElEFTmjFDKN9D9u0=;
        b=nqDL5nojCiqjDe7qG7JekPzOj+pbzuwkehMlkCYNUQeyifhGknq+dz24+voFvHVN03
         ZE0wp6LV8ZjltX70Sg1WgQM0DQA4+lNTPqdzCfig++bfHAYG52Aj6TDlMMc2ADcJq3TG
         ORMahQ/B38mLpyZc5yEzY7/wY2RZZLbIFQL4zmF7+rK9ypsFZd2vb0aNCJTdgqbxoEhj
         jArcAcuuGXT5HcxyKDtoxSQNHaR4KCT7fE+isqa6amJPsVor6v984LZZtJ8iCbV2aSGJ
         fUh/DFDqDB7sszGpGt5C6Edb+S3qwwR2p0tbsh+bXL8qJmqhlmDT3FS9bfAtLsZNZvOI
         auZA==
X-Gm-Message-State: AOJu0Yw9TW5n+O9KgnZOm/Ff856wblzK8FLwa3gG8iCEsU8O5PeW1QAD
	Gk+B2w3OCE5EH9LtfcJ5FweFAt0G/fhCJgQPqR2f1qOtnGZlA/9FR0PevQ4+62fztOuVsjyS1tL
	WIA==
X-Google-Smtp-Source: AGHT+IEUWprvVmVuSYtzFA49UxYfcrGUXDqAiBMNCkst20+BVIen1Cj6IcGG2Wfj827fT1oPfDVf+A==
X-Received: by 2002:a17:906:6b8f:b0:a30:3a34:57ac with SMTP id l15-20020a1709066b8f00b00a303a3457acmr50932ejr.123.1706142001116;
        Wed, 24 Jan 2024 16:20:01 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709064e9100b00a2a1bbda0a6sm414795eju.175.2024.01.24.16.20.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 16:20:00 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40eb95cbe52so8155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:20:00 -0800 (PST)
X-Received: by 2002:a05:600c:4f08:b0:40e:b21d:6c0c with SMTP id
 l8-20020a05600c4f0800b0040eb21d6c0cmr72157wmq.2.1706141999967; Wed, 24 Jan
 2024 16:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123121223.22318-1-yaoma@linux.alibaba.com> <20240123121223.22318-3-yaoma@linux.alibaba.com>
In-Reply-To: <20240123121223.22318-3-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Jan 2024 16:19:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X_uLqi1W7JuSjo=WXF5JEvtM=wxbSeFQQ2KhVcW9=Fcw@mail.gmail.com>
Message-ID: <CAD=FV=X_uLqi1W7JuSjo=WXF5JEvtM=wxbSeFQQ2KhVcW9=Fcw@mail.gmail.com>
Subject: Re: [PATCH 2/3] watchdog/softlockup: report the most time-consuming hardirq
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de, 
	maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 23, 2024 at 4:12=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> =
wrote:
>
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> top three most time-consuming hardirq can be quite useful for
> further troubleshooting.
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by using the time-consuming information
> of hardirq.
>
> [   67.714044] watchdog: BUG: soft lockup - CPU#9 stuck for 28s! [swapper=
/9:0]
> [   67.714548] CPU#9 Utilization every 4s during lockup:
> [   67.714549]  #1: 0.0% system,        0.0% softirq,   95.0% hardirq,  0=
0% idle
> [   67.714551]  #2: 0.0% system,        0.0% softirq,   90.0% hardirq,  0=
0% idle
> [   67.714553]  #3: 0.0% system,        0.0% softirq,   90.0% hardirq,  0=
0% idle
> [   67.714555]  #4: 0.0% system,        0.0% softirq,   95.0% hardirq,  0=
0% idle
> [   67.714556]  #5: 0.0% system,        0.0% softirq,   90.0% hardirq,  0=
0% idle
> [   67.714570] CPU#9 Detect HardIRQ Time exceeds 50% since 45s. Most time=
-consuming HardIRQs:
> [   67.714571]  #1: 99.9% irq#7(IPI)
> [   67.714575]  #2: 0.0% irq#10(arch_timer)
> [   67.714578]  #3: 0.0% irq#2(IPI)
> ...
> [   67.714654] Call trace:
> [   67.714656]  __do_softirq+0xa8/0x364
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  include/linux/irq.h     |   9 ++
>  include/linux/irqdesc.h |   2 +
>  kernel/irq/irqdesc.c    |   9 +-
>  kernel/watchdog.c       | 186 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 205 insertions(+), 1 deletion(-)

Just like on patch #1, I'd overall like to say that I'm very excited
about this patch and think it'll help track down a lot of issues, so
please continue moving forward with it!

That being said, my gut says that this can be a lot simpler / lower
overhead if we just use the existing IRQ counts that the framework is
already keeping track of for us. We could look for the IRQs that had
the most counts on the soft locked CPU over the period of time.

It might not be quite as good/accurate compared to what you have here
but it seems like it would be "good enough". Normally when there's an
IRQ storm that's so bad that it's causing a softlockup then each IRQ
isn't actually that slow but they're going off nonstop. It would catch
that case perfectly.

I guess maybe (?) the case it wouldn't catch so well would be if you
had a loop that looked like:

* CPU from "storming" device takes ~10 ms and finishes.
* After the "storming" device finishes, we somehow manage to service a
whole pile of normal interrupts from non-storming devices.
* After the non-storming interrupts finished, then we went back to
servicing the slow storming interrupt.

I haven't dug into the bowels of the Linux IRQ handling well enough to
know if that would be possible. However, even if it was possible it
doesn't feel likely to happen. If those "normal" interrupts aren't
storming then it seems unlikely we'd see more than one of each of them
between the "storming" interrupts. Thus it feels like the "storming"
interrupt would still have the highest (or tied for the highest) count
on the locked up CPU. Maybe you could print the top 4 or 5 (instead of
the top 3) and you'd be pretty certain to catch even this case?

In any case, I'll wait before doing a more thorough review for now and
hope the above sounds right to you.

-Doug

