Return-Path: <linux-kernel+bounces-60279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724A85028A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DCB284542
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB5365;
	Sat, 10 Feb 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKhN3aTB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7A63B3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707539696; cv=none; b=VvYsvXoZDzn6I24VkKR2pQHowLNYgBOrLhLjMUp+Z7fTCQp99X0SCIvEh5IwH3ZzHEgT4QgKiHnOsA0q9s4DonEEl4l1AOw0niTElgUYD5jds/y3SvRvP38Nw/l8o0Fg6V1xcCoBHqQ148qHvdawefKV3qsZhOA1OBfGxGhgoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707539696; c=relaxed/simple;
	bh=r6NZQy3N5FK16vfqUw5bwcHS3CDXs3bukP2Aa5ka1KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7A+0GEw66y0vaWWpGhnBOJ2d6fldhi39PgtlyzEHWTlB0iAL9ERs3lJuvqWAeH6I9FUkkyk9wbdysAPXnUI34f9dbGgg1q4ZHqRyOygDHz2m4nqjD8rKiv39KrkTnG1CD0CLeZPIkfFFOCZQAa95M8s35CodWW3AlXphr/bCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKhN3aTB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707539693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm8tCy68hH/xREkEUNBVR5nya6VJXsgdgWwuPK8/8xM=;
	b=hKhN3aTBi7JES1qMbn2AeTw1iliP0pt4/azdTvhFAG8KG09jyP4FGXixnY3o9EGU+ZdLY5
	P7BznXeYYPAM40KJpUUz+VTImjHUB1b6ktHcQfSFdU/gUIRuIb1eWBm77wV+adz/ONSLiD
	sE1Oh3I8koyds8ddUbGzpP04mY/x6UU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-LLn9tBkQNDCWhSZzkMGhKw-1; Fri,
 09 Feb 2024 23:34:49 -0500
X-MC-Unique: LLn9tBkQNDCWhSZzkMGhKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB7453C0C131;
	Sat, 10 Feb 2024 04:34:48 +0000 (UTC)
