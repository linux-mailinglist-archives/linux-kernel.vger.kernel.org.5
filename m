Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC17EE502
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjKPQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKPQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:14:57 -0500
X-Greylist: delayed 48188 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 08:14:53 PST
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58230D52;
        Thu, 16 Nov 2023 08:14:53 -0800 (PST)
Date:   Thu, 16 Nov 2023 08:14:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700151291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hCdpp6WuZChEageao1OSIKSoEG+NAbC7V6anMmbVTw=;
        b=TVdt2kLp10lwI+ILX1XByT8I+aaSEG8dC0FNt5MlTwdFHJronmgM3TnX8Qb4qst1QSx8Cz
        f0yIoOMyhXs6F7sB0f6AKux87PkRWi9SaL5Ps7gX/Gww/JVvs+GjPGXhsH5w+sDRuuRPvb
        LLFrWkw8YLZo+KywKweZogBeAG62lAg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: kmem: properly initialize local objcg variable in
 current_obj_cgroup()
Message-ID: <ZVY_9-NqTzDj5yFR@P9FQF9L96D.corp.robot.car>
References: <20231116025109.3775055-1-roman.gushchin@linux.dev>
 <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 08:04:18AM +0100, Vlastimil Babka wrote:
> On 11/16/23 03:51, Roman Gushchin wrote:
> > Actually the problem is caused by uninitialized local variable in
> > current_obj_cgroup(). If the root memory cgroup is set as an active
> > memory cgroup for a charging scope (as in the trace, where systemd
> > tries to create the first non-root cgroup, so the parent cgroup is
> > the root cgroup), the "for" loop is skipped and uninitialized objcg is
> > returned, causing a panic down the accounting stack.
> > 
> > The fix is trivial: initialize the objcg variable to NULL
> > unconditionally before the "for" loop.
> > 
> > Fixes: e86828e5446d ("mm: kmem: scoped objcg protection")
> > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1959
> > Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: stable@vger.kernel.org
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
> 
> We could also do this to make it less confusing?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..a08bcec661b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3175,7 +3175,6 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  		objcg = rcu_dereference_check(memcg->objcg, 1);
>  		if (likely(objcg))
>  			break;
> -		objcg = NULL;
>  	}
>  
>  	return objcg;

Yeah, good catch, it's a remaining of the code with try_get() inside
the loop.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
