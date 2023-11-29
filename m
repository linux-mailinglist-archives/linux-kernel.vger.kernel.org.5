Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB557FD3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjK2KRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjK2KRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:17:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B821AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6GGwjQV2ic0iBo4PY0SK3yhc60oFKSFlJ0J7DppLNDs=; b=peoR9cKyz/SB2NeKdUeYntjPzm
        cUuxpUxlXfg2mvF+k47Tdb7x8MV12NakLafWFHX7TH/b21SBVEyeiNTlW9lbl8ynXV9V/VL+fWSX1
        Uo/xjWB/33WjgCGEtLNdFxj6Pn6mKLKWIyh2rEE8TWf3F5Zv4gaVQNLEVGdXseHwSbw7d4KSaVTxR
        EejbR65nPi2Nq6wDy3nt3vpQhg35nf0sfWggntAygUaBPoD6fzz8KsLT/E5zrY4uV4OnYw09XTiFq
        XNs1g20y2bHvymc2rMXne2+68a0KCmdRV5UIxDgtKLLgLBo/R3OsPAqjWbJGDgN/kXiroQWAMoGMK
        WrfIFLlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8Hd1-00DHdF-Rh; Wed, 29 Nov 2023 10:17:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2C7B300293; Wed, 29 Nov 2023 11:17:10 +0100 (CET)
Date:   Wed, 29 Nov 2023 11:17:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Tang <tangsong8264@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Core Scheduling unnecessary force idle?
Message-ID: <20231129101710.GB30650@noisy.programming.kicks-ass.net>
References: <76d535f6-f92c-4564-aafa-290042cf76a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d535f6-f92c-4564-aafa-290042cf76a9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:53:35PM +0800, Benjamin Tang wrote:
> When I'm reading the code related to "core scheduling", I have a question.
> 
> Say the RQs in a particular core look like this:
> Let CFS1 and CFS4 be 2 untagged CFS tasks.
> Let CFS2 and CFS3 be 2 untagged CFS tasks.
> 
>          rq0                      rq1
>     CFS1(no tag)     CFS3(tagged)
>     CFS2(tagged)    CFS4(no tag)
> 
> Say schedule() runs on rq0. In the core-wide pick logic, if I'm not
> mistaken,
> the end result of the selection will be (say prio(CFS1) > prio(CFS3)):
> 
>          rq0                 rq1
>     CFS1(no tag)    IDLE
> 
> Why not consider trying to find untagged tasks for rq1 here?
> Is it because it seems less fair, or are there other considerations?
> 
> I would be very grateful if someone could give me some suggestions.
> Thanks!

Because it's expensive to unconditionally track the untagged tasks. I
suppose it could be fixed by iterating the task-set when we
enable/disable core-scheduling, but that's going to be somewhat painful.

A work-around would be to always tag everything, eg. have an explicit
'rest' tag.
