Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EC7AF49A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjIZUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjIZUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:03:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FDD6;
        Tue, 26 Sep 2023 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cW7UwTU4IBzgMWLZdvH0diCsmdfVN4HZZOVutj9gxn4=; b=D8UzNTfbhr+RjQ6dS2l7M9zg+3
        gRcveDYnv0zJMts4w7+KAkwEzdYwpRuBx0CRSlvObEb0jgLxCrzK+R6jWuGjrj+7/6c0/sVLbtv7z
        MuZEzvgFP2oehG8m+Y4/LFpLAeiGGaV6+1CnViVcv/wkOutebLSgo54A1f78K+JfT7b7UQREG+7hG
        abYzeE/vBcWGE3BbW9Ie8VsfGcwbj9Lkxs+Reg7kIX9ZAnOPmIGIEJ1q0HQlWQQJPUcps++Ur3yKe
        ZqfVCxXJvFJOhFepDiPDBEwp1IbXnpmaq0lMSEG5doWRY014fTvo4dsIRjT06xeullaw7awtJUL0S
        1/0gh4FA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlEGT-0034BK-18;
        Tue, 26 Sep 2023 20:02:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76C02300288; Tue, 26 Sep 2023 22:02:38 +0200 (CEST)
Date:   Tue, 26 Sep 2023 22:02:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
Message-ID: <20230926200238.GB13828@noisy.programming.kicks-ass.net>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
 <ZRMEHb3_0Ku1UuK_@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRMEHb3_0Ku1UuK_@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 04:17:33PM +0000, Carlos Llamas wrote:
> On Fri, Sep 08, 2023 at 03:49:14PM -0700, Elliot Berman wrote:
> > After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
> > tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
> > always woken up on the thaw path. Prior to that commit, tasks could ask
> > freezer to consider them "frozen enough" via freezer_do_not_count(). The
> > commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
> > allows freezer to immediately mark the task as TASK_FROZEN without
> > waking up the task.  This is efficient for the suspend path, but on the
> > thaw path, the task is always woken up even if the task didn't need to
> > wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
> > these tasks are capable of handling of the wakeup, we can observe a
> > power/perf impact from the extra wakeup.
> 
> This issue is hurting the performance of our stable 6.1 releases. Does
> it make sense to backport these patches into stable branches once they
> land in mainline? I would assume we want to fix the perf regression
> there too?

Note that these patches are in tip/sched/core, slated for the next merge
window.
