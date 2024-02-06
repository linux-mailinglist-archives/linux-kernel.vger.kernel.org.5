Return-Path: <linux-kernel+bounces-55640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8184BF5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9028834A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8911B95A;
	Tue,  6 Feb 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JOtPm8AQ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C11B949
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255721; cv=none; b=mMzqJw+gOJ45Q/YMnaGxXfKaBRVJ7Y8wY4utZBqbuVUyXwIwcTsrSi29cqIpWxsjCgpL97TpzlL+TVMgWQ3oSQkcZxBKIv8BL+xmsshRhEk9J+D/MNSFIAIeLhFIKDfHjPYWSqd0ck+An3aZyT2nDo3TO/mlavrZa7U2+nGJXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255721; c=relaxed/simple;
	bh=NbB3Ko8kuYd6dBRFM/prvtAfN4ZYsgWRLM2XWmLJmSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYyFd7skyvtrcwdUqfiMfXTBejDPyk4bWt1zEuGboCyPhdvSPO+NM4/tieXPi7J4+enMvXYaOQZTbVyQKa/qoa6brOac0dP39PfXunaB2hN/IUhKHfuqbIbciJ2BkA3Iadt9SeDqGIHTFp7Iu9cnim9qo7H+ZMwNGB0pzSS/arE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JOtPm8AQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0aabed735so18508161fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707255716; x=1707860516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4NFsgHfx0ZYyVUKp4J+0H9H+3ZFIE+ig3GjqGFu/Ns=;
        b=JOtPm8AQv+J+ONdUQHJcekW/DA3UiOcxLKHfYFfsGEgwdFskvpnRnONSyilVFcrDYW
         R12pQBqU+1nVX+pIUzqD8UABWAbfSGR2nKuN9mOiNjF5hKCujtPsJp6YU/0H3y5FYQXI
         5mHOkHkTgaPSZwtke3Bqba/ikqwHjMzlSP/H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255716; x=1707860516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4NFsgHfx0ZYyVUKp4J+0H9H+3ZFIE+ig3GjqGFu/Ns=;
        b=nZXyg8IS7MlsVNAlO0hN1Z5jc0NV9yMBZxaxUVVcd5cBazZWE6QJPzt8riYTaIJ9I+
         GU5zbqWbv84VIz60ec8Q0MlGgKvtv+QzcAIm8Y98+971jGhbNAYbhxnxTmAGpJT/CKok
         v09YiiWOecECSeknHo+kO0ZMqJhcqJ6J0LkGAHKO1lvFphByEYVWfl5MR1/sbActvvRO
         bqnhdLZqD6+xJ0BITvYDrwHajBfc7DXClR5U3/ij7p861ZymziHsAy+3FSci+zCf+x+q
         1+7DQhZUbcSGt+Hafuq+C81/ssTELGzPowKRNhC9hb3o3yaOGqxQcdBV9Iur75IQG+DI
         AHdg==
X-Forwarded-Encrypted: i=1; AJvYcCWi7p10umO+LwqFIk8d+J6FfCxCTgG4nAPf5eDP25RO3YZCYeVc3mzhfaUOWxFSLf+aoUZsG+SrjeCAUkgxMVifmW+VCsP3xBkdwBok
X-Gm-Message-State: AOJu0Yx8H45LKBbpXqNW1u8XBtoNyLXcncyH0npSLObPothbey4LoYRb
	X2hYfHFFlnEWDdgXv342jPbhNiDXoGXro/Esij3Y4HKak1KD9GRYHXdiC+6IPyiw5brWPrHDULn
	cWw==
