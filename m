Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6752C805FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbjLEU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:58:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C12E188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:59:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4331CC433C7;
        Tue,  5 Dec 2023 20:59:01 +0000 (UTC)
Date:   Tue, 5 Dec 2023 15:59:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <20231205155927.4b3b9151@gandalf.local.home>
In-Reply-To: <20231202184507.26178c17@rorschach.local.home>
References: <20231201154932.468d088b@gandalf.local.home>
        <b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
        <20231202184507.26178c17@rorschach.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2023 18:45:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2 Dec 2023 14:24:26 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Note, the unlikely tracing is running on my production server v6.6.3.
> > > 
> > > The above trace is from my test box with latest Linus's tree.    
> > 
> > Nice tool!!!  
> 
> Thanks! It's only been in the kernel since 2008 ;-)
> 
>   1f0d69a9fc815 ("tracing: profile likely and unlikely annotations")
> 
> > 
> > My kneejerk reaction is that that condition is suboptimal.  Does the 
> > (untested) patch below help things?  
> 
> I'll give it a try on Monday.
> 

This looks to have caused a difference. Although there's other RCU
functions that need dealing with, but that's for when I have time to
analyze all the places that have bad annotations.


Anyway:

 correct incorrect  %        Function                  File              Line
 ------- ---------  -        --------                  ----              ----
 [..]
   17924        0   0 rcu_softirq_qs                 tree.c               247

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
