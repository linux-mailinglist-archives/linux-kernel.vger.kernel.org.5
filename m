Return-Path: <linux-kernel+bounces-59376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A284A84F610
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A934B233F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF54383BD;
	Fri,  9 Feb 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EVLsxpc3"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186F36B1A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485735; cv=none; b=De67jKW90k7pTudEAigEydYzQj4aNECDbrGQCmD2XiUsHiWBiyyMYxlabsIHKi3MOmiTEyrnW3w0ynWdQHDyfggjlAY2oCunsZBefiwqaLOBiRropcw/7G47rG3x3nefCLUAwuJTIiRC8Cr9C1hKi2tQhE2qa+KGyodabTQMKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485735; c=relaxed/simple;
	bh=dt9m9H2DRW05eyF8R8+WGFp5UfGYaHRVdh2uDT3OeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqQcljrjx4lZlnKWchiqyi8XFMmcp2FcB3kz6Jygtk77Qp1qR5Kckyw4cOIExeXYOE7sjLm/GknpTFAtZb2ly5c6KW9UHTzMNVRyNFPinj6TVTo8a/Yu7QOmHUVZWfIye7J9Van15mVwPEPRmhBoai89KoiAok6LFkbseQ0xgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EVLsxpc3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so129490166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707485730; x=1708090530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XVyl43zesoomQ88MtJroVLddAINUcyBQuMjqSxAYLXI=;
        b=EVLsxpc38Pp4bgUQxxQA2WrWEnDQ9Hsb8WS9hFyOzsJrXBkaq0w4NGDQjOiDfviWZk
         CzmpMhqiCLUYn9lh2SEyZuaSL+Nv9i3AeSqMGDZy/jqDV7oh2FQ2vArQ4MIL9Uf5LuFP
         hU9JI0Wv/jvifYn/Hvl65AI4I2msLfaH0qfx0i26IpdriIuVglHltVNoNTthyLYHY42H
         52dbLWUV1vAieHrQhc99/ZpxqiE2XEpfNVzY1qZsvdfxyTQ4TEBNQs/SaCHc6UptEWCu
         jx8Z1LEGcQxVZr4KuSFI6XPFxvG8CxW5MQfqUj1f2mlLvsT4nqzueP+hz6l/UXnb2QFf
         fSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485730; x=1708090530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVyl43zesoomQ88MtJroVLddAINUcyBQuMjqSxAYLXI=;
        b=L4IId+b4adqJXlvqvZV4tLx0/p1YujgpEzpfdUSnlqB/XFujSMJoUvvsUNiXvDwaga
         Odmxen1d7udPGR5/LR8lUAGL6bvXuny4xibRPCgjTZW5lotJJpQjdGwUWXVzGyuc7S48
         y2YwUo3I5o6wcoS2hhzCEvuAOxzg29GVk9cA9dnZe/hL9G7thgSrCk0QhmvXhAN2ilYb
         CrcUG2SbkA4O+Nrjl7g79eeqNMcwymqIgcIOBwJPvTlOfE9icYQLTnHvfRG1Rmk8WJL1
         jedUuItNbJVGtE49DOA4HbKxgmlbYMleo/xotkyBe3uOWOCMbVfN7voOLEW75LzTtXm6
         xtKg==
X-Gm-Message-State: AOJu0YzcOV1tTLMDKdURKsdgfufSfmJhtElMtSO9n8xmfgGWmlgS+NbF
	4s/XFgGcs+5bnjQpgDO29p+DAgameRjS4iiDXbFKV9QFF8wPv/2v4ABGH8jMsYg=
X-Google-Smtp-Source: AGHT+IFdeaMUVDJjwVRlbNscJ26z7/Y8PIhI6TxMtgwTpZzHCit5+rnQB5n2ZbiyKU4OD/j4swoANg==
X-Received: by 2002:a17:906:2491:b0:a3c:d92:8ec4 with SMTP id e17-20020a170906249100b00a3c0d928ec4mr139704ejb.45.1707485730617;
        Fri, 09 Feb 2024 05:35:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEEbySux81R7VE440MdrwX1W6jrbbsUwjIW0xMho+6rOQlMINrrc8mBCLCKO20PVS+zGF31t4VpcppxgUX911ZyjqNmE5jW9DWiZlLuqdwzTxw3dyQQKXmXsNfSfSZKrME0uLuxWYICm1IyUeCDj6TAg+9OyAAFP+i6Aj5riha6aozPgJw6/PoCIgg/+nt8vJiAZb7fLMFmA==
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b00a3af8158bd7sm766756ejf.67.2024.02.09.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:35:30 -0800 (PST)
Date: Fri, 9 Feb 2024 14:35:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: dianders@chromium.org, akpm@linux-foundation.org, kernelfans@gmail.com,
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 1/2] watchdog/softlockup: low-overhead detection of
 interrupt