X-Google-Smtp-Source: AGHT+IGwYhQ6RZAT3rbpuh5M0T6xoH6eTheZHlhhG6xkVdqC9laJ6ibTmyuvfdxnl+CB/Whbh9xvvQ==
X-Received: by 2002:a05:6512:12c9:b0:511:54a8:3adb with SMTP id p9-20020a05651212c900b0051154a83adbmr3890527lfg.2.1707255715677;
        Tue, 06 Feb 2024 13:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrR1YFjxgPJ2lNhkuywwr18St69D6oc2YkHhU4ISwEMCiTcKmlR71c0fWdxgl9RfYNd7aNPWrNgHHENXVMFXp/37blqbs6hM6oi4AT
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906134f00b00a372b38380csm1610363ejb.13.2024.02.06.13.41.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 13:41:55 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so21305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:41:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzW/9So4nuNlvoqSTToLkyalKdeH5LuwUlYCxUZTLIunFc6U06URIWE/9Kg9iN1CV6lGa5PRyfVgpvsmgXAX5FGX5QSSma4p6RqeFZ
X-Received: by 2002:a05:600c:3d89:b0:40f:f069:6bd6 with SMTP id
 bi9-20020a05600c3d8900b0040ff0696bd6mr59076wmb.0.1707255713986; Tue, 06 Feb
 2024 13:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206095902.56406-1-yaoma@linux.alibaba.com> <20240206095902.56406-2-yaoma@linux.alibaba.com>
In-Reply-To: <20240206095902.56406-2-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2024 13:41:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+mcBdeq8mmH0h41byUtL-G1zFmZQtj341ubwqyPxD1A@mail.gmail.com>
Message-ID: <CAD=FV=V+mcBdeq8mmH0h41byUtL-G1zFmZQtj341ubwqyPxD1A@mail.gmail.com>
Subject: Re: [PATCHv5 1/3] watchdog/softlockup: low-overhead detection of interrupt
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 6, 2024 at 1:59=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> w=
rote:
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
>  kernel/watchdog.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

On v4 you got Liu Song's Reviewed-by and I don't think this is
massively different than v4. I would have expected you to carry the
tag forward. In any case ,I guess Liu Song can give it again...


> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 81a8862295d6..71d5b6dfa358 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -16,6 +16,8 @@
>  #include <linux/cpu.h>
>  #include <linux/nmi.h>
>  #include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/sysctl.h>
>  #include <linux/tick.h>
> @@ -333,6 +335,90 @@ __setup("watchdog_thresh=3D", watchdog_thresh_setup)=
;
>
>  static void __lockup_detector_cleanup(void);
>
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +#define NUM_STATS_GROUPS       5
> +#define NUM_STATS_PER_GROUP    4
> +enum stats_per_group {
> +       STATS_SYSTEM,
> +       STATS_SOFTIRQ,
> +       STATS_HARDIRQ,
> +       STATS_IDLE,

nit: I still would have left "NUM_STATS_PER_GROUP" here instead of as
a separate #define.


> +static void print_cpustat(void)
> +{
> +       int i, group;
> +       u8 tail =3D __this_cpu_read(cpustat_tail);

Sorry for not noticing before, but why are you using
"__this_cpu_read()" instead of "this_cpu_read()"? In other words, why
do you need the double-underscore version everywhere? I don't think
you do, do you?


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
> +       for (i =3D 0; i < NUM_STATS_GROUPS; i++) {
> +               group =3D (tail + i) % NUM_STATS_GROUPS;
> +               printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
> +                       "%3u%% hardirq,\t%3u%% idle\n", i+1,

nit: though I don't care too much in this case, I think kernel folks
slightly prefer "i + 1" instead of "i+1". Running
"./scripts/checkpatch.pl --strict" will give a warning about this, for
instance. Actually, "./scripts/checkpatch.pl --strict" has a few extra
style nits that you could consider fixing.


> +static void report_cpu_status(void)
> +{
> +       print_cpustat();
> +}

I don't understand why you need the extra wrapper. You didn't have it
on v3 and I don't see any reason why you introduced it. Ah, I see, in
the next patch you add something to it. OK, I guess it's fine to
introduce it here.

-Doug

