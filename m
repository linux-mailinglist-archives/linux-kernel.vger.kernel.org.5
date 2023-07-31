Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73656769AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjGaPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjGaPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BE170D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690816676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5AQD0LEeAYqXT6lCclyKYKI2TrgcsgrUICQAk7owCY=;
        b=NaakIejzj46IvTLvKHSZbcCi8J0IyWXVGvCztXNcIf3lsVsjAu0FoPb4a15x9JvaW80KVI
        gUYUx5D2jhDOZsSV6rjl0dBP9l3tQbi9meInMQMdXSY9I2602uI/XTfz/ID3gBW+N9e3fv
        VHe7K0atZnFXtGVrsvlooX0aNWnu1So=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-KTvrLiRFPjSyg1LUGQ0QOw-1; Mon, 31 Jul 2023 11:17:54 -0400
X-MC-Unique: KTvrLiRFPjSyg1LUGQ0QOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD46C185A791;
        Mon, 31 Jul 2023 15:17:52 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3DFA1454143;
        Mon, 31 Jul 2023 15:17:51 +0000 (UTC)
Date:   Mon, 31 Jul 2023 11:17:51 -0400
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 0/2] Fix nohz_full vs cfs bandwidth
Message-ID: <20230731151751.GC232229@lorien.usersys.redhat.com>
References: <20230712133357.381137-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712133357.381137-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,

On Wed, Jul 12, 2023 at 09:33:55AM -0400 Phil Auld wrote:
> This is v6 of patch 2/2 which is adding code to prevent
> the tick from being stopped when the single running task
> has bandwidth limits. Discussions had led to the idea of
> adding a bit to task_struct to help make this decision.
> 
> There was some complexity with doing it in the task which
> is  avoided by using something in the cfs_rq. Looking 
> into that lead me to the hierarchical_quota field in the 
> cfs_bandwith struct. We spend a good deal of effort
> updating (or trying to, see patch 1/2) that value for
> the whole task_group tree when a quota is set/changed.
> 
> This new version first fixes that value to be meaningful
> for cgroupv2 and then leverages it to make the decisions
> about blocking the tick_stop. 
> 
> Phil Auld (2):
>   sched, cgroup: Restore meaning to hierarchical_quota
>   Sched/fair: Block nohz tick_stop when cfs bandwidth in use
> 
>  kernel/sched/core.c     | 23 ++++++++++++++---
>  kernel/sched/fair.c     | 56 ++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/features.h |  2 ++
>  kernel/sched/sched.h    |  3 ++-
>  4 files changed, 76 insertions(+), 8 deletions(-)
> 
> -- 
> 2.31.1
> 

Ping :)

Any thoughts on these now?


Cheers,
Phil
-- 

