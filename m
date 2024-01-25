Return-Path: <linux-kernel+bounces-39377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAD83CFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B831F242E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A3125BB;
	Thu, 25 Jan 2024 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="a0Ct1Qdw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666311731
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223085; cv=none; b=i2C7hEJ37XSO6+4QIXuBapmS3n+KserT3fH1eBss0sn9GqXTFV9lKkFcbyQgkNQBoeUj6pWEGPvTC2/B74Jy5tHoZqAWuy5WPigxMccasADvmhyHBfi7B0jZtExr/Nosp5V6OIi6c7GBUudh2+PbGS18uJ8/wbW+KcGKsOsQltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223085; c=relaxed/simple;
	bh=x+9cZFwfUUbXCSIUNvGOd+YWk7iUfd+WBM+Y4Bxq87g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1cLnSS3Wa+0IBNMRCImNoT0N8sZT8651qjuhAJke6TZAPClWJ7mF8ydjfLRwMCkq7jqsWD3umdtp+PICVCdyfGc5FcggDlG4/VvSYGgzM88EvoK4nU5BJc3L6UwlP8fzrHzz8dHYXPuJ9d2PEULkjvO4nYAM9JKBo+K481rkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=a0Ct1Qdw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290b1e19101so971721a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706223083; x=1706827883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnJEKVw0k0WgdGsgQiun3uEEO1MzAZB4cFb7xewCZWo=;
        b=a0Ct1QdwnQH0X1eUK+i28MokP1ZYceuK1iIA+qHVQxdOO09fumlqmYoYBlT7sip2RS
         DWutmisy3e6LoVkhor6r2kDKdN+Ej/uL5ChA59YLieyCbsPyLYSVabtEtBQcXzGaNOPf
         gPXATIBF5bPIpreKuvJgEG85fzKpOfMozboXWOvMnqm2dJomiaULEaRN3/u45OqX1wKu
         ZzkBMCacHWrbcLqYmsStNJxj3HiDTYhQiXnxj7WfHD+P3AhwbbVa0CyTMpPuGkec+auO
         jr4xIJTz7JgLWirhp6g9CAJmz1Jp8Obqrw/mtr+Uz1WwVl83OM954OqGzmChFp1MsUeg
         XY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706223083; x=1706827883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnJEKVw0k0WgdGsgQiun3uEEO1MzAZB4cFb7xewCZWo=;
        b=Z2ed6oIq0Y1LBlZInhdDGiYeInzZIHTsACN7dT0Srwz13rMv1K/4q0JPF2rnKLIeK3
         urfmIjLevj94CrmukkhKhFTtExghZEhdAl8+p3pt2BOQHw+j13OouX4joFwlWxQulSaN
         9zs3N8vAQnfINgGGlaFaWAjlUecipnIpLec0z/9+p4NGNwIuZaPlia7Bmm38calzz0c7
         2YEzRjkImYIoDqTKZTTfZIYfdoJK680LV1AwH54GQB0ra/lRUG2/iHhCet4soqMPv4W4
         lSdfOsE/45/b5AfUQcnibqxHFZGFvnt/vm47/TXEvOOq/ZYMQ+WF+2ldTfvBuHYBwwb5
         Yryw==
X-Gm-Message-State: AOJu0Yy/nEDo2M+CdhiWgNyWjNMa7XuJ/U+iBx+gIAN6q4n4de+xR2Qk
	G/zmQ3WVnW9Ymi0JzUAtnZK6/O01LMoT8Wt6bE3FEsQRDM183fDtI8pUF2vlhzbZIr/wLNNNNXF
	AcZ/Zbv8Xs868Zjf0bDcIRXEBoSNReri0l0nKOw==
X-Google-Smtp-Source: AGHT+IHTt2kfCDEIEqdQhaB1moHLVMHvs0ForCZoVTPtNM//1C1xaPtRtXtr7AubXLZ/EjIQvOS1P1z4QWqLRBNJjKQ=
X-Received: by 2002:a17:90b:4c04:b0:293:dfe6:6046 with SMTP id
 na4-20020a17090b4c0400b00293dfe66046mr35774pjb.8.1706223082705; Thu, 25 Jan
 2024 14:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com> <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
