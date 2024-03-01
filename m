Return-Path: <linux-kernel+bounces-87852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B19586D9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB40284603
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE63FE55;
	Fri,  1 Mar 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9oMEgeO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE7405DB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262715; cv=none; b=aXLqoY5jYItTJ54a63+6ZcsQX6s2bn6fKTQTUQ6j1GlVa03GhV5SjPboqvVTMPVTuerw2lrvPc+7W/WZITL5oY+U3HvsuyWB9GautrUQYCyEGkgZ1T/qXN6A2g17JL2BazSSiivKY7r5ADLdpvSmUkMJD/HCncwymEKxnWil+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262715; c=relaxed/simple;
	bh=X8XQ+jk9if64gn0rjs+A4Ly/wmqU6bEZfB6Q3IM4qQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2UnI+6C+eRQRgoz2h+Ww3/SDlUStDmfEYR++q3npUIZwvArkF6KXDzEVC2f6mA/AMaKbBeVIwKidFHdr6OJoiFqfSc2lADxXUOLzL6itkvKOJiuUC54mzNYTMyPQLs5DuW0RF92eV1nG2eoW0g76XPLYQL2H3xZQ88TmH41AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9oMEgeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709262712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcGwgdBJper5AgTECd8GeyqmYr9HUHlBPRBmogKlLAs=;
	b=E9oMEgeOkfFsyfMHn1UY8itwkQbpuaVUWGvEbP2ia0zrfS6KQ2OedWE0Ltu9i0FiEoOfhf
	M8GB1cNOYgIxK3HxrAQLgLqGYeDk5RVuRud563oIcPiXeFFNfQzn0FKHwzB1PRwNRtORcN
	eMIR6UdnldaSDpXX4/u8C5e6HBARiU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PFj_ZmfcPS6iYvoH3XQDAg-1; Thu, 29 Feb 2024 22:11:47 -0500
X-MC-Unique: PFj_ZmfcPS6iYvoH3XQDAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78B5085970A;
	Fri,  1 Mar 2024 03:11:47 +0000 (UTC)
