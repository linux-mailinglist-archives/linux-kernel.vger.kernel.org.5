Return-Path: <linux-kernel+bounces-37817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518EC83B602
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7121E1C21CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAF387;
	Thu, 25 Jan 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UaeCboSb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E009399
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141993; cv=none; b=m95qBX5YtHu+nw06zFiHDNPPMtglzR42GZ4NSYV7TTy54vlXmVwbQ9XUX1sogM2HXXJqEG62eejE9TiKBHZuBu9Af+kI72Pecdaslyn6dLKtpFJsaqU8ghmJu4IPv3J96QvvVP/6axgLGun1MPwwpwu3CkFZupc6d/s2SDC7GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141993; c=relaxed/simple;
	bh=lzBvstscaL3KEepCa04p04xyK7Nnoxy7E/qcMl6hIVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ofj30SXjLIuE+38nmQ0vhn5EGvj8hHak5D0ou+AHToeZXJLt1NUVzI6gRVMXOKA+v6if6Phh7eRmgCH/1Icc8Kk6cPaJxCwuR0arkHf+gnM8eIC9GNGFV1acV7Hz1k9rLhUhwzf8FZuqUyLLeWrBAWLmMNIcMLh8RC8p+LCZcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UaeCboSb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30f7c9574eso191385266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706141987; x=1706746787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKNM/AfzeGANPwzw8B42DpfVfEXpXqtP1IJKhPAjUWw=;
        b=UaeCboSbHVzv3PixcANcPpCNMzlKaa/qancDMEMCMVQLMFITvpTYA6ILtIaT905S0l
         NEP1PIe1N02WbAqfk1dLRqcLgjiLWipw4JXVGUtKvD8bbwL3D/Vh3Jut4ZMFJGSsG4uo
         37AoEnwdbrbLm/9oQPXT97NIv3pJlFC7pq9lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141987; x=1706746787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKNM/AfzeGANPwzw8B42DpfVfEXpXqtP1IJKhPAjUWw=;
        b=KXoxrdzObc6VIyinOPmELbE+sotNGqNw7YqV92nLiGHMHxghbBPyh6Jmv03UAOrMkp
         e36G1R7Q67Uob6dRvb0i8t3LCVM9fRoHMPLCVbDv+nDAIHtg4uMYXqmi2ypA78BnAdIX
         76SY6apwmDAflCwBV7Q5fMnsD+eZUavXy0nuf8i+JHzZKIi581Hu47ahr6DApJNxFe5k
         E55sg3Kpyz+dAitGI7R1/CWk+32UKxcXBZWNOHtGfzpB5d7HxJnEBSVfYlXJ0KiCjkp8
         TZw1vVn7kpb8ztGa0t1GChK8FAYEwfcZlmlDHiFgm5F+Dy/Qybx6ZqKAbdXiiL48VOcb
         zwsg==
X-Gm-Message-State: AOJu0YwuMs5m7QC1vlQ0qEO8G1g9Pjk/Mgy3w7tFh8ExTF92epwseBsc
	E3fBl44yS/wcyIy4epHNiWU3Y6sgboB3UlEtAODayg3q+KYObbrxC09kp1IGaulFDS61p7oo8Br
	oFA==
X-Google-Smtp-Source: AGHT+IF1mG1OMLiaS/V2Kq2z354+UFo1AwYLa8v7tH+95bqSgbTFaWDfmS2Kw0aXjVvLOqu6mUx++Q==
X-Received: by 2002:a17:906:ad89:b0:a2f:ba78:2b3e with SMTP id la9-20020a170906ad8900b00a2fba782b3emr40454ejb.101.1706141986698;
        Wed, 24 Jan 2024 16:19:46 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id cw11-20020a170907160b00b00a30b9f87a6esm413134ejd.142.2024.01.24.16.19.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 16:19:46 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so8545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:19:45 -0800 (PST)
