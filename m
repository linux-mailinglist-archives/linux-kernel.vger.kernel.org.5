Return-Path: <linux-kernel+bounces-127648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDCD894EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7B1C227EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357F58AA8;
	Tue,  2 Apr 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqQJ+GdV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E5xRPWUe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C549454
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050922; cv=none; b=VoiPOx/+W0ue9+3nlI0jhTs8oDBYStWxiyZ2AhIFuAVWFC3uXLKr/WajUEE/dhpPH+S6il4GEXmq8IQZ67SjDyCcedReEhKy+h4YgESgyVneBt+umx+9jiKzypjCbm08QQTHSGv4uCE0bPY8pfcJYdC6TkDZ8/B0zZC8R6IewDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050922; c=relaxed/simple;
	bh=4P6NmsQd9ymTEeqbbtoj/MFmztwiWWpFPE3C3DIaKHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNOtac7NX3GMyPPVOx8Mm6shhOUGK3WVQnRRAWOssOk9879kcJXUGrCnoVvqlrFRtvqhv4O571+jsRhld4lOy+o+3mChZlNBENa08eYNVX0d2FbDNeLs1eU/mQpaTQ3FXH11umWeJtZxza9htDmmKUokM/P+yc+raYulDJt7Tqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqQJ+GdV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E5xRPWUe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EC7920EEB;
	Tue,  2 Apr 2024 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712050918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8a+wnZE91QojPp3DV/yCTs38b1kVho56fYvZnxQs0=;
	b=bqQJ+GdViZ/PcRAUfTqvgjd3mqqtqqTbpRPQifuS/ygPstRqVS+jHnwNIziT6Y2sxeeC8y
	ckr2jVBT0jf1mwnJeKx8NustibVm2uiqE/86dfxvUKWk6oVfKy7jWbMUS8Iy9em6/7Em+v
	x4UYvNYKQ/lgglPS8/hsCw5PFcsbcFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712050918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8a+wnZE91QojPp3DV/yCTs38b1kVho56fYvZnxQs0=;
	b=E5xRPWUeeMOUJ4QbU/2ftypWQ7KnHvURp5ssvETvW31ZcDGYjsCPLy9RSvvfx+gWUvE1IO
	6+EFM0mC+F90a9Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 722A013A90;
	Tue,  2 Apr 2024 09:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BuEkG+bSC2YIAgAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 09:41:58 +0000
Message-ID: <69089796-9a3b-41a1-9b7c-18c773b96aa2@suse.cz>
Date: Tue, 2 Apr 2024 11:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/slub: simplify get_partial_node()
Content-Language: en-US
To: xiongwei.song@windriver.com, rientjes@google.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, chengming.zhou@linux.dev
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-4-xiongwei.song@windriver.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240331021926.2732572-4-xiongwei.song@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.10
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[windriver.com,google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: 8EC7920EEB

On 3/31/24 4:19 AM, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> The break conditions can be more readable and simple.
> 
> We can check if we need to fill cpu partial after getting the first
> partial slab. If kmem_cache_has_cpu_partial() returns true, we fill
> cpu partial from next iteration, or break up the loop.
> 
> Then we can remove the preprocessor condition of
> CONFIG_SLUB_CPU_PARTIAL. Use dummy slub_get_cpu_partial() to make
> compiler silent.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/slub.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 590cc953895d..ec91c7435d4e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2614,18 +2614,20 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  		if (!partial) {
>  			partial = slab;
>  			stat(s, ALLOC_FROM_PARTIAL);
> -		} else {
> -			put_cpu_partial(s, slab, 0);
> -			stat(s, CPU_PARTIAL_NODE);
> -			partial_slabs++;
> +
> +			/* Fill cpu partial if needed from next iteration, or break */
> +			if (kmem_cache_has_cpu_partial(s))

That kinda puts back the check removed in patch 1, although only in the
first iteration. Still not ideal.

> +				continue;
> +			else
> +				break;
>  		}
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		if (partial_slabs > s->cpu_partial_slabs / 2)
> -			break;
> -#else
> -		break;
> -#endif

I'd suggest intead of the changes done in this patch, only change this part
above to:

	if ((slub_get_cpu_partial(s) == 0) ||
	    (partial_slabs > slub_get_cpu_partial(s) / 2))
		break;

That gets rid of the #ifdef and also fixes a weird corner case that if we
set cpu_partial_slabs to 0 from sysfs, we still allocate at least one here.

It could be tempting to use >= instead of > to achieve the same effect but
that would have unintended performance effects that would best be evaluated
separately.

>  
> +		put_cpu_partial(s, slab, 0);
> +		stat(s, CPU_PARTIAL_NODE);
> +		partial_slabs++;
> +
> +		if (partial_slabs > slub_get_cpu_partial(s) / 2)
> +			break;
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return partial;