Received: from [10.22.17.112] (unknown [10.22.17.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8D31C14B0B;
	Sat, 10 Feb 2024 04:34:48 +0000 (UTC)
Message-ID: <d9dcd170-0ceb-489b-8df3-3fe35e9b4251@redhat.com>
Date: Fri, 9 Feb 2024 23:34:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpuset: remove /proc/PID/cpuset
Content-Language: en-US
To: "brookxu.cn" <brookxu.cn@gmail.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org
References: <20240202104911.125894-1-brookxu.cn@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240202104911.125894-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 2/2/24 05:49, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> Now we can get all cgroup paths from /proc/PID/cgroup for
> a long time, so it maybe useless to keep /proc/PID/cpuset,
> besides the path get from /proc/PID/cpuset is not consistent
> with /proc/PID/cgroup in default hierarchy, so now we may
> can safely remove /proc/PID/cpuset to avoid the mismatch.

With cgroup v2, the value of /proc/PID/cgroup may not match 
/proc/PID/cpuset. That is the expected behavior due to the way cgroup v2 
works. For example,

Root [CS] --> A [CS] --> B --> C where [CS] means cpuset controller is 
enabled at that cgroup.

If a process P is in cgroup C, /proc/PID/cgroup will show /A/B/C. 
However, /proc/PID/cpuset will show /A because it is where the cpuset 
controller setting will apply to process P. Also removing an existing 
procfs file may break an existing application that relies on it. So we 
don't do that unless there is a strong reason to do so.

NAK

>
> root@test:~# cat /proc/1186/cgroup
> 0::/system.slice/lmeter.service
>
> root@test:~# cat /proc/1186/cpuset
> /system.slice
>
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> ---
>   arch/mips/configs/sb1250_swarm_defconfig |  1 -
>   arch/sh/configs/sdk7786_defconfig        |  1 -
>   arch/sh/configs/urquell_defconfig        |  1 -
>   fs/proc/base.c                           |  6 ----
>   kernel/cgroup/cpuset.c                   | 40 ------------------------
>   5 files changed, 49 deletions(-)
>
> diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
> index ce855b644bb0..2fbea9c604df 100644
> --- a/arch/mips/configs/sb1250_swarm_defconfig
> +++ b/arch/mips/configs/sb1250_swarm_defconfig
> @@ -3,7 +3,6 @@ CONFIG_HIGH_RES_TIMERS=y
>   CONFIG_LOG_BUF_SHIFT=15
>   CONFIG_CGROUPS=y
>   CONFIG_CPUSETS=y
> -# CONFIG_PROC_PID_CPUSET is not set
>   CONFIG_CGROUP_CPUACCT=y
>   CONFIG_NAMESPACES=y
>   CONFIG_RELAY=y
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
> index 7b427c17fbfe..6fe340d4860c 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -13,7 +13,6 @@ CONFIG_CGROUP_DEBUG=y
>   CONFIG_CGROUP_FREEZER=y
>   CONFIG_CGROUP_DEVICE=y
>   CONFIG_CPUSETS=y
> -# CONFIG_PROC_PID_CPUSET is not set
>   CONFIG_CGROUP_CPUACCT=y
>   CONFIG_CGROUP_MEMCG=y
>   CONFIG_CGROUP_SCHED=y
> diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
> index 445bb451a5ec..c960221a0549 100644
> --- a/arch/sh/configs/urquell_defconfig
> +++ b/arch/sh/configs/urquell_defconfig
> @@ -11,7 +11,6 @@ CONFIG_CGROUP_DEBUG=y
>   CONFIG_CGROUP_FREEZER=y
>   CONFIG_CGROUP_DEVICE=y
>   CONFIG_CPUSETS=y
> -# CONFIG_PROC_PID_CPUSET is not set
>   CONFIG_CGROUP_CPUACCT=y
>   CONFIG_CGROUP_MEMCG=y
>   CONFIG_CGROUP_SCHED=y
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 98a031ac2648..8dcd23b9212a 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3309,9 +3309,6 @@ static const struct pid_entry tgid_base_stuff[] = {
>   #ifdef CONFIG_LATENCYTOP
>   	REG("latency",  S_IRUGO, proc_lstats_operations),
>   #endif
> -#ifdef CONFIG_PROC_PID_CPUSET
> -	ONE("cpuset",     S_IRUGO, proc_cpuset_show),
> -#endif
>   #ifdef CONFIG_CGROUPS
>   	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
>   #endif
> @@ -3658,9 +3655,6 @@ static const struct pid_entry tid_base_stuff[] = {
>   #ifdef CONFIG_LATENCYTOP
>   	REG("latency",  S_IRUGO, proc_lstats_operations),
>   #endif
> -#ifdef CONFIG_PROC_PID_CPUSET
> -	ONE("cpuset",    S_IRUGO, proc_cpuset_show),
> -#endif
>   #ifdef CONFIG_CGROUPS
>   	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
>   #endif
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ba36c073304a..908cd7e6efa8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -5066,46 +5066,6 @@ void __cpuset_memory_pressure_bump(void)
>   	rcu_read_unlock();
>   }
>   
> -#ifdef CONFIG_PROC_PID_CPUSET
> -/*
> - * proc_cpuset_show()
> - *  - Print tasks cpuset path into seq_file.
> - *  - Used for /proc/<pid>/cpuset.
> - *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
> - *    doesn't really matter if tsk->cpuset changes after we read it,
> - *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
> - *    anyway.
> - */
> -int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
> -		     struct pid *pid, struct task_struct *tsk)
> -{
> -	char *buf;
> -	struct cgroup_subsys_state *css;
> -	int retval;
> -
> -	retval = -ENOMEM;
> -	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> -	if (!buf)
> -		goto out;
> -
> -	css = task_get_css(tsk, cpuset_cgrp_id);
> -	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
> -				current->nsproxy->cgroup_ns);
> -	css_put(css);
> -	if (retval == -E2BIG)
> -		retval = -ENAMETOOLONG;
> -	if (retval < 0)
> -		goto out_free;
> -	seq_puts(m, buf);
> -	seq_putc(m, '\n');
> -	retval = 0;
> -out_free:
> -	kfree(buf);
> -out:
> -	return retval;
> -}
> -#endif /* CONFIG_PROC_PID_CPUSET */
> -
>   /* Display task mems_allowed in /proc/<pid>/status file. */
>   void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
>   {


