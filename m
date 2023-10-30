Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2058C7DBF87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjJ3SLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjJ3SLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:11:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA37CC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:11:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 713D41F38C;
        Mon, 30 Oct 2023 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698689463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gKDFOEPmhqeqgEnPsJX/gtAMRMS09FFpFfsCT7nylw=;
        b=PPa94rF6SmntBiDNKBoLhVuSW02pU+ugAPhNI0SSzoz/akaOf6kPGuS5UhxYuavBqT/jqb
        gbqfXsbQClZbed5V0YjeAoKZsisK3Hpn7hDbCULivUtzrGE3e1NJE2JlBHXyCtPr9cIyOg
        sd1A5LPcEMM7acMrJi7PX4nYIdKOj2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698689463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gKDFOEPmhqeqgEnPsJX/gtAMRMS09FFpFfsCT7nylw=;
        b=1/23uOztM2hXq3WV635Bl+sEZlxQEbb01b6Kr47P21pm/8MiQru2RBDzL3OdDwbXtm2t5J
        l1I2riomtpEJygBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4570E138EF;
        Mon, 30 Oct 2023 18:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zrNOELfxP2WHRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 30 Oct 2023 18:11:03 +0000
Message-ID: <e40a5393-14b6-017f-cfcb-a938ed1cf455@suse.cz>
Date:   Mon, 30 Oct 2023 19:11:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 5/7] slub: Introduce freeze_slab()
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-6-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231024093345.3676493-6-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We will have unfrozen slabs out of the node partial list later, so we
> need a freeze_slab() function to freeze the partial slab and get its
> freelist.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

As you noted, we'll need slab_update_freelist().
Otherwise,

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 7d0234bffad3..5b428648021f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3079,6 +3079,33 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>  	return freelist;
>  }
>  
> +/*
> + * Freeze the partial slab and return the pointer to the freelist.
> + */
> +static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
> +{
> +	struct slab new;
> +	unsigned long counters;
> +	void *freelist;
> +
> +	do {
> +		freelist = slab->freelist;
> +		counters = slab->counters;
> +
> +		new.counters = counters;
> +		VM_BUG_ON(new.frozen);
> +
> +		new.inuse = slab->objects;
> +		new.frozen = 1;
> +
> +	} while (!__slab_update_freelist(s, slab,
> +		freelist, counters,
> +		NULL, new.counters,
> +		"freeze_slab"));
> +
> +	return freelist;
> +}
> +
>  /*
>   * Slow path. The lockless freelist is empty or we need to perform
>   * debugging duties.

