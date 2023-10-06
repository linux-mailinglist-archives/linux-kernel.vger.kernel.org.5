Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C47BBFB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjJFT0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjJFT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:26:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67934A2;
        Fri,  6 Oct 2023 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g8R3qBu9m/zPeVFFMHKdKfTDFnYyK8HF/dF9rq+sKnE=; b=PSngGpGo4hR9epceZ+3PeAIDlm
        euGOSftofJ2bZvRttvA8lrev0oTtCSrbZ2tuR2QWOSfVbPXzxImPxvjMe3DnunRwTKSANsu2hqpyo
        ZVSHHWjg0ND+ZYprsmtyEdOjoTOvcLXTmkROCWznP6hXsZBUp0TEDMWA6XqR9nENqN7AGLar7mrkN
        OR7uhfWsf97N3cOhhwbHHhUfFjd1Y0erek1lgzwUTg9v5aV0YyPQbKRYMZmuI5iClN4MPuS+dtpAo
        133Y7mpFZ/2s/VKQVq5EGwj/GILyPE1JOevlgWThziUaYqIKaXYXtuUeGuqBPqE2/JFm1C9qgR2Bj
        eYNNKOVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoqRI-00Cq4H-1m;
        Fri, 06 Oct 2023 19:24:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A20F7300392; Fri,  6 Oct 2023 21:24:45 +0200 (CEST)
Date:   Fri, 6 Oct 2023 21:24:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>, "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Message-ID: <20231006192445.GE743@noisy.programming.kicks-ass.net>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
 <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
 <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006155501.GH36277@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:

> And yeah, min_deadline is hosed somehow.
> 
> migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> migration/28-185     [028] d..2.    70.264277: __print_se: ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -66302085 E (11372/tr)
> migration/28-185     [028] d..2.    70.264280: __print_se:   ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -66302085 E (-1//autogroup-31)
> migration/28-185     [028] d..2.    70.264282: __print_se:   ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N (-1//autogroup-33)
> migration/28-185     [028] d..2.    70.264283: validate_cfs_rq: min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256
> 
> I need to go make dinner (kids hungry), but I'll see if I can figure out
> how this happens...

*sigh*, does the below help?

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fbcbda97d5..6a670f119efa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 */
 		deadline = div_s64(deadline * old_weight, weight);
 		se->deadline = se->vruntime + deadline;
+		min_deadline_cb_propagate(&se->run_node, NULL);
 	}
 
 #ifdef CONFIG_SMP
