Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BD793635
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjIFHZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjIFHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:25:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D055E59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvirAZxakejjQRMmtLQi7P2+8RvF8vSXY6Gk8xEWvoA=; b=JGUzSNoBDZXJ72rJgZQbuptQJt
        3QeYeEyRN4QfbfRZzCLohM1PSRFJJKYF5ob3tY03Md/tntRCYsOT2uXswR8sXvprtnBTuejfqImO4
        HEdubGUeyELBuOo1ph6VtuI/DxjWhHWPcomnpYd89WoZ0Tc9w+bBBRaV5j6k+RuBHUoGIy8SrlK9i
        1F+UawdzRutImAkCAIdkZAUpk2/dctYzJR3b8bpQ/nzF4v8tQ+6GWdxsu4hS0Nbu9xGMeM+rP/j7c
        omEngCY2BYcldxfPNj9uAa7usIeg4fYhSowQOLjeSlg/n+Qnj6VmQiP8lK8qkyuTZtt1kBUbamTMj
        ZbWF8XKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdmuK-000wWt-0Q;
        Wed, 06 Sep 2023 07:25:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3549B3003F2; Wed,  6 Sep 2023 09:25:01 +0200 (CEST)
Date:   Wed, 6 Sep 2023 09:25:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 7/7] sched/fair: Fair server interface
Message-ID: <20230906072501.GA38741@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
 <20230905135500.GB20703@noisy.programming.kicks-ass.net>
 <ee0ac345-e3b0-52ea-d70e-0048b2296e67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0ac345-e3b0-52ea-d70e-0048b2296e67@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 06:17:26PM +0200, Daniel Bristot de Oliveira wrote:

> > Additionally, should not the deadline parameters be vetted by access
> > control before being accepted ?
> 
> like security_task_getscheduler(p)? But we have no p...

I was thinking sched_dl_overflow() or thereabout. That still runs on p,
but I'm thikning that should be easily adapted to dl_se or somesuch.
