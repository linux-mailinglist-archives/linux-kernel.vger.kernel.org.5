Return-Path: <linux-kernel+bounces-66751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187885611B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F57292F27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215212AAD3;
	Thu, 15 Feb 2024 11:13:00 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDA129A91
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995580; cv=none; b=UZ7avGqxrccSNOkEIQaBtYCIPnkkdJWAEqWjALDS8Qtq3yXVW+EeCbWRzyonPGE8QdBgYWgaZX0jBgVTiQmjqmPcgahUQe93LLLZ1nA6VqHxZAALsjCoXkAZlOxT/UU5l1IyRvTjybWqPELd9kMNCbwO0uhNkKMvbjTkbfo+vXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995580; c=relaxed/simple;
	bh=nu1XrfB4BQfmjRVljW3gTCICIHfIdRfzdnYRfIMXWqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiM+zAUtiHUKsmui2IsmYtSin1rOfxSFNqS2n/CF5h67TF3qDCfTqD+lbP0UPKx/YGR+aW5iCpYZQzfQKPGo24gm9BYO1D5ITwMaJVuQhsQKANbsfx1XMxHcHBY7ASl1ZhgpKoVM4+Irz4NcQ8RGNHum5TXoX3bvwyIS50GF6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4502A1FD39;
	Thu, 15 Feb 2024 11:12:57 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D5D613A53;
	Thu, 15 Feb 2024 11:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tzNrCrnxzWWJNQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 11:12:57 +0000
Message-ID: <bb7112a8-df8a-4df8-a8db-0cb4761720dd@suse.cz>
Date: Thu, 15 Feb 2024 12:12:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] mm,page_owner: Filter out stacks by a threshold
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-7-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214170157.17530-7-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4502A1FD39
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On 2/14/24 18:01, Oscar Salvador wrote:
> We want to be able to filter out the stacks based on a threshold we can
> can tune.
> By writing to 'count_threshold' file, we can adjust the threshold value.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
..

> ---
>  mm/page_owner.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 5258a417f4d1..9b975f59b773 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -846,9 +846,11 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
>  	return stack;
>  }
>  
> +static unsigned long page_owner_stack_threshold;
> +
>  static int stack_print(struct seq_file *m, void *v)
>  {
> -	int i;
> +	int i, stack_count;
>  	struct stack *stack = v;
>  	unsigned long *entries;
>  	unsigned long nr_entries;
> @@ -856,14 +858,15 @@ static int stack_print(struct seq_file *m, void *v)
>  
>  	nr_entries = stack_record->size;
>  	entries = stack_record->entries;
> +	stack_count = refcount_read(&stack_record->count);

Again "- 1" here.

> -	if (!nr_entries || nr_entries < 0 ||
> -	    refcount_read(&stack_record->count) < 2)
> +	if (!nr_entries || nr_entries < 0 || stack_count < 2 ||
> +	    stack_count < page_owner_stack_threshold)

Which will also correct the comparison.

>  		return 0;
>  
>  	for (i = 0; i < nr_entries; i++)
>  		seq_printf(m, " %pS\n", (void *)entries[i]);
> -	seq_printf(m, "stack_count: %d\n\n", refcount_read(&stack_record->count));
> +	seq_printf(m, "stack_count: %d\n\n", stack_count);

And no - 1 needed here then.


