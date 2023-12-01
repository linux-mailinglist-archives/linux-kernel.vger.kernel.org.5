Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6180124B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjLASKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA4FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701454204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNpyc+USobI6amLbpzPhS9IlXEPDw+xJpgpdIIbgOk4=;
        b=C/cYra78Ccmv653op49WAYstpgh3KS9g9X9NldPLMPskN1QeIB7kTiu8Qw344IZWxE1/4c
        3qNhF3fqKNV6JEolg2wX2MOLdUDTQqcZjCHU8CMbFvb9B5qa/jX2CianfKX4T6puBUcqCn
        MKGj1HzcbiPotfU4qkbkm37Fb/5ccuM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298--Utt3jrmNROW3JOUTlDIWg-1; Fri,
 01 Dec 2023 13:09:58 -0500
X-MC-Unique: -Utt3jrmNROW3JOUTlDIWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71134280CFA8;
        Fri,  1 Dec 2023 18:09:58 +0000 (UTC)
Received: from [10.22.17.155] (unknown [10.22.17.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5E3910E46;
        Fri,  1 Dec 2023 18:09:57 +0000 (UTC)
Message-ID: <a873ce8e-96b2-448c-a380-214b91d3f03f@redhat.com>
Date:   Fri, 1 Dec 2023 13:09:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v5 1/2] cgroup/rstat: Optimize
 cgroup_rstat_updated_list()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20231130204327.494249-1-longman@redhat.com>
 <20231130204327.494249-2-longman@redhat.com>
 <ZWoZ7U8f5NNwimej@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWoZ7U8f5NNwimej@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


On 12/1/23 12:37, Tejun Heo wrote:
> On Thu, Nov 30, 2023 at 03:43:26PM -0500, Waiman Long wrote:
>> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
>> the updated tree in a way to pop out the leaf nodes first before
>> their parents. This can cause traversal of multiple nodes before a
>> leaf node can be found and popped out. IOW, a given node in the tree
>> can be visited multiple times before the whole operation is done. So
>> it is not very efficient and the code can be hard to read.
>>
>> With the introduction of cgroup_rstat_updated_list() to build a list
>> of cgroups to be flushed first before any flushing operation is being
>> done, we can optimize the way the updated tree nodes are being popped
>> by pushing the parents first to the tail end of the list before their
>> children. In this way, most updated tree nodes will be visited only
>> once with the exception of the subtree root as we still need to go
>> back to its parent and popped it out of its updated_children list.
>> This also makes the code easier to read.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Applied to cgroup/for-6.8 with a small comment edit.
>
> ...
>> + * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
>> + * level and push all the parents first before their next level children
>> + * into a singly linked list built from the tail backward like "pushing"
>> + * cgroups into a stack. The parent is by the caller.
> I found the last sentence a bit difficult to understand and changed it to
> "The root is pushed by the caller." That's what you meant, right?

Yes, you are right. Thanks for the edit.

Cheers,
Longman

