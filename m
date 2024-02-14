Return-Path: <linux-kernel+bounces-66126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5229A855767
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6941EB23816
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258AC1420B3;
	Wed, 14 Feb 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EFKOVr3B"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DB604DD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954008; cv=none; b=FTdTnj54wCidBC5zuwiLI11n2cB0LZz3p5CP19BQA9xQCp6UgIhCCAm9m4qXOLYbMWaFCZIPd1rG2d7YorDcerOkRc3xHI6ISYm+quqGa0i40gwi56OuSO451dqwJutaNzTRAC7jAgGcth9jo/brxY4xeA0Wo2hzgEEhr3LWVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954008; c=relaxed/simple;
	bh=ZtXHMMs51sy2lq9Yur67XyHT9kEZLyfzdpjYUFJ5ktY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic9Ph5YK2X8gKRfv6p5+ufr37bOJsCQhKyC7awjjadyLWGlAUUvnyZnbKyJo8XPzncuShUuq8NsBzNgC1OZlf6ategFQwFcOeDnvAYSolTaHtFugYhVI+ZLgyYJ2H2PaJZ33JUeWT4r2mwhUi+FFlKW9gHo/45ROZG2eKvsEKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EFKOVr3B; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d107900457so3834341fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707954003; x=1708558803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3h2sR0bd4KQ8sw8Q+rg4t4BcaYOvU/ONccVYZP6UM0=;
        b=EFKOVr3BhMrNM+9P2z2abL20EfdLyjjt+U4jdqvFr8S0OC4L5ntr4B7sbF/pQFIi90
         dMAaR03Uvb1YrIXMtoke7uznOxb80KY6MZhXTUmZJtpoyZSLlWqKH5t0eY5cGrgWuTRu
         ltqE7p/WbuGkfvJANmY1X/3V+5pnM1Bgp+RPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707954003; x=1708558803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3h2sR0bd4KQ8sw8Q+rg4t4BcaYOvU/ONccVYZP6UM0=;
        b=HkkP77ICGrhlAEfvGYk7vBQqDdnR6FLo8OR8oS3wz6Xsz9JAzwnr8gNZ5r3xSP3K1s
         Msvdb3cga//SBIeM9R8ctBO/bR+rD01LK4WeO/WlAbLqjWqZ8654zt4WnXSGYAMXZjOI
         WP3Eu5Dd/jZisE2n8wrjPU/Zw208hD/x6ZbnJD+Nr80BVYVkyRoopea9LVdtK4CNkXoO
         vZNu+dGY8t1a6S58kMPB6BgK90cec1WvK6/ZwfkCjuJ/gTJeU0SxgBLub8rE9U0dsnrV
         S0kg4Dwao6I5PVe3xc1v2jT0lfgdGK5KFxqQTnymy+HvyxXpOfZ67JPw9VMBjo9K5xDq
         w+qw==
X-Forwarded-Encrypted: i=1; AJvYcCU6LRu5D5nKgBFRQbAV4Itv6mh7AOAnjFWMYKmRxEADl4DIVpUAxFx22WvdmNQ9bq1IgIjlFaQ7XIbu3XpNutTd9+TLMOvuMpJzbwhq
X-Gm-Message-State: AOJu0YwS3pijojAZP7aQzRGx9oYbds3S8tIK7XbPAU2l7jsTaxt8PcFV
	2hPGZa65+ESZq1ePKrpQHWhXtL64bxc1UFxB0s9O5mrPLMpoBGOyeAElMW1zDk7gH4h6sPmUQqV
	Y95vS
X-Google-Smtp-Source: AGHT+IEfbCMW3YMxZvDHoKgFUjzyEWYrH1o5HIadkVVIHgz7dJh61YsIMQ7yMvFvlU4XBQqPyzI3wA==
X-Received: by 2002:a05:651c:220d:b0:2d0:b663:f052 with SMTP id y13-20020a05651c220d00b002d0b663f052mr129656ljq.6.1707954002707;
        Wed, 14 Feb 2024 15:40:02 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id n17-20020a056402061100b00562d908daf4sm17509edv.84.2024.02.14.15.40.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:40:01 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso2437a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:40:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVds+WrVuG8175aeTKWShPWiq3vsIUvSUf+7IYinunTmRndcxYOMbyVfNdYFO8Ha/vPF2VfnVgNhA2xvDF1ywmJGqphmrIwaUBoFHpF
