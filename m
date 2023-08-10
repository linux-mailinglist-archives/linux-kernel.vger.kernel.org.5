Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C47775B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjHJK0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHJK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:26:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808A83
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZwoRcwPde2jMSuFGIZJQsN8ToBMZksq6y8S2UUNSdAY=; b=vBoG7IYxv14q8bktC7uZU+G75r
        CXvW0BvAGK9IwO1j1Ita/Ace+JnjF7MEmxe3XSgWmwBtUDsRywoydnhLWU3YG2Bq7yyR8Fl9HwWSA
        loCoe/G9I5zVvECc3GZa0t50NO6G3gDYS7Zu4bRacEX+22xm/DqvPRIsB2/WOovmtX+iwyxe+vFOs
        2C9qqW2WxUOZsLOhWnGKVSqJC6tgde32dY68TRolwts0FOJ0w/p6IIBEkvrpw39wqIM/KRM86qLQQ
        B4+/SQO1UeCq7/AwZI2g7EJ0WSpYJttBWsJXi01fNyN1GBDA2m+Xx/jnEBVC9FcmJ0rPDVSRlrifW
        ocyVpZiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qU2rz-00Bxov-GM; Thu, 10 Aug 2023 10:26:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4422730003A;
        Thu, 10 Aug 2023 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09747201D137B; Thu, 10 Aug 2023 12:26:18 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:26:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH 0/2 RESEND] Two fixes for sysctl_sched_rr_timeslice
Message-ID: <20230810102617.GW212435@hirez.programming.kicks-ass.net>
References: <20230802151906.25258-1-chrubis@suse.cz>
 <20230810083028.l2ov4wpffhv3zw3h@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810083028.l2ov4wpffhv3zw3h@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:30:28AM +0100, Mel Gorman wrote:
> On Wed, Aug 02, 2023 at 05:19:04PM +0200, Cyril Hrubis wrote:
> > - Fixes rounding error for initial value with CONFIG_HZ_300
> > 
> > - Fixes read from the file after reset to default (by writing val <= 0)
> > 
> 
> Hi Peter,
> 
> Any chance this can be picked up in tip please? It might have helped if
> the leader mentioned the main problem covered in patch 1 -- some HZ
> values can fail LTP tests due to a simple rounding error at compile
> time.

Yah, sorry, too much crazy atm :/ Got it queued.
