Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB0080618C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbjLEWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbjLEWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D65137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701814584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2Vem31mI/E1rxmbZRCBYAPkrSR+YjFerajC0+h+2EI=;
        b=dVat5q1A35wXT8Nf76O/hEt5AccD2IDRmLUFLYZ1qCJdVHhmdINS3DrF6alqiduTNoJCi1
        AvV/iayvbS+ZVgHTDJlo9YDguBo/+15AXixy4M3mo+gDmODm9w/LC7HPjsRAyleTuglDnU
        2oXkYH/hw1EULws8XcuNJ1U+ShZXaKU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-3LYAxG9aN0qe_CfFGknouw-1; Tue,
 05 Dec 2023 17:16:16 -0500
X-MC-Unique: 3LYAxG9aN0qe_CfFGknouw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F03511C0BB41;
        Tue,  5 Dec 2023 22:16:15 +0000 (UTC)
Received: from [10.22.8.88] (unknown [10.22.8.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCC8C112131D;
        Tue,  5 Dec 2023 22:16:14 +0000 (UTC)
Message-ID: <7284ef19-ba26-46cd-9630-cad18c2e3ce7@redhat.com>
Date:   Tue, 5 Dec 2023 17:16:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs in
 cpu_is_isolated() check
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
 <ZWYbqNnnt6gQOssK@slm.duckdns.org>
 <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
 <ZWZl0uvqeZ-fR1O9@slm.duckdns.org>
 <b6f88157-cf5e-4c7b-99f3-1944b4e7ebde@redhat.com>
 <ZWoSrfztmprcdkpO@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWoSrfztmprcdkpO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 12:06, Tejun Heo wrote:
> Hello,
>
> On Wed, Nov 29, 2023 at 11:01:04AM -0500, Waiman Long wrote:
> ...
>>>> Depending on how the cpumask operators are implemented, we may not have a
>>>> guarantee that testing CPU 2, for instance, will always return true. That is
>>> Can you please elaborate this part a bit? I'm having a difficult time
>>> imagining the sequence of operations where this would matter but that could
>>> easily be me not being familiar with the details.
>> I may be a bit paranoid about incorrect result due to racing as I had been
>> burned before. Just testing a bit in the bitmask may probably be OK. I don't
> Setting and clearing a bit is as atomic as it gets, right?
Yes, I think so.
>
>> think it will be a problem for x86, but I am less certain about other more
>> exotic architectures like arm64 or PPC which I am less familiar about. I add
>> a seqcount for synchronization just for the peace of mind. I can take the
>> seqcount out if you don't it is necessary.
> I just can't think of a case where this would be broken. The data being read
> and written is atomic. There's no way to break a bit operation into multiple
> pieces. It is possible to write a really bone-headed bitmask operations
> (like, if you shift the bits into place or sth) to make the bits go through
> unintended changes but that'd just be a flat-out broken implementation. Even
> for a bitmask where write accesses are synchronized through a spinlock, we
> should still be able to use test_bit() without holding the lock. This seems
> like a pretty basic assumption.
>
> Adding unnecessary synchronization confuses the readers. If we don't need
> it, we shouldn't have it.

OK, I will send a simplified v2 patch.

Cheers,
Longman

