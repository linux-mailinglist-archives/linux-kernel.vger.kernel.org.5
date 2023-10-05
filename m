Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BF7BA34B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJEPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjJEPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED31AA;
        Thu,  5 Oct 2023 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o2YxsTk1skEg1zkGIfIcr75SCuwR3u/h7Q16ZDMeKGQ=; b=Pmpqe2ha+itDC41eYUnmhi0Hln
        8lHRScG/U8h+n9/2paGxi+wr8Ld1tMzOGiOUp6IAAXXLp8eJGNl4qe9B+N0ECUcVaM1ZpZvmqIYe/
        sPUAL8PtEPGHrzbeeTqUW7Vx4AyV4CfBE/vJLJ5mw3AYWqRiCUICzRHQsJ50CcKlTWCtp4sc7ZSqQ
        66glhV+56UP10wPEX06EBH8dcmjGKrEowFC30A3sI5UlcEmndWfV0yVBdxxeFPJAk1BbTmqwr2KM/
        3kDOKQ0f8Qpfr+DrKURkKZKrhzlNu+UYCRekgApCxy/ZWgf5w14XKs+8EO0Jq825rrQZdjzJpNFjf
        kxH4Iq8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoQ0Y-00BmeE-0M;
        Thu, 05 Oct 2023 15:11:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A75B300451; Thu,  5 Oct 2023 17:11:23 +0200 (CEST)
Date:   Thu, 5 Oct 2023 17:11:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "efault@gmx.de" <efault@gmx.de>,
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
Message-ID: <20231005151123.GD743@noisy.programming.kicks-ass.net>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005150258.GA36277@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:02:58PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 05, 2023 at 07:31:34AM +0000, Biju Das wrote:
> 
> > [   26.099203] EEVDF scheduling fail, picking leftmost
> 
> This, that the problem.. the rest is just noise because printk stinks.
> 
> Weirdly have not seen that trigger, and I've been running with this
> patch on for a few days now :/

I've killed the patch for now, will try again once we figure out what
goes side-ways.


Thanks!
