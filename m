Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E076400B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjGZTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjGZTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:55:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F502691;
        Wed, 26 Jul 2023 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XyTW0Ej/ctvX5mhAYSsUtLai+EJ8srqN7zialJMkLmE=; b=hM1wJiCXTM2z10qaH70Y3td19Q
        RcNkzv2osxtg8g5vj9sDJvWhn20I2tyHdnfNRVCieOfO++Y9Q3cl6+xO7wjUeov18fOZuZlG+hbPi
        HUDwSYX/Nlfs1QoXzUQehGHWijgiU7cp3U79zFxvgoVlpDsyGPAVt9iOYENQ8E8R5m7zRPHoMFiF4
        2ZCQVJm86wwBgM+/ZGkpklArFaA1/clBOci/PfKeaZ+ldYZjK2AbJ+Nk0Xdxb+TDkrL1/+XoWsVXa
        ujTRXxt/hpfEFtfai3OXujo2NVSNvmdOm/34N4u2U50WMJAYFE8mlQjPbUeqxEX36eEWrTdxEevL9
        xAj7AhOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOkan-005ynS-0H;
        Wed, 26 Jul 2023 19:54:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 465A730056F;
        Wed, 26 Jul 2023 21:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0952E201BD673; Wed, 26 Jul 2023 12:25:12 +0200 (CEST)
Date:   Wed, 26 Jul 2023 12:25:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 4/4] intel_idle: Add ibrs_off module parameter to
 force disable IBRS
Message-ID: <20230726102512.GD3802077@hirez.programming.kicks-ass.net>
References: <20230710194857.2898284-1-longman@redhat.com>
 <20230710194857.2898284-5-longman@redhat.com>
 <f5f25279-bbb5-e040-aeaa-dd3d8686c670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5f25279-bbb5-e040-aeaa-dd3d8686c670@redhat.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:45:49PM -0400, Waiman Long wrote:
> On 7/10/23 15:48, Waiman Long wrote:
> > Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> > disables IBRS when the cstate is 6 or lower. However, there are
> > some use cases where a customer may want to use max_cstate=1 to
> > lower latency. Such use cases will suffer from the performance
> > degradation caused by the enabling of IBRS in the sibling idle thread.
> > Add a "ibrs_off" module parameter to force disable IBRS and the
> > CPUIDLE_FLAG_IRQ_ENABLE flag if set.
> > 
> > In the case of a Skylake server with max_cstate=1, this new ibrs_off
> > option will likely increase the IRQ response latency as IRQ will now
> > be disabled.
> > 
> > When running SPECjbb2015 with cstates set to C1 on a Skylake system.
> > 
> > First test when the kernel is booted with: "intel_idle.ibrs_off"
> >    max-jOPS = 117828, critical-jOPS = 66047
> > 
> > Then retest when the kernel is booted without the "intel_idle.ibrs_off"
> > added.
> >    max-jOPS = 116408, critical-jOPS = 58958
> > 
> > That means booting with "intel_idle.ibrs_off" improves performance by:
> >    max-jOPS:   1.2%, which could be considered noise range.
> >    critical-jOPS: 12%, which is definitely a solid improvement.
> > 
> > The admin-guide/pm/intel_idle.rst file is updated to add a description
> > about the new "ibrs_off" module parameter.
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
> >   drivers/idle/intel_idle.c                   | 11 ++++++++++-
> >   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> Ping! Is there further suggested changes for this patch series or is it good
> enough to be merged?

I suppose I'll go stick it in x86/core unless someone objects.
