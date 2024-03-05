Return-Path: <linux-kernel+bounces-92063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D613871A54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C041F22211
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D954794;
	Tue,  5 Mar 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ORGRaPXB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eqw32iux";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7ewie3s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oCIKzPXv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0240535BE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633676; cv=none; b=uEicsvx5wVj+WIrSmB3yB2LdIMwnXTp9TmHLFRTeCE3SlSAXzuftRinJ7cjxTLF9asFHJ66xcmRdAL0cIqw3ogQeST4aPbzCqSP77rWbtaSoBaplhDk3X6KNirAytALm83IBTC1yUF152fevuMDF3UZLpEopen3TjALav8aNQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633676; c=relaxed/simple;
	bh=kLtgZqnnwg4vuH/erqqbbZfLGLt0RqP0jwFlpvrPu1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGv4Lk2LVVpmNNoNJjt2guwNP6xFBSa2C9S7HQw6/n1vj911ufTL4qFFiAWxJx88ftMsh+svOWKmhwq+0ODgdSrOJsHZ1I8jQ4dR6CIiutVmytLJWW4IHCZV2Gjm0VBIDQsH93azqMcCA2v1nE+Kk6gLIr6vInJmokoL9y4pUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ORGRaPXB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eqw32iux; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7ewie3s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oCIKzPXv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA4D676B92;
	Tue,  5 Mar 2024 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709633673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kkr6ARiJ03khTdzC3k+puse6CFNVn3fbphN67eYRLHw=;
	b=ORGRaPXB5yjle3asOdY+3T+Jh5NQJ8QcH1mlc+JW5J4kP77EhKJ1ZWyDWXQZAd3W8bc3/g
	Mjmq70Dax29DE/gudNn+ZjKzvkKR2T3d6Zr7hHOxjqLtmNEwB+WpU1xrWbKpD/CoJhF7Rc
	tJEdQ2lakdWl22oXRdmcyAsDbcJMIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709633673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kkr6ARiJ03khTdzC3k+puse6CFNVn3fbphN67eYRLHw=;
	b=eqw32iuxKGFDJxWwDm67e+YYeZzWf1mB/smoyJLyoeoQejNtwSWnhG1lsjs/QRplUsVLs1
	8/fpqFrCEJUXPTBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709633672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kkr6ARiJ03khTdzC3k+puse6CFNVn3fbphN67eYRLHw=;
	b=J7ewie3s6jFZeIgwNq3TOWq5y8u/r3OiFztEmbkqm9kupy3HB4IdqyT/tmAgY03sHguJL4
	kS4oUzhPyBP8c+5RrbRqX4OeAGQgV9vxZCpQHN6C5K0yov/+65dezE6W+gEDGm/M2vKqMz
	XZ0r9rDgkP+7YlK+8WSZJum2YS2XK+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709633672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kkr6ARiJ03khTdzC3k+puse6CFNVn3fbphN67eYRLHw=;
	b=oCIKzPXvvyn48myWXqc13D5qMIwDDNkeGmVEXpNlMhpuqy0HAUGvOtgPOVnsdMMQGKYQgF
	ppE5ZbtW6d2EM6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD747139D0;
	Tue,  5 Mar 2024 10:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q47xMYjw5mVkFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Mar 2024 10:14:32 +0000
Message-ID: <80269a92-1242-49be-97c5-315c0621a1d3@suse.cz>
Date: Tue, 5 Mar 2024 11:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: remove PARTIAL_NODE slab_state
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240305083913.1494784-1-chengming.zhou@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240305083913.1494784-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.36
X-Spamd-Result: default: False [-0.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 BAYES_HAM(-0.57)[81.31%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 3/5/24 09:39, Chengming Zhou wrote:
> The PARTIAL_NODE slab_state has gone with SLAB removed, so just
> remove it.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks, queued.

> ---
>  mm/slab.h                  | 1 -
>  tools/include/linux/slab.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 96cb74be4b69..d2bc9b191222 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -363,7 +363,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
>  enum slab_state {
>  	DOWN,			/* No slab functionality yet */
>  	PARTIAL,		/* SLUB: kmem_cache_node available */
> -	PARTIAL_NODE,		/* SLAB: kmalloc size for node struct available */
>  	UP,			/* Slab caches usable but not all extras yet */
>  	FULL			/* Everything is working */
>  };
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index 311759ea25e9..51b25e9c4ec7 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -18,7 +18,6 @@ bool slab_is_available(void);
>  enum slab_state {
>  	DOWN,
>  	PARTIAL,
> -	PARTIAL_NODE,
>  	UP,
>  	FULL
>  };

