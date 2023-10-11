Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFE7C4BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbjJKHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbjJKHeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:34:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95992
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bb4TaTpxv5J8iSs+A5abhWEGldd9r3gdni3LZgLtLDA=; b=mZ6PbUSdKl1FJmB0ShPmISe2v0
        GM8FD2rBcJrbVNTNzv0qN3qmBFiaproN8z6lsS+DoUfIN88tSKuHVZvFWwfg5QHvMGmpDce1bL9hR
        Sdwn+ETvYM69aXB1uB9Ueb99gKF7qWnab+WTyitImNoAnzg0Knc8KLBmYjlyJSGUEUkyMCsxJseg/
        WCWjozLWwmT9zVJ9WCX4fTB3AoVuQ89WgfOof0XJGiuH2TBwPlTcJzYCzSGTmjaJv4CTfAPUiLpJ5
        7xyS4TZIfwHb1dKYEEyrWvAHsbx047Vh7GgqUwKUlhpmp2+mC4g/rHk9WlcrqenPOZz1ZzHBqRZEV
        g1RQrvdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqTiX-009UTG-NS; Wed, 11 Oct 2023 07:33:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62D8D30026F; Wed, 11 Oct 2023 09:33:17 +0200 (CEST)
Date:   Wed, 11 Oct 2023 09:33:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: Re: [PATCH 05/15] sched/fair: Implement an EEVDF like policy
Message-ID: <20231011073317.GJ14330@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org>
 <xm265y3sodyo.fsf@google.com>
 <a54a4ccb-9d56-4686-93b6-e9bbbe01f625@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54a4ccb-9d56-4686-93b6-e9bbbe01f625@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:14:30PM +0800, Abel Wu wrote:

> With Benjamin's fix, the semantics of 'Earliest Eligible' preserved.

Yeah, my bad.

> But since all this is about latency rather than fairness, I wonder if

It is about both, fairness is absolutely important.

> there are cases worthy of breaking the 'eligible' rule.

See the discussion with Youssef, if we weaken the eligible rule you get
horrific interference because you end up placing new tasks around the
0-lag point.
