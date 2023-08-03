Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7176E5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjHCKfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjHCKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:35:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B019B0;
        Thu,  3 Aug 2023 03:34:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C07B1F853;
        Thu,  3 Aug 2023 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691058898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYn5KTL6hoclU8R8tOQwMLLVXag1TZw3PWIRsarQ/JU=;
        b=WHS9GyBrNm1Q32Q6akgqrEDRLlMuziSOm0sS4ZqVqfoCCLRBcGOGliKsEUOpvB8pdK8gaq
        2irAU7N+SJj+EQGj6IFxUk8oyYdSCHAp3WE4ozKfWaqRiJhmEFb0sisnHahQllSvMz8hS/
        ZdPh43f2o/87KkA0OZKU7GTqq9RVN3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691058898;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYn5KTL6hoclU8R8tOQwMLLVXag1TZw3PWIRsarQ/JU=;
        b=+PeNjKME0A1mlH6xUdfp4hc1szcFjxSYfCFO3FRSxlnXJDNvqAFJA1qwv0GDK20ivobkvD
        my5WiFPlCRqr8LCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C24FD134B0;
        Thu,  3 Aug 2023 10:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BDi+LtGCy2RrFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Aug 2023 10:34:57 +0000
Message-ID: <8a08b7aa-ce1f-4b3d-abb5-cf3191474725@suse.cz>
Date:   Thu, 3 Aug 2023 12:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v5 3/3] mm: Dump the memory of slab object in
 kmem_dump_obj()
Content-Language: en-US
To:     thunder.leizhen@huaweicloud.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
References: <20230803101754.1149-1-thunder.leizhen@huaweicloud.com>
 <20230803101754.1149-4-thunder.leizhen@huaweicloud.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230803101754.1149-4-thunder.leizhen@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 12:17, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The contents of the slab object may contain some magic words and other
> useful information that may be helpful in locating problems such as
> memory corruption and use-after-free.
> 
> To avoid print flooding, dump up to "16 * sizeof(int) = 64" bytes
> centered on argument 'ojbect'.
> 
> For example:
> slab kmalloc-64 start ffff4043802d8b40 pointer offset 24 size 64
> [8b40]: 12345678 00000000 8092d000 ffff8000
> [8b50]: 00101000 00000000 8199ee00 ffff4043
> [8b60]: 00000000 00000000 00000000 00000100
> [8b70]: 00000000 9abcdef0 a8744de4 ffffc7fe
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  mm/slab_common.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ee6ed6dd7ba9fa5..0232de9a3b29cf5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -553,7 +553,7 @@ static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *
>  bool kmem_dump_obj(void *object)
>  {
>  	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
> -	int i;
> +	int i, object_size = 0;
>  	struct slab *slab;
>  	unsigned long ptroffset;
>  	struct kmem_obj_info kp = { };
> @@ -580,12 +580,36 @@ bool kmem_dump_obj(void *object)
>  		ptroffset = ((char *)object - (char *)kp.kp_objp) - kp.kp_data_offset;
>  		pr_cont(" pointer offset %lu", ptroffset);
>  	}
> -	if (kp.kp_slab_cache && kp.kp_slab_cache->object_size)
> -		pr_cont(" size %u", kp.kp_slab_cache->object_size);
> +	if (kp.kp_slab_cache && kp.kp_slab_cache->object_size) {
> +		object_size = kp.kp_slab_cache->object_size;
> +		pr_cont(" size %u", object_size);
> +	}
>  	if (kp.kp_ret)
>  		pr_cont(" allocated at %pS\n", kp.kp_ret);
>  	else
>  		pr_cont("\n");
> +
> +	/* Dump a small piece of memory centered on 'object' */
> +	if (kp.kp_objp && object_size) {
> +		int *p = object, n = 16;
> +
> +		p += n / 2;
> +		if ((void *)p > kp.kp_objp + object_size)
> +			p = kp.kp_objp + object_size;
> +
> +		p -= n;
> +		if ((void *)p < kp.kp_objp)
> +			p = kp.kp_objp;
> +
> +		n = min_t(int, object_size / sizeof(int), n);
> +		for (i = 0; i < n; i++, p++) {
> +			if (i % 4 == 0)
> +				pr_info("[%04lx]:", 0xffff & (unsigned long)p);
> +			pr_cont(" %08x", *p);
> +		}
> +		pr_cont("\n");

There's a print_hex_dump() for this, see how it's used from e.g. __dump_page().


> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
>  		if (!kp.kp_stack[i])
>  			break;

