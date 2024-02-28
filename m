Return-Path: <linux-kernel+bounces-84514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EB86A7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8498A1F22105
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2820B35;
	Wed, 28 Feb 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tezNYvNp"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89520B03
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709095890; cv=none; b=h9SA54fOog55l33uzJ1B24M/iXLqmrTD15CHsvNcL6ACl6GAU0BCBQ92Eu6TjJxjLR+gV0myTsEWF0st3xpOSP0Xv2vEnvSHAVZ35u7Dp8duAB2jvbGPb3rWa8gi3NwfuYrLTzZaWFjfoSsQSOq9TMrpMgC5CMcz+iWOmYJBgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709095890; c=relaxed/simple;
	bh=m7v4dhAQbqoW11dKnytEHJl0Jf/Tj6DtwEZ3kATPsQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dou3hvGtlZAOOdTvW1WkVd/3J9avk9rjt8W6nYln3ZgFPcrspVrREoOf6eJw3X5GCjdK6+Ka2vtuWzgKp643C3nO1BFt4WdXBcKM0KmYyKHgV95JKeQh6sIL4lYoNBRiL38Qy0p3aEH4PzVYFiLz3nhZAos4WXqfH5yui9DoH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tezNYvNp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so26105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709095887; x=1709700687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXZBBeNL/fvEAIGlHv7FN+Xl17NoWz5GJcdGlzhydbs=;
        b=tezNYvNpRHF0KzhSyf7VD3UGCXhbVfv/FL61Vw9OxF4KXWSQOdS4Q30rUAzjdwVgK1
         E7jExn/26nnTkTzo477/wiV03uBhUcbkK6IfBUvvuPL9QKRPWxeLUB5KElMNupttQtmf
         zOsWOnCz5jojrgjgLqbWqH4/bQPzGJi8YLRBvykO62FCpWzJAJgyE203SYm0PIwa4OfP
         aFBzXQQGlu5bYfvCOVs6kOh6b+LSH5aLJM9fuecL+PdaXTpiSFa1V4i6WBvrXrhMUQ4L
         o/vS7HSZeWsaAnWzKJS/YldDV3DGNeQ8JBilcNdx6OuQHbxGhtq2C1q24ZQwlC1Zxala
         tWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709095887; x=1709700687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXZBBeNL/fvEAIGlHv7FN+Xl17NoWz5GJcdGlzhydbs=;
        b=OXvCON2ccXoYq9iZVVx4CcM0G+ysKFGnc5dDG+lo4SbCj3ybpiwzj/fjixvO7bZufJ
         NzqBGNt9BzgKbRZew9aoghrjvn7DzPzdgZ8rwG0udYoWidPdi5hwMbrabdxDr7oZDHiL
         xuEcM5Y2FfpFvrJReSBeoV/W/JsWnplTMgAXSemkMvO5R2QnIbDpPkCYN5byhS2MSR7u
         UF3FGX1TNnPKof661v6Hgq1g+gu70ipEfAU/mbzEONS0QkcidPsPvzLQauWtoNZSJOhi
         k+UMoh7B3upekmhda7MOPvJKipK4bYhErBAVQaZILVrc7mcGmyEJNyKjYJMKS8rGyxmp
         8N2w==
X-Gm-Message-State: AOJu0YygJmsJ0djarBq1Zv8Gp5lEquI4FP7PfzHvq1vjeuBoV/zMb2fi
	3nH/+iT3aX3lBAUf1azAQzbrsSRbW4Cbqps4jCuFR6+36ncpYjEONr2Z26HFYjVu71AWvhhzFxJ
	4SQ1vXNe6r3xoANCUrYVAxWWYng6C/WbU4LQ=
X-Google-Smtp-Source: AGHT+IEoWS3a3PKbMkVJvLE5hqdBz4+UHOc98KRh9t4Wim06RVweyruoxl4E9a4JxiqMjA9dIDzjBv7J0U6Xqlat2Fw=
X-Received: by 2002:a05:600c:1e15:b0:412:a390:3440 with SMTP id
 ay21-20020a05600c1e1500b00412a3903440mr13338wmb.3.1709095887512; Tue, 27 Feb
 2024 20:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com> <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
In-Reply-To: <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 27 Feb 2024 20:51:15 -0800
Message-ID: <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:43=E2=80=AFPM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> Happy to report that I did not see any regressions with the series
> as expected. Full results below.
>
[snip]
> o System Details
>
> - 3rd Generation EPYC System
> - 2 x 64C/128T
> - NPS1 mode
>
> o Kernels
>
> tip:            tip:sched/core at commit 8cec3dd9e593 ("sched/core:
>                 Simplify code by removing duplicate #ifdefs")
>
> proxy-setup:    tip + this series
>

Hey! Thank you so much for taking the time to run these through the
testing! I *really* appreciate it!

Just to clarify: by "this series" did you test just the 7 preparatory
patches submitted to the list here, or did you pull the full
proxy-exec-v8-6.8-rc3 set from git?
(Either is great! I just wanted to make sure its clear which were covered)

[snip]
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks so much again!
-john

