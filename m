Return-Path: <linux-kernel+bounces-96608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121E875EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221DF1F21613
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD651031;
	Fri,  8 Mar 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BynHUM00";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RoFfSx5D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BynHUM00";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RoFfSx5D"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A7E555
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884420; cv=none; b=XqWPm9ExGeR7rKrSxnJlk3Fr/171m26FYv5+DIz06haYdRl+kQ45rj78xOD+E97LK+dcgvff5gTd0+4sko2OcleI0lXITC/BtRrJYlRN0DXB/KcVIXpTfvvmyfsgRAs6jzuQs0afWH5FnH31s4Vsf6z+4+Myt7eeArLgpXwEOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884420; c=relaxed/simple;
	bh=VNV5swdqrI0DNG2HieLkadUPj8pYn3qTQRRk2ARvEzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiG70sJraahGMNYd6QKUoEra7J9TTeqWA8GlE0lidUExzBE71gi78ZxyWx971MxGeZgj0kG651QvbfmPjdoEznM6t0l1sxaOubMWCvrd4jch8L3j0N7J5VBpkWIQuCeLCTcHGETBK6Rs5Lfxrj9yMZJ6yez9pQwYNlE5qK70p60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BynHUM00; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RoFfSx5D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BynHUM00; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RoFfSx5D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 299F120383;
	Fri,  8 Mar 2024 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709884416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rp1D2QYjHNl+iUq7FT+HRREVK4qqEoRgZESSZNDJq4Q=;
	b=BynHUM00jAgdskbp4wm6oemibVk3XPcOt9jA9PXU8Nrx09OF7i6r7WML6HkJ+fIFPY4IYo
	RpeIGguI1CYb/wKTvtqP7YKMMX6XYbR1Dfz6EkRpwMLH1GF2sMVfQsLNQ44XyxmiqpZAAS
	Pz7HWY6tJ1VvUvTzskoHceVw8dFITuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709884416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rp1D2QYjHNl+iUq7FT+HRREVK4qqEoRgZESSZNDJq4Q=;
	b=RoFfSx5DnDMbTHqN1emARAv2MMV+7MlyKvgLo+oyUhmCRxJyLSxbPDane3A3m6TaZdAnAM
	HdUBjJPO0ZgJV0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709884416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rp1D2QYjHNl+iUq7FT+HRREVK4qqEoRgZESSZNDJq4Q=;
	b=BynHUM00jAgdskbp4wm6oemibVk3XPcOt9jA9PXU8Nrx09OF7i6r7WML6HkJ+fIFPY4IYo
	RpeIGguI1CYb/wKTvtqP7YKMMX6XYbR1Dfz6EkRpwMLH1GF2sMVfQsLNQ44XyxmiqpZAAS
	Pz7HWY6tJ1VvUvTzskoHceVw8dFITuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709884416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rp1D2QYjHNl+iUq7FT+HRREVK4qqEoRgZESSZNDJq4Q=;
	b=RoFfSx5DnDMbTHqN1emARAv2MMV+7MlyKvgLo+oyUhmCRxJyLSxbPDane3A3m6TaZdAnAM
	HdUBjJPO0ZgJV0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0715813310;
	Fri,  8 Mar 2024 07:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kPG5AADE6mUNSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 08 Mar 2024 07:53:36 +0000
Message-ID: <cce858b3-cd8c-4b11-9564-d3c38eb8d536@suse.cz>
Date: Fri, 8 Mar 2024 08:53:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm,page_owner: Drop unnecesary check
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240306123217.29774-1-osalvador@suse.de>
 <20240306123217.29774-3-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240306123217.29774-3-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.32
X-Spamd-Result: default: False [-3.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-2.03)[95.25%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 3/6/24 13:32, Oscar Salvador wrote:
> stackdepot only saves stack_records which size is greather than 0,
> so we cannot possibly have empty stack_records.
> Drop the check.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>---
>  mm/page_owner.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 7163a1c44ccf..e7139952ffd9 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -865,8 +865,7 @@ static int stack_print(struct seq_file *m, void *v)
>  	entries = stack_record->entries;
>  	stack_count = refcount_read(&stack_record->count) - 1;
>  
> -	if (!nr_entries || nr_entries < 0 || stack_count < 1 ||
> -	    stack_count < page_owner_stack_threshold)
> +	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
>  		return 0;
>  
>  	for (i = 0; i < nr_entries; i++)


