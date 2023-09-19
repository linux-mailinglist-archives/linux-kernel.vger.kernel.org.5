Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90007A6EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjISWiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjISWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:37:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E955BA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Egdihm2RrJ5EhybjlY5bRjL7jGltZYr3L1D/P8P/NWs=; b=n30bbR3CEeGQtBtfgECeM+p87Z
        vz/qgXom1/xwG2gXFgONETH7tqcg2hdsK6DZK+gI/XmZt83CgIydfsAZ73vXOvO9Na6m8IN/uVj4H
        mgYqX9eCJIheclGvUEUV1RIKmmzanvg8JBwU/C3TGBC+70KY/bVi3Le9eb5/z4kvRvASdqqhyBuvt
        g8PUfjMZNW9FsVqaZFbyZ/aGOjVIZ4IVwQ3+OSMmlUt6lgGOTZZw1zsvDLsem1ptGG+ueHtzr2iuq
        olTgJ0ohpvX95brRsfohPJDzR9bIZlIh0Ec0MJ+nFPCd1uV0CJUlDyynBvWJUeOSlQfRudwnRQ5Qy
        tZqBgm0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qijL5-00DxTR-1i;
        Tue, 19 Sep 2023 22:37:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CE92300585; Wed, 20 Sep 2023 00:37:04 +0200 (CEST)
Date:   Wed, 20 Sep 2023 00:37:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        daniel.m.jordan@oracle.com
Subject: Re: [PATCH 2/2] sched/eevdf: Use sched_attr::sched_runtime to set
 request/slice suggestion
Message-ID: <20230919223704.GG424@noisy.programming.kicks-ass.net>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
 <20230915124822.956946622@noisy.programming.kicks-ass.net>
 <20230919220708.l2llt2f5xullxzzz@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919220708.l2llt2f5xullxzzz@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:07:08PM +0100, Qais Yousef wrote:
> On 09/15/23 14:43, peterz@infradead.org wrote:
> > Allow applications to directly set a suggested request/slice length using
> > sched_attr::sched_runtime.
> 
> I'm probably as eternally confused as ever, but is this going to be the latency
> hint too? I find it hard to correlate runtime to latency if it is.

Yes. Think of it as if a task has to save up for it's slice. Shorter
slice means a shorter time to save up for the time, means it can run
sooner. Longer slice, you get to save up longer.

Some people really want longer slices to reduce cache trashing or
held-lock-preemption like things. Oracle, Facebook, or virt thingies.

Other people just want very short activations but wants them quickly.
