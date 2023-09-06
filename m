Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64152793D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbjIFNIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIFNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:08:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D776CC7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:08:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694E4C433C8;
        Wed,  6 Sep 2023 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694005696;
        bh=q5UnNoIfDw2T6R2bmsCTlYu42NHHujjkDP1szlKTbB0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SacT/kN1kenGL/QEd9lzT+gCmIKj4LKhAm5aGiqPrm3ZrvxN9fHaqB5ao/qrQyO+m
         RmSqi5QfrIwpEf3owWBmfChp2qN15F4FJ8mF6AGx5/QfrU6lJNUS8R63IjnZHydEDw
         8U+sWFTkEYzxge432X7NoNqvqGrxOP0o853VrxulwXgj4RNMy9O0mz7QNeLvy0t1X+
         jpjWHoSmSyQ0sa1f/U65djTxUfQsaRcqZV4/A/ODheRT2Ns+lDi072Yh/oWlZjh/QC
         NZoEOAcDC9ApFT5odfDPZ9a4GoUFh2dZz1lpmY6tyU3AEuXzCY1IaRaGeS6rOzqehd
         jwbK9upiEZrow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 05BF4CE0FF4; Wed,  6 Sep 2023 06:08:16 -0700 (PDT)
Date:   Wed, 6 Sep 2023 06:08:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
Message-ID: <c06ea3f3-4f07-42fb-9ad1-a227e9534bb1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
 <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
 <20220426162445.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220622195856.GA1694215@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhzghof1eo.mognet@vschneid.remote.csb>
 <20220705172342.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhsfmfc7s5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhsfmfc7s5.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:30:02AM +0100, Valentin Schneider wrote:
> On 05/07/22 10:23, Paul E. McKenney wrote:
> > The second of these occurred near shutdown, but the first was quite some
> > time before shutdown.  In case that makes a difference.
> >
> > I have not seen this since.
> >
> > Any other diagnostics I should add?
> >
> 
> Sorry, I let this get buried to the bottom of my inbox :(
> 
> I've had another look at rcutorture.c but just like for
> rcu_torture_reader(), I don't see any obvious culprit (no
> kthread_set_per_cpu() usage)).
> 
> One thing I think would help is a scheduling trace (say sched_switch,
> sched_wakeup and cpuhp*, combined with ftrace_dump_on_oops + panic_on_warn
> ?) - that should at least tell us if the issue is in the wakeup placement
> (if the task gets placed on a dying CPU *after* CPUHP_AP_ACTIVE), or in the
> balance_push() mechanism (the task was *already* on the CPU when it started
> dying and never moved away).
> 
> Neither make sense to me, but it has to be somewhere in there...

And given that it has been more than a year since I have seen this,
I am considering it to be fixed, whether purposefully or accidentally.

							Thanx, Paul
