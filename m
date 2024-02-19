Return-Path: <linux-kernel+bounces-70700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D7859B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD622813B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D0B79ED;
	Mon, 19 Feb 2024 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeVwNCPM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6279DB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316098; cv=none; b=F+NUpqPLJ+cgQ7Cf1I3UbohJ8ejLShBEeRMDG8aQSPpP6vsBdSkPRij7nEgaOK0J0oW6JKW5TT218jurAM2Y7zpm9gjEMSU9KaDGdPDN1gDpkbAlSX5+H2PkIT07KSq1R2n38wayJmpUZEYvDEZTUfhAwiG+zf7dEIteQtc/ZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316098; c=relaxed/simple;
	bh=Mk4wK5kAHbioHEN5GBxfOS48xHJfdzaEjxYyc15nxfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOjI+UWx/pq+oi93pdX/3FXvLYA7mqqGZhLtZFzdq9no7NCeSHU5OZLzxo7GrNPCTFK/RY4d2pmMdeRhFZCjZ1TFN5rlL8jtffw6RCFDtY3B7WZ85LeaMm8L0R3jQe5+Sisa80yoDKSpDWjWe+Sy/NqlbZN8aYnvWxhD3EBV6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeVwNCPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708316092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WK+42F2ocf8jrrrMT4Ru0mEzyoFEd7cO7zcjZSeW/fw=;
	b=JeVwNCPMFDBB7OrOXsJ1jBg476XkTYDNPYqUeBYpVq0vjOgvBOV3E4UwHWYr9PIjaRqGeh
	g990soWSKSBFC5fN1fo4bG6F5gJ+apWLQoV8yVCBmwlAOnkPrP2teVWlcCd1evy8eYYVhs
	DbXcTo8SlUYddQ5IyU5QEVnQVwjq/lY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-FCAHBZStPeCFr_WkfJewZA-1; Sun, 18 Feb 2024 23:14:48 -0500
X-MC-Unique: FCAHBZStPeCFr_WkfJewZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB7B5863062;
	Mon, 19 Feb 2024 04:14:47 +0000 (UTC)
Received: from [10.22.8.104] (unknown [10.22.8.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24A2A1C060AF;
	Mon, 19 Feb 2024 04:14:47 +0000 (UTC)
Message-ID: <6d8f5126-3595-4abd-9b05-b19a659d1cea@redhat.com>
Date: Sun, 18 Feb 2024 23:14:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH printk v2 26/26] lockdep: Mark emergency section in
 lockdep splats
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-27-john.ogness@linutronix.de>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240218185726.1994771-27-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


On 2/18/24 13:57, John Ogness wrote:
> Mark an emergency section within print_usage_bug(), where
> lockdep bugs are printed. In this section, the CPU will not
> perform console output for the printk() calls. Instead, a
> flushing of the console output is triggered when exiting
> the emergency section.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>   kernel/locking/lockdep.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e85b5ad3e206..00465373d358 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -56,6 +56,7 @@
>   #include <linux/kprobes.h>
>   #include <linux/lockdep.h>
>   #include <linux/context_tracking.h>
> +#include <linux/console.h>
>   
>   #include <asm/sections.h>
>   
> @@ -3970,6 +3971,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
>   	if (!debug_locks_off() || debug_locks_silent)
>   		return;
>   
> +	nbcon_cpu_emergency_enter();
> +
>   	pr_warn("\n");
>   	pr_warn("================================\n");
>   	pr_warn("WARNING: inconsistent lock state\n");
> @@ -3998,6 +4001,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
>   
>   	pr_warn("\nstack backtrace:\n");
>   	dump_stack();
> +
> +	nbcon_cpu_emergency_exit();
>   }
>   
>   /*

lockdep.c has multiple functions that print stuff to the console, like

  - print_circular_bug_header()
  - print_bad_irq_dependency()
  - print_deadlock_bug()
  - print_collision()
  - print_usage_bug()
  - print_irq_inversion_bug()
  - print_lock_invalid_wait_context()
  - print_lock_nested_lock_not_held()
  - print_unlock_imbalance_bug()
  - print_lock_contention_bug()
  - print_freed_lock_bug()
  - print_held_locks_bug()
  - lockdep_rcu_suspicious()

So what is special about print_usage_bug() that it needs this emergency 
treatment but not the other ones?

Cheers,
Longman


