Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E054B7F3421
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjKUQp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKUQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:45:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8E6100
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:45:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE9C433C7;
        Tue, 21 Nov 2023 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700585123;
        bh=CVDzwk2jOwJs7kMN49WDpMFr6C+98fD/I20HgAUdANs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MHQiSuLnKg9dTv0kiPb8jRhdzMqGsLGn3guLJLdm2tSBpfm93sCH8VqvrzQJRBzVR
         no2JwCfSyiYFXRUFOdfm0+OHmlTUXDMuel2hck2JDHNy+aa5Dzh1Oq47Ec8D5qK+oC
         OruacyS4lcIIRMsaGXknxlAy1em6O5O+yvpiYFiuAYc2yYCER2Rx8XnUECA2m8Wgvd
         H1rzrSHtpf05heCPTxZiLMsMTsggP76kJmw5Lpc0Cn6eLRFOAnTHuhT9U9HrtPs9eU
         ZCqhX6IdLdfhkp6Xd5JNNTMJMAXHizavjBzYvOpbvUYKOUdB7on0EjlgwJs7rn4uTn
         ocFzgh5Px9Duw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDC4FCE04C0; Tue, 21 Nov 2023 08:45:22 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:45:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <fc50b15e-8ad1-4ed5-b833-fd3b72c0aa0e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <20231121094444.04701bdc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094444.04701bdc@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:44:44AM -0500, Steven Rostedt wrote:
> On Tue, 21 Nov 2023 15:36:47 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > Still utterly confused about what task-tracing rcu is and how it is
> > different from preemptible rcu.
> 
> Is this similar to synchronize_rcu_tasks()? As I understand that one (grace
> period continues until all tasks have voluntarily scheduled or gone into
> user space). But I'm a bit confused by synchronize_rcu_tasks_trace()?
> 
> Note, that for syncronize_rcu_tasks() the critical sections must not call
> schedule (although it is OK to be preempted).

The synchronize_rcu_tasks() and synchronize_rcu_tasks_trace() functions
are quite different, as noted elsewhere in this thread.

							Thanx, Paul
