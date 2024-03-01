Return-Path: <linux-kernel+bounces-87859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4019286DA09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CFA2855F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421994120B;
	Fri,  1 Mar 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H0z7oJN0"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31340866
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263825; cv=none; b=QwrW5W0uaZDPkux1UGv+3booT/p7Wo4ecfoSpPEg8O8xmmLcy4sqSlgvPuqMa3cG8qK5i+YppUX7QuQcfct8xe3cmS8XkDrvFgtmq+kRXzAnqHVw1frRHB8AWXmkJxrzfAXT2AETvhOpcI/1YNEY/9U3c2QB/hterzF+PaiTyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263825; c=relaxed/simple;
	bh=V9UDJU8PuEPFFocLUcD90wWFc/f/MTfqTYdjPPjvTEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph1Ws1npZgnDu+yzzt2Ljey/910vhhb9bsevE96Q1GnMpFyHqa5bTcXWEcz+CY+EccXGPLGWyddkMTHqZYZeswvrYW7b4B/gbjjVOC8rTgmJPRjVQjdODxZqHaeVvzYYZwfIRnUHKA897PazXFJpStKqILWUA1344ksCHJtUiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H0z7oJN0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1334096a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709263822; x=1709868622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSJ33PAXwdIQj/MBJ1WCh0TwpfR+rYsX3nA6UbI9AWs=;
        b=H0z7oJN0yAzzsADMMzbcoz0pVFnLHoDAdN/OyjA5+x12CMfqq+ZRKWNNae4L+V87fO
         rD0vvz8kxoJpo5TBHlFIvHilcOxw1TrPii8K1ec1M+psBep02h5xyvJGSiJmsQJF2WJP
         XxU8a/Ua3cKw/DbY585R/+HgogKUiC9kTwskL4h3fqGbJvHr0Qux5vlR//5XhpANet83
         aDl5qIEw4vokjNXCWk/81vdeEn4SD2kUrLj7H/LmcjcuLayXvQVUGGaLs/vOe9cnbMP4
         IGZ9x+L+wrXylYPnWsomD+wVBiI2FhWTrnwH/lxmpUwZJAxwUj+uPw/dRMLUOko8gtkj
         cagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709263822; x=1709868622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSJ33PAXwdIQj/MBJ1WCh0TwpfR+rYsX3nA6UbI9AWs=;
        b=Yntpjmu2z2OekoHh2IrqPTLd9RhSF6dbdRI3FgXqn0YTnTwWXt24O4WbEMwyomkxIJ
         o8WKJAXZXq8oVsEXEuTf+/04HPrLlKqBaz/FL01t9aAEMRqhGWSR7sS1vqjA2piXrqqn
         Xb8bTSSjiqgEdXMEgL+I2UEpkkGrd1NQjHNYyjxHkPgqB7Vu4qwUj/9n7NQUawQfD9Xl
         AK71Fg3Bwt+smjz9TuPzrUbbrIJl0GLW5cE3wyax7C/oNB1/NuCrpC/8wbwsldBSMPKZ
         6OuHVyvFqESTuCGhaZTeK8eF20AVf5WmAnuKHUdqYCdq8y6nKC+/mtTu2quCdjju9lsA
         svYQ==
X-Gm-Message-State: AOJu0YzIfVkmAJ60sSLtvxs7oXPXGSRKLukFx4m14Hx+TeUd49tuGtIB
	0XmBKxwZx+5ermEz1ZMYnJMZf6sawNDQW2uTLx94n8NhmpYCj9ahBH+MaQ4h2UE=
X-Google-Smtp-Source: AGHT+IFlEjQ3cgjQLboyYOL6ZF4fIkYg2r9U5vwXCn4UpnRDkG/nNf9tSDZjdWfymCSGq1iEhtP0jA==
X-Received: by 2002:a17:902:7241:b0:1db:be98:e9a with SMTP id c1-20020a170902724100b001dbbe980e9amr447687pll.26.1709263822126;
        Thu, 29 Feb 2024 19:30:22 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b001db40866e09sm2262019pln.260.2024.02.29.19.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 19:30:21 -0800 (PST)
Message-ID: <d0977c14-2837-497b-896b-0a2ad20fb3d5@bytedance.com>
Date: Fri, 1 Mar 2024 11:28:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sched/fair: Fix task migrated to isolated cpus
Content-Language: en-US
To: Zheng Zucheng <zhengzucheng@huawei.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, joshdon@google.com
Cc: linux-kernel@vger.kernel.org
References: <20240301023109.336707-1-zhengzucheng@huawei.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20240301023109.336707-1-zhengzucheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zucheng, thanks for the bugfix. But it has already been addressed
by the following patches in tip/sched/core:

8aeaffef8c6e ("sched/fair: Take the scheduling domain into account in select_idle_smt()")
23d04d8c6b8e ("sched/fair: Take the scheduling domain into account in select_idle_core()")

On 3/1/24 10:31 AM, Zheng Zucheng Wrote:
> On the wakeup path with hyperthreading, select cpu only looks at
> task->cpus_ptr to see if the task can run on the target cpu. If isolcpus
> kernel parameter is set, and isolated cpus will be part of mask
> task->cpus_ptr, tasks were migrated to our isolated cpus.
> 
> Steps to reproduce on my 32-CPU hyperthreads machine:
> 1. with boot parameter: "isolcpus=0,1"
>     (thread lists: 0,16 and 1,17)
> 2. cgcreate -g cpuset:test
>     echo 0-31 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>     echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>     cgexec -g cpuset:test "test_threads"
> 3. some threads will be migrated to the isolated cpu0/1.
> 
> Fix it by checking the valid domain mask in select_idle_smt() and
> select_idle_core()
> 
> Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
> Cc: stable@vger.kernel.org # v5.12+
> Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
> ---
>   kernel/sched/fair.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..e6552c77e0f1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7289,7 +7289,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>   		if (!available_idle_cpu(cpu)) {
>   			idle = false;
>   			if (*idle_cpu == -1) {
> -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
>   					*idle_cpu = cpu;
>   					break;
>   				}
> @@ -7297,7 +7297,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>   			}
>   			break;
>   		}
> -		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> +		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
>   			*idle_cpu = cpu;
>   	}
>   
> @@ -7311,12 +7311,12 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>   /*
>    * Scan the local SMT mask for idle CPUs.
>    */
> -static int select_idle_smt(struct task_struct *p, int target)
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>   {
>   	int cpu;
>   
>   	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
> -		if (cpu == target)
> +		if (cpu == target || !cpumask_test_cpu(cpu, sched_domain_span(sd)))
>   			continue;
>   		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>   			return cpu;
> @@ -7341,7 +7341,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>   	return __select_idle_cpu(core, p);
>   }
>   
> -static inline int select_idle_smt(struct task_struct *p, int target)
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>   {
>   	return -1;
>   }
> @@ -7591,7 +7591,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   		has_idle_core = test_idle_cores(target);
>   
>   		if (!has_idle_core && cpus_share_cache(prev, target)) {
> -			i = select_idle_smt(p, prev);
> +			i = select_idle_smt(p, sd, prev);
>   			if ((unsigned int)i < nr_cpumask_bits)
>   				return i;
>   		}

