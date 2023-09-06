Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E5793DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjIFNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjIFNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FFE6B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694007171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCpIrP65/3nTEPon1JRD3ISd+XlrrDIC3wEjklFq6gE=;
        b=W3hR24UoHtU2mfiHO0HMxOGYVtRdF5UsUU0wstEvpk08Auf7turOhFRlfGeojRX/9ysg92
        Gw00inb+tzQznEWAm5Ycr1pIyHWr34Yux7Sg89/EoE1zTYln72yJY6vK4ZLEbLr/HFBa4A
        b7eaGOiCZQrKEnvz7Swk/Jx0+ywXIes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-OCD-ndfMNSWE3vkR3V2dwA-1; Wed, 06 Sep 2023 09:32:46 -0400
X-MC-Unique: OCD-ndfMNSWE3vkR3V2dwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 243771825488;
        Wed,  6 Sep 2023 13:32:46 +0000 (UTC)
Received: from [10.22.32.253] (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD7B7202869C;
        Wed,  6 Sep 2023 13:32:45 +0000 (UTC)
Message-ID: <9578a3a7-4151-6b60-3241-d883afe08bc1@redhat.com>
Date:   Wed, 6 Sep 2023 09:32:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] Revert "locking/rwsem: Remove reader optimistic
 spinning"
Content-Language: en-US
To:     Bongkyu Kim <bongkyu7.kim@samsung.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CGME20230901010734epcas2p1a0d3698e76590637f9175fca40ad9eaf@epcas2p1.samsung.com>
 <20230901010704.18493-2-bongkyu7.kim@samsung.com>
 <20230904151008.GA25717@noisy.programming.kicks-ass.net>
 <94764456-c4d4-03eb-81ef-df402f4916f6@redhat.com>
 <20230906112741.GA18415@KORCO045595.samsungds.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230906112741.GA18415@KORCO045595.samsungds.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 07:27, Bongkyu Kim wrote:
> On Mon, Sep 04, 2023 at 03:56:56PM -0400, Waiman Long wrote:
>> On 9/4/23 11:10, Peter Zijlstra wrote:
>>> On Fri, Sep 01, 2023 at 10:07:03AM +0900, Bongkyu Kim wrote:
>>>> This reverts commit 617f3ef95177840c77f59c2aec1029d27d5547d6.
>>>>
>>>> In mobile environment, reader optimistic spinning is still useful
>>>> because there're not many readers. In my test result at android device,
>>>> it improves application startup time about 3.8%
>>>> App startup time is most important factor for android user expriences.
>>>> So, re-enable reader optimistic spinning by this commit. And,
>>>> the later patch will make it optional feature by cmdline.
>>> I'm not seeing any mention on how this interacts with all the rwsem work
>>> that has been done since that commit, like the handoff rework.
>>>
>>> Why is a straight revert a sane thing at this point?
>> I also agree that a revert is not the best way to reintroduce the feature.
>> It should document the reason why reader optimistic spinning is not the
>> default as discussed in commit 617f3ef9517 ("locking/rwsem: Remove reader
>> optimistic spinning") and under what condition should reader optimistic
>> spinning can be turned back on.
>>
>> Besides, I now think we may not really need 2 separate nonspinnable bits. We
>> can go with one that is set by writer timing out when spinning on reader.
>>
>> Cheers,
>> Longman
> Should I modify like the below?
> - Title to "locking/rwsem: Reintroduce reader optimistic spinning"
> - Add more document like Longman's comment
> - Reconsidering about 2 separate nonspinnable bits to one

Besides the above, Peter also ask to verify that it won't affect handoff 
handling which requires that an unlocker see the lock will be free and 
wake up the head of the wait queue. Given the fact that the simple 
heuristic of skipping optimistic spinning if the lock is reader owned is 
kept, that shouldn't be a problem, but you still need to document that.

Cheers,
Longman

