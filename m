Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABEA7BBC32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjJFP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjJFPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:55:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500409E;
        Fri,  6 Oct 2023 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WaEf6FrRWvtJnI5YP9M3tuune/f/xvQ8jUCMeM104oA=; b=p7lYaZ7x0sCFwueHdtmZIZAewN
        qoKhx2eoWOrz5CzIPGPFqw19jMPfXXuCJgXuX0Ny7EYS/U5iZu7cRL6d7zTN7SheI9dz9Q12lsghM
        gXZj3aqzWotuB0ALp5XykK0ROpHk/mGxqaD4GRScfPqZqc+t+i4AgmkPlz6br2Hkp7buhSkR3uZxt
        7KMyPyTmK0TFuBCOmq0cf9bnXeXalcS0DT+ZMBuqp12s/Uk2Q6FyGI/ZGlGs1tyvE6iIo2A5SYFeW
        KxxlcNJuA/BgGn5+bpJ8zcJIDFe5bF1DeeFGWmhFvhz7+JtMNcRjJDzDxMIdH9tb6mSsPz2p5JNEo
        U2pZt83w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qonAL-00G9FU-Sv; Fri, 06 Oct 2023 15:55:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B3A3300392; Fri,  6 Oct 2023 17:55:01 +0200 (CEST)
Date:   Fri, 6 Oct 2023 17:55:01 +0200
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
Message-ID: <20231006155501.GH36277@noisy.programming.kicks-ass.net>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
 <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
 <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:39:09PM +0200, Mike Galbraith wrote:
> On Fri, 2023-10-06 at 16:00 +0200, Peter Zijlstra wrote:
> > On Fri, Oct 06, 2023 at 12:31:28PM +0200, Mike Galbraith wrote:
> > > On Fri, 2023-10-06 at 10:35 +0200, Marek Szyprowski wrote:
> > > >
> > > >
> > > > Just to note, I've run into this issue on the QEmu's 'arm64/virt'
> > > > platform, not on the Samsung specific hardware. 
> > >
> > > It doesn't appear to be arch specific, all I have to do is enable
> > > autogroup, raspberry or x86_64 desktop box, the occasional failure
> > > tripping over task groups, leaving both best and best_left with
> > > identical but not what we're looking for ->min_deadline.
> >
> > OK, autogroups enabled and booted, /debug/sched/debug shows autogroups
> > are indeed in existence.
> >
> > I've ran hackbench and a kernel build, but no whoopsie yet :-(
> >
> > I suppose I'll kick some benchmarks and go make a cup 'o tea or
> > something.
> 
> Hm, just booting gets me a handful, and generic desktop activity
> produces a fairly regular supply.  This is virgin 6.6.0.ga9e6eb3-tip.

You're running that systemd thing, eh?

If I create two groups (or two users with autogroup on) and have them
both build a kernel I do indeed get splat.

And yeah, min_deadline is hosed somehow.

migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
migration/28-185     [028] d..2.    70.264277: __print_se: ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -66302085 E (11372/tr)
migration/28-185     [028] d..2.    70.264280: __print_se:   ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -66302085 E (-1//autogroup-31)
migration/28-185     [028] d..2.    70.264282: __print_se:   ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N (-1//autogroup-33)
migration/28-185     [028] d..2.    70.264283: validate_cfs_rq: min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256

I need to go make dinner (kids hungry), but I'll see if I can figure out
how this happens...
