Return-Path: <linux-kernel+bounces-47537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBA844F19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C98B2C475
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B317554;
	Thu,  1 Feb 2024 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJx0YHTR"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9683125D2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754193; cv=none; b=MTiJMFVFc2ZeybmUrDOLDSiSPYPRjr9Yn7AxP8S2v65w2AJeuFofcI4iPPu63hoTGnxLCfjMDkIk+m/1m6PZIPMGHup4BfKB+mBvxnAZypWFnc5lMbnYv6pMA33RmI8B8BasdnCFTAnz4tBbk1JdmMEm7F9FQ9Kfn+yHewn0GZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754193; c=relaxed/simple;
	bh=nu0kNQbxC1lod5nqjmBr0FQZkXkPSSaDf6JaK5AYOl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELk3TpjNiOsCKwFnO87gW+SU31Qj2Gb3/ru2MGKat4rO6YDBws0i+BO7oFT0SDAm5b9Q14ir+Lv7TeWg6hSNZAuk6bXHekyXMPFhx+pKMKeb6GmzmTetfwgTwLUFrP3urb5C7jFcR8MIzYr7SE5fcy6hNaC5Yu1pONrAqrEGpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cJx0YHTR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso2965913a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706754189; x=1707358989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iv6b2i9l9rFe8vA78TEWX0/zmUGmgrOJP47imeaplQ=;
        b=cJx0YHTRbSC/0r0kVPXxfH4pV57hjJg3y81MUBioaBJGdQ8k/BQJPzJW/eTS46Fwis
         ywr61urhG36SCYoZsNpeAvzqvcuOB15O+93TMK2ipwB0HxFe5RWvgo37Q7+BU/mF4F4t
         yRqmg2B0gr0wXOM323hxLAg2fqWMycRNiqvl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706754189; x=1707358989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iv6b2i9l9rFe8vA78TEWX0/zmUGmgrOJP47imeaplQ=;
        b=APFkUvufjcTXy/3pBR1oEWpz7gAhrn7ZHK0vFJ+eYG6mXuMc2MyoSoiL3YW19Yh3jP
         C7i2QO4VCl+vRtDUmvlfCH3HqzhT47ZMOfUhS08gNGJUrA34/JjddoIbG5aBYASCPvqW
         8JUErAv0MykqFQWHFJ3amvqMaxkvOp+UBITppFhgxFMmtmNnPepbP1OnkrgZn+Z6Hvcv
         VCcNyNIjaNcLyvnj51Oc0ZLBaQuG+bnfOv2WVuRoEy3ksym9vjelrZwjo7Cl0wFTSDUS
         qYfbwq4DM6E9oXoef+A8KFa/6/MvA3Pj655XFQjPu3jmltWA1wRh7ZQYF2rFms8uDFo0
         n7Mg==
X-Gm-Message-State: AOJu0Yyp22AlQI9ft+/4l8J/WgaZSpweDQfaHg8F3Wgec2EgMV3CF3ZZ
	WtT1nXtA7Md4x1TQ83JThd5ofLPrTQ56j8VgEcFGM4waf3skmr4AAkyFedri4nxPpuIY6yML1Wl
	c2Q==
X-Google-Smtp-Source: AGHT+IGLIN0t7DNfyFYdJM9nZLt7GBf54TKW+NLjY8F8ERytdBov19+LkbvXadXw8fzUtdxj6PmayQ==
X-Received: by 2002:a05:6402:5201:b0:55f:3463:2109 with SMTP id s1-20020a056402520100b0055f34632109mr3964450edd.10.1706754188777;
        Wed, 31 Jan 2024 18:23:08 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id h28-20020a50cddc000000b0055f384e7530sm2433422edj.32.2024.01.31.18.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 18:23:07 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ef9382752so27715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:23:07 -0800 (PST)
X-Received: by 2002:a05:600c:518e:b0:40f:b642:1919 with SMTP id
 fa14-20020a05600c518e00b0040fb6421919mr49606wmb.5.1706754187220; Wed, 31 Jan
 2024 18:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131171738.35496-1-yaoma@linux.alibaba.com> <20240131171738.35496-2-yaoma@linux.alibaba.com>
In-Reply-To: <20240131171738.35496-2-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jan 2024 18:22:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VOYo-OsjKwPQFuBHgB6Uk9E-nb3CiwKjj_yLtPDa7sYQ@mail.gmail.com>
Message-ID: <CAD=FV=VOYo-OsjKwPQFuBHgB6Uk9E-nb3CiwKjj_yLtPDa7sYQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] watchdog/softlockup: low-overhead detection of
 interrupt storm
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 31, 2024 at 9:17=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> =
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
>     #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #5: 0% system, 0% softirq, 100% hardirq, 0% idle
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
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  kernel/watchdog.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)

Random high-level question: I'm trying to figure out exactly when your
code will trigger. The only way it will trigger is if the timer
interrupt is a higher priority than the storming interrupt. By this I
don't mean that the timer will interrupt the storming one (it's not a
nested interrupt), but that if both interrupts are currently asserted
we'll service the timer first.

If the storming interrupt is always serviced before the timer
interrupt then the softlockup code won't trigger at all. In that case
we should detect a hard lockup and hopefully you've got the buddy
detector enabled and pseudo-NMI turned on. Then hopefully we'll have
actually interrupted the storming interrupt and it'll be on the
callstack.

