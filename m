Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E58A7929D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353606AbjIEQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354134AbjIEJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:50:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB312A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dvlDpiEOoqBI3j8a37DX+2buukk9llzsd8rtK0T442s=; b=gEfDHRp5wzv0WDiySJMFgTKRs9
        dorc+v3tposS1Zv/EngPhrGvGhZm6jSjDOs4D7+soieRp6lpKjo0PjglbYJAVKtpui/xj7WIYhaOT
        1zDK78Cdoj72bB+GGOhxPVNUOfL+nQKXeX3lsQn3Eo5rzfEX0dQirI2jWmbv80NusCeZT6xVHP020
        yGCwxNRxWy2ziIoyhtlEscuNdok56iMZTqyeuZBqJfjNJwdYJKscp659IuR5SNUG1apj9+Bl162Jl
        MTer7ZKB+Va+riZPm4gOrG/i/fxbTWwI7C74zejdYhGrZn/JzCwYxGr7QCHwCMU3GJijqk40TOTSP
        GX7jM41A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdSgd-008KTf-DQ; Tue, 05 Sep 2023 09:49:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1773430057E; Tue,  5 Sep 2023 11:49:31 +0200 (CEST)
Date:   Tue, 5 Sep 2023 11:49:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com, hdanton@sina.com,
        ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
Message-ID: <20230905094930.GA28319@noisy.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
 <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
 <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
 <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
 <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
 <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
 <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:33:57PM +0530, Shrikanth Hegde wrote:
> Hi Tim, Peter. 

Back from PTO; mailbox is a disaster area, but I'll try and have a look
soon.
