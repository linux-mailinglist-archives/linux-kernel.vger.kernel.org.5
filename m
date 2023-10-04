Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9E7B7F74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbjJDMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJDMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC2A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696423293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9EYoJHAMXTzex9TDtrut0Nd9oVsTL1iGGDRikr4WZU=;
        b=Q3HVTiNH+5y2VHvRMzozqs5eMlCKN+mAXRY1hS1sV+VkfRkHqc22ebykjf0WhBGliphrEL
        YOHNhkC6awvrqg0x3W07q/J94nabKZv96ZiGecGw0s45PYCcfKKgYHJ3BrAhmfUJD6OBaI
        wV5OS5NjsUj+poMutHEuV7Nw/KAChwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-Y9rOroiMMRe-u7cAmwRDGQ-1; Wed, 04 Oct 2023 08:41:23 -0400
X-MC-Unique: Y9rOroiMMRe-u7cAmwRDGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB026811E8E;
        Wed,  4 Oct 2023 12:41:22 +0000 (UTC)
Received: from [10.22.32.136] (unknown [10.22.32.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22CC9C15BB8;
        Wed,  4 Oct 2023 12:41:22 +0000 (UTC)
Message-ID: <4a4076c4-c6ad-063d-a2e1-3048cf71f723@redhat.com>
Date:   Wed, 4 Oct 2023 08:41:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <871qeaefco.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/23 08:34, Florian Weimer wrote:
> * Peter Zijlstra:
>
>> Subject: sched: Add CPU_FILL()
>>
>> Add the CPU_FILL() macros to easily create an all-set cpumask.
>>
>> FreeBSD also provides this macro with this semantic.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> My main concer is that obtaining the size of the mask, or at least an
> approximiation is not exactly easy.  If there's an expectation that
> applications reset the mask more often than they do today (I don't have
> the full context here), then we'd some decent interface to get the
> approriate size.

I believe the macro just use sizeof(cpu_set_t) as the size of the 
bitmask. It is the same case as in CPU_ZERO().

Regards,
Longman

