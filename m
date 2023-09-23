Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6C7ABCD1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjIWAbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjIWAaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07971136
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695428964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylxfdIFHKtXWaD8iCatK3DCzd559D5PBdYjOV69DHc8=;
        b=LXXg52ZXr/6UhC7FhfSnaveYyPgeCdNiXCm21HeUYFn1wflP0yumA2GoSxTtfFB3KvpF0W
        /dbC19NztIfZmtNDyDogSxrN27YQODrMlXtROk3BXPs8X+Sv2Y0ObqxAQt4dOlaAS/T94o
        JLOepg8/RiGZzGQzPAjv2TIB4mndVa8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-d9V6XYJsODS_aOOQm3b_qA-1; Fri, 22 Sep 2023 20:29:19 -0400
X-MC-Unique: d9V6XYJsODS_aOOQm3b_qA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2FBE85A5A8;
        Sat, 23 Sep 2023 00:29:18 +0000 (UTC)
Received: from [10.22.18.172] (unknown [10.22.18.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A14A5492C37;
        Sat, 23 Sep 2023 00:29:18 +0000 (UTC)
Message-ID: <79793717-95f8-2bd7-407a-ae547131809d@redhat.com>
Date:   Fri, 22 Sep 2023 20:29:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220909192848.963982-1-longman@redhat.com>
 <20230921074247.GC14803@noisy.programming.kicks-ass.net>
 <06163c13-03b2-bfe0-90b4-5267a039a02c@redhat.com>
 <20230922194704.GA40277@noisy.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230922194704.GA40277@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/23 15:47, Peter Zijlstra wrote:
> On Fri, Sep 22, 2023 at 02:45:04PM -0400, Waiman Long wrote:
>
>> I believe early_printk should only be used in the non-SMP boot process. The
>> use of printk() is frequently used for debugging purpose and the insertion
>> of printk at some lock critical section can cause the lockdep splat to come
>> out obscuring the debugging process.
> By default early_printk is disabled somewhere early, but it has a keep
> argument to keep it around.
>
> Anyway, printk() as it exists today is wholly unsuited for debugging.
> There are too many contexts where it will flat out not work. When you
> use early_print with keep then you can use early_printk() instead of
> printk() to debug.
>
> Also, see the patches I pointed John at. Perf would not be what it is
> without those patches.
>
> Serial lines and early printk are not optional. That is, I flat out
> refuse to develop on machines without them.

Thanks for the debugging tip.

BTW, it is not just printk() that can be problematic in some contexts. I 
believe the various WARN*() calls cause the same kind of lockdep problem 
even though these WARN() calls shouldn't be triggered that often

Cheers,
Longman

