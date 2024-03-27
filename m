Return-Path: <linux-kernel+bounces-120577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6D888D9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A264299252
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510437703;
	Wed, 27 Mar 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WccdZ039";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ajaJdWBh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WccdZ039";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ajaJdWBh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECB374EE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529645; cv=none; b=Ybliw4CUkc+zhqeP6nEANf0hTv9XCh43EoQ10BFpWeT3knQm6QZ4NGmZCrmWsa7hP67kSgSiNh/NR0VInZQQIakPsIFmc0Yezc/wtHIKSNsJOsbW/KIDw+v513QHHLRujIeggLoLVwFoFaExSraE29h7pT5qlQpwZTp87BtpHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529645; c=relaxed/simple;
	bh=GGGRmxLCnhGsli+4HWWsw1sGOsAmpPiu8AylFrevOsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN31uNk8+6fDZMTraz6PncpCUmCxI1UUdWSwJZ4HhxwxFFHzSO/vsa4UJgqtQqhcDAKAwJ7WwOHLuNn3UbYDtjzyYEPQRNs4tnl9kFIWyG33G1Mxi+OQy4kv1zAYoSTxrcuiDEvyuDiCIhvTBiE1rX+BBQCIq8tIgLUQEHmZ2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WccdZ039; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ajaJdWBh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WccdZ039; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ajaJdWBh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97CEC387A0;
	Wed, 27 Mar 2024 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711529641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+nV4FXBFEIfJn1nP8KUD8AMey9E2WlbuBTskPgjqLA=;
	b=WccdZ039zT2VYCeEx1fbN9pXmOzpC4yqHc244P7N4vsp49KINYXndVzA19aXb2My8LxC9W
	y1ZtertV+n/jmdCd+LqY1wGmi8Tc+e8WWBC0rUIooiKA9QmzuC0ZjL+/6LuaR8aUCfsfP1
	kLYwF7H8IPwChGDNG0CMpO8/B5+obBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711529641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+nV4FXBFEIfJn1nP8KUD8AMey9E2WlbuBTskPgjqLA=;
	b=ajaJdWBh2rUGqYrQsQGKWEw9mOWQ2CMgNekLA8QJSk8QJ2ewkHqfY+v3MO81wKzUvDTiDk
	Sr4TfnTfYbTxzcDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711529641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+nV4FXBFEIfJn1nP8KUD8AMey9E2WlbuBTskPgjqLA=;
	b=WccdZ039zT2VYCeEx1fbN9pXmOzpC4yqHc244P7N4vsp49KINYXndVzA19aXb2My8LxC9W
	y1ZtertV+n/jmdCd+LqY1wGmi8Tc+e8WWBC0rUIooiKA9QmzuC0ZjL+/6LuaR8aUCfsfP1
	kLYwF7H8IPwChGDNG0CMpO8/B5+obBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711529641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+nV4FXBFEIfJn1nP8KUD8AMey9E2WlbuBTskPgjqLA=;
	b=ajaJdWBh2rUGqYrQsQGKWEw9mOWQ2CMgNekLA8QJSk8QJ2ewkHqfY+v3MO81wKzUvDTiDk
	Sr4TfnTfYbTxzcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82BB513688;
	Wed, 27 Mar 2024 08:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZVZxH6neA2bMDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 27 Mar 2024 08:54:01 +0000
Message-ID: <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>
Date: Wed, 27 Mar 2024 09:54:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-11-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.24
X-Spamd-Result: default: False [-2.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.95)[86.56%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> Free page accounting currently happens a bit too high up the call
> stack, where it has to deal with guard pages, compaction capturing,
> block stealing and even page isolation. This is subtle and fragile,
> and makes it difficult to hack on the code.
> 
> Now that type violations on the freelists have been fixed, push the
> accounting down to where pages enter and leave the freelist.

Awesome!

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Just some nits:

> @@ -1314,10 +1349,10 @@ static inline void expand(struct zone *zone, struct page *page,
>  		 * Corresponding page table entries will not be touched,
>  		 * pages will stay not present in virtual address space
>  		 */
> -		if (set_page_guard(zone, &page[size], high, migratetype))
> +		if (set_page_guard(zone, &page[size], high))
>  			continue;
>  
> -		add_to_free_list(&page[size], zone, high, migratetype);
> +		add_to_free_list(&page[size], zone, high, migratetype, false);

This is account_freepages() in the hot loop, what if we instead used
__add_to_free_list(), sum up nr_pages and called account_freepages() once
outside of the loop?

>  		set_buddy_order(&page[size], high);
>  	}
>  }

<snip>

> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 042937d5abe4..914a71c580d8 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -252,7 +252,8 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
>  		 * Isolating this block already succeeded, so this
>  		 * should not fail on zone boundaries.
>  		 */
> -		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
> +		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page,
> +							   migratetype));
>  	} else {
>  		set_pageblock_migratetype(page, migratetype);
>  		__putback_isolated_page(page, order, migratetype);

Looks like a drive-by edit of an extra file just to adjust identation.

