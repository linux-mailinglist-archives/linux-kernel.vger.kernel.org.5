Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1FE7BE2C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjJIO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25CF99
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696861675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iydLHg+u5KMfVoyhVtA2QOCHk3nf/DZIegZMvg91+cQ=;
        b=ipt0xixqJGiP6yBhIhAoTZteYwp8sYd7vlS6n4m+cy+aKRdrCy1GQiNQfo0dq3lY2zsmom
        BcPix2MJZ7HOdv0redAiuPnCBsrSu0eua1czV7NDJa+yuigyJTZlKf1r9Zqkq928gaK+j/
        YOzKEfwiEhHiOelRSJCF36xxRyo8eLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-7EpCVosjNFiWlV8YVwkTrw-1; Mon, 09 Oct 2023 10:27:52 -0400
X-MC-Unique: 7EpCVosjNFiWlV8YVwkTrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EDE1811E98;
        Mon,  9 Oct 2023 14:27:51 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6657A40C6EA8;
        Mon,  9 Oct 2023 14:27:43 +0000 (UTC)
Date:   Mon, 9 Oct 2023 10:27:40 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
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
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Message-ID: <20231009142740.GA437913@lorien.usersys.redhat.com>
References: <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
 <20231006192445.GE743@noisy.programming.kicks-ass.net>
 <ZSCoLllO/cYnnIMi@chenyu5-mobl2.ccr.corp.intel.com>
 <OS0PR01MB59222333D50ADBAD1786DA9A86C8A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZSD9wsBPUfhTULf7@chenyu5-mobl2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSD9wsBPUfhTULf7@chenyu5-mobl2.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 02:42:10PM +0800 Chen Yu wrote:
> Hi Biju,
> 
> On 2023-10-07 at 06:26:05 +0000, Biju Das wrote:
> > Hi Chen Yu,
> > 
> > > Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
> > > se
> > > 
> > > On 2023-10-06 at 21:24:45 +0200, Peter Zijlstra wrote:
> > > > On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
> > > >
> > > > > And yeah, min_deadline is hosed somehow.
> > > > >
> > > > > migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> > > > > migration/28-185     [028] d..2.    70.264277: __print_se:
> > > ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -
> > > 66302085 E (11372/tr)
> > > > > migration/28-185     [028] d..2.    70.264280: __print_se:
> > > ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -
> > > 66302085 E (-1//autogroup-31)
> > > > > migration/28-185     [028] d..2.    70.264282: __print_se:
> > > ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N
> > > (-1//autogroup-33)
> > > > > migration/28-185     [028] d..2.    70.264283: validate_cfs_rq:
> > > min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256
> > > > >
> > > > > I need to go make dinner (kids hungry), but I'll see if I can figure
> > > > > out how this happens...
> > > >
> > > > *sigh*, does the below help?
> > > >
> > > > ---
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > > > 04fbcbda97d5..6a670f119efa 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq,
> > > struct sched_entity *se,
> > > >  		 */
> > > >  		deadline = div_s64(deadline * old_weight, weight);
> > > >  		se->deadline = se->vruntime + deadline;
> > > > +		min_deadline_cb_propagate(&se->run_node, NULL);
> > > >  	}
> > > >
> > > >  #ifdef CONFIG_SMP
> > > 
> > > Is it because without this patch, the se->deadline is not always synced
> > > with se->min_deadline, then in pick_eevdf() the following condition could
> > > not be met, thus we get a NULL candidate and has to pick the leftmost one?
> > > 	if (se->deadline == se->min_deadline)
> > > 
> > > Regarding the circular locking warning triggered by printk, does it mean we
> > > should not get a NULL candidate from __pick_eevdf() in theory? And besides,
> > > we should not use printk with rq lock hold?
> > 
> > Is it not a useful error log? At least from the initial report Marek Szyprowski doesn't see "EEVDF scheduling fail, picking leftmost" but seen only warning triggered by this in the logs.
> > 
> 
> Yes, it is a useful log. I was trying to figure out the safe scenario to use
> printk.
>

You should not use printk with a rq lock held as some console implementations
(framebuffer etc) call schedule_work() which loops back into the scheduler
and bad things happen.

Some places in the scheduler use printk_deferred() when needed. 

I think this will be better when the RT printk stuff is fully merged. 

Cheers,
Phil

> thanks,
> Chenyu
> 

-- 

