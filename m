Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801AD7E28E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjKFPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjKFPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:41:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8237107
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sLFl/gOCp/k4uldMb79ASnHcAWXHfWhEZa7PC6AlPY=; b=Tv5V2Q4jAr7eTAYLYAlk34WPj0
        nPH5728iDsCHUVQtbjCzLr0Y26ZvKSaogCvnuJygqJDkFcSVtqvLfO0nDPoTynZ610iKAmsqhqbI4
        3+9Ye44uNMN/1J9uo7gWmiy9ZU8yefnfJcrPKUS2YDZiwH9XFnvVyYoZJLMVtOJeF4Gq0On5MoQse
        xFkXJhhgufTDLSawgoP9DUrVhG6d4+Re6VIetLReRU64ax76sf0gRHPdXduwm0tU2AenF7MkJsnxY
        cnQB6Z7BMCVzVIuafGIdAC+e3nMJlwZBDBiwjdBVCNnyQ42sdZtf5xhkEKUdpW3SeK3mN/3/FAPX7
        0vLlu9xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r01iU-00AcO8-2l;
        Mon, 06 Nov 2023 15:40:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82A2230049D; Mon,  6 Nov 2023 16:40:42 +0100 (CET)
Date:   Mon, 6 Nov 2023 16:40:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Message-ID: <20231106154042.GH3818@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
> Add an interface for fair server setup on debugfs.
> 
> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
> 
>  - fair_server_runtime: set runtime in ns
>  - fair_server_period: set period in ns
>  - fair_server_defer: on/off for the defer mechanism
> 

This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to be the
total available bandwidth control, right?

But then shouldn've we also rip out the throttle thingy right quick?
