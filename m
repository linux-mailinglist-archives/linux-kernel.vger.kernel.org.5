Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272EC812A88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjLNIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:38:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0148ACF;
        Thu, 14 Dec 2023 00:39:02 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74579221EA;
        Thu, 14 Dec 2023 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1702543141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCAxAN1l9jaJtTvJ6E9N1/DLsGXk6YJuQMAKVwbliB0=;
        b=jm2D6nlGxrfWaNWs67pvBi/wEynw0hspA2+7z1brnkX0MUXtXojcOa7O8ly/Ift9ccBbpj
        rpeEQ/B847cdi7Uz5kl0f02DHFgfdsBndRg3fG82R6EXtIEzhEUW6a4VL9ptag7Q1kKrAy
        nyyCeUXsT6DAipwIa6ny8RE3nmhPNjc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1702543141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCAxAN1l9jaJtTvJ6E9N1/DLsGXk6YJuQMAKVwbliB0=;
        b=jm2D6nlGxrfWaNWs67pvBi/wEynw0hspA2+7z1brnkX0MUXtXojcOa7O8ly/Ift9ccBbpj
        rpeEQ/B847cdi7Uz5kl0f02DHFgfdsBndRg3fG82R6EXtIEzhEUW6a4VL9ptag7Q1kKrAy
        nyyCeUXsT6DAipwIa6ny8RE3nmhPNjc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5465D137E8;
        Thu, 14 Dec 2023 08:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id rIyuESW/emWAOwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Thu, 14 Dec 2023 08:39:01 +0000
Date:   Thu, 14 Dec 2023 09:38:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXq_H4St_NSEFkcD@tiehlicka>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213013807.897742-3-schatzberg.dan@gmail.com>
X-Spam-Score: 1.74
X-Spamd-Result: default: False [1.74 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.00)[30.96%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_RATELIMIT(0.00)[to_ip_from(RLhyf994aoi9gdt4d63rk4ux49)];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.16)[-0.806];
         RCPT_COUNT_TWELVE(0.00)[19];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,kernel.org,bytedance.com,lwn.net,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.74
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-12-23 17:38:03, Dan Schatzberg wrote:
> Allow proactive reclaimers to submit an additional swappiness=<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.

You are providing the usecase in the cover letter and Andrew usually
appends that to the first patch in the series. I think it would be
better to have the usecase described here.

[...]
> @@ -1304,6 +1297,18 @@ PAGE_SIZE multiple when read back.
>  	This means that the networking layer will not adapt based on
>  	reclaim induced by memory.reclaim.
>  
> +The following nested keys are defined.
> +
> +	  ==========		================================
> +	  swappiness		Swappiness value to reclaim with
> +	  ==========		================================
> +
> +	Specifying a swappiness value instructs the kernel to perform
> +	the reclaim with that swappiness value. Note that this has the
> +	same semantics as the vm.swappiness sysctl - it sets the

same semantics as vm.swappiness applied to memcg reclaim with all the
existing limitations and potential future extensions.

> +	relative IO cost of reclaiming anon vs file memory but does
> +	not allow for reclaiming specific amounts of anon or file memory.
> +
>    memory.peak
>  	A read-only single value file which exists on non-root
>  	cgroups.

The biggest problem with the implementation I can see, and others have
pointed out the same, is how fragile this is. You really have to check
the code and _every_ place which defines scan_control to learn that
mem_cgroup_shrink_node, reclaim_clean_pages_from_list,
reclaim_folio_list, lru_gen_seq_write, try_to_free_pages, balance_pgdat,
shrink_all_memory and __node_reclaim. I have only checked couple of
them, like direct reclaim and kswapd and none of them really sets up
swappiness to the default memcg nor global value. So you effectively end
up with swappiness == 0.

While the review can point those out it is quite easy to break and you
will only learn about that very indirectly. I think it would be easier
to review and maintain if you go with a pointer that would fallback to
mem_cgroup_swappiness() if NULL which will be the case for every
existing reclaimer except memory.reclaim with swappiness value.
-- 
Michal Hocko
SUSE Labs
