Return-Path: <linux-kernel+bounces-125968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3D892EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128071C20B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604E79E1;
	Sun, 31 Mar 2024 06:26:12 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFD7490
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711866372; cv=none; b=LaqTbeno/fnzT1OnBSfQjhnHN5rIUFN0SkZP3DJ0m+MOGApZ3XtpgYhDSprXAn2PUnwY+UtR8t2hlOZBDpqox+nOFKQH+SPy0O+26ofWbGxPMCSfUlBn244EVgPa3NNXKWKkHMZJ0enWoP5zYTF9bjf2UN968ILnoBoG+BAHjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711866372; c=relaxed/simple;
	bh=rGn4vL9+asmP70dMTI/LIUbfHclY24B3bM9CP8QSGHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWCR86RLbU9TQesl2oCZ3cVCRcv3o+Lci5z3/cXmZ8+fF9mEKmiAiwPsKvFslLfLWmR5AS+B7ZN9qa3xmDqKWPI3uJAmNlXEBj/XvPa8FKSEs6SGt+T/Y7/KFnG7mRug4UKVoY6Zx64+sfKoc45O68F0xOIJ4yRNdyDI0Ss5Aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.152])
	by sina.com (172.16.235.24) with ESMTP
	id 6609015C00007CD6; Sun, 31 Mar 2024 14:23:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 29318145089346
X-SMAIL-UIID: F8131F5289424113AB8638F7DD5264EF-20240331-142331-1
From: Hillf Danton <hdanton@sina.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Date: Sun, 31 Mar 2024 14:23:14 +0800
Message-Id: <20240331062314.3394-1-hdanton@sina.com>
In-Reply-To: <ZghSHWexmBHXpyA-@pc638.lan>
References: <000000000000f2f0c0061494e610@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 30 Mar 2024 18:55:41 +0100 Uladzislau Rezki <urezki@gmail.com>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d9642dd06c25..8867aac3668c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3467,19 +3467,19 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	 */
>  	kmemleak_ignore(ptr);
>  
> -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_monitor_work(krcp);
> -

This is not enough at least WRT run_page_cache_worker() [1]

[1] https://lore.kernel.org/lkml/0000000000007a44120614e27cb7@google.com/

while the reason why syzbot failed to catch the zone->per_cpu_pageset in
setup_zone_pageset() in mm/page_alloc.c is trylock [2]

[2] https://lore.kernel.org/lkml/000000000000a5ee4e0614ee586e@google.com/

>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
>  
> -	/*
> -	 * Inline kvfree() after synchronize_rcu(). We can do
> -	 * it from might_sleep() context only, so the current
> -	 * CPU can pass the QS state.
> -	 */
> -	if (!success) {
> +	if (success) {
> +		// Set timer to drain after KFREE_DRAIN_JIFFIES.
> +		if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> +			schedule_delayed_monitor_work(krcp);
> +	} else {
> +		/*
> +		 * Inline kvfree() after synchronize_rcu(). We can do
> +		 * it from might_sleep() context only, so the current
> +		 * CPU can pass the QS state.
> +		 */
>  		debug_rcu_head_unqueue((struct rcu_head *) ptr);
>  		synchronize_rcu();
>  		kvfree(ptr);
> 
> 
> --