Message-ID: <ZcYqIOR17BHJyHbx@alley>
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-2-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208125426.70511-2-yaoma@linux.alibaba.com>

Hi,

I am sorry for jouning this game so late. But honestly, it went
forward too quickly. A good practice is to wait a week before
sending new version so that you give a chance more people
to provide some feedback.

The only exception might be when you know exactly who could
review it because the area in not interesting for anyone else.
But this is typicall not the case for kernel core code.


On Thu 2024-02-08 20:54:25, Bitao Hu wrote:
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
> Therefore，I think it is necessary to report CPU utilization during the
> softlockup_thresh period (report once every sample_period, for a total
> of 5 reportings), like this:
>   watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>   CPU#28 Utilization every 4s during lockup:
>     #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #5: 0% system, 0% softirq, 100% hardirq, 0% idle

I like this. IMHO, it might be really useful.

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -333,6 +335,92 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
>  
>  static void __lockup_detector_cleanup(void);
>  
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
> +#define NUM_STATS_GROUPS	5

It would be nice to synchronize this with the hardcoded 5 in:

static void set_sample_period(void)
{
	/*
	 * convert watchdog_thresh from seconds to ns
	 * the divide by 5 is to give hrtimer several chances (two
	 * or three with the current relation between the soft
	 * and hard thresholds) to increment before the
	 * hardlockup detector generates a warning
	 */
	sample_period = get_softlockup_thresh() * ((u64)NSEC_PER_SEC / 5);

For exmaple, define and use the following in both situations:

#define NUM_SAMPLE_PERIODS	5

> +enum stats_per_group {
> +	STATS_SYSTEM,
> +	STATS_SOFTIRQ,
> +	STATS_HARDIRQ,
> +	STATS_IDLE,
> +	NUM_STATS_PER_GROUP,
> +};
> +
> +static const enum cpu_usage_stat tracked_stats[NUM_STATS_PER_GROUP] = {
> +	CPUTIME_SYSTEM,
> +	CPUTIME_SOFTIRQ,
> +	CPUTIME_IRQ,
> +	CPUTIME_IDLE,
> +};
> +
> +static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
> +static DEFINE_PER_CPU(u8, cpustat_util[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
> +static DEFINE_PER_CPU(u8, cpustat_tail);
> +
> +/*
> + * We don't need nanosecond resolution. A granularity of 16ms is
> + * sufficient for our precision, allowing us to use u16 to store
> + * cpustats, which will roll over roughly every ~1000 seconds.
> + * 2^24 ~= 16 * 10^6
> + */
> +static u16 get_16bit_precision(u64 data_ns)
> +{
> +	return data_ns >> 24LL; /* 2^24ns ~= 16.8ms */

I would personally use

    delta_ns >> 20  /* 2^20ns ~= 1ms */

to make it easier for debugging by a human. It would support
the sample period up to 65s which might be enough.

But I do not resirt on it. ">> 24" provides less granularity
but it supports longer sample periods.

> +static void print_cpustat(void)
> +{
> +	int i, group;
> +	u8 tail = __this_cpu_read(cpustat_tail);
> +	u64 sample_period_second = sample_period;
> +
> +	do_div(sample_period_second, NSEC_PER_SEC);
> +	/*
> +	 * We do not want the "watchdog: " prefix on every line,
> +	 * hence we use "printk" instead of "pr_crit".
> +	 */
> +	printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
> +	       smp_processor_id(), sample_period_second);
> +	for (i = 0; i < NUM_STATS_GROUPS; i++) {

This starts with the 1st group in the array. Is it the oldest one?
It should take into account cpustat_tail.


> +		group = (tail + i) % NUM_STATS_GROUPS;
> +		printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
> +			"%3u%% hardirq,\t%3u%% idle\n", i + 1,
> +			__this_cpu_read(cpustat_util[group][STATS_SYSTEM]),
> +			__this_cpu_read(cpustat_util[group][STATS_SOFTIRQ]),
> +			__this_cpu_read(cpustat_util[group][STATS_HARDIRQ]),
> +			__this_cpu_read(cpustat_util[group][STATS_IDLE]));
> +	}
> +}
> +

Best Regards,
Petr

