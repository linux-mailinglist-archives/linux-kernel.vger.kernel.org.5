Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C2479C08F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378174AbjIKWah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjIKPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:06:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21308FA;
        Mon, 11 Sep 2023 08:06:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F33AC21846;
        Mon, 11 Sep 2023 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694444777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3NcnsHGknnJ7cHnY26g+rBrlWoffQOAc/XoZUQrCqrY=;
        b=g2e0Ix0WsXHVCtUfFNlRtCpzELg+W/oxqEGec2hZa3MeHjKus+/qaaOhvf96HesTyEvrzG
        Cb8OhyXbiYoRNFZVxBo1gAG0cH52Ev4T+pYWKmLkmkPzrVPPY4IQE0+3CScGI27jeWb3DP
        D6CCBToElZc5Fpw2u1AKU9ajd9PIXbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694444777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3NcnsHGknnJ7cHnY26g+rBrlWoffQOAc/XoZUQrCqrY=;
        b=m19VrTzdO70dmwg2PHQaue4EnWq9K83S5nwPVtmESXQkrK+k2wzjBszTXydG16EyTzdeYn
        1so5MJSnQbD0oqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94851139CC;
        Mon, 11 Sep 2023 15:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0oA5Iegs/2TXXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Sep 2023 15:06:16 +0000
Message-ID: <afaa8691-0be9-4574-a87d-aab68c7a49b3@suse.cz>
Date:   Mon, 11 Sep 2023 17:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab_common: fix slab_caches list corruption after
 kmem_cache_destroy()
Content-Language: en-US
To:     Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Rafael Aquini <raquini@redhat.com>, stable@vger.kernel.org
References: <20230908230649.802560-1-aquini@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 tR6d+JzM8nFUZA==
In-Reply-To: <20230908230649.802560-1-aquini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/23 01:06, Rafael Aquini wrote:
> After the commit in Fixes:, if a module that created a slab cache does not
> release all of its allocated objects before destroying the cache (at rmmod
> time), we might end up releasing the kmem_cache object without removing it
> from the slab_caches list thus corrupting the list as kmem_cache_destroy()
> ignores the return value from shutdown_cache(), which in turn never removes
> the kmem_cache object from slabs_list in case __kmem_cache_shutdown() fails
> to release all of the cache's slabs.
> 
> This is easily observable on a kernel built with CONFIG_DEBUG_LIST=y
> as after that ill release the system will immediately trip on list_add,
> or list_del, assertions similar to the one shown below as soon as another
> kmem_cache gets created, or destroyed:
> 
>   [ 1041.213632] list_del corruption. next->prev should be ffff89f596fb5768, but was 52f1e5016aeee75d. (next=ffff89f595a1b268)
>   [ 1041.219165] ------------[ cut here ]------------
>   [ 1041.221517] kernel BUG at lib/list_debug.c:62!
>   [ 1041.223452] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   [ 1041.225408] CPU: 2 PID: 1852 Comm: rmmod Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
>   [ 1041.228244] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
>   [ 1041.231212] RIP: 0010:__list_del_entry_valid+0xae/0xb0
> 
> Another quick way to trigger this issue, in a kernel with CONFIG_SLUB=y,
> is to set slub_debug to poison the released objects and then just run
> cat /proc/slabinfo after removing the module that leaks slab objects,
> in which case the kernel will panic:
> 
>   [   50.954843] general protection fault, probably for non-canonical address 0xa56b6b6b6b6b6b8b: 0000 [#1] PREEMPT SMP PTI
>   [   50.961545] CPU: 2 PID: 1495 Comm: cat Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
>   [   50.966808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
>   [   50.972663] RIP: 0010:get_slabinfo+0x42/0xf0
> 
> This patch fixes this issue by properly checking shutdown_cache()'s
> return value before taking the kmem_cache_release() branch.
> 
> Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> Cc: stable@vger.kernel.org

Thanks, added to slab.git. Tweaked the code a bit:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.6/hotfixes&id=46a9ea6681907a3be6b6b0d43776dccc62cad6cf

> ---
>  mm/slab_common.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index cd71f9581e67..31e581dc6e85 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -479,7 +479,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
>  
>  void kmem_cache_destroy(struct kmem_cache *s)
>  {
> -	int refcnt;
> +	int err;
>  	bool rcu_set;
>  
>  	if (unlikely(!s) || !kasan_check_byte(s))
> @@ -490,17 +490,20 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  
>  	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
>  
> -	refcnt = --s->refcount;
> -	if (refcnt)
> +	s->refcount--;
> +	if (s->refcount) {
> +		err = -EBUSY;
>  		goto out_unlock;
> +	}
>  
> -	WARN(shutdown_cache(s),
> +	err = shutdown_cache(s);
> +	WARN(err,
>  	     "%s %s: Slab cache still has objects when called from %pS",
>  	     __func__, s->name, (void *)_RET_IP_);
>  out_unlock:
>  	mutex_unlock(&slab_mutex);
>  	cpus_read_unlock();
> -	if (!refcnt && !rcu_set)
> +	if (!err && !rcu_set)
>  		kmem_cache_release(s);
>  }
>  EXPORT_SYMBOL(kmem_cache_destroy);

