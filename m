Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB027EDBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjKPHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:04:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D771192;
        Wed, 15 Nov 2023 23:04:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 818AC228F8;
        Thu, 16 Nov 2023 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700118259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpPRcxQ5IiHGTAj6tgpbwrduKyzSuCcDvStD8GSl+y8=;
        b=afYDxkq5miwZnwVOvswSzpRNWbmJphZ00V5EhAfqDMtn0mODHh/Yl72DKtcjhFh8rm5GFl
        1F9aFP+XhltXUYs4kbt5zijVrucVGn2IAS7IXhkbYnWCmM2wY7NxxGztcH/oQ8+ijfVnXB
        fktOOjTPZRdkT6HCC6qflIu0vLubuYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700118259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpPRcxQ5IiHGTAj6tgpbwrduKyzSuCcDvStD8GSl+y8=;
        b=6hKjd+VNaIQALyi0U+PGWfKHk6TdjAXs63eYJgYKLy7HNOwvJgT9kWt1OWMwZnOccwi0ao
        UWYRD4xA/XTMTRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BC9C139C4;
        Thu, 16 Nov 2023 07:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ly+6EfO+VWVmOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Nov 2023 07:04:19 +0000
Message-ID: <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
Date:   Thu, 16 Nov 2023 08:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: kmem: properly initialize local objcg variable in
 current_obj_cgroup()
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
References: <20231116025109.3775055-1-roman.gushchin@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231116025109.3775055-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.00)[41.80%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.18)[-0.920];
         RCPT_COUNT_SEVEN(0.00)[11];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 03:51, Roman Gushchin wrote:
> Actually the problem is caused by uninitialized local variable in
> current_obj_cgroup(). If the root memory cgroup is set as an active
> memory cgroup for a charging scope (as in the trace, where systemd
> tries to create the first non-root cgroup, so the parent cgroup is
> the root cgroup), the "for" loop is skipped and uninitialized objcg is
> returned, causing a panic down the accounting stack.
> 
> The fix is trivial: initialize the objcg variable to NULL
> unconditionally before the "for" loop.
> 
> Fixes: e86828e5446d ("mm: kmem: scoped objcg protection")
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1959
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: stable@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

We could also do this to make it less confusing?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 774bd6e21e27..a08bcec661b6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3175,7 +3175,6 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		objcg = rcu_dereference_check(memcg->objcg, 1);
 		if (likely(objcg))
 			break;
-		objcg = NULL;
 	}
 
 	return objcg;


> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..b138501e6489 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3165,6 +3165,7 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  	return NULL;
>  
>  from_memcg:
> +	objcg = NULL;
>  	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>  		/*
>  		 * Memcg pointer is protected by scope (see set_active_memcg())