In-Reply-To: <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 25 Jan 2024 22:51:11 +0000
Message-ID: <CALrw=nGHUJWhZvibb61r8wDgZ7eRCDU5-vv=uTouAZH90vUGWw@mail.gmail.com>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing tasklet_struct
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	Mike Snitzer <msnitzer@redhat.com>, Damien Le Moal <damien.lemoal@wdc.com>, 
	Bob Liu <bob.liu@oracle.com>, Hou Tao <houtao1@huawei.com>, 
	Nathan Huckleberry <nhuck@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 25 Jan 2024 at 10:30, Mikulas Patocka <mpatocka@redhat.com> wrote=
:
> >
> > There's a problem with the tasklet API - there is no reliable way how t=
o
> > free a structure that contains tasklet_struct. The problem is that the
> > function tasklet_action_common calls task_unlock(t) after it called the
> > callback. If the callback does something that frees tasklet_struct,
> > task_unlock(t) would write into free memory.
>
> Ugh.
>
> I see what you're doing, but I have to say, I dislike this patch
> immensely. It feels like a serious misdesign that is then papered over
> with a hack.
>
> I'd much rather see us trying to move away from tasklets entirely in
> cases like this. Just say "you cannot do that".
>
> In fact, of the two cases that want this new functionality, at least
> dm-verity already makes tasklets a conditional feature that isn't even
> enabled by default, and that was only introduced in the last couple of
> years.
>
> So I think dm-verity would be better off just removing tasklet use,
> and we should check whether there are better models for handling the
> latency issue.
>
> The dm-crypt.c case looks different, but similar. I'm not sure why it
> doesn't just use the workqueue for the "in interrupt" case. Like
> dm-verity, it already does have a workqueue option, and it's a
> setup-time option to say "don't use the workqueue for reads / writes".
> But it feels like the code should just say "tough luck, in interrupt
> context we *will* use workqueues".

This is not great just considering the following context: the
tasklet/interrupt code was added, when we discovered dm-crypt most
likely processes read bios in interrupt context when using NVME
drives. So this would penalise the most desirable case for fast disk
encryption (decryption that is): systems use NVMEs mostly to get fast
IO, so they are the most sensitive to any latency introduced by
dm-crypt. For us it was a go/no-go: without this we might have
switched to dodgy proprietary self encrypting drives.

On the other hand this code never uses tasklets for slower media, but
they don't care and can use the default workqueue option in the first
place.

> So honestly, both of the cases you bring up seem to be just BUGGY. The
> fix is not to extend tasklets to a new thing, the fix is to say "those
> two uses of tasklets were broken, and should go away".
>
> End result: I would suggest:
>
>  - just get rid of the actively buggy use of tasklets. It's not
> necessary in either case.
>
>  - look at introducing a "low-latency atomic workqueue" that looks
> *exactly* like a regular workqueue, but has the rule that it's per-cpu
> and functions on it cannot sleep
>
> because I think one common issue with workqueues - which are better
> designed than tasklets - is that scheduling latency.
>
> I think if we introduced a workqueue that worked more like a tasklet -
> in that it's run in softirq context - but doesn't have the interface
> mistakes of tasklets, a number of existing workqueue users might
> decide that that is exactly what they want.
>
> So we could have a per-cpu 'atomic_wq' that things can be scheduled
> on, and that runs from softirqs just like tasklets, and shares the
> workqueue queueing infrastructure but doesn't use the workqueue
> threads.
>
> Yes, the traditional use of workqueues is to be able to sleep and do
> things in process context, so that sounds a bit odd, but let's face
> it, we
>
>  (a) already have multiple classes of workqueues
>
>  (b) avoiding deep - and possibly recursive - stack depths is another
> reason people use workqueues
>
>  (c) avoiding interrupt context is a real concern, even if you don't
> want to sleep
>
> and I really *really* would like to get rid of tasklets entirely.
>
> They started as this very specific hardcoded softirq thing used by
> some drivers, and then the notion was generalized.
>
> And I think it was generalized badly, as shown by this example.
>
> I have added Tejun to the cc, so that he can throw his hands up in
> horror and say "Linus, you're crazy, your drug-fueled idea would be
> horrid because of Xyz".
>
> But *maybe* Tejun has been taking the same drugs I have, and goes
> "yeah, that would fit well".
>
> Tejun? Please tell me I'm not on some bad crack..
>
>                Linus