X-Received: by 2002:a50:8d13:0:b0:55f:8851:d03b with SMTP id
 s19-20020a508d13000000b0055f8851d03bmr325802eds.5.1707954001556; Wed, 14 Feb
 2024 15:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-3-yaoma@linux.alibaba.com> <8734tufwjh.ffs@tglx>
In-Reply-To: <8734tufwjh.ffs@tglx>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 14 Feb 2024 15:39:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=URLh5N6smwdnPXn6di8iek_vn=uBYFWBpCdsuRjLK8ew@mail.gmail.com>
Message-ID: <CAD=FV=URLh5N6smwdnPXn6di8iek_vn=uBYFWBpCdsuRjLK8ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] watchdog/softlockup: report the most time-consuming hardirq
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bitao Hu <yaoma@linux.alibaba.com>, akpm@linux-foundation.org, pmladek@suse.com, 
	maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 14, 2024 at 3:36=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Jan 23 2024 at 20:12, Bitao Hu wrote:
> > +/*
> > + * If the proportion of time spent handling irq exceeds 50% during a s=
ampling period,
> > + * then it is necessary to tally the handling time of each irq.
> > + */
> > +static inline bool need_trace_irqtime(int type)
> > +{
> > +     int tail =3D this_cpu_read(cpustat_tail);
> > +
> > +     if (--tail =3D=3D -1)
> > +             tail =3D 4;
> > +     return this_cpu_read(cpustat_diff[tail][type]) > sample_period/2;
> > +}
> > +
> > +static void irq_handler_entry_callback(void *data, int irq, struct irq=
action *action)
> > +{
> > +     this_cpu_ptr(irq_to_desc(irq)->irq_time)->start_time =3D local_cl=
ock();
> > +}
> > +
> > +static void irq_handler_exit_callback(void *data, int irq, struct irqa=
ction *action, int ret)
> > +{
> > +     u64 delta;
> > +     struct per_irqtime *irq_time;
> > +
> > +     if (test_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags))=
) {
> > +             irq_time =3D this_cpu_ptr(irq_to_desc(irq)->irq_time);
> > +             delta =3D local_clock() - irq_time->start_time;
> > +             irq_time->delta +=3D delta;
> > +     }
> > +}
>
> I can understand what you are trying to achieve, but you inflict the
> overhead of two tracepoints to every interrupt unconditionally.
>
> For the vast majority of usage scenarios that's just pointless overhead
> for no value. That's not acceptable at all.
>
> Instrumentation and debugging has to find the least intrusive solution
> and not just go for the perfect picture. Remember: perfect is the enemy
> of good.
>
> You really have to think hard about what you really need to achieve for
> a particular problem case.
>
> In this case it's completely sufficient to know the number of interrupts
> which happened since softlockup detection took a snapshot and the actual
> analysis.
>
> That's especially true when interrupt time accounting is active because
> then the only interesting information is which interrupts fired during
> the observation period.
>
> Even if that's not available it is a reasonable assumption that the
> number of interrupts during the observation period gives a pretty
> conclusive hint about the potential cause of the problem.
>
> This is not meant to find the oddball issue of an interrupt handler
> which consumes a lot of time per invocation. This is about storm
> detection where the handler runs briefly and actually returns
> IRQ_HANDLED so that the spurious detection does not catch it.
>
> This can be implemented with exactly zero overhead for the good case,
> keeping it self contained to the interrupt core code and providing
> sensible interfaces for the watchdog code.
>
> See the uncompiled patch for illustration below.
>
> As a side note: While C does not allow proper encapsulation it's a non
> starter to fiddle with the interrupt descriptor internals in random code
> just because the compiler allows you to do so. While not enforced there
> are clear boundaries and we went a long way to encapsulate this.

I think you must have gotten dropped from all the future versions of
this patch series when Bitao took my advice and started using
interrupt counts instead of tracing. For what it's worth, the latest
version can be found at:

https://lore.kernel.org/r/20240214021430.87471-1-yaoma@linux.alibaba.com

