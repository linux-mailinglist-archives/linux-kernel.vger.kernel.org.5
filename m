Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930487A8344
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjITNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjITNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:25:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D00E7AC;
        Wed, 20 Sep 2023 06:25:27 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id E405B212C4B7;
        Wed, 20 Sep 2023 06:25:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E405B212C4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695216327;
        bh=+TFCyhLrjU2GRB3G3Q8iRvFT2orGxXvTmChxV5qs6Zw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gM3OCePsIjHUaMbiv7MbJMJw/8oYmz0qHYOZrdvg7+1n7bjVyOAuBE4CLMpR3zsrV
         /ZQ5ML7SX/MwuePkPxDBfAWeDjwKsepvl5FoTJBXTEjXWqQdtQshVGinujOfiRjXgs
         zV8utcR0SgzC40NFBHREnWvI1P+91ogOH7My327o=
Message-ID: <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
Date:   Wed, 20 Sep 2023 15:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
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
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
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

On 9/20/2023 1:07 PM, Michal Hocko wrote:
> On Wed 20-09-23 12:04:48, Jeremi Piotrowski wrote:
>> On 9/20/2023 10:43 AM, Michal Hocko wrote:
>>> On Wed 20-09-23 01:11:01, Jeremi Piotrowski wrote:
>>>> On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
>>>>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>>>>
>>>>> ------------------
>>>>
>>>> Hi Greg/Michal,
>>>>
>>>> This commit breaks userspace which makes it a bad commit for mainline and an
>>>> even worse commit for stable.
>>>>
>>>> We ingested 6.1.54 into our nightly testing and found that runc fails to gather
>>>> cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
>>>> into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
>>>> fine.
>>>
>>> Could you expand some more on why is the file read? It doesn't support
>>> writing to it for some time so how does reading it helps in any sense?
>>>
>>> Anyway, I do agree that the stable backport should be reverted.
>>>
>>
>> This file is read together with all the other memcg files. Each prefix:
>>
>> memory
>> memory.memsw
>> memory.kmem
>> memory.kmem.tcp
>>
>> is combined with these suffixes
>>
>> .usage_in_bytes
>> .max_usage_in_bytes
>> .failcnt
>> .limit_in_bytes
>>
>> and read, the values are then forwarded on to other components for scheduling decisions.
>> You want to know the limit when checking the usage (is the usage close to the limit or not).
> 
> You know there is no kmem limit as there is no way to set it for some
> time (since 5.16 - i.e. 2 years ago). I can see that users following old
> kernels could have missed that though.

I know what you mean, but I think this generally went unnoticed because the limit file is read
unconditionally, but only written when a kmem limit is explicitly requested for a specific
container, which is rarely (if ever) done.

Regarding following old kernels: a majority of kubernetes users are still on 5.15 and only slowly
started shifting to >=6.1 very recently (this summer). This is mostly driven by distro vendor
policies which tend to follow the pattern of "follow LTS kernels but don't switch to the next
LTS immediately".

I know this is far from ideal for reporting these kinds of issues, would love to report
them as soon as a kernel release happens.

> 
>> Userspace tolerates MEMCG/MEMCG_KMEM being disabled, but having a single file out of the
>> set missing is an anomaly. So maybe we could keep the dummy file just for the
>> sake of consistency? Cgroupv1 is legacy after all.
> 
> What we had was a dummy file. It didn't allow to write any value so it
> would have always reported unlimited. The reason I've decided to remove
> the file was that there were other users not being able to handle the
> write failure while they are just fine not having the file. So we are
> effectively between a rock and hard place here. Either way something is
> broken. The other SW got fixed as well but similar to your case it takes
> some time to absorb the change through all 3rd party users.
> 
>>>>> Address this by wiping out the file completely and effectively get back to
>>>>> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
>>>>
>>>> On reads, the runc code checks for MEMCG_KMEM=n by checking
>>>> kmem.usage_in_bytes.
> 
> Just one side note. Config options get renamed and their semantic
> changes over time so I would just recomment to never make any
> dependencies on any specific one. 
> 

Right, what i meant is the logic is this, with checking the "usage"
file to determine whether the controller is available:

    value, err := fscommon.GetCgroupParamUint(path, usage)
    if err != nil {
        if name != "" && os.IsNotExist(err) {
            // Ignore ENOENT as swap and kmem controllers
            // are optional in the kernel.
            return cgroups.MemoryData{}, nil
        }
        return cgroups.MemoryData{}, err
    }

and if it is, then it proceeds to read "limit_in_bytes" and the others.

>>>> If it is present then runc expects the other cgroup files
>>>> to be there (including kmem.limit_in_bytes). So this change is not effectively
>>>> the same.
>>>>
>>>> Here's a link to the PR that would be needed to handle this change in userspace
>>>> (not merged yet and would need to be propagated through the ecosystem):
>>>>
>>>> https://github.com/opencontainers/runc/pull/4018.
>>>
>>> Thanks. Does that mean the revert is still necessary for the Linus tree
>>> or do you expect that the fix can be merged and propagated in a
>>> reasonable time?
>>>
>>
>> We can probably get runc and currently supported kubernetes versions patched in time
>> before 6.6 (or the next LTS kernel) hits LTS distros.
>>
>> But there's still a bunch of users running cgroupv1 with unsupported kubernetes
>> versions that are still taking kernel updates as they come, so this might get reported
>> again next year if it stays in mainline.
> 
> I can see how 3rd party users are hard to get aligned but having a fix
> available should allow them to apply it or is there any actual roadblock
> for them to adapt as soon as they hit the issue?
> 

The issue with this is that these users are running a frozen set of kubernetes (+runc)
binaries, but still pull kernel updates from the base distro. These kubernetes versions
are out of maintenance so the code will not get fixed and no one will release fixed
binaries.

> I mean, normally I would be just fine reverting this API change because
> it is disruptive but the only way to have the file available and not
> break somebody is to revert 58056f77502f ("memcg, kmem: further
> deprecate kmem.limit_in_bytes") as well. Or to ignore any value written
> there but that sounds rather dubious. Although one could argue this
> would mimic nokmem kernel option.
> 

I just want to make sure we don't introduce yet another new behavior in this legacy
system. I have not seen breakage due to 58056f77502f. Mimicing nokmem sounds good but
does this mean "don't enforce limits" (that should be fine) or "ignore writes to the limit"
(=don't event store the written limit). The latter might have unintended consequences.

