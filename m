Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD2793718
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjIFIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjIFIYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:24:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE4BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HASdbWBlLGvRLbOokcwiL20PVPPUOGsikw/Wsh36spU=; b=fZXiNbVC5bwzTmPsV1CyU6Gxnq
        /RSg5eBN9ZeqmbM4fhnUTt3bSviJ3kgYSxIcYF8I2jAL6qdM1sa9L4SU+rVFFenHeTseuirUcGFnY
        UtOrPXaPYU8yzSBLkOwBpQxT3n9hyq1HSlliiKzyioJKRJoZD1vicOT2ZBtFvnZxn8u2FHN7GBc5H
        DaMoVPXzT4XiVffNxDbeFLDH+n33wTujSqXl/9hLz3QWpb1zex/i1jtL2XhlFTMSVdEpFh1zK6IE3
        C6kL9+WoZKlMtpKzx7LaP63GqLQahS3hWqu82hz2cCMyUwy7uxvwr6rhNAahByYQj8NjOQh8Izpi4
        d89Ja+2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdnoo-000ySJ-2D;
        Wed, 06 Sep 2023 08:23:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBB793003F2; Wed,  6 Sep 2023 10:23:23 +0200 (CEST)
Date:   Wed, 6 Sep 2023 10:23:23 +0200
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
Message-ID: <20230906082323.GA28941@noisy.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
 <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
 <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
 <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
 <20230905104136.GC28319@noisy.programming.kicks-ass.net>
 <0410f8756bbcb2f893622de4e146c13e9565248e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0410f8756bbcb2f893622de4e146c13e9565248e.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:54:09AM -0700, Tim Chen wrote:

> > > +		goto fully_busy;
> > > +		break;
> > 
> > This is really daft; why can't this simply be: fallthrough; ? At the
> > very least that break must go.
> > 
> > 
> 
> Yes, the break should go.  I was adding the goto to prevent compiler
> from complaining about fall through code. 

But that's what we have the fallthrough keyword for, no?
