Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE523808909
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjLGNVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGNVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA1AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701955289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlxnIkTVs+MeF68tCsmk/nR1vv5URTWbbq/XkKatOUM=;
        b=VASoLc3T4fHEot6tOntF8ZRlz0DARTVmt8/XuFeiOHXFw2zGVoxUEROvD73gbvMvuSGOe5
        0a+H1scnD5EYJqLBLT70GxXv8VFPAUyO5LULYEUilMX1gCuwakFSQyfbBo2UviXpvsrz2Q
        pIKkb4+6Whxi9xD79ZGNyDiBjSdgRug=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-jCRHf0RGOiK98jxr_VOP_w-1; Thu,
 07 Dec 2023 08:21:22 -0500
X-MC-Unique: jCRHf0RGOiK98jxr_VOP_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B3C3813F28;
        Thu,  7 Dec 2023 13:21:22 +0000 (UTC)
Received: from [10.22.32.209] (unknown [10.22.32.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFB23492BE6;
        Thu,  7 Dec 2023 13:21:21 +0000 (UTC)
Message-ID: <0a79501b-ff60-4122-840f-fc0095ae05fd@redhat.com>
Date:   Thu, 7 Dec 2023 08:21:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup] cgroup: Move rcu_head up near the top of
 cgroup_root
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20231207043753.876437-1-longman@redhat.com>
 <CAJD7tkZtt8xedBJyRns+6HpdXoBxadLUGuGNG5s1trEbRgb9hA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkZtt8xedBJyRns+6HpdXoBxadLUGuGNG5s1trEbRgb9hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 23:51, Yosry Ahmed wrote:
> On Wed, Dec 6, 2023 at 8:38 PM Waiman Long <longman@redhat.com> wrote:
>> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
>> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
>> for freeing the cgroup_root.
>>
>> The use of kvfree_rcu(), however, has the limitation that the offset of
>> the rcu_head structure within the larger data structure cannot exceed
>> 4096 or the compilation will fail. By putting rcu_head below the cgroup
>> structure, any change to the cgroup structure that makes it larger has
>> the risk of build failure. Commit 77070eeb8821 ("cgroup: Avoid false
>> cacheline sharing of read mostly rstat_cpu") happens to be the commit
>> that breaks it even though it is not its fault. Fix it by moving the
>> rcu_head structure up before the cgroup structure.
>>
>> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/cgroup-defs.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 5a97ea95b564..45359969d8cf 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -562,6 +562,10 @@ struct cgroup_root {
>>          /* Unique id for this hierarchy. */
>>          int hierarchy_id;
>>
>> +       /* A list running through the active hierarchies */
>> +       struct list_head root_list;
>> +       struct rcu_head rcu;
>> +
> Perhaps the comment should mention the placement requirements, and
> maybe a pointer to wherever it is specified that the offset of struct
> rcu_head should not exceed 4096?

Fair. I will update the patch description to give more details about 
that. It is new to me too before I got a compilation failure report in 
linux-next.

Cheers,
Longman

>

