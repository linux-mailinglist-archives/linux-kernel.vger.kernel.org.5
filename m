Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CE7AA1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjIUVGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjIUVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D86EE4E5ED;
        Thu, 21 Sep 2023 10:17:21 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8EBC7212C5B4;
        Thu, 21 Sep 2023 03:43:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EBC7212C5B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695292989;
        bh=SOX5o5oyS7LBbpizIPBbrtijPHb6zgqQsGJ5vxNHoRg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KS6RUS3maeHbxTGmUE9NWlj60qEleuPTBYYk8JsyzO4q+sPwdZ//gABDcp7SHFTee
         /HMZ15pczaXyx4Wt3T0Vx2enaJFbBL2dpK8qSyfX4WFsQwsfwfJ2CFSZWIx4ULFx8X
         +p5xFjwwMSC9rbg7dOFDrm3Lzd9qo9uGqLViDvxg=
Message-ID: <f01b5d93-0f43-41c8-b3d8-40ef9696dcf8@linux.microsoft.com>
Date:   Thu, 21 Sep 2023 12:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
References: <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
 <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
 <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
 <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
 <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz>
 <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
 <ZQv2MXOynlEPW/bX@dhcp22.suse.cz>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <ZQv2MXOynlEPW/bX@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2023 9:52 AM, Michal Hocko wrote:
> On Wed 20-09-23 14:46:52, Shakeel Butt wrote:
>> On Wed, Sep 20, 2023 at 1:08 PM Michal Hocko <mhocko@suse.com> wrote:
>>>
>> [...]
>>>> have a strong opinion against it. Also just to be clear we are not
>>>> talking about full revert of 58056f77502f but just the returning of
>>>> EOPNOTSUPP, right?
>>>
>>> If we allow the limit to be set without returning a failure then we
>>> still have options 2 and 3 on how to deal with that. One of them is to
>>> enforce the limit.
>>>
>>
>> Option 3 is a partial revert of 58056f77502f where we keep the no
>> limit enforcement and remove the EOPNOTSUPP return on write. Let's go
>> with option 3. In addition, let's add pr_warn_once on the read of
>> kmem.limit_in_bytes as well.
> 
> How about this?
> --- 

I'm OK with this approach. You're missing this in the patch below:

// static struct cftype mem_cgroup_legacy_files[] = {

+       {
+               .name = "kmem.limit_in_bytes",
+               .private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+               .write = mem_cgroup_write,
+               .read_u64 = mem_cgroup_read_u64,
+       },


Thanks,
Jeremi

>>From 81ae0797d8da1b9cfbf357b4be4787a5bbf46bb4 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 21 Sep 2023 09:38:29 +0200
> Subject: [PATCH] mm, memcg: reconsider kmem.limit_in_bytes deprecation
> 
> This reverts commits 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
> and partially reverts 58056f77502f ("memcg, kmem: further deprecate
> kmem.limit_in_bytes") which have incrementally removed support for the
> kernel memory accounting hard limit. Unfortunately it has turned out
> that there is still userspace depending on the existence of
> memory.kmem.limit_in_bytes [1]. The underlying functionality is not
> really required but the non-existent file just confuses the userspace
> which fails in the result. The patch to fix this on the userspace side
> has been submitted but it is hard to predict how it will propagate
> through the maze of 3rd party consumers of the software.
> 
> Now, reverting alone 86327e8eb94c is not an option because there is
> another set of userspace which cannot cope with ENOTSUPP returned when
> writing to the file. Therefore we have to go and revisit 58056f77502f
> as well. There are two ways to go ahead. Either we give up on the
> deprecation and fully revert 58056f77502f as well or we can keep
> kmem.limit_in_bytes but make the write a noop and warn about the fact.
> This should work for both known breaking workloads which depend on the
> existence but do not depend on the hard limit enforcement.
> 
> [1] http://lkml.kernel.org/r/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
> Fixes: 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
> Fixes: 58056f77502f ("memcg, kmem: further deprecate kmem.limit_in_bytes")
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst |  7 +++++++
>  mm/memcontrol.c                                | 12 ++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 5f502bf68fbc..ff456871bf4b 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -92,6 +92,13 @@ Brief summary of control files.
>   memory.oom_control		     set/show oom controls.
>   memory.numa_stat		     show the number of memory usage per numa
>  				     node
> + memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
> +                                     memory hard limit. Kernel hard limit is not
> +                                     supported since 5.16. Writing any value to
> +                                     do file will not have any effect same as if
> +                                     nokmem kernel parameter was specified.
> +                                     Kernel memory is still charged and reported
> +                                     by memory.kmem.usage_in_bytes.
>   memory.kmem.usage_in_bytes          show current kernel memory allocation
>   memory.kmem.failcnt                 show the number of kernel memory usage
>  				     hits limits
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a4d3282493b6..ac7f14b2338d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3097,6 +3097,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>  				   unsigned int nr_pages)
>  {
> +	struct page_counter *counter;
>  	struct mem_cgroup *memcg;
>  	int ret;
>  
> @@ -3107,6 +3108,10 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>  		goto out;
>  
>  	memcg_account_kmem(memcg, nr_pages);
> +
> +	/* There is no way to set up kmem hard limit so this operation cannot fail */
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		WARN_ON(!page_counter_try_charge(&memcg->kmem, nr_pages, &counter));
>  out:
>  	css_put(&memcg->css);
>  
> @@ -3867,6 +3872,13 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
>  		case _MEMSWAP:
>  			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
>  			break;
> +		case _KMEM:
> +			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
> +				     "Writing any value to this file has no effect. "
> +				     "Please report your usecase to linux-mm@kvack.org if you "
> +				     "depend on this functionality.\n");
> +			ret = 0;
> +			break;
>  		case _TCP:
>  			ret = memcg_update_tcp_max(memcg, nr_pages);
>  			break;

