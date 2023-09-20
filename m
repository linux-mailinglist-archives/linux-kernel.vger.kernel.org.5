Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BC7A7575
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjITILK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:11:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB6ADA1;
        Wed, 20 Sep 2023 01:11:02 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 00268212C4B0; Wed, 20 Sep 2023 01:11:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00268212C4B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695197462;
        bh=MCcFdYcZBq72znSVOGs8taMAEPXbYkraDxusQXChN6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KU12UclarmRWfDJZUmgx0gvenLqRo5r/VS7sUpslwGHf4LO3Wws2ZA5jOG84QhruY
         8HhLeUk21ak2eADTaCPLv7qJcrj3VPOyLofny44JVT1JcWCDMyJGhLum8gTiXCOLhN
         zyL+vxc/1fN0wN6vRAIz+G6P9iGEfIDV/r+0ixK4=
Date:   Wed, 20 Sep 2023 01:11:01 -0700
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop kmem.limit_in_bytes
Message-ID: <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191042.204185566@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------

Hi Greg/Michal,

This commit breaks userspace which makes it a bad commit for mainline and an
even worse commit for stable.

We ingested 6.1.54 into our nightly testing and found that runc fails to gather
cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
fine.

> Address this by wiping out the file completely and effectively get back to
> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.

On reads, the runc code checks for MEMCG_KMEM=n by checking
kmem.usage_in_bytes. If it is present then runc expects the other cgroup files
to be there (including kmem.limit_in_bytes). So this change is not effectively
the same.

Here's a link to the PR that would be needed to handle this change in userspace
(not merged yet and would need to be propagated through the ecosystem):

https://github.com/opencontainers/runc/pull/4018.

Jeremi

> 
> From: Michal Hocko <mhocko@suse.com>
> 
> commit 86327e8eb94c52eca4f93cfece2e29d1bf52acbf upstream.
> 
> kmem.limit_in_bytes (v1 way to limit kernel memory usage) has been
> deprecated since 58056f77502f ("memcg, kmem: further deprecate
> kmem.limit_in_bytes") merged in 5.16.  We haven't heard about any serious
> users since then but it seems that the mere presence of the file is
> causing more harm thatn good.  We (SUSE) have had several bug reports from
> customers where Docker based containers started to fail because a write to
> kmem.limit_in_bytes has failed.
> 
> This was unexpected because runc code only expects ENOENT (kmem disabled)
> or EBUSY (tasks already running within cgroup).  So a new error code was
> unexpected and the whole container startup failed.  This has been later
> addressed by
> https://github.com/opencontainers/runc/commit/52390d68040637dfc77f9fda6bbe70952423d380
> so current Docker runtimes do not suffer from the problem anymore.  There
> are still older version of Docker in use and likely hard to get rid of
> completely.
> 
> Address this by wiping out the file completely and effectively get back to
> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
> 
> I would recommend backporting to stable trees which have picked up
> 58056f77502f ("memcg, kmem: further deprecate kmem.limit_in_bytes").
> 
> [mhocko@suse.com: restore _KMEM switch case]
>   Link: https://lkml.kernel.org/r/ZKe5wxdbvPi5Cwd7@dhcp22.suse.cz
> Link: https://lkml.kernel.org/r/20230704115240.14672-1-mhocko@kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst |    2 --
>  mm/memcontrol.c                                |   10 ----------
>  2 files changed, 12 deletions(-)
> 
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -91,8 +91,6 @@ Brief summary of control files.
>   memory.oom_control		     set/show oom controls.
>   memory.numa_stat		     show the number of memory usage per numa
>  				     node
> - memory.kmem.limit_in_bytes          This knob is deprecated and writing to
> -                                     it will return -ENOTSUPP.
>   memory.kmem.usage_in_bytes          show current kernel memory allocation
>   memory.kmem.failcnt                 show the number of kernel memory usage
>  				     hits limits
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3841,10 +3841,6 @@ static ssize_t mem_cgroup_write(struct k
>  		case _MEMSWAP:
>  			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
>  			break;
> -		case _KMEM:
> -			/* kmem.limit_in_bytes is deprecated. */
> -			ret = -EOPNOTSUPP;
> -			break;
>  		case _TCP:
>  			ret = memcg_update_tcp_max(memcg, nr_pages);
>  			break;
> @@ -5056,12 +5052,6 @@ static struct cftype mem_cgroup_legacy_f
>  	},
>  #endif
>  	{
> -		.name = "kmem.limit_in_bytes",
> -		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
> -		.write = mem_cgroup_write,
> -		.read_u64 = mem_cgroup_read_u64,
> -	},
> -	{
>  		.name = "kmem.usage_in_bytes",
>  		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
>  		.read_u64 = mem_cgroup_read_u64,
> 
> 
