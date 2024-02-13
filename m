Return-Path: <linux-kernel+bounces-63605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5C85321F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D99B20BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8156471;
	Tue, 13 Feb 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GeyQkYiV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DN0txwQ1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cz85Lar8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1zjxZoX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AB56444
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831749; cv=none; b=S3QsuZ++SJr7i6J+72m1YDJ24MkIOH4yo76EOrrqAqsw2056aUQUExHJLFiV4mTM/MV77n0r20jn21iIC0L5oII8gSPZ54IvjKL4oytm6SmRr9W16aojtAanf8RZWh+HamAWJL8NfwxStI6iUt1bVWBwltrHe3bxunlp6dM+C5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831749; c=relaxed/simple;
	bh=B6pF8AkbyirQBxWwhsmfyiC/uceO7X471RPSpulWgVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGMdDOfLfT0cyrovHGBckTFCaokGR2xVnQS/cTO/x1sVnIaLN4bmyi3KBWIw5/nnatd9eTLy/EIyw6VBW0Ax+NLf/OYLKBlTCpnByJK8uR2i+Vt3ZldIqGhqokzwyZVGwIFQ94aZ2suUtgCVQ9YPgLsPP7t30RpcqB1KgtTNuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GeyQkYiV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DN0txwQ1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cz85Lar8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q1zjxZoX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE16A1FCD8;
	Tue, 13 Feb 2024 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707831746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCSWNMriDs+O5InzTCr4S0mBv91EYSv9PrgxheazaDU=;
	b=GeyQkYiV42wF2YZm4VgvxwiIdqvvgDxVNodjzQh4nOTZOvoEIAIZ9NcDT48vkpenIGQ0Lb
	HX0MjJLUBLdx7HfPEPwxIhy7wHljJURDIgFilUreK0u0IIZwO3Yf5V22YJMsrNWKcBl3Tr
	6W7fvIdwvtryMtOlIwkz3C0vhGHNLjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707831746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCSWNMriDs+O5InzTCr4S0mBv91EYSv9PrgxheazaDU=;
	b=DN0txwQ1jAfARXwEp5OXiacChwK6FI2l35/IjZKTA/Dom5cMeE5nAmOzeKzEh3mQetCpcD
	X8Saa9zExHZNQfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707831745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCSWNMriDs+O5InzTCr4S0mBv91EYSv9PrgxheazaDU=;
	b=Cz85Lar8Rb2NO2ux9p2DHypFt6Hy9ZVHGoAruwBObSWT8Rf6lUiFZ0hZwlgrh4S3fpRLCw
	FnToGYl9eQRefiBrkru9RsuTFl+X/rCESyC9lIQsXTR/4WaPGgJZeVDmXf/Sz2Z1+PXITn
	g/l56B9AtIhPme8VHYViDXUxUiHPoOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707831745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCSWNMriDs+O5InzTCr4S0mBv91EYSv9PrgxheazaDU=;
	b=Q1zjxZoXyeaSSO3z3Ff2CBnQvmYN3Z2xxVZdjlh0J6gmQpYXbr4BwcwQTGRscClww2tbo4
	p5ulrklsiea4eZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9F781370C;
	Tue, 13 Feb 2024 13:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQzaNMFxy2WbHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 13:42:25 +0000
Message-ID: <8ff46f99-d167-448f-9aae-a634b8aae4d0@suse.cz>
Date: Tue, 13 Feb 2024 14:42:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212223029.30769-3-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-0.08)[63.36%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.17

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
>  static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -199,6 +271,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>  		return;
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  	page_ext_put(page_ext);
> +	inc_stack_record_count(handle);

What if this is dummy handle, which means we have recursed in page owner,
and we'll by trying to kmalloc() its struct stack and link it to the
stack_list because it was returned for the first time? Also failure_handle.
Could you pre-create static (not kmalloc) struct stack for these handles
with refcount of 0 and insert them to stack_list, all during
init_page_owner()? Bonus: no longer treating stack_list == NULL in a special
way in add_stack_record_to_list() (although you don't need to handle it
extra even now, AFAICS).

>  }
>  
>  void __set_page_owner_migrate_reason(struct page *page, int reason)


