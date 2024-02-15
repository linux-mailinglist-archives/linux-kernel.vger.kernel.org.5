Return-Path: <linux-kernel+bounces-66749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038185610F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A651C21242
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D312B147;
	Thu, 15 Feb 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SpE7Oabv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wN6In+Sq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tae2G1rg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1c1W27sC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E012A158
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995443; cv=none; b=JxdjdO5nHCjjDOg0XGaU9og4Cu/EWjLRiKpPLkhMyoAjrb7wwY/f0aDkpCw8tcWqIzpurcD7cIKVPuUj5XYSwws5GEWojYiT2kaw9o/Wk2ObtaC+KpjHsogyCNJnVrwTEOJQYtuHUr6YvILu/4CS+6K9bmCwv/P/H7lwTCm3AbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995443; c=relaxed/simple;
	bh=B0vBWySrpPCC9F04SvntC7CarLmc39ktOUUEEnNOK18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQc9EiJ//O5lGRFYGSmpkBSQaW6KesDQuD9U+So93XPVdZ3JTod2Y/tYUARMLHvWnbagL6oGdOSz1QNivE80NWEeC/6AL9nC71UT2S6jEEe/A//qakAb5kFOHZdmxVTYuXiBEP+jyt7tSHlszsMMb2ClQy/gThvtLuIcg54BGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SpE7Oabv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wN6In+Sq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tae2G1rg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1c1W27sC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F281721FE8;
	Thu, 15 Feb 2024 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707995440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/rePRTTXIR2SNKRlxOuF/gBJ5LkqGnM8buqh9JDPaU=;
	b=SpE7OabvrMpiQgDTcR1nCbFpMuMY6F2visNl7LAnTCzaP8yOOq+jxYhOZwXSnnVKmrNOFd
	P3RDTFIXMPcIh6ZxpZ/TVGV610an4DBvpA8c3GvrEkPqiuEh2ZpDgL9g4RLafW5+nTb76G
	ReTiX0NyekhjneHGKRqSXfbk6bXhljM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707995440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/rePRTTXIR2SNKRlxOuF/gBJ5LkqGnM8buqh9JDPaU=;
	b=wN6In+Sqg1y4PlrhcWMaWoDsLiMtjW6Dp7JsWUQdesQ6L+xewfuoAIsMWzWQO37Z1+Rv9V
	zOtgmuDDJfx197Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707995438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/rePRTTXIR2SNKRlxOuF/gBJ5LkqGnM8buqh9JDPaU=;
	b=tae2G1rg5a/u78q8n0MrvdO4zTFm1ZDwW9crEHppgfsqj6fgnn5F80xRAYNyncTrHnw/Yz
	8UqcMb9nj+XTFAB5W2dkj2YJjTcCyvhdinUQz+C+4B5cf0qwBfHkWt0b5Ky8j0GRNynOx8
	SmzX8aGnVuegZjDplmaxIk6d1NxkrDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707995438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/rePRTTXIR2SNKRlxOuF/gBJ5LkqGnM8buqh9JDPaU=;
	b=1c1W27sCDomu/cZYSYFPskmZxCNUcp3LE3VCGJYZgyTKE/+NzwdT6uTx5RiMThyuN46x8l
	iARkWsLUb5xYgODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDD4313A53;
	Thu, 15 Feb 2024 11:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X+24NS7xzWX4NAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 11:10:38 +0000
Message-ID: <4f4f008b-bde1-4551-ae24-db2c0778eb27@suse.cz>
Date: Thu, 15 Feb 2024 12:10:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] mm,page_owner: Display all stacks and their count
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-6-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214170157.17530-6-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.92
X-Spamd-Result: default: False [-5.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-0.63)[82.22%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/14/24 18:01, Oscar Salvador wrote:
> This patch adds a new directory called 'page_owner_stacks' under
> /sys/kernel/debug/, with a file called 'show_stacks' in it.
> Reading from that file will show all stacks that were added by page_owner
> followed by their counting, giving us a clear overview of stack <-> count
> relationship.
> 
> E.g:
> 
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   alloc_pages_mpol+0x91/0x1f0
>   folio_alloc+0x14/0x50
>   filemap_alloc_folio+0xb2/0x100
>   __filemap_get_folio+0x14a/0x490
>   ext4_write_begin+0xbd/0x4b0 [ext4]
>   generic_perform_write+0xc1/0x1e0
>   ext4_buffered_write_iter+0x68/0xe0 [ext4]
>   ext4_file_write_iter+0x70/0x740 [ext4]
>   vfs_write+0x33d/0x420
>   ksys_write+0xa5/0xe0
>   do_syscall_64+0x80/0x160
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  stack_count: 4578
> 
> The seq stack_{start,next} functions will iterate through the list
> stack_list in order to print all stacks.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Marco Elver <elver@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

..

> +static int stack_print(struct seq_file *m, void *v)
> +{
> +	int i;
> +	struct stack *stack = v;
> +	unsigned long *entries;
> +	unsigned long nr_entries;
> +	struct stack_record *stack_record = stack->stack_record;
> +
> +	nr_entries = stack_record->size;
> +	entries = stack_record->entries;
> +
> +	if (!nr_entries || nr_entries < 0 ||
> +	    refcount_read(&stack_record->count) < 2)
> +		return 0;
> +
> +	for (i = 0; i < nr_entries; i++)
> +		seq_printf(m, " %pS\n", (void *)entries[i]);
> +	seq_printf(m, "stack_count: %d\n\n", refcount_read(&stack_record->count));

So count - 1 here to report actual usage, as explained in reply to 4/7?


