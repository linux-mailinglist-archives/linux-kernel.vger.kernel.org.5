Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D47A788A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjITKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjITKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:04:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8A4BAB;
        Wed, 20 Sep 2023 03:04:52 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 112CB212C4B2;
        Wed, 20 Sep 2023 03:04:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 112CB212C4B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695204292;
        bh=3bC6p4sdHzytTO0QKfyFybQqp0lACEhiSf/B5PUqc00=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=h/YyjqOEiWd8pu5Aeb671sFZKoQY0fwShQJicaEbCnEbeLBtsh7LHpAw5WRPPLqc2
         BSkSqH5iAh9vTpQhEDIKk607F+IZLp27UXDd9uW9rs+uHhndP4n4ewpTFGgF5w1ycY
         KQ5DrwpI4tOdPwgzvZQ1f6U3SuOuZipLoAyhOBG4=
Message-ID: <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
Date:   Wed, 20 Sep 2023 12:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
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
Content-Language: en-US
In-Reply-To: <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
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

On 9/20/2023 10:43 AM, Michal Hocko wrote:
> On Wed 20-09-23 01:11:01, Jeremi Piotrowski wrote:
>> On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
>>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>
>> Hi Greg/Michal,
>>
>> This commit breaks userspace which makes it a bad commit for mainline and an
>> even worse commit for stable.
>>
>> We ingested 6.1.54 into our nightly testing and found that runc fails to gather
>> cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
>> into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
>> fine.
> 
> Could you expand some more on why is the file read? It doesn't support
> writing to it for some time so how does reading it helps in any sense?
> 
> Anyway, I do agree that the stable backport should be reverted.
> 

This file is read together with all the other memcg files. Each prefix:

memory
memory.memsw
memory.kmem
memory.kmem.tcp

is combined with these suffixes

.usage_in_bytes
.max_usage_in_bytes
.failcnt
.limit_in_bytes

and read, the values are then forwarded on to other components for scheduling decisions.
You want to know the limit when checking the usage (is the usage close to the limit or not).

Userspace tolerates MEMCG/MEMCG_KMEM being disabled, but having a single file out of the
set missing is an anomaly. So maybe we could keep the dummy file just for the
sake of consistency? Cgroupv1 is legacy after all.

>>> Address this by wiping out the file completely and effectively get back to
>>> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
>>
>> On reads, the runc code checks for MEMCG_KMEM=n by checking
>> kmem.usage_in_bytes. If it is present then runc expects the other cgroup files
>> to be there (including kmem.limit_in_bytes). So this change is not effectively
>> the same.
>>
>> Here's a link to the PR that would be needed to handle this change in userspace
>> (not merged yet and would need to be propagated through the ecosystem):
>>
>> https://github.com/opencontainers/runc/pull/4018.
> 
> Thanks. Does that mean the revert is still necessary for the Linus tree
> or do you expect that the fix can be merged and propagated in a
> reasonable time?
> 

We can probably get runc and currently supported kubernetes versions patched in time
before 6.6 (or the next LTS kernel) hits LTS distros.

But there's still a bunch of users running cgroupv1 with unsupported kubernetes
versions that are still taking kernel updates as they come, so this might get reported
again next year if it stays in mainline.