X-Received: by 2002:a05:600c:3b1c:b0:40e:61cf:af91 with SMTP id
 m28-20020a05600c3b1c00b0040e61cfaf91mr33895wms.7.1706141984791; Wed, 24 Jan
 2024 16:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123121223.22318-1-yaoma@linux.alibaba.com> <20240123121223.22318-2-yaoma@linux.alibaba.com>
In-Reply-To: <20240123121223.22318-2-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Jan 2024 16:19:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WEEQeKX=ec3Gr-8CKs2K0MaWN3V0-0yOsuret0qcB_AA@mail.gmail.com>
Message-ID: <CAD=FV=WEEQeKX=ec3Gr-8CKs2K0MaWN3V0-0yOsuret0qcB_AA@mail.gmail.com>
Subject: Re: [PATCH 1/3] watchdog/softlockup: low-overhead detection of
 interrupt storm
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de, 
	maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 23, 2024 at 4:12=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> =
wrote:
>
> The following softlockup is caused by interrupt storm, but it cannot be
> identified from the call tree. Because the call tree is just a snapshot
> and doesn't fully capture the behavior of the CPU during the soft lockup.
>   watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>   ...
>   Call trace:
>     __do_softirq+0xa0/0x37c
>     __irq_exit_rcu+0x108/0x140
>     irq_exit+0x14/0x20
>     __handle_domain_irq+0x84/0xe0
>     gic_handle_irq+0x80/0x108
>     el0_irq_naked+0x50/0x58
>
> Therefore=EF=BC=8CI think it is necessary to report CPU utilization durin=
g the
> softlockup_thresh period (report once every sample_period, for a total
> of 5 reportings), like this:
>   watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>   CPU#28 Utilization every 4s during lockup:
>     #1: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>     #2: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>     #3: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>     #4: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>     #5: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>   ...
>
> This would be helpful in determining whether an interrupt storm has
> occurred or in identifying the cause of the softlockup. The criteria for
> determination are as follows:
>   a. If the hardirq utilization is high, then interrupt storm should be
>   considered and the root cause cannot be determined from the call tree.
>   b. If the softirq utilization is high, then we could analyze the call
>   tree but it may cannot reflect the root cause.
>   c. If the system utilization is high, then we could analyze the root
>   cause from the call tree.

Just to set the tone: this sounds like a great idea! I've found myself
wanting something like this for a long time but I've never sat down to
try to code up a mechanism. I have review comments below, but mostly
it's just details. IMO the idea is definitely something we want to
land.


> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  kernel/watchdog.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 81a8862295d6..9fad10e0a147 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -23,6 +23,8 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/stop_machine.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/math64.h>
>
>  #include <asm/irq_regs.h>
>  #include <linux/kvm_para.h>
> @@ -441,6 +443,58 @@ static int is_softlockup(unsigned long touch_ts,
>         return 0;
>  }
>
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +static DEFINE_PER_CPU(u64, cpustat_old[NR_STATS]);
> +static DEFINE_PER_CPU(u64, cpustat_diff[5][NR_STATS]);
> +static DEFINE_PER_CPU(int, cpustat_tail);

The above is potentially a lot of memory. On some configs we allow up
to 8192 CPUs and you're storing (NR_STATS * 6) u64s per CPU plus
another int per CPU . NR_STATS can be up to 11 currently, so if I did
my math right then that's

8 * 8192 * 11 * 6 + 4 * 8192 =3D 4,358,144 bytes (!) That's probably not OK=
.

In theory you only need 4 stats (plus the total) instead of 11. If you
do that plus the "old" then that would give you (8 * 8192 * 5 * 6 + 4
* 8192) =3D 1,998,848 bytes. That's still a lot, but at least less.
..so at the very least you should only store the fields you need.

Given the amount of potential space at stake, it's probably worth
optimizing this to something smaller than u64 as well. It feels like
it would be easy to use u32. You only need diffs here and it doesn't
seem like it would be hard to figure out how to use 32-bits, even if
you have the drop a bit of granularity.

