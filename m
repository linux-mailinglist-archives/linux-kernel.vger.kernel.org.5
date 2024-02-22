Return-Path: <linux-kernel+bounces-77405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B08604D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F441C23CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0D73F35;
	Thu, 22 Feb 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz2uvLbw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDf189rS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz2uvLbw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDf189rS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692571738;
	Thu, 22 Feb 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637536; cv=none; b=szTQD/2w3qmFZUsbvdOznTeCy6asNqJUrzrLEub5GFzstSuDVR6DCJtBWLrQq3/wI9KLtKW8nHsycDcnBPGXO78sYDiJuvdOYu2ZIJhMl0sMMeO7d/pqpxn2nGWMZzFI2cnP6k6wEHRXd2S9G1vaQdRmrlBMUt0Mw4kaouiEe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637536; c=relaxed/simple;
	bh=AWl+DXGsKjgrNy+G5SN3TUq9VMTt8GW/MbSwwKglgPE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ktsQ0QUZjZ3hsvRA7ulfg/SZGdDW0o1ABRYyJyq1VG6uuHDORc8uqsCWUMtqnI8wh/0063eDu2iWHux7fF4MSb5+PG8xD6OhG2pBSyc6KyYPDoSIyMZP+8P+G0uGuWu9Gn9D+1VyERMa807eSM8As1XyKdFyytF6tlFRxwTAAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz2uvLbw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDf189rS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz2uvLbw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDf189rS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B199E1F792;
	Thu, 22 Feb 2024 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708637532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4dJOBkFLnxSfVfNOF9l/CCf3u4xOydj32a58ss033A=;
	b=Hz2uvLbwv3ySBAjtMwkbTlQTdX7wPSRyGHjLq60rqYcQW7V2tlpxkwcCt82iFjAa7yLg8V
	RswXjXVsG2695EN0deDToDYPUqw96mBljD+4YMrMAeG8g30n2qgcr4X6kbPFCCHTBS2MTj
	pJf7uajW41VxcnJ/Ifl1tLTzwXebM/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708637532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4dJOBkFLnxSfVfNOF9l/CCf3u4xOydj32a58ss033A=;
	b=kDf189rSbTDbyB9qlHlOiIuNgW9VbqNhcMeHK99WXfYncNrUhEHGTuNFVBho8OjE8Jnxk4
	E0Fmqb2XwF6s8LDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708637532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4dJOBkFLnxSfVfNOF9l/CCf3u4xOydj32a58ss033A=;
	b=Hz2uvLbwv3ySBAjtMwkbTlQTdX7wPSRyGHjLq60rqYcQW7V2tlpxkwcCt82iFjAa7yLg8V
	RswXjXVsG2695EN0deDToDYPUqw96mBljD+4YMrMAeG8g30n2qgcr4X6kbPFCCHTBS2MTj
	pJf7uajW41VxcnJ/Ifl1tLTzwXebM/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708637532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4dJOBkFLnxSfVfNOF9l/CCf3u4xOydj32a58ss033A=;
	b=kDf189rSbTDbyB9qlHlOiIuNgW9VbqNhcMeHK99WXfYncNrUhEHGTuNFVBho8OjE8Jnxk4
	E0Fmqb2XwF6s8LDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D3BF13A8C;
	Thu, 22 Feb 2024 21:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9oD+IVy912ViLQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 22 Feb 2024 21:32:12 +0000
Message-ID: <a6890607-4418-4356-a7f8-155f01ede14d@suse.cz>
Date: Thu, 22 Feb 2024 22:32:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
 Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
References: <20240222165549.32753-2-vbabka@suse.cz>
 <20240222185642.rmnp76oquu5wfo6c@revolver>
 <20240222192746.cb65qvtmhaikfeko@revolver>
 <18565605-7f68-4950-b66f-496c1f3c393b@suse.cz>
In-Reply-To: <18565605-7f68-4950-b66f-496c1f3c393b@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[Oracle.com,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,suse.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/22/24 22:19, Vlastimil Babka wrote:
> On 2/22/24 20:27, Liam R. Howlett wrote:
>> * Liam R. Howlett <Liam.Howlett@Oracle.com> [240222 13:56]:
>>> * Vlastimil Babka <vbabka@suse.cz> [240222 11:56]:
>>> This separates the check for potentially merging previous to a later
>>> failure case.  Would it be better to check:
>>> 	if (curr && curr->vm_ops && curr->vm_ops->close)
>>> 
>>> and not set merge_prev = true, ie we cannot merge with the predecessor?
> 
> Good suggestion, thanks!

Or actually as Lorenzo informed me, it would affect case 5 as well and we
don't want that. And special casing 5 vs 7 that early would be ugly again.

So I'll just do the code dedup Lorenzo suggested...

>>> That way we would exit as merge_prev == false.
>>> 
>>> We would have the added benefit of not having to look at merge_prev &
>>> merge_next case with this vm_ops->close in mind (case 1 and 6).. because
>>> I'm pretty sure we can currently get to case 6 in this way:
>>> 
>>> merge_prev = true
>>> check for merge_next.. can_vma_merge_before(next...);
>>> is_mergeable_vma(next.... , true);
>>> if (true && next->vm_ops && next->vm_ops->close) /* Fine for next.. */
>>> 
>>> Remove curr by case 6 without checking curr->vm_ops &&
>>> curr->vm_ops->close
>>> 
>>> If I am correct, then are we blaming the right commit?
> 
> It was bisected with no nondeterminism in the test, so yeah.
> 
>> I am not correct.
>> The file check will ensure the same ops, so the file and ops must match.
>> As long as both are checked on one VMA then it will work as required.
> 
> Right, otherwise we would have bigger issues even before the buggy commit,
> we were never checking curr's vma_ops before.
> 
>>> 
>>> Perhaps we should just fail earlier when we find a curr with the close
>>> ops?
>> 
>> I'd rather fail earlier, but it's not a big deal.
> 
> Your suggestion will indeed result in a nicer and more obvious code, so will
> do, thanks!
> 
>>> 
>>> >  			} else {			/* case 5 */
>>> > +				err = dup_anon_vma(prev, curr, &anon_dup);
>>> >  				adjust = curr;
>>> >  				adj_start = (end - curr->vm_start);
>>> >  			}
>>> > -- 
>>> > 2.43.1
>>> > 
> 


