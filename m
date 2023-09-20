Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3D37A7915
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjITKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:21:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C390EAD;
        Wed, 20 Sep 2023 03:21:41 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2BF7C212C4B3;
        Wed, 20 Sep 2023 03:21:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BF7C212C4B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695205301;
        bh=2MniQsug91jwOSu/YyVgz9F4Hyl7CDet0WnAmSOuWhY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DZF28Ylh13QXobO3U0L2pHvZLnHVj+gNmED89RYf4K5gqiLYlvfCnMYMTZ2tTuQ40
         GBvDVBnt2dAlSXtVEiuhkRJK0lzkvBIRyNhbA3bMmPuhzyX2WpSLnDJlmsXAaIRUpU
         wsPR2CjegMpKHQw1xjum7hKE9MR75K6HRoSouIvU=
Message-ID: <76525b1a-6857-434d-86ee-3c2ff4db0e4c@linux.microsoft.com>
Date:   Wed, 20 Sep 2023 12:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz> <2023092032-applied-gave-0bff@gregkh>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <2023092032-applied-gave-0bff@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2023 11:25 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 20, 2023 at 10:43:56AM +0200, Michal Hocko wrote:
>> On Wed 20-09-23 01:11:01, Jeremi Piotrowski wrote:
>>> On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
>>>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>
>>> Hi Greg/Michal,
>>>
>>> This commit breaks userspace which makes it a bad commit for mainline and an
>>> even worse commit for stable.
>>>
>>> We ingested 6.1.54 into our nightly testing and found that runc fails to gather
>>> cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
>>> into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
>>> fine.
>>
>> Could you expand some more on why is the file read? It doesn't support
>> writing to it for some time so how does reading it helps in any sense?
>>
>> Anyway, I do agree that the stable backport should be reverted.
> 
> That will just postpone the breakage, we really shouldn't break
> userspace.
> 
> That being said, having userspace "break" because a file is no longer
> present is not good coding style on the userspace side at all.  That's
> why we have sysfs and single-value-files now, if the file isn't present,
> then userspace instantly notices and can handle it.  Much easier than
> the old-style multi-fields-in-one-file problem.
> 

The memcg files in this case are single-value, but userspace expects to be able
to read memcg limits when it can read the usage (indicating MEMCG is enabled).
If it can't - then something is off, and the node is marked unhealthy.

>>>> Address this by wiping out the file completely and effectively get back to
>>>> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
> 
> The fact that this is a valid option (i.e. no file) with that config
> option disabled makes me want to keep this as well, as how does
> userspace handle this option disabled at all?  Or old kernels?
> 

Userspace has had to handle the case of MEMCG_KMEM=n, but that had 2 cases so far:

limits/usage/max_usage/failcnt files are all available or none of them are available.

Now it needs to handle 3 of 4 files being available, but only for kmem (and not plain
memory, memsw or kmem.tcp). That's an inconsistency.

> I can drop this from stable kernels, but again, this feels like the runc
> developers are just postponing the problem...
>

Since cgroups v1 is deprecated, I think the runc developers haven't touched this part
of the code in years and expected it to keep working while they wait for the long tail
of usage to die out.

> thanks,
> 
> greg k-h

