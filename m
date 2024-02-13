Return-Path: <linux-kernel+bounces-63817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71128534CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C12A1F29676
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381E5FDC8;
	Tue, 13 Feb 2024 15:36:05 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C695F863
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838565; cv=none; b=dcsg4r+P1qd/64iNTNMTXhvDsVl+JndEbc+rtwrduR67C1gHnJHXSLTU/w/vO9drRSgjKx8XOP5IxB8MNwOGT29FmfsOvppoLUn2CANZDiua9x/ZM9GwTyaPcLz8bIyoKLvuAXHOW24PpbEOD94zAU/Lixa6UiWp3mnMNm4pwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838565; c=relaxed/simple;
	bh=xZUB8BUYh9q0K4zYhrKO5UiHbHyA8zQWz3EYhJ1Eclw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgDJL/jDwrxQoxzr3swJ2eEdHCjPQO287DCXOhAVQRsPRmzT3ThvB9Geg0CJm2q/fKi1Kdv+V8mU4alBu7UQ0z2TW94Q27V5pbck9VQBpPAxa6IzdfTz4bxSQxfoGDNd67IdlRL5P3NXiaH5k+cqwTEXbLkyUANQVp6DRpekHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB2BA22017;
	Tue, 13 Feb 2024 15:36:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD70D1370C;
	Tue, 13 Feb 2024 15:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M+mrMWGMy2VzQAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 15:36:01 +0000
Message-ID: <ff695557-603c-4bbd-ac6e-3a35ae6ed74f@suse.cz>
Date: Tue, 13 Feb 2024 16:36:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] mm,page_owner: Display all stacks and their count
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-4-osalvador@suse.de>
 <b706176a-c60a-4960-ba4a-2755c612d9c8@suse.cz>
 <ZcuLyjU52Gd3xJI8@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZcuLyjU52Gd3xJI8@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EB2BA22017
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On 2/13/24 16:33, Oscar Salvador wrote:
> On Tue, Feb 13, 2024 at 03:25:26PM +0100, Vlastimil Babka wrote:
>> On 2/12/24 23:30, Oscar Salvador wrote:
>> > +static int stack_print(struct seq_file *m, void *v)
>> > +{
>> > +	char *buf;
>> > +	int ret = 0;
>> > +	struct stack *stack = v;
>> > +	struct stack_record *stack_record = stack->stack_record;
>> > +
>> > +	if (!stack_record->size || stack_record->size < 0 ||
>> > +	    refcount_read(&stack_record->count) < 2)
>> > +		return 0;
>> > +
>> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
>> > +
>> > +	ret += stack_trace_snprint(buf, PAGE_SIZE, stack_record->entries,
>> > +				   stack_record->size, 0);
>> > +	if (!ret)
>> > +		goto out;
>> > +
>> > +	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
>> > +		  refcount_read(&stack_record->count));
>> > +
>> > +	seq_printf(m, buf);
>> > +	seq_puts(m, "\n\n");
>> > +out:
>> > +	kfree(buf);
>> 
>> Seems rather wasteful to do kzalloc/kfree so you can print into that buffer
>> first and then print/copy it again using seq_printf. If you give up on using
>> stack_trace_snprintf() it's not much harder to print the stack directly with
>> a loop of seq_printf. See e.g. slab_debugfs_show().
> 
> Well, I thought about not reinventing the wheel there, but fair enough
> than performing a kmalloc/free op on every print might be suboptimal.
> I will try to do ir with seq_printf alone.

Of course once there's more than one stackdepot user printing into a
seq_file, creating a common seq_file helper analogy of
stack_trace_snprintf() and using it from all places, would also be an option :)

> Thanks
>  
> 