It feels like you could even go down to 8-bits per stat, though. You
don't _really_ need such accurate percentages, right? Does it really
matter if you have 99.4%? It seems like just saying 99% would be fine.
Just do the math here and store the integral percentage per stat you
care about. The numbers 0 - 100 can be stored in 8 bits.

Combining that all together, I guess you could do this (untested):

1. Get the current stats and right shift them all by 10 and convert
them to 32-bit. This gives you (roughly) microseconds which will roll
over roughly every ~4000 seconds. That seems about right, though I
guess it's possible to do more and see if we can squeeze into 16 bits.

2. Sum up all 11 of the stats to get a total. This should still fit
into 32-bits.

3. Do the math to get the integral percentages and store those in the tail =
slot.

4. Store the 4 stats you care about plus the total (all 32-bits) in
"cpustat_old".

If I've got that right, your definitions should be able to be:

#define NUM_OLD_STATS_GROUPS  5
#define NUM_STATS_PER_GROUP 4
static DEFINE_PER_CPU(u32, cpustat_old[NUM_STATS_PER_GROUP + 1]);
static DEFINE_PER_CPU(u8,
cpustat_utilization[NUM_OLD_STATS][NUM_STATS_PER_GROUP]);
static DEFINE_PER_CPU(u8, cpustat_tail);

With the maximum number of CPUs, that's now this, if I got my math right.

4 * 8192 * 5 + 1 * 8192 * 5 * 4 + 1 * 8192 =3D 335,872 bytes.

That's a lot less, but still a lot. I'd be interested to hear other
opinions, but it's probably worth a Kconfig knob.


> +static void update_cpustat(void)
> +{
> +       u64 *old =3D this_cpu_ptr(cpustat_old);
> +       u64 (*diff)[NR_STATS] =3D this_cpu_ptr(cpustat_diff);
> +       int tail =3D this_cpu_read(cpustat_tail), i;

nit: Please define "i" on its own line. It looks weird the way you have it =
here.

> +       struct kernel_cpustat kcpustat;
> +       u64 *cpustat =3D kcpustat.cpustat;
> +
> +       kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
> +       for (i =3D 0; i < NR_STATS; i++) {
> +               diff[tail][i] =3D cpustat[i] - old[i];
> +               old[i] =3D cpustat[i];
> +       }
> +       this_cpu_write(cpustat_tail, (tail + 1) % 5);
> +}
> +
> +static void print_cpustat(void)
> +{
> +       int i, j, k;
> +       u64 a[5][NR_STATS], b[5][NR_STATS];
> +       u64 (*diff)[NR_STATS] =3D this_cpu_ptr(cpustat_diff);
> +       int tail =3D this_cpu_read(cpustat_tail);
> +       u32 period_us =3D sample_period / 1000;
> +
> +       for (i =3D 0; i < 5; i++) {
> +               for (j =3D 0; j < NR_STATS; j++) {
> +                       a[i][j] =3D 100 * (diff[i][j] / 1000);
> +                       b[i][j] =3D 10 * do_div(a[i][j], period_us);
> +                       do_div(b[i][j], period_us);
> +               }
> +       }
> +       printk(KERN_CRIT "CPU#%d Utilization every %us during lockup:\n",
> +               smp_processor_id(), period_us/1000000);
> +       for (k =3D 0, i =3D tail; k < 5; k++, i =3D (i + 1) % 5) {
> +               printk(KERN_CRIT "\t#%d: %llu.%llu%% system,\t%llu.%llu%%=
 softirq,\t"
> +                       "%llu.%llu%% hardirq,\t%llu.%llu%% idle\n", k+1,
> +                       a[i][CPUTIME_SYSTEM], b[i][CPUTIME_SYSTEM],
> +                       a[i][CPUTIME_SOFTIRQ], b[i][CPUTIME_SOFTIRQ],
> +                       a[i][CPUTIME_IRQ], b[i][CPUTIME_IRQ],
> +                       a[i][CPUTIME_IDLE], b[i][CPUTIME_IDLE]);

As per your response to Liu Song, I understand why you're using
"printk" instead of pr_crit(), but it deserves a comment.