I just wanted to make sure I was understanding correctly. This is why
you don't print the stats from watchdog_hardlockup_check() because
they're not useful there, right?


> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 81a8862295d6..046507be4eb5 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -23,6 +23,8 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/stop_machine.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/math64.h>

nit: instead of adding to the end, add these in sorted order. The
includes we have now are _almost_ in sorted order. I'd add these
between "init.h" and "module.h"


>  #include <asm/irq_regs.h>
>  #include <linux/kvm_para.h>
> @@ -441,6 +443,85 @@ static int is_softlockup(unsigned long touch_ts,
>         return 0;
>  }
>
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING

In v1 I think I suggested adding a new config. Even with your
optimizations you've quoted this as taking up "237,568 bytes" of
global storage when things are configured for the max number of CPUs.
It feels like someone might not want that. Adding a new Kconfig knob
shouldn't be a huge problem. Maybe you can have it default to "yes" if
the max number of CPUs is <=3D 64 or 128 or something?


> +#define NUM_STATS_GROUPS       5
> +enum stats_per_group {
> +       STATS_SYSTEM,
> +       STATS_SOFTIRQ,
> +       STATS_HARDIRQ,
> +       STATS_IDLE,
> +       NUM_STATS_PER_GROUP,
> +};
> +static enum cpu_usage_stat stats[NUM_STATS_PER_GROUP] =3D {

"static const", not just "static"

nit: maybe call this "tracked_stats" since "stats" is a bit of a
generic name for a global.


> +       CPUTIME_SYSTEM,
> +       CPUTIME_SOFTIRQ,
> +       CPUTIME_IRQ,
> +       CPUTIME_IDLE,
> +};
> +static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
> +static DEFINE_PER_CPU(u8, cpustat_utilization[NUM_STATS_GROUPS][NUM_STAT=
S_PER_GROUP]);
> +static DEFINE_PER_CPU(u8, cpustat_tail);
> +
> +/*
> + * We don't need nanosecond resolution. A granularity of 16ms is
> + * sufficient for our precision, allowing us to use u16 to store
> + * cpustats, which will roll over roughly every ~1000 seconds.
> + * 2^24 ~=3D 16 * 10^6
> + */
> +static u16 get_16bit_precision(u64 data)

nit: instead of "data", call it "data_ns"


> +{
> +       return data >> 24LL; /* 2^24ns ~=3D 16.8ms */
> +}
> +
> +static void update_cpustat(void)
> +{
> +       u8 i;

FWIW, Andrew Morton (who will likely be the one landing this patch)
was quoted in LWN [1] the other week saying that "i" should be an
integer. :-P Making it an "int" won't make the code any less
efficient.

[1] https://lwn.net/Articles/958417/


> +       u16 old;
> +       u8 utilization;
> +       u8 tail =3D __this_cpu_read(cpustat_tail);
> +       struct kernel_cpustat kcpustat;
> +       u64 *cpustat =3D kcpustat.cpustat;
> +       u16 sample_period_ms =3D get_16bit_precision(sample_period);

It's not really milliseconds, right? Maybe "sample_period_16"?


> +       kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
> +       for (i =3D STATS_SYSTEM; i < NUM_STATS_PER_GROUP; i++) {

nit: start i as 0 instead of assuming that STATS_SYSTEM is 0.


> +               old =3D __this_cpu_read(cpustat_old[i]);
> +               cpustat[stats[i]] =3D get_16bit_precision(cpustat[stats[i=
]]);

IMO make a local called "new" and store the 16-bit precision there.
That's easier to read, gets rid of the cast below, and is probably
more efficient (the compiler doesn't need to upcast the 16-bit value
and store it in a 64-bit memory location). ...oh, or maybe "new" is a
reserved keyword? You could call them "old_stat_16" and "new_stat_16".


> +               utilization =3D 100 * (u16)(cpustat[stats[i]] - old) / sa=
mple_period_ms;

Maybe slightly better to round, with:

utilization =3D DIV_ROUND_UP(100 * (new - old), sample_period_ms);

What do you think?


> +               __this_cpu_write(cpustat_utilization[tail][i], utilizatio=
n);
> +               __this_cpu_write(cpustat_old[i], cpustat[stats[i]]);
> +       }
> +       __this_cpu_write(cpustat_tail, (tail + 1) % NUM_STATS_GROUPS);
> +}
> +
> +static void print_cpustat(void)
> +{
> +       u8 i, j;
> +       u8 tail =3D __this_cpu_read(cpustat_tail);
> +       u64 sample_period_second =3D sample_period;
> +
> +       do_div(sample_period_second, NSEC_PER_SEC);
> +       /*
> +        * We do not want the "watchdog: " prefix on every line,
> +        * hence we use "printk" instead of "pr_crit".
> +        */
> +       printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n=
",
> +               smp_processor_id(), sample_period_second);
> +       for (j =3D STATS_SYSTEM, i =3D tail; j < NUM_STATS_GROUPS;

Here initting "j" to STATS_SYSTEM definitely doesn't make sense. Init to 0.

You could also make your loop easier to understand with just:

for (i =3D 0; i < NUM_STATS_GROUPS; i++) {
  unsigned int group =3D (tail + i) % NUM_STATS_GROUPS;


-Doug

