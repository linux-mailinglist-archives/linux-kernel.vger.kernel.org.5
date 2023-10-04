Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBE7B7FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbjJDM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbjJDM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B0DBD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696424118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHxNdftNfbtBf2GFdPgNzG0RM9xd9rOW4AEyDiC7wEs=;
        b=ZiLYso9SYQ8eXe43O5TPLbUR2htpNKzc9NEMDgvgCmNSz/yuIfZphFWhofoMugV5DWJRRa
        DJZwGtYoaL3mkL9Yx4svLiGoUTE2LudT7gmsuWNyatP6k+4ty7bLU9ygYgSbcAbb4GQX+A
        qhqyH955/6A+ZTTaP9AMSWoypfXsYtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-eTIlFov2P4ido5HDamKyMw-1; Wed, 04 Oct 2023 08:55:13 -0400
X-MC-Unique: eTIlFov2P4ido5HDamKyMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DAB28039C8;
        Wed,  4 Oct 2023 12:55:13 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54C2D40C6EA8;
        Wed,  4 Oct 2023 12:55:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Waiman Long <longman@redhat.com>
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
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
References: <20231003205735.2921964-1-longman@redhat.com>
        <20231004083648.GI27267@noisy.programming.kicks-ass.net>
        <871qeaefco.fsf@oldenburg.str.redhat.com>
        <4a4076c4-c6ad-063d-a2e1-3048cf71f723@redhat.com>
Date:   Wed, 04 Oct 2023 14:55:10 +0200
In-Reply-To: <4a4076c4-c6ad-063d-a2e1-3048cf71f723@redhat.com> (Waiman Long's
        message of "Wed, 4 Oct 2023 08:41:21 -0400")
Message-ID: <87mswycztd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Waiman Long:

> On 10/4/23 08:34, Florian Weimer wrote:
>> * Peter Zijlstra:
>>
>>> Subject: sched: Add CPU_FILL()
>>>
>>> Add the CPU_FILL() macros to easily create an all-set cpumask.
>>>
>>> FreeBSD also provides this macro with this semantic.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> My main concer is that obtaining the size of the mask, or at least an
>> approximiation is not exactly easy.  If there's an expectation that
>> applications reset the mask more often than they do today (I don't have
>> the full context here), then we'd some decent interface to get the
>> approriate size.
>
> I believe the macro just use sizeof(cpu_set_t) as the size of the
> bitmask. It is the same case as in CPU_ZERO().

I mean the CPU_FILL_S macro also defined in the patch.  Correctly
written applications should not use CPU_FILL and statically sized CPU
sets.

Thanks,
Florian

