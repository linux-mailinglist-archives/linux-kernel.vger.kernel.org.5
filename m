Return-Path: <linux-kernel+bounces-63189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608F852C11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3491C229E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C021A04;
	Tue, 13 Feb 2024 09:16:08 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A8210E4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815768; cv=none; b=FUFJ/3dxornS7KMUeAILQxNKn1KzsXgtOcHYZHG/J0RLdBe8nzXte6vBU9mHxp0zblRN6olstaQZ3UJghXLI4vde1UE3pUp+X7R9B24YOgQujQp08UW2u1aR/KNeF/oaWcRJJ93L6Vv+f1M9eMRNcrLuzKTUoLYfIMPcA6jewNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815768; c=relaxed/simple;
	bh=E2ZxuFKsqx1gBtxyAyUoLK7tkKjEHNUQbaU168bL5D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqjFfhvv251gG0coY8K9lK2iqSNMHCKrkVtzPXH4zogrYFqLD3rfik43Dtrhz+asmAraPyJnxW02OJzOBh0Lf1W6cw86xnfYwHcU1DjIrYkgSyueIvw96/zjSOMpMmYn1CQFOkQSBvu9y/la2ODuM5u7vrLbIhWAZCjMBAEk5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A7D42116D;
	Tue, 13 Feb 2024 09:16:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74ED713404;
	Tue, 13 Feb 2024 09:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /8kgHFQzy2USVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 09:16:04 +0000
Message-ID: <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
Date: Tue, 13 Feb 2024 10:16:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212223029.30769-3-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8A7D42116D
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On 2/12/24 23:30, Oscar Salvador wrote:
> page_owner needs to increment a stack_record refcount when a new allocation
> occurs, and decrement it on a free operation.
> In order to do that, we need to have a way to get a stack_record from a
> handle.
> Implement __stack_depot_get_stack_record() which just does that, and make
> it public so page_owner can use it.
> 
> Also implement {inc,dec}_stack_record_count() which increments
> or decrements on respective allocation and free operations, via
> __reset_page_owner() (free operation) and __set_page_owner() (alloc
> operation).
> 
> Traversing all stackdepot buckets comes with its own complexity,
> plus we would have to implement a way to mark only those stack_records
> that were originated from page_owner, as those are the ones we are
> interested in.
> For that reason, page_owner maintains its own list of stack_records,
> because traversing that list is faster than traversing all buckets
> while keeping at the same time a low complexity.
> inc_stack_record_count() is responsible of adding new stack_records
> into the list stack_list.
> 
> Modifications on the list are protected via a spinlock with irqs
> disabled, since this code can also be reached from IRQ context.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h |  9 +++++
>  lib/stackdepot.c           |  8 +++++
>  mm/page_owner.c            | 73 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)

..


> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -36,6 +36,14 @@ struct page_owner {
>  	pid_t free_tgid;
>  };
>  
> +struct stack {
> +	struct stack_record *stack_record;
> +	struct stack *next;
> +};
> +
> +static struct stack *stack_list;
> +static DEFINE_SPINLOCK(stack_list_lock);
> +
>  static bool page_owner_enabled __initdata;
>  DEFINE_STATIC_KEY_FALSE(page_owner_inited);
>  
> @@ -61,6 +69,57 @@ static __init bool need_page_owner(void)
>  	return page_owner_enabled;
>  }
>  
> +static void add_stack_record_to_list(struct stack_record *stack_record)
> +{
> +	unsigned long flags;
> +	struct stack *stack;
> +
> +	stack = kmalloc(sizeof(*stack), GFP_KERNEL);

I doubt you can use GFP_KERNEL unconditionally? Think you need to pass down
the gfp flags from __set_page_owner() here?
And what about the alloc failure case, this will just leave the stack record
unlinked forever? Can we somehow know which ones we failed to link, and try
next time? Probably easier by not recording the stack for the page at all in
that case, so the next attempt with the same stack looks like the very first
again and attemps the add to list.
Still not happy that these extra tracking objects are needed, but I guess
the per-users stack depot instances I suggested would be a major change.

> +	if (stack) {
> +		stack->stack_record = stack_record;
> +		stack->next = NULL;
> +
> +		spin_lock_irqsave(&stack_list_lock, flags);
> +		if (!stack_list) {
> +			stack_list = stack;
> +		} else {
> +			stack->next = stack_list;
> +			stack_list = stack;
> +		}
> +		spin_unlock_irqrestore(&stack_list_lock, flags);
> +	}
> +}
> +
> +static void inc_stack_record_count(depot_stack_handle_t handle)
> +{
> +	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> +
> +	if (stack_record) {
> +		/*
> +		 * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
> +		 * with REFCOUNT_SATURATED to catch spurious increments of their
> +		 * refcount.
> +		 * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
> +		 * set a refcount of 1 ourselves.
> +		 */
> +		if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
> +			refcount_set(&stack_record->count, 1);

Isn't this racy? Shouldn't we use some atomic cmpxchg operation to change
from REFCOUNT_SATURATED to 1?

> +			/* Add the new stack_record to our list */
> +			add_stack_record_to_list(stack_record);
> +		}
> +		refcount_inc(&stack_record->count);
> +	}
> +}
> +


