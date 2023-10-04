Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036667B84FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbjJDQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbjJDQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC504CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696436624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHHB0nuT3xkUSZTp0095FiMfUGouLO4qSIAie4xx6Z4=;
        b=GFFQs4UmPsWbASRJ2tI4j5mBvnHYRFslWbLGZMgdH0ho2SqQpdvWlXLKDL7VAxWiFLVWOm
        cpc+0M/74oVBX7vj3VuIepjNB5viXI9dIl/4aedENh6zkNXC/SM0WN38K5onK1fHTi7DpD
        cMOghJv18+y/GhKUoS8r+WoozjD2UsU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-y9HjJXybP7OcneZxV6mywg-1; Wed, 04 Oct 2023 12:23:30 -0400
X-MC-Unique: y9HjJXybP7OcneZxV6mywg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE6533C2864B;
        Wed,  4 Oct 2023 16:23:29 +0000 (UTC)
Received: from [10.22.32.136] (unknown [10.22.32.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02BB01005B8E;
        Wed,  4 Oct 2023 16:23:28 +0000 (UTC)
Message-ID: <0c36c117-b44c-89ef-1988-6059c41fad65@redhat.com>
Date:   Wed, 4 Oct 2023 12:23:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
 <871qeaefco.fsf@oldenburg.str.redhat.com>
 <4a4076c4-c6ad-063d-a2e1-3048cf71f723@redhat.com>
 <87mswycztd.fsf@oldenburg.str.redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87mswycztd.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/23 08:55, Florian Weimer wrote:
> * Waiman Long:
>
>> On 10/4/23 08:34, Florian Weimer wrote:
>>> * Peter Zijlstra:
>>>
>>>> Subject: sched: Add CPU_FILL()
>>>>
>>>> Add the CPU_FILL() macros to easily create an all-set cpumask.
>>>>
>>>> FreeBSD also provides this macro with this semantic.
>>>>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> My main concer is that obtaining the size of the mask, or at least an
>>> approximiation is not exactly easy.  If there's an expectation that
>>> applications reset the mask more often than they do today (I don't have
>>> the full context here), then we'd some decent interface to get the
>>> approriate size.
>> I believe the macro just use sizeof(cpu_set_t) as the size of the
>> bitmask. It is the same case as in CPU_ZERO().
> I mean the CPU_FILL_S macro also defined in the patch.  Correctly
> written applications should not use CPU_FILL and statically sized CPU
> sets.

Right, that can be a problem. If the input bitmask size is less than 
cpumask_size(), CPU_FILL_S() won't work to reset the cpumask. In fact, 
it will treat that bitmask just like a regular sched_setaffinity() call 
and set it accordingly.

With that caveat, I would prefer to keep using a length of 0 for the 
reset then.

Cheers,
Longman

