Return-Path: <linux-kernel+bounces-67090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819E856623
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF89B1F25264
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23405132479;
	Thu, 15 Feb 2024 14:42:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027613246F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008127; cv=none; b=Z3X4kuzlcYSAa0mYqN/WZnNaGe6xp44CNFlRFR5cqMVbC9ml3iMR2eVphmbFUn8hAcpkX3WwtCJI95P5PN3NoaZNx26pRPdzL9kwIKgxHcxAUdZakgwadw37QtcLsVWJauU25DokD+L4pSKcBluo4/eGKadf/Am2bFX3M0MvMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008127; c=relaxed/simple;
	bh=1iE642cmMGZSjdPlTyM9NvhPHi1h7rzgZBOYYDcrJZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GnehXBkHy1YX5IdVt1B60DpvJJfiYi9i7dNxthgudOdG3+LhP8AsMQoAfr/EcIUpKvPIVE7hUlRlIWMFAEAwBMdcNOhwWPUscmUhTFk36wb17kpZKMhdxigbAC6KGeS+WUKCHq8W8NmPGIZa+uZDOHhRZwLpOxzi6mlOaXXPZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41FEg1Mh092207;
	Thu, 15 Feb 2024 23:42:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 15 Feb 2024 23:42:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41FEg0tt092203
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 15 Feb 2024 23:42:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c3b0f5b0-9f86-40be-b815-8177a4f0b71f@I-love.SAKURA.ne.jp>
Date: Thu, 15 Feb 2024 23:41:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] profiling: initialize prof_cpu_mask from
 profile_online_cpu()
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
References: <000000000000d6b55e060d6bc390@google.com>
 <7227c8d1-08f6-4f95-ad0f-d5c3e47d874d@I-love.SAKURA.ne.jp>
 <85edf211-aa30-4671-93e0-5173b3f7adf2@I-love.SAKURA.ne.jp>
In-Reply-To: <85edf211-aa30-4671-93e0-5173b3f7adf2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Linus.

It seems that nobody maintains this code.

Can I directly send this patch to you, as "THE REST" rule of MAINTAINERS file?
Is some tag like [PATCH ORPHANED] available?

On 2024/01/31 23:06, Tetsuo Handa wrote:
> syzbot is reporting uninit-value at profile_hits(), for commit acd895795d35
> ("profiling: fix broken profiling regression") by error initialized
> prof_cpu_mask too early.
> 
> do_profile_hits() is called from profile_tick() from timer interrupt
> only if cpumask_test_cpu(smp_processor_id(), prof_cpu_mask) is true and
> prof_buffer is not NULL. But the syzbot's report says that profile_hits()
> was called while current thread is still doing vzalloc(buffer_bytes)
> where prof_buffer is NULL at this moment. This indicates two things.
> 
> One is that cpumask_set_cpu(cpu, prof_cpu_mask) should have been called
>  from profile_online_cpu() from cpuhp_setup_state() only after
> profile_init() completed. Fix this by explicitly calling cpumask_copy()
>  from create_proc_profile() on only UP kernels.
> 
> The other is that multiple threads concurrently tried to write to
> /sys/kernel/profiling interface, which caused that somebody else tried
> to re-initialize prof_buffer despite somebody has already initialized
> prof_buffer. Fix this by using serialization.
> 
> Reported-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
> Fixes: acd895795d35 ("profiling: fix broken profiling regression")
> Tested-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/ksysfs.c  | 27 ++++++++++++++++++++++-----
>  kernel/profile.c |  6 +++---
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 1d4bc493b2f4..66bc712f590c 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -91,10 +91,23 @@ static ssize_t profiling_store(struct kobject *kobj,
>  				   struct kobj_attribute *attr,
>  				   const char *buf, size_t count)
>  {
> +	static DEFINE_MUTEX(lock);
>  	int ret;
>  
> -	if (prof_on)
> -		return -EEXIST;
> +	/*
> +	 * We need serialization, for profile_setup() initializes prof_on
> +	 * value. Also, use killable wait in case memory allocation from
> +	 * profile_init() triggered the OOM killer and chose current thread
> +	 * blocked here.
> +	 */
> +	if (mutex_lock_killable(&lock))
> +		return -EINTR;
> +
> +	if (prof_on) {
> +		count = -EEXIST;
> +		goto out;
> +	}
> +
>  	/*
>  	 * This eventually calls into get_option() which
>  	 * has a ton of callers and is not const.  It is
> @@ -102,11 +115,15 @@ static ssize_t profiling_store(struct kobject *kobj,
>  	 */
>  	profile_setup((char *)buf);
>  	ret = profile_init();
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		count = ret;
> +		goto out;
> +	}
>  	ret = create_proc_profile();
>  	if (ret)
> -		return ret;
> +		count = ret;
> +out:
> +	mutex_unlock(&lock);
>  	return count;
>  }
>  KERNEL_ATTR_RW(profiling);
> diff --git a/kernel/profile.c b/kernel/profile.c
> index 8a77769bc4b4..7575747e2ac6 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -114,11 +114,9 @@ int __ref profile_init(void)
>  
>  	buffer_bytes = prof_len*sizeof(atomic_t);
>  
> -	if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
>  		return -ENOMEM;
>  
> -	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
> -
>  	prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
>  	if (prof_buffer)
>  		return 0;
> @@ -481,6 +479,8 @@ int __ref create_proc_profile(void)
>  		goto err_state_prep;
>  	online_state = err;
>  	err = 0;
> +#else
> +	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
>  #endif
>  	entry = proc_create("profile", S_IWUSR | S_IRUGO,
>  			    NULL, &profile_proc_ops);


