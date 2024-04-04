Return-Path: <linux-kernel+bounces-131166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7D8983F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95A288F29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F67443E;
	Thu,  4 Apr 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ks1K9p+y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fFQdm6+o"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79E74BE5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222814; cv=none; b=TFmduMQtkr+KxjZ3udCcpnGAzoQhHtjJvFq8eg5X/afAXqyM6yU0+ROW0cqOJPAo68yZps0Whr84NGohG9SU8V5NAieLa4zjP7tlJ9EJcvcVoJ2p+OxpR8HbaoEyjGKoR/NoHCnhBaHE3HRxhNQVRSeROADSE/NfpAU1czKAQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222814; c=relaxed/simple;
	bh=lfE8JfpNDJwwkt2EwjekZvO6E9caYSoLl1n5nw5zKu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVOi8NsFiMRH74JGloE9vMv+UiJixCm/Mc0GolD+DDfZ4WdKZk5S3E+n7iclf/JYF6bKZt2c2IOphWW8nRhr0tu6RIIx6lOMu3HFCm+1f22Y/hMr+ku7mvYPy+STf5//0uHR5C4pO/CIQExFZtlW+UdtjOgN6UVpo5pzzD/Tbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ks1K9p+y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fFQdm6+o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 431FC210A4;
	Thu,  4 Apr 2024 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712222808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K718IVs++aefO+JflhqPFBhOVoNtCDSYrTOiw2Ex8WA=;
	b=ks1K9p+yBDuu9YIEeEmwrOVbuWk9S7XKnGQLAiyd34d99+nVSLAYW8wEuu2k8l2rHB7dRe
	5YMA4rF44tX3AC8/j7tyK/V+hAMfJNskXKOQFeehjXJSIbXSg9AmyGI6hf0EPhR8BWgiUD
	6oEI0p1THxBH7a01nDIAcn7zm01F05g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712222808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K718IVs++aefO+JflhqPFBhOVoNtCDSYrTOiw2Ex8WA=;
	b=fFQdm6+osuqhnhojugEiowU1K1ecB+hf5JKZ0/UgLwy3mAboBWwU4Tae5Zx4ACG1lfEVu1
	tYqbKVmhRWTmVyDw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 282FD139E8;
	Thu,  4 Apr 2024 09:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KmF7CVhyDmbXIwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Thu, 04 Apr 2024 09:26:48 +0000
Message-ID: <8a2890f0-108f-4fca-98e1-913373aa2cff@suse.cz>
Date: Thu, 4 Apr 2024 11:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/slub: simplify get_partial_node()
Content-Language: en-US
To: xiongwei.song@windriver.com, rientjes@google.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, chengming.zhou@linux.dev
References: <20240404055826.1469415-1-xiongwei.song@windriver.com>
 <20240404055826.1469415-4-xiongwei.song@windriver.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240404055826.1469415-4-xiongwei.song@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[windriver.com,google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,windriver.com:email]
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Flag: NO

On 4/4/24 7:58 AM, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> The break conditions for filling cpu partial can be more readable and
> simple.
> 
> If slub_get_cpu_partial() returns 0, we can confirm that we don't need
> to fill cpu partial, then we should break from the loop. On the other
> hand, we also should break from the loop if we have added enough cpu
> partial slabs.
> 
> Meanwhile, the logic above gets rid of the #ifdef and also fixes a weird
> corner case that if we set cpu_partial_slabs to 0 from sysfs, we still
> allocate at least one here.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
> 
> The measurement below is to compare the performance effects when checking
> if we need to break from the filling cpu partial loop with the following
> either-or condition:
> 
> Condition 1:
> When the count of added cpu slabs is greater than cpu_partial_slabs/2:
> (partial_slabs > slub_get_cpu_partial(s) / 2)
> 
> Condition 2:
> When the count of added cpu slabs is greater than or equal to
> cpu_partial_slabs/2:
> (partial_slabs >= slub_get_cpu_partial(s) / 2)
> 
> The change of breaking condition can effect how many cpu partial slabs
> would be put on the cpu partial list.
> 
> Run the test with a "Intel(R) Core(TM) i7-10700 CPU @ 2.90GHz" cpu with
> 16 cores. The OS is Ubuntu 22.04.
> 
> hackbench-process-pipes
>                   6.9-rc2(with ">")      6.9.0-rc2(with ">=")
> Amean     1       0.0373 (   0.00%)      0.0356 *   4.60%*
> Amean     4       0.0984 (   0.00%)      0.1014 *  -3.05%*
> Amean     7       0.1803 (   0.00%)      0.1851 *  -2.69%*
> Amean     12      0.2947 (   0.00%)      0.3141 *  -6.59%*
> Amean     21      0.4577 (   0.00%)      0.4927 *  -7.65%*
> Amean     30      0.6326 (   0.00%)      0.6649 *  -5.10%*
> Amean     48      0.9396 (   0.00%)      0.9884 *  -5.20%*
> Amean     64      1.2321 (   0.00%)      1.3004 *  -5.54%*
> 
> hackbench-process-sockets
>                   6.9-rc2(with ">")      6.9.0-rc2(with ">=")
> Amean     1       0.0609 (   0.00%)      0.0623 *  -2.35%*
> Amean     4       0.2107 (   0.00%)      0.2140 *  -1.56%*
> Amean     7       0.3754 (   0.00%)      0.3966 *  -5.63%*
> Amean     12      0.6456 (   0.00%)      0.6734 *  -4.32%*
> Amean     21      1.1440 (   0.00%)      1.1769 *  -2.87%*
> Amean     30      1.6629 (   0.00%)      1.7031 *  -2.42%*
> Amean     48      2.7321 (   0.00%)      2.7897 *  -2.11%*
> Amean     64      3.7397 (   0.00%)      3.7640 *  -0.65%*
> 
> It seems there is a bit performance penalty when using ">=" to break up
> the loop. Hence, we should still use ">" here.

Thanks for evaluating that, I suspected that would be the case so we should
not change that performance aspect as part of a cleanup.

> ---
>  mm/slub.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 590cc953895d..6beff3b1e22c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2619,13 +2619,10 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  			stat(s, CPU_PARTIAL_NODE);
>  			partial_slabs++;
>  		}
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		if (partial_slabs > s->cpu_partial_slabs / 2)
> -			break;
> -#else
> -		break;
> -#endif
>  
> +		if ((slub_get_cpu_partial(s) == 0) ||
> +		    (partial_slabs > slub_get_cpu_partial(s) / 2))
> +			break;
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return partial;

After looking at the result and your v1 again, I arrived at this
modification that incorporates the core v1 idea without reintroducing
kmem_cache_has_cpu_partial(). The modified patch looks like below. Is it OK
with you? Pushed the whole series with this modification to slab/for-next
for now.

----8<-----
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2614,18 +2614,17 @@ static struct slab *get_partial_node(struct kmem_cache *s,
                if (!partial) {
                        partial = slab;
                        stat(s, ALLOC_FROM_PARTIAL);
+                       if ((slub_get_cpu_partial(s) == 0)) {
+                               break;
+                       }
                } else {
                        put_cpu_partial(s, slab, 0);
                        stat(s, CPU_PARTIAL_NODE);
-                       partial_slabs++;
-               }
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-               if (partial_slabs > s->cpu_partial_slabs / 2)
-                       break;
-#else
-               break;
-#endif
 
+                       if (++partial_slabs > slub_get_cpu_partial(s) / 2) {
+                               break;
+                       }
+               }
        }
        spin_unlock_irqrestore(&n->list_lock, flags);
        return partial;


