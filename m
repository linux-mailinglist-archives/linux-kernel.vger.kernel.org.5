Return-Path: <linux-kernel+bounces-71557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131A85A70C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BB1C20980
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D763C097;
	Mon, 19 Feb 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epYUeuqf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310163B786
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355262; cv=none; b=tJnsYKRtSM4dBaqRumige+jnpdgsTOQQ5ZnaPh9AWedhhLAbVRKoiLXgbZmvjERGJSwt8SZItJ2/b4MmkoE+ZSYKBlZ8t2/9g1fJOTB7xq/mcSRKds83hMCaOaq3PhCX3Jc9SQfntMBc4Rpi7b2AKbVHJmUIR/ZMFD8g31ltQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355262; c=relaxed/simple;
	bh=Ew+dGXVsCgEqa5mBfaomwwTj2lZnDKjk4rPvJnxQONE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FH+2e8TZa0vaVcfCnMv0feePNgKDBFeJzIaPqWmNd8Tt4Yacvs+VjkozUPFlEHm/YHePJPFYluvSlHbFZ4KhvcqAYxMNEKs28ARQmsU6Ac6kRxR58gn3ALlWYuXuBlEDg/Z2zPxZ1gi+0IuYiJ9KYs/kYKc1pvQLVYHrnho/O/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epYUeuqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708355260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bq0yxLT9GQ44OZH1nHxF8G18LGmtdCiB5O9JufGUOgg=;
	b=epYUeuqfjEElVhdM4dBlefJMPsn/nQ6DIUQC6u5VzeHb049oPQtkUTuaiVkvh7F5giwg9y
	44CC7wO/5HiggrcTMekZil81wVkbUNwQjdQ0Iil7bTPqnWDjtpKmExz0wItnLo7BfSnoIJ
	8ZpTrOLQt9HMsOADQUPR6HhxCoT+hBU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-XpDDY6X4Ne22ntoz9-R5hw-1; Mon,
 19 Feb 2024 10:07:36 -0500
X-MC-Unique: XpDDY6X4Ne22ntoz9-R5hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0789828B6A25;
	Mon, 19 Feb 2024 15:07:36 +0000 (UTC)
Received: from [10.22.18.9] (unknown [10.22.18.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84DFF20229A3;
	Mon, 19 Feb 2024 15:07:35 +0000 (UTC)
Message-ID: <759adfbf-b238-44fe-b538-418b43701539@redhat.com>
Date: Mon, 19 Feb 2024 10:07:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH printk v2 26/26] lockdep: Mark emergency section in
 lockdep splats
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-27-john.ogness@linutronix.de>
 <6d8f5126-3595-4abd-9b05-b19a659d1cea@redhat.com>
 <878r3gbtev.fsf@jogness.linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <878r3gbtev.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 2/19/24 06:11, John Ogness wrote:
> On 2024-02-18, Waiman Long <longman@redhat.com> wrote:
>> On 2/18/24 13:57, John Ogness wrote:
>> lockdep.c has multiple functions that print stuff to the console, like
>>
>>    - print_circular_bug_header()
>>    - print_bad_irq_dependency()
>>    - print_deadlock_bug()
>>    - print_collision()
>>    - print_usage_bug()
>>    - print_irq_inversion_bug()
>>    - print_lock_invalid_wait_context()
>>    - print_lock_nested_lock_not_held()
>>    - print_unlock_imbalance_bug()
>>    - print_lock_contention_bug()
>>    - print_freed_lock_bug()
>>    - print_held_locks_bug()
>>    - lockdep_rcu_suspicious()
>>
>> So what is special about print_usage_bug() that it needs this
>> emergency treatment but not the other ones?
> I do not expect to be able to identify all "emergency printing" paths in
> the kernel from the beginning. This series initially marks some sections
> that are IMHO interesting for the feature.
That is what I like to see in the changelog. I am aware that this patch 
is probably not complete, but you need to set the right expectation that 
similar changes will have to be done elsewhere in lockdep to complete 
the change. We can make the other necessary changes after this patch 
series have been merged. It also helps if you can document what 
undesirable thing may happen if printk() is called without setting the 
emergency mode.
>   
>
> As you are implying, for lockdep probably all printing should be
> considered emergency. Is it preferred to place the markers outside the
> high-level print functions, for example:
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 00465373d358..7a4e4f4a9156 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2182,10 +2182,12 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
>   			*trace = save_trace();
>   		}
>   
> +		nbcon_cpu_emergency_enter();
>   		if (src->class_idx == target->class_idx)
>   			print_deadlock_bug(current, src, target);
>   		else
>   			print_circular_bug(&src_entry, target_entry, src, target);
> +		nbcon_cpu_emergency_exit();
>   	}
>   
>   	return ret;
>
> Or is it preferred to put them directly around the various pr_warn()
> blocks (as the patch in this series is doing)?

There are pros and cons for both. It will depend on how expensive is the 
nbcon_cpu_emergency_{enter|exit}() call as printing won't happen if 
lockdep is turned off somehow. Since lockdep is for debugging and 
efficiency isn't that important, putting the emergency enter/exit 
markers outside the high level print functions will make it a bit easier 
to read.

My 2 cents.

Cheers,
Longman


>
> John Ogness
>


