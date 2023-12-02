Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B2801A27
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjLBC4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBC4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE915D54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701485817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvwjUNJeoy2IcJbz1Tc64DxOTpWO3+WIeQ+/gLfl3dg=;
        b=FadaVDYMTKhYYsy1H3Ye0lcAXvkptZ1bN6QSnKs87yCQM4UK6RKTG/im3lqpJpGY0TT3Pj
        AhcofvnB1l3Ol98CFz0qVDGdQwD2Z2kFCP6Snz+XkuvsOfNHMaroxcDmLz8SGA3ghSZBL8
        osl6mmQCrGP3ivYKJhq3Hliv5EkDaCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-cgIriIYhNUmYe3leOGzmkA-1; Fri, 01 Dec 2023 21:56:50 -0500
X-MC-Unique: cgIriIYhNUmYe3leOGzmkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE235185A781;
        Sat,  2 Dec 2023 02:56:49 +0000 (UTC)
Received: from [10.22.17.155] (unknown [10.22.17.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47B9840C6EB9;
        Sat,  2 Dec 2023 02:56:48 +0000 (UTC)
Message-ID: <436e96d1-29eb-49ec-a463-2ed420757ce8@redhat.com>
Date:   Fri, 1 Dec 2023 21:56:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Attreyee M <tintinm2017@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux CGroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <ZWqPBHCXz4nBIQFN@archie.me>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWqPBHCXz4nBIQFN@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


On 12/1/23 20:57, Bagas Sanjaya wrote:
>> -void mem_cgroup_flush_stats(void)
>> +/*
>> + * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
>> + * @memcg: root of the subtree to flush
>> + *
>> + * Flushing is serialized by the underlying global rstat lock. There is also a
>> + * minimum amount of work to be done even if there are no stat updates to flush.
>> + * Hence, we only flush the stats if the updates delta exceeds a threshold. This
>> + * avoids unnecessary work and contention on the underlying lock.
>> + */
> What is global rstat lock?

It is the cgroup_rstat_lock in kernel/cgroup/rstat.c.

Cheers,
Longman