Received: from [10.22.8.117] (unknown [10.22.8.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5C3840153A7;
	Fri,  1 Mar 2024 03:11:46 +0000 (UTC)
Message-ID: <88916bbe-1de6-4845-acb2-624668581fa2@redhat.com>
Date: Thu, 29 Feb 2024 22:11:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpuset: remove /proc/PID/cpuset
Content-Language: en-US
To: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org
References: <20240202104911.125894-1-brookxu.cn@gmail.com>
 <d9dcd170-0ceb-489b-8df3-3fe35e9b4251@redhat.com>
 <CADtkEefJCbijj7eS+L3kcMCBtHqze3oMkX4yXbfoJG1mT3YkQw@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CADtkEefJCbijj7eS+L3kcMCBtHqze3oMkX4yXbfoJG1mT3YkQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 2/29/24 21:43, 许春光 wrote:
> Hi waiman:
>
> Thanks for analyse in detail, we found some guy use /proc/PID/cpuset
> to get the path and cause a live issue.

Just remember that in cgroup v2, /proc/PID/cpuset may not give you the 
actual cgroup the process is in. It just give you the cgroup where the 
corresponding cpuset setting will apply to that "PID" process.

Cheers,
Longman

>
> Thanks.
>
> Waiman Long <longman@redhat.com> 于2024年2月10日周六 12:34写道：
>> On 2/2/24 05:49, brookxu.cn wrote:
>>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>>
>>> Now we can get all cgroup paths from /proc/PID/cgroup for
>>> a long time, so it maybe useless to keep /proc/PID/cpuset,
>>> besides the path get from /proc/PID/cpuset is not consistent
>>> with /proc/PID/cgroup in default hierarchy, so now we may
>>> can safely remove /proc/PID/cpuset to avoid the mismatch.
>> With cgroup v2, the value of /proc/PID/cgroup may not match
>> /proc/PID/cpuset. That is the expected behavior due to the way cgroup v2
>> works. For example,
>>
>> Root [CS] --> A [CS] --> B --> C where [CS] means cpuset controller is
>> enabled at that cgroup.
>>
>> If a process P is in cgroup C, /proc/PID/cgroup will show /A/B/C.
>> However, /proc/PID/cpuset will show /A because it is where the cpuset
>> controller setting will apply to process P. Also removing an existing
>> procfs file may break an existing application that relies on it. So we
>> don't do that unless there is a strong reason to do so.
>>
>> NAK
>>
>>> root@test:~# cat /proc/1186/cgroup
>>> 0::/system.slice/lmeter.service
>>>
>>> root@test:~# cat /proc/1186/cpuset
>>> /system.slice
>>>
>>> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
>>> ---
>>>    arch/mips/configs/sb1250_swarm_defconfig |  1 -
>>>    arch/sh/configs/sdk7786_defconfig        |  1 -
>>>    arch/sh/configs/urquell_defconfig        |  1 -
>>>    fs/proc/base.c                           |  6 ----
>>>    kernel/cgroup/cpuset.c                   | 40 ------------------------
>>>    5 files changed, 49 deletions(-)
>>>
>>> diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
>>> index ce855b644bb0..2fbea9c604df 100644
>>> --- a/arch/mips/configs/sb1250_swarm_defconfig
>>> +++ b/arch/mips/configs/sb1250_swarm_defconfig
>>> @@ -3,7 +3,6 @@ CONFIG_HIGH_RES_TIMERS=y
>>>    CONFIG_LOG_BUF_SHIFT=15
>>>    CONFIG_CGROUPS=y
>>>    CONFIG_CPUSETS=y
>>> -# CONFIG_PROC_PID_CPUSET is not set
>>>    CONFIG_CGROUP_CPUACCT=y
>>>    CONFIG_NAMESPACES=y
>>>    CONFIG_RELAY=y
>>> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
>>> index 7b427c17fbfe..6fe340d4860c 100644
>>> --- a/arch/sh/configs/sdk7786_defconfig
>>> +++ b/arch/sh/configs/sdk7786_defconfig
>>> @@ -13,7 +13,6 @@ CONFIG_CGROUP_DEBUG=y
>>>    CONFIG_CGROUP_FREEZER=y
>>>    CONFIG_CGROUP_DEVICE=y
>>>    CONFIG_CPUSETS=y
>>> -# CONFIG_PROC_PID_CPUSET is not set
>>>    CONFIG_CGROUP_CPUACCT=y
>>>    CONFIG_CGROUP_MEMCG=y
>>>    CONFIG_CGROUP_SCHED=y
>>> diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
>>> index 445bb451a5ec..c960221a0549 100644
>>> --- a/arch/sh/configs/urquell_defconfig
>>> +++ b/arch/sh/configs/urquell_defconfig
>>> @@ -11,7 +11,6 @@ CONFIG_CGROUP_DEBUG=y
>>>    CONFIG_CGROUP_FREEZER=y
>>>    CONFIG_CGROUP_DEVICE=y
>>>    CONFIG_CPUSETS=y
>>> -# CONFIG_PROC_PID_CPUSET is not set
>>>    CONFIG_CGROUP_CPUACCT=y
>>>    CONFIG_CGROUP_MEMCG=y
>>>    CONFIG_CGROUP_SCHED=y
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index 98a031ac2648..8dcd23b9212a 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -3309,9 +3309,6 @@ static const struct pid_entry tgid_base_stuff[] = {
>>>    #ifdef CONFIG_LATENCYTOP
>>>        REG("latency",  S_IRUGO, proc_lstats_operations),
>>>    #endif
>>> -#ifdef CONFIG_PROC_PID_CPUSET
>>> -     ONE("cpuset",     S_IRUGO, proc_cpuset_show),
>>> -#endif
>>>    #ifdef CONFIG_CGROUPS
>>>        ONE("cgroup",  S_IRUGO, proc_cgroup_show),
>>>    #endif
>>> @@ -3658,9 +3655,6 @@ static const struct pid_entry tid_base_stuff[] = {
>>>    #ifdef CONFIG_LATENCYTOP
>>>        REG("latency",  S_IRUGO, proc_lstats_operations),
>>>    #endif
>>> -#ifdef CONFIG_PROC_PID_CPUSET
>>> -     ONE("cpuset",    S_IRUGO, proc_cpuset_show),
>>> -#endif
>>>    #ifdef CONFIG_CGROUPS
>>>        ONE("cgroup",  S_IRUGO, proc_cgroup_show),
>>>    #endif
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index ba36c073304a..908cd7e6efa8 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -5066,46 +5066,6 @@ void __cpuset_memory_pressure_bump(void)
>>>        rcu_read_unlock();
>>>    }
>>>
>>> -#ifdef CONFIG_PROC_PID_CPUSET
>>> -/*
>>> - * proc_cpuset_show()
>>> - *  - Print tasks cpuset path into seq_file.
>>> - *  - Used for /proc/<pid>/cpuset.
>>> - *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
>>> - *    doesn't really matter if tsk->cpuset changes after we read it,
>>> - *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
>>> - *    anyway.
>>> - */
>>> -int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>>> -                  struct pid *pid, struct task_struct *tsk)
>>> -{
>>> -     char *buf;
>>> -     struct cgroup_subsys_state *css;
>>> -     int retval;
>>> -
>>> -     retval = -ENOMEM;
>>> -     buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>> -     if (!buf)
>>> -             goto out;
>>> -
>>> -     css = task_get_css(tsk, cpuset_cgrp_id);
>>> -     retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>> -                             current->nsproxy->cgroup_ns);
>>> -     css_put(css);
>>> -     if (retval == -E2BIG)
>>> -             retval = -ENAMETOOLONG;
>>> -     if (retval < 0)
>>> -             goto out_free;
>>> -     seq_puts(m, buf);
>>> -     seq_putc(m, '\n');
>>> -     retval = 0;
>>> -out_free:
>>> -     kfree(buf);
>>> -out:
>>> -     return retval;
>>> -}
>>> -#endif /* CONFIG_PROC_PID_CPUSET */
>>> -
>>>    /* Display task mems_allowed in /proc/<pid>/status file. */
>>>    void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
>>>    {


