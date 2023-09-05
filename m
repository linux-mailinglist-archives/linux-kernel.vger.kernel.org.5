Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A72792B26
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbjIEQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354305AbjIEKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:39:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF092E8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bho1rikArwHh1Ir6UT1I183seDwg4WavDpy177iqdMA=; b=pgSjpkapTO1DZDXS3H3rqXcdE+
        +SsbfNJOHmtMfGSHWV+Fr1S0FR2nduaXxpyUWX9dTE+2VqZOry9I5sGvchpzARqTR9cGvERkFVsa+
        Eng1G8dh5JFjVA1hFBUZZrUQuKkhi0fgUQsSptj0pO1ArdTDiCGmFhO4Iv4zu6aB1aiKQX4JaDwyj
        2QFRIWg33ipCRECtmdCAnqKvp48GzDHbbiD5OWj1LNeqBoADRi9mO+gwe3+NAdLNOexN4UFA7nFsM
        JFb39ekfD7JgUKfaDowOcreJ2zyozrXN3t36RJAT9mHIYCjA8zHzvm6C+7LTTzpFiOZLRPfKxUpMq
        MrdQO8ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdTSL-0001Al-0N;
        Tue, 05 Sep 2023 10:38:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 378BF300687; Tue,  5 Sep 2023 12:38:50 +0200 (CEST)
Date:   Tue, 5 Sep 2023 12:38:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, bristot@redhat.com,
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
Message-ID: <20230905103850.GB28319@noisy.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
 <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
 <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
 <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
 <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
 <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:19:40PM -0700, Tim Chen wrote:
> Just back from my long vacation.  Wonder if you have any comments on the above patch
> for fixing the SMT4 case?

This should have:

Fixes: fee1759e4f04 ("sched/fair: Determine active load balance for SMT sched groups")

Right?
