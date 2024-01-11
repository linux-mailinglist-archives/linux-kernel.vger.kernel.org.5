Return-Path: <linux-kernel+bounces-23947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A688382B44D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB94B23336
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A552F73;
	Thu, 11 Jan 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KA43Xvce"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D551C33
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e80d40a41so7166212e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704995133; x=1705599933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/YiI5NVEfRE8VSXBvWOI4f/yMhO4R3kw/CSrndYtcs=;
        b=KA43Xvce6pL1cQQ/2O65+7pbr5v0WWAaL9ScF9DQzfSKfAVFuDtLklgr6b7TP7cFGn
         oa+CTuCRM8v+raAdouq2C+ISumL3Iu3YZRD8zrVhIHuYm9gTIhLDJRhWQRjKmsx/QmzE
         YP8JemelwwYPgnSh7CqiHhoiJqqpzKK/vYsWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995133; x=1705599933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/YiI5NVEfRE8VSXBvWOI4f/yMhO4R3kw/CSrndYtcs=;
        b=d9pwe3DbcQza5dwdUCAX15qv5nxgBvnl7Ekme9xjuRlEke2rklyTxzILmtG3XR4GsE
         DlIqJB/RAZet1Hwy93lDpfvmouTZ9XVmhvpsnfUPJPbvEraU7x5EuQVNxEdBw223bQrJ
         SHpC6hJHdCmdgEQJK8iQ3ZXbhXgpcbb3dgLMpLBsFMbfzYLEI7u6PZwuWRtLNsLxbbs2
         Ch1v5ZTX9pP98RQql/NR1Im22JYdA1ebqvOkLUda165lDbgY+AJWG1E6S8QtkG2Utxf3
         tk+LJedpVDEht6uaDeY5VYDETq8qFiyizvKvm/VEpLaoNLn2rq1GNu8ocqHoRvhvAwlX
         63VA==
X-Gm-Message-State: AOJu0YwWlMbdyt851JLlZgPePoblNdHBcUV1nRG7EUNWLpuq7u/rE57H
	KenLc2cM71m2+12X0PW5uBqtNUdBs6v1BSW2K+AlKE9oPkCmk4sq
X-Google-Smtp-Source: AGHT+IGZOr5Lkt3D/PWYsnC7mV1gSDXBr9KJfMi8+RQdtrwSrdSdhRvezZ1HEK0yWeFUpY9FLssGIQ==
X-Received: by 2002:ac2:4e91:0:b0:50e:3e3a:3d6e with SMTP id o17-20020ac24e91000000b0050e3e3a3d6emr24073lfr.110.1704995132792;
        Thu, 11 Jan 2024 09:45:32 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n6-20020ac242c6000000b0050eada03298sm258067lfl.44.2024.01.11.09.45.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:45:32 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso6887039e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:45:32 -0800 (PST)
X-Received: by 2002:a05:6512:234f:b0:50e:31fc:ca1e with SMTP id
 p15-20020a056512234f00b0050e31fcca1emr32291lfu.40.1704995131854; Thu, 11 Jan
 2024 09:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com> <ZZ+ixagkxRPYyTCE@vingu-book>
In-Reply-To: <ZZ+ixagkxRPYyTCE@vingu-book>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 09:45:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
Message-ID: <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 00:11, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Could you confirm that cpufreq governor is schedutil and the driver is
> amd-pstate on your system ?

schedutil yes, amd-pstate no. I actually just use acpi_cpufreq

>
> Also I'm interested by the output of the amd_pstate to confirm that it uses the
> adjust_perf callback
>
> I suppose that you don't use uclamp feature and amd doesn't use EAS so that let
> the change of the min parameter of adjust_perf which was probably always 0
> unless you use deadline scheduler and which now takes into account irq pressure.
>
> Could you try the patch below which restores the previous min value ?
>
> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..3fe8ac6ce9cc 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -194,10 +194,11 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
>         unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> +       struct rq *rq = cpu_rq(sg_cpu->cpu);
>
>         util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>         util = max(util, boost);
> -       sg_cpu->bw_min = min;
> +       sg_cpu->bw_min = cpu_bw_dl(rq);
>         sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>  }
>
> @@ -442,7 +443,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
>                 sg_cpu->util = prev_util;
>
> -       cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_min),
>                                    sg_cpu->util, max_cap);
>
>         sg_cpu->sg_policy->last_freq_update_time = time;
> --
> 2.34.1
>
>
> >
> > I'll keep that revert in my private test-tree for now (so that I have
> > a working machine again), but I'll move it to my main branch soon
> > unless somebody has a quick fix for this problem.
> >
> >                 Linus

