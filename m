Return-Path: <linux-kernel+bounces-127090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B121894698
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C152B21DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13554BEA;
	Mon,  1 Apr 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfTjMRhs"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E902A1BF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006931; cv=none; b=ffqNDNnEpZo+pMI/lvSw3rVt+aYRQIZQu3OIz1hQrCmVl+3lmRHPbn3wJeOyVlkTs9aFozCRtiDn6SbmsoIteSKTTbO4GSSDQVZy5iq9N+7BTqTyiNOfI8t7Bt88OOWEgKvKck5HTCw0e/q/y0W/sKlYmdqRkTsomwkQNVC+qK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006931; c=relaxed/simple;
	bh=MEs36YMnsrPR4rdb3o8Ig0bsP2s1uGCzHh26qAa8u9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/LCQu6iL0N88ULQuwPcjADsvsXgstpgCk16cpMC9hMp3r6QDzjyMnr+CLUDwyF93KZmkNczuDwLxLv8wZdUlnGCISRTppv3n1FyTdgAL96+AZRflGsLeRFs0fBrYdN4Yl/iBfHRTzTAZgxqZv6yxZXjc0qaZWzh3OrTiT+y9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfTjMRhs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430d3fcc511so1050061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712006929; x=1712611729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9FZOMgU0YGB8ZQhwbqpscpxskcen7gXbnNqwcarIA4=;
        b=hfTjMRhsiSHc3/XGmrOSSXHgthzfsxeHDZrDaGVFW/gk0aTfCm18czj+IOA90wfOK7
         St4fYgTySFiudyTBUP0yDa2HG8XJBwQk++Z1t2+B3OWK7b272J0zXZ71PgArzEE4uoGq
         3XkBi59P/4aBzkkrJR55Pv2akzSmBp8lHfH9hHUuAOUgjK3AXiVGkt05O72iHyIcplVU
         z8BocDeoQelL+stAu8BUf65JxZzQsWuqIFcK2gS+g3ebxzkACE0ICTAs8fAsUDfdya0c
         oXbTtwIIE/xcLrBY+fX6YyA4/JT/cmnvt9spGz8+MEQbECJoySGF9Joet8nF5m1Z4J/v
         TT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006929; x=1712611729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9FZOMgU0YGB8ZQhwbqpscpxskcen7gXbnNqwcarIA4=;
        b=KlJos+ZWLCoSSqNQXCyWQQiAb6xBhz9YatTtDXe59kQ0tmO/cLA1LIy4zVX+E3vGDv
         k4QYKvZ//4VE7cIHrkHhOLLvlFbkY+1jRDyws4Mqx/5oaGNGPRa7q1CRiDjW2ze0qoGu
         vMNGZO2zoQMAjbiiDhghZ9mEvEamjyADgtu7140/CsrsrvfTYpTx6xM9QIxcR3S+yxHr
         EvdX8IxZnki61GjrLN4rYQY07NRsPk0lBbPIvFv2toWyi7Jv1N9txukhikMFjRaUh3K2
         jymbSKyL2NeeSem3tF5/8EKqgzY9nL9UHNrSemg5Vexa52Ts6lJiDJd0bxhMFgpwrLRw
         mzHw==
X-Gm-Message-State: AOJu0YykXBDu3eR3OIqYt6b1kyjcPsXzDy3jB+2qR7C4WdX+qeNhG1+Q
	0FOxgwPaAXTfPweiYhDC34MXuaYFAi33GRoY3A1ikaT70eIikjoJDALIjdKnjQByrshvvNa1dM0
	cmEmldYCe/KJN//rt6paSzQQaUj/LUY819lM=
X-Google-Smtp-Source: AGHT+IHTe0AzR1sA9lTRPGg5FAMC8tMLoIhvHGu7hsJdmd7Ki1fgKHYioGxaodWk/rcRU3iEU0r6uPny7bsnnepnoHQ=
X-Received: by 2002:a05:622a:5506:b0:431:3c48:a65b with SMTP id
 fj6-20020a05622a550600b004313c48a65bmr866396qtb.11.1712006928809; Mon, 01 Apr
 2024 14:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315044007.2778856-1-jstultz@google.com> <218a5f34-dcca-ab0e-e098-807993ca3898@amd.com>
In-Reply-To: <218a5f34-dcca-ab0e-e098-807993ca3898@amd.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 14:28:35 -0700
Message-ID: <CANDhNCoYVeWyhfePPrMqsLTY_1nTUM3GekgtpsyOm7QNLZYpXA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Preparatory changes for Proxy Execution v9
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

On Sun, Mar 24, 2024 at 11:44=E2=80=AFPM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> On 3/15/2024 10:09 AM, John Stultz wrote:
> > As mentioned last time[1], after previous submissions of the
> > Proxy Execution series, I got feedback that the patch series was
> > getting a bit unwieldy to review, and Qais suggested I break out
> > just the cleanups/preparatory components of the patch series and
> > submit them on their own in the hope we can start to merge the
> > less complex bits and discussion can focus on the more
> > complicated portions afterwards. This so far has not been very
> > successful, with the submission & RESEND of the v8 preparatory
> > changes not getting much in the way of review.
> >
> > Nonetheless, for v9 of this series, I=E2=80=99m again only submitting
> > those early cleanup/preparatory changes here (which have not
> > changed since the v8 submissions, but to avoid confusion with the
> > git branch names, I=E2=80=99m labeling it as v9). In the meantime, I=E2=
=80=99ve
> > continued to put a lot of effort into the full series, mostly
> > focused on polishing the series for correctness, and fixing some
> > hard to trip races.
> >
> > If you are interested, the full v9 series, it can be found here:
> >   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v9-6.=
8
> >   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v9-6.8
>
> Tested the v9 of the series.
>
> tl;dr
>
> o I still see a small regression for hackbench. I'll get some perf
>   profiles for the same and leave them in this thread soon (I do
>   not have them at the moment unfortunately)
>
> o There is a regression for some combinations in schbench. I'll
>   have to recheck if I can consistently reproduce this or not and
>   look at the perf profile to see if something is sticking out.

Much appreciated for the extra testing of the whole series!

I've not had much time to dig further on performance tuning since v8
(v9 mostly focused on fixes), so I didn't expect much change.
As I do some more detailed analysis of behavior via tracing for
correctness, I'm hoping there will be some finds there to further
improve things, but I'm not sure all of the overhead of handling proxy
rq-migrations and re-selecting the next task will be avoidable. So I
expect some potential throughput impact, but hopefully the latency
improvements will be worth it.

> > New in v9:
> > (In the git tree. Again, none of the preparatory patches
> > submitted here have changed since v8)
>
> Since these changes in this preparatory series have remained the same,
> please feel free to add:
>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Just added to my WIP tree. I'll likely be sending a RESEND of the v9
prep patches in the next few days, and will add them there as well.

Thank you so much again!
-john

