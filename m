Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD67705F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjHDQ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHDQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27CBE7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8C962089
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855CFC433C8;
        Fri,  4 Aug 2023 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166497;
        bh=QbXK6cjzyzYpTexkDQnjA6HpPhZ1dR9sbMzjWsDQaz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+1ISQA+ECvHq+Q4/jaw17XQbEhWuYvKjSs7I3XXafA2x75GhKAIhPa/Vdlbg1Uwq
         uZ/QqquK6kT7tdzYgUdgHuFi2eX8GT6xrqtxT/Hstgfycsibbf6lBXbAHre9mYZOoL
         KNqesgAbHMftkHbodI0lt7Vo2cAZ3dI17zvO3Ba26OlZvKMsCg+3d2FaxEk6rI1yfF
         xzioz4jJSI9LzIW2/FQas8iHwFY/8QhS96QuSB/1mJHUYT/RWRecO2L1D9FksNcBzd
         Qdvrax1lYq8q2vRPP3wKZ4fAGPzFCOO/wxlnD5phEVWlIo4yPA23Zw15E9VUlbzA7V
         qOHb25vwxWQWQ==
Date:   Fri, 4 Aug 2023 17:28:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Message-ID: <20230804162812.GC30679@willie-the-truck>
References: <20230722031729.3913953-1-longman@redhat.com>
 <20230728150614.GF21718@willie-the-truck>
 <62d4b353-0237-9ec6-a63e-8a7a6764aba5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d4b353-0237-9ec6-a63e-8a7a6764aba5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:37:31PM -0400, Waiman Long wrote:
> 
> On 7/28/23 11:06, Will Deacon wrote:
> > On Fri, Jul 21, 2023 at 11:17:28PM -0400, Waiman Long wrote:
> > > The following circular locking dependency was reported when running
> > > cpus online/offline test on an arm64 system.
> > > 
> > > [   84.195923] Chain exists of:
> > >                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down
> > > 
> > > [   84.207305]  Possible unsafe locking scenario:
> > > 
> > > [   84.213212]        CPU0                    CPU1
> > > [   84.217729]        ----                    ----
> > > [   84.222247]   lock(cpuhp_state-down);
> > > [   84.225899]                                lock(cpu_hotplug_lock);
> > > [   84.232068]                                lock(cpuhp_state-down);
> > > [   84.238237]   lock(dmc620_pmu_irqs_lock);
> > > [   84.242236]
> > >                  *** DEADLOCK ***
> > > 
> > > The problematic locking order seems to be
> > > 
> > > 	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
> > > 
> > > This locking order happens when dmc620_pmu_get_irq() is called from
> > > dmc620_pmu_device_probe(). Since dmc620_pmu_irqs_lock is used for
> > > protecting the dmc620_pmu_irqs structure only, we don't actually need
> > > to hold the lock when adding a new instance to the CPU hotplug subsystem.
> > > 
> > > Fix this possible deadlock scenario by releasing the lock before
> > > calling cpuhp_state_add_instance_nocalls() and reacquiring it afterward.
> > > To avoid the possibility of 2 racing dmc620_pmu_get_irq() calls inserting
> > > duplicated dmc620_pmu_irq structures with the same irq number, a dummy
> > > entry is inserted before releasing the lock which will block a competing
> > > thread from inserting another irq structure of the same irq number.
> > > 
> > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   drivers/perf/arm_dmc620_pmu.c | 28 ++++++++++++++++++++++------
> > >   1 file changed, 22 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> > > index 9d0f01c4455a..7cafd4dd4522 100644
> > > --- a/drivers/perf/arm_dmc620_pmu.c
> > > +++ b/drivers/perf/arm_dmc620_pmu.c
> > > @@ -76,6 +76,7 @@ struct dmc620_pmu_irq {
> > >   	refcount_t refcount;
> > >   	unsigned int irq_num;
> > >   	unsigned int cpu;
> > > +	unsigned int valid;
> > >   };
> > >   struct dmc620_pmu {
> > > @@ -423,9 +424,14 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
> > >   	struct dmc620_pmu_irq *irq;
> > >   	int ret;
> > > -	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
> > > -		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
> > > +	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node) {
> > > +		if (irq->irq_num != irq_num)
> > > +			continue;
> > > +		if (!irq->valid)
> > > +			return ERR_PTR(-EAGAIN);	/* Try again later */
> > It looks like this can bubble up to the probe() routine. Does the driver
> > core handle -EAGAIN coming back from a probe routine?
> Right, I should add code to handle this error condition. I think it can be
> handled in dmc620_pmu_get_irq(). The important thing is to release the
> mutex, wait a few ms and try again. What do you think?

I don't really follow, but waiting a few ms and trying again sounds like
a really nasty hack for something which doesn't appear to be constrained
by broken hardware. In other words, we got ourselves into this mess, so
we should be able to resolve it properly.

Will
