Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F9797719
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbjIGQVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbjIGQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286B6A59;
        Thu,  7 Sep 2023 09:17:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84A5E2185A;
        Thu,  7 Sep 2023 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694069595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JftswgzMi1yTthK09YjvkREc+mptG29T3G2e3TGgDE4=;
        b=kJqlzL9IxHHlFpgqGzCQAkKVpNMWEPdMi/9IGRgS4jRjb/fUf1NNaKhMiJvUkzgLkS9vaT
        +G5yS0ORsUL7K8FL8X/aUIZiznw8eUPN1p408P/a9JbTZ8GjA2Yq8Td0UfZtuuHd0urrJJ
        ZUki1w6+YKbBfcUFjWrcrrGkp95bC3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694069595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JftswgzMi1yTthK09YjvkREc+mptG29T3G2e3TGgDE4=;
        b=SxMHmyMT1ihgn5YPNa64XVJGnNxHRuAFWX8DeGPEKYxW4TpVZEaE6O+aZKm0oncN+KWQvj
        sUoxgnv6PACUsWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C5611358B;
        Thu,  7 Sep 2023 06:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tKHvEVtz+WR0fAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Sep 2023 06:53:15 +0000
Message-ID: <49ff5505-5a4a-1ad5-8552-6e79a91ee8c9@suse.cz>
Date:   Thu, 7 Sep 2023 08:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huaweicloud.com>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
References: <20230904180806.1002832-1-joel@joelfernandes.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230904180806.1002832-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/4/23 20:08, Joel Fernandes (Google) wrote:
> It is unsafe to dump vmalloc area information when trying to do so from
> some contexts. Add a safer trylock version of the same function to do a
> best-effort VMA finding and use it from vmalloc_dump_obj().

I was a bit confused by the subject which suggests a new function is added,
but it seems open-coded in its only caller. I assume it's due to evolution
of the series. Something like:

mm/vmalloc: use trylock for vmap_area_lock in vmalloc_dump_obj()

?

I also notice it's trying hard to copy everything from "vm" to temporary
variables before unlocking, presumably to prevent use-after-free, so should
that be also mentioned in the changelog?

> [applied test robot feedback on unused function fix.]
> [applied Uladzislau feedback on locking.]
> 
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: rcu@vger.kernel.org
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/vmalloc.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..2c6a0e2ff404 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  #ifdef CONFIG_PRINTK
>  bool vmalloc_dump_obj(void *object)
>  {
> -	struct vm_struct *vm;
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> +	const void *caller;
> +	struct vm_struct *vm;
> +	struct vmap_area *va;
> +	unsigned long addr;
> +	unsigned int nr_pages;
>  
> -	vm = find_vm_area(objp);
> -	if (!vm)
> +	if (!spin_trylock(&vmap_area_lock))
> +		return false;
> +	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> +	if (!va) {
> +		spin_unlock(&vmap_area_lock);
>  		return false;
> +	}
> +
> +	vm = va->vm;
> +	if (!vm) {
> +		spin_unlock(&vmap_area_lock);
> +		return false;
> +	}
> +	addr = (unsigned long)vm->addr;
> +	caller = vm->caller;
> +	nr_pages = vm->nr_pages;
> +	spin_unlock(&vmap_area_lock);
>  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> -		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> +		nr_pages, addr, caller);
>  	return true;
>  }
>  #endif

