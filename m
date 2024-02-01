Return-Path: <linux-kernel+bounces-47538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700B844F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B9E1F2A9E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DC171D0;
	Thu,  1 Feb 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yi9+f7Aa"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18E29406
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754233; cv=none; b=PZAOoq9aQc6TVmZHeXgZ64WKMPnTL7AEKL1RLqXKRCzNeZ0pDbyIWQ9IeIxLj62KGoiWycH2hTlP3/lRuA07BbcU8QDOr/pXFh9PDGUeWjjJUQqJl6MAvdcIpWSGO1EISJst2NTc7TYWSP7duusJXQNq4KADtJT8hXMNIlq3TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754233; c=relaxed/simple;
	bh=fF8rm1hx4wC235N7exScTm46j4/jonMqkS1iYE5PP4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrUYcsa6Myu6cYnwr1F1rwJcp2Z1obGwLdg6YRgh9gfTgu1dyNSlGeBFgvtO3SjqvZ0CYFgKJrzPulJViSghqn06dCrYz6UyiAuleKSuftj6lgS1C/DrBf7uw41nz5nuTrN7iqAVaybaUj0SU6eTvc2LPKb4fgt3fRsRGvbpg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yi9+f7Aa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55faa1e3822so504066a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706754229; x=1707359029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGiDYQgkTeYqdaD8zhMTae1aFTjBudh6uzs/TaYxGh4=;
        b=Yi9+f7AacX1wUfoeeYyvPLS03YkFFW/aSbnG3j+DXwcXT2tGp258t90R/Vokh9puLK
         vnBYDG0hxBOhdazsRnxNQYH1DsvdMjyApXcxLHQfmt+Z67J+D5m39L63pgd9O2eMMz5+
         k2+G0H2dpK86m/Y5ENqM/5jJBAm/4DfFm+1Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706754229; x=1707359029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGiDYQgkTeYqdaD8zhMTae1aFTjBudh6uzs/TaYxGh4=;
        b=G6h6oSZua3B/cDyLf/2SSxubt+dbrhsvyVtWjzlUXrk3XKpEXFv91Up97UNDw4cKpG
         OSAgff2Lu3kaQfhFs2HRS3/lHlSgfIGBDZlK87EP2JVmfC4n1FvzS5AaHVgB45pDLJ2C
         YL4V+gF5GcfrR4axQCa3buJCvEBhlqqQs/jG6rt2sEmsRZKiTni1Wqvs2T5wfesEpofk
         5OEiD3+1O8E0QJs8uxA8WPdhHgvjBzJPwu292LSti6ekVkthNmKAmqkFId8k0YW8G5Zu
         9cGGN8Oez+XBpz/2zX4EsUuJk/UG5Ke3P+Ec5WspVhkoxoDAvaEFzAbVbNlocF0mRvg+
         e+ww==
X-Gm-Message-State: AOJu0YxgYe8VTTbiSu5dH70Sqqgr+5Hq1bCoPlvOL0ftt/gCLnWp7auK
	uCK+BAXiLYXGrnfR6D6J8Vfv4Tmg8GqmJNOCwND72ief39hmcx99n7CbiUhZw/dtmSQPyKp1b6a
	z+fuY
X-Google-Smtp-Source: AGHT+IGwTIiDEaVFiaoPjpkLJ+3U6OEu5tOBR6zFYLwQIjoj/eEcktdZGJsmMFa0N9ECGgrLuahWfA==
X-Received: by 2002:a17:907:20b6:b0:a36:58fd:c242 with SMTP id pw22-20020a17090720b600b00a3658fdc242mr2400403ejb.19.1706754228806;
        Wed, 31 Jan 2024 18:23:48 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id vw1-20020a170907a70100b00a35bfc2d570sm3763870ejc.6.2024.01.31.18.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 18:23:48 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso8671a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:23:47 -0800 (PST)
X-Received: by 2002:a50:cd11:0:b0:55f:88de:bb03 with SMTP id
 z17-20020a50cd11000000b0055f88debb03mr121380edi.4.1706754227355; Wed, 31 Jan
 2024 18:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131171738.35496-1-yaoma@linux.alibaba.com> <20240131171738.35496-3-yaoma@linux.alibaba.com>
In-Reply-To: <20240131171738.35496-3-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jan 2024 18:23:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XFWjkvuJmeJjb_OLCPJOtshmr=1A66R_WukHv4FEXr8Q@mail.gmail.com>
Message-ID: <CAD=FV=XFWjkvuJmeJjb_OLCPJOtshmr=1A66R_WukHv4FEXr8Q@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] watchdog/softlockup: report the most frequent interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 31, 2024 at 9:17=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> =
wrote:
>
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> most frequent interrupts could be good enough for further
> troubleshooting.
>
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by comparing the counts of interrupts.
>
> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker=
/9:1:214]
> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
> [ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardI=
RQs:
> [ 2987.491493]  #1: 330985      irq#7(IPI)
> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
> ...
> [ 2987.492728] Call trace:
> [ 2987.492729]  __do_softirq+0xa8/0x364
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  kernel/watchdog.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 046507be4eb5..c4c25f25eae7 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -25,6 +25,9 @@
>  #include <linux/stop_machine.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/math64.h>
> +#include <linux/irq.h>
> +#include <linux/bitops.h>
> +#include <linux/irqdesc.h>

Like in patch #1, don't just jam headers at the end. Put them in a
sensible order.



>  #include <asm/irq_regs.h>
>  #include <linux/kvm_para.h>
> @@ -431,11 +434,15 @@ void touch_softlockup_watchdog_sync(void)
>         __this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
>  }
>
> +static void set_potential_softlockup(unsigned long now, unsigned long to=
uch_ts);
> +
>  static int is_softlockup(unsigned long touch_ts,
>                          unsigned long period_ts,
>                          unsigned long now)
>  {
>         if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_t=
hresh) {
> +               /* Softlockup may occur in the current period */
> +               set_potential_softlockup(now, period_ts);

Something is really confusing to me about the
set_potential_softlockup() and set_potential_softlockup_hardirq()
functions and the comment above this line doesn't help me. From the
comment and the name of the function it sounds like at this point in
the code you've already determined that a softlockup is likely. ...but
I don't think that's the case. At this point in the code all we know
is that the softlockup detector is running, right?

I guess the first thing that would help would be to just get rid of
the set_potential_softlockup() wrapper and just inline here:

if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5))
  set_potential_softlockup_hardirq();

