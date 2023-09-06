Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89F7938C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbjIFJsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbjIFJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6121E171A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VWvslC/d6T0SRndp1Nl0Grdu04mGs5sTh2pssoFGybk=; b=WbSAYhq5daejd9NfzYCdut2/Hd
        4v8Vv6AZW9q7I7912kiY4EiRIaiRfEJeMs4R0hxgAcab9IX+NEH6i7JuHgPvvvYRgAuy1ve8zrCID
        4u6eyoIYg3aEwof3tnZ0qgA34Q5w9iGKIlcKnHhLTj6x7wLN+bqwkD5PFILj7fu4+v+YvALHpw0oo
        s/P0NT1YqPHSERS1xhqZ9LFumXCIz5jKqmo7ZanCMOydPmCUqO2YjrQls+BDQLUcf3CTvr2jwaepx
        Je2cAn+tOLS/FkbNy9uMQiOBOEAGaZm7qlWXgxX1ul0mCNWfroEgfwlHzjgSgk1wj/9tKbAr8eU+x
        OcVwgNfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdp8T-001Dvf-BR; Wed, 06 Sep 2023 09:47:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C49943003F2; Wed,  6 Sep 2023 11:47:44 +0200 (CEST)
Date:   Wed, 6 Sep 2023 11:47:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Message-ID: <20230906094744.GE38741@noisy.programming.kicks-ass.net>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
 <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
 <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
 <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
 <ae4b342c424b76dc3f8adafcc2da7c02b9755b10.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae4b342c424b76dc3f8adafcc2da7c02b9755b10.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:44:57PM -0700, Tim Chen wrote:

> Reading up on sched_clock() documentation and seems like it should 
> indeed be monotonic.

It tries very hard to be monotonic but cannot guarantee. The moment TSC
is found unstable it's too late to fix up everything.

