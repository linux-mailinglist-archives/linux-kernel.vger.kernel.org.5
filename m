Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAA7DE5E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjKASQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjKASQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6F10C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698862485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n284L869YZxY8n/xQrB63AFMrPs7jEpIh/yllTjR+Bc=;
        b=QQHLuqp8VmnFJ87hSNC4hSdFqqk3RRkZ1xZoctO3RHQcceiwiR3ZF3n0jJ8DH7euvuzmK9
        4SVFQTCjVorkbl0RWChS9LyC+ZSEuK/X3fjJXiOtigxH5drP2G37I+M0SaO6bJLTli8GeG
        7ZMPglCn1MY9LTCkYM8VafeA4nZZIqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-ROHZxsdVOS6YXr5xEWSiZA-1; Wed, 01 Nov 2023 14:14:40 -0400
X-MC-Unique: ROHZxsdVOS6YXr5xEWSiZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CF7A811E7E;
        Wed,  1 Nov 2023 18:14:39 +0000 (UTC)
Received: from [10.22.33.245] (unknown [10.22.33.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A37552026D4C;
        Wed,  1 Nov 2023 18:14:38 +0000 (UTC)
Message-ID: <7dc9cf67-b482-a723-c779-14c7598e1869@redhat.com>
Date:   Wed, 1 Nov 2023 14:14:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230905133243.91107-1-longman@redhat.com>
 <ahevhcy2aa7k3plmfvlepjehs6u3fun3j4oyskdz7axkhftlyi@zr3j473rciwi>
 <f75859e0-04d4-3da2-8df0-eb8841623a7c@redhat.com>
 <agjgbmdi2yqegjk7p7m52yb3wxmr64ivohbra5wapcd3lwynpw@jjmx6dsboo53>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <agjgbmdi2yqegjk7p7m52yb3wxmr64ivohbra5wapcd3lwynpw@jjmx6dsboo53>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 12:13, Michal Koutný wrote:
> On Fri, Oct 13, 2023 at 12:03:18PM -0400, Waiman Long <longman@redhat.com> wrote:
>>> [chain]
>>>     root
>>>     |                           \
>>>     mid1a                        mid1b
>>>      cpuset.cpus=0-1              cpuset.cpus=2-15
>>>      cpuset.cpus.partition=root
>>>     |
>>>     mid2
>>>      cpuset.cpus=0-1
>>>      cpuset.cpus.partition=root
>>>     |
>>>     cont
>>>      cpuset.cpus=0-1
>>>      cpuset.cpus.partition=root
>> In this case, the effective CPUs of both mid1a and mid2 will be empty. IOW,
>> you can't have any task in these 2 cpusets.
> I see, that is relevant to a threaded subtree only where the admin / app
> can know how to distribute CPUs and place threads to internal nodes.
>
>> For the remote case, you can have intermediate tasks in both mid1a and mid2
>> as long as cpuset.cpus contains more CPUs than cpuset.cpus.exclusive.
> It's obvious that cpuset.cpus.exclusive should be exclusive among
> siblings.
> Should it also be so along the vertical path?

Sorry for the late reply. I have forgot to respond earlier.

We don't support that vertical exclusive check in cgroup v1 
cpuset.cpu_exclusive.
>    root
>    |
>    mid1a
>     cpuset.cpus=0-2
>     cpuset.cpus.exclusive=0
>    |
>    mid2
>     cpuset.cpus=0-2
>     cpuset.cpus.exclusive=1
>    |
>    cont
>     cpuset.cpus=0-2
>     cpuset.cpus.exclusive=2
>     cpuset.cpus.partition=root
>
> IIUC, this should be a valid config regardless of cpuset.cpus.partition
> setting on mid1a and mid2.
> Whereas
>
>    root
>    |
>    mid1a
>     cpuset.cpus=0-2
>     cpuset.cpus.exclusive=0
>    |
>    mid2
>     cpuset.cpus=0-2
>     cpuset.cpus.exclusive=1-2
>     cpuset.cpus.partition=root
>    |
>    cont
>     cpuset.cpus=1-2
>     cpuset.cpus.exclusive=1-2
>     cpuset.cpus.partition=root
>
> Here, I'm hesitating, will mid2 have any exclusively owned cpus?
>
> (I have flashes of understading cpus.exclusive as being a more
> expressive mechanism than partitions. OTOH, it seems non-intuitive when
> both are combined, thus I'm asking to internalize it better.
> Should partitions be deprecated for simplicty? They're still good to
> provide the notification mechanism of invalidation.
> cpuset.cpus.exclusive.effective don't have that.)

Like cpuset.cpus, cpuset.cpus.exclusive follows the same hierarchical 
rule. IOW, the CPUs in cpuset.cpus.exclusive will be ignored if they are 
not present in its ancestor nodes. The value in cpuset.cpus.exclusive 
shows the intent of the users. cpuset.cpus.exclusive.effective shows the 
real exclusive CPUs when partition is enabled. So we just can't use 
cpuset.cpus.exclusive as a replacement for cpuset.cpus.partition.

As a result, we can't actually support the vertical CPU exclusion as you 
suggest above.

>
>> They will be ready eventually. This requirement of remote partition actually
>> came from our OpenShift team as the use of just local partition did not meet
>> their need. They don't need access to exclusive CPUs in the parent cgroup
>> layer for their management daemons. They do need to activate isolated
>> partition in selected child cgroups to support our Telco customers to run
>> workloads like DPDK.
>>
>> So they will add the support to upstream Kubernetes.
> Is it worth implementing anything touching (ancestral)
> cpuset.cpus.partition then?

I don't quite get what you want to ask here.

Cheers,
Longman

