Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8095F791DED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjIDT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjIDT5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6801B3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693857422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSIxBAZ0vuRyDLq8UZdv8SC1G/S/i9IBu68WnvJ9Jig=;
        b=fPJVQ6uiO08gX/bvXsF7G8uHGgVXvW6WslIXi8tu5WXSFGKwEpu2lt9h0jkatzmSvNxKNU
        DvpaAq4445el0yEnr8WTUYJGUx1cMegHDLB7u1VjjO3TbOZH0VMBTWeoUqiVOp6vpC5wM/
        BHZKsnYNCw9hQp5wsr9gP2620/q32Qc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-o6h2jvrsNKSs1GL0d8wv8w-1; Mon, 04 Sep 2023 15:56:58 -0400
X-MC-Unique: o6h2jvrsNKSs1GL0d8wv8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED219803F3A;
        Mon,  4 Sep 2023 19:56:57 +0000 (UTC)
Received: from [10.22.8.119] (unknown [10.22.8.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457416B5AA;
        Mon,  4 Sep 2023 19:56:57 +0000 (UTC)
Message-ID: <94764456-c4d4-03eb-81ef-df402f4916f6@redhat.com>
Date:   Mon, 4 Sep 2023 15:56:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] Revert "locking/rwsem: Remove reader optimistic
 spinning"
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Bongkyu Kim <bongkyu7.kim@samsung.com>
Cc:     mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CGME20230901010734epcas2p1a0d3698e76590637f9175fca40ad9eaf@epcas2p1.samsung.com>
 <20230901010704.18493-2-bongkyu7.kim@samsung.com>
 <20230904151008.GA25717@noisy.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230904151008.GA25717@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 11:10, Peter Zijlstra wrote:
> On Fri, Sep 01, 2023 at 10:07:03AM +0900, Bongkyu Kim wrote:
>> This reverts commit 617f3ef95177840c77f59c2aec1029d27d5547d6.
>>
>> In mobile environment, reader optimistic spinning is still useful
>> because there're not many readers. In my test result at android device,
>> it improves application startup time about 3.8%
>> App startup time is most important factor for android user expriences.
>> So, re-enable reader optimistic spinning by this commit. And,
>> the later patch will make it optional feature by cmdline.
> I'm not seeing any mention on how this interacts with all the rwsem work
> that has been done since that commit, like the handoff rework.
>
> Why is a straight revert a sane thing at this point?

I also agree that a revert is not the best way to reintroduce the 
feature. It should document the reason why reader optimistic spinning is 
not the default as discussed in commit 617f3ef9517 ("locking/rwsem: 
Remove reader optimistic spinning") and under what condition should 
reader optimistic spinning can be turned back on.

Besides, I now think we may not really need 2 separate nonspinnable 
bits. We can go with one that is set by writer timing out when spinning 
on reader.

Cheers,
Longman