..but then I'd want a comment explaining what that "if" test means.
Maybe something like this (assuming it's correct):

The "sample_period" is set so that we should get called ~5 times
between the start of the softlockup and when it is detected /
reported. If we've already been called twice and it looks like a
softlockup might be occurring, start counting interrupts.

Also: assuming I understand correctly, won't your "time_after_eq()"
always be true as you've written it? Shouldn't it be something like:

if (time_after_eq(now, period_ts + 2 * get_softlockup_thresh() / 5))

..or maybe you don't need this "if" test at all since you're using
"need_record_irq_counts(STATS_HARDIRQ)" here. IMO that should be
pulled out here as well since it makes it more obvious...



>                 /* Warn about unreasonable delays. */
>                 if (time_after(now, period_ts + get_softlockup_thresh()))
>                         return now - touch_ts;
> @@ -462,6 +469,8 @@ static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_=
GROUP]);
>  static DEFINE_PER_CPU(u8, cpustat_utilization[NUM_STATS_GROUPS][NUM_STAT=
S_PER_GROUP]);
>  static DEFINE_PER_CPU(u8, cpustat_tail);
>
> +static void print_hardirq_counts(void);
> +

Rather than predeclaring, can't you just put the functions here?


>  /*
>   * We don't need nanosecond resolution. A granularity of 16ms is
>   * sufficient for our precision, allowing us to use u16 to store
> @@ -516,10 +525,156 @@ static void print_cpustat(void)
>                         __this_cpu_read(cpustat_utilization[i][STATS_HARD=
IRQ]),
>                         __this_cpu_read(cpustat_utilization[i][STATS_IDLE=
]));
>         }
> +       print_hardirq_counts();
> +}
> +
> +#define HARDIRQ_PERCENT_THRESH         50
> +#define NUM_HARDIRQ_REPORT             5
> +static DECLARE_BITMAP(softlockup_hardirq_cpus, CONFIG_NR_CPUS);
> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
> +
> +struct irq_counts {
> +       int irq;
> +       u32 counts;
> +};
> +
> +static void find_counts_top(struct irq_counts *irq_counts, int irq, u32 =
counts, int range)

nit: it's not really "finding" anything. Maybe "tabulate_irq_count" or
something?


> +{
> +       unsigned int i, j;
> +
> +       for (i =3D 0; i < range; i++) {
> +               if (counts > irq_counts[i].counts) {
> +                       for (j =3D range - 1; j > i; j--) {
> +                               irq_counts[j].counts =3D irq_counts[j - 1=
].counts;
> +                               irq_counts[j].irq =3D irq_counts[j - 1].i=
rq;
> +                       }
> +                       irq_counts[j].counts =3D counts;
> +                       irq_counts[j].irq =3D irq;
> +                       break;
> +               }
> +       }

Rather than a double loop, can't you just swap? Untested:

  unsigned int i;
  struct irq_counts new_count =3D { irq, counts };

  for (i =3D 0; i < range; i++) {
    if (count > irq_counts[i].counts)
      swap(new_count, irq_counts[i])
  }


> +}
> +
> +/*
> + * If the proportion of time spent handling irq exceeds HARDIRQ_PERCENT_=
THRESH%
> + * during sample_period, then it is necessary to record the counts of ea=
ch irq.
> + */
> +static inline bool need_record_irq_counts(int type)

Let the compiler decide if this should be inline. No need for the
forced "inline" keyword.

Also: why do you need to pass in the "type". This function only makes
sense for "STATS_HARDIRQ"


> +{
> +       int tail =3D __this_cpu_read(cpustat_tail);
> +       u8 utilization;
> +
> +       if (--tail =3D=3D -1)
> +               tail =3D 4;

Instead of the above:

tail =3D (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;


> +       utilization =3D __this_cpu_read(cpustat_utilization[tail][type]);
> +       return utilization > HARDIRQ_PERCENT_THRESH;
> +}
> +
> +/*
> + * Mark softlockup as potentially caused by hardirq
> + */
> +static void set_potential_softlockup_hardirq(void)
> +{
> +       u32 i;
> +       u32 *counts =3D __this_cpu_read(hardirq_counts);
> +       int cpu =3D smp_processor_id();
> +       struct irq_desc *desc;
> +
> +       if (!need_record_irq_counts(STATS_HARDIRQ))
> +               return;
> +
> +       if (!test_bit(cpu, softlockup_hardirq_cpus)) {
> +               counts =3D kmalloc_array(nr_irqs, sizeof(u32), GFP_ATOMIC=
);

I think "nr_irqs" has the potential to grow at runtime, right? That
means you should read it and store locally how big your array actually
is. Otherwise you could allocate enough space for 64 IRQs, someone
could grow nr_irqs, and you could try looping over 128. Presumably
when you loop over with "for_each_irq_desc" you'd also need to
bounds-check in case someone on a different CPU expanded the number
after you read it...


-Doug

