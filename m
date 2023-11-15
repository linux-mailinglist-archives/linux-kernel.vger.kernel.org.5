Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346BC7EC220
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbjKOMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjKOMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:20:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF967122
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eCH7m2rNk1CrTPl5u9+ZOynuyIFWUez8QntUwDuu0Dw=; b=iwVmSkfvYYgKa8Ht4RBuBXjKY8
        tbh7ezXj14y3wXt51vjYnLZ0oyprUlD5uPMMLZVXmNb68tx4VR1GsqlRGw0JlpjpRahwFpqRStnWZ
        m/AIsdtSeX/5ThgBOoir7DOxZYsitY/3b2XVpb3BcGNKLuRnWboJ0iE/nzv/28EL+x2FhA3tduIpp
        hp9niBDnoXN9hPSodUenEwVJd3G2FXRcUvyEExFkcfs5S9CbPyPW/RLEvCFoYmCQgzxRx9CRYQfdR
        Jr2Z0vKnEuOfvwFXmUkqu6GVgWCrfzrB85CMpGOXJ/l1K+xbTMyPrIW8wRCHWg2Y+Sk9Pj0dBrTrC
        1CaXSeqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3Ese-00E7gI-6o; Wed, 15 Nov 2023 12:20:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D85AD300427; Wed, 15 Nov 2023 13:20:27 +0100 (CET)
Date:   Wed, 15 Nov 2023 13:20:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/fair: introduce core_vruntime and
 core_min_vruntime
Message-ID: <20231115122027.GZ8262@noisy.programming.kicks-ass.net>
References: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
 <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 07:33:40PM +0800, Cruz Zhao wrote:
> To compare the priority of sched_entity from different cpus of a core,
> we introduce core_vruntime to struct sched_entity and core_min_vruntime
> to struct cfs_rq.
> 
> cfs_rq->core->core_min_vruntime records the min vruntime of the cfs_rqs
> of the same task_group among the core, and se->core_vruntime is the
> vruntime relative to se->cfs_rq->core->core_min_vruntime.

But that makes absolutely no sense. vruntime of different RQs can
advance at wildly different rates. Not to mention there's this random
offset between them.

No, this cannot be.
