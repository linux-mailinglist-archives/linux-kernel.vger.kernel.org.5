Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243A775E49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjHIL6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjHIL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF21728
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5D796375F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2563EC433C8;
        Wed,  9 Aug 2023 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691582330;
        bh=/H1ZcbRfUSpWvjoUyw2HXiK0PXbG+SaxxJBWfjFis1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJQpckXDBvAWwfq+S4FYIEpKw6nOfUxvf0nt/E6OvJUe2zH0jaqaUt/i9VG1Nov4H
         EfR+czQz3C0j7MQxmOd3QAAswKf1BP4k3/+lO36cw5H9vkxfDHtcaLoxp6cnhbrrs3
         j6pE08HJ2FJt9n1L7pRyKHlrBESG63GTmVdrsjtpV6xLdEse5NnZZWOqFSg3ohhvt4
         SnJUFLMUl76ZY8hBba5rffHkff9gkPi0ho4AkVjWr69yPwQLU9CZSQrqGQNpfuSd3g
         Ff8Fb+TH2d4YPDM2Icj6Wbs5GGA5rPHTFWNOGZsFNtj66s9B3PYu1NITXWDphhOQ7K
         KfcT7gcxtMv8g==
Date:   Wed, 9 Aug 2023 12:58:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Message-ID: <20230809115845.GA3903@willie-the-truck>
References: <20230807154446.208572-1-longman@redhat.com>
 <0d32adf1-43fd-2762-d5ab-707d5969dcb0@arm.com>
 <e2be710d-336e-7136-ef23-08f5eab35aed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2be710d-336e-7136-ef23-08f5eab35aed@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:10:01PM -0400, Waiman Long wrote:
> 
> On 8/8/23 08:29, Robin Murphy wrote:
> > On 2023-08-07 16:44, Waiman Long wrote:
> > > The following circular locking dependency was reported when running
> > > cpus online/offline test on an arm64 system.
> > > 
> > > [   84.195923] Chain exists of:
> > >                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock -->
> > > cpuhp_state-down
> > > 
> > > [   84.207305]  Possible unsafe locking scenario:
> > > 
> > > [   84.213212]        CPU0                    CPU1
> > > [   84.217729]        ----                    ----
> > > [   84.222247]   lock(cpuhp_state-down);
> > > [   84.225899] lock(cpu_hotplug_lock);
> > > [   84.232068] lock(cpuhp_state-down);
> > > [   84.238237]   lock(dmc620_pmu_irqs_lock);
> > > [   84.242236]
> > >                  *** DEADLOCK ***
> > > 
> > > The problematic locking order seems to be
> > > 
> > >     lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
> > > 
> > > This locking order happens when dmc620_pmu_get_irq() calls
> > > cpuhp_state_add_instance_nocalls(). Since dmc620_pmu_irqs_lock is used
> > > for protecting the dmc620_pmu_irqs structure only, we don't actually
> > > need
> > > to hold the lock when adding a new instance to the CPU hotplug
> > > subsystem.
> > > 
> > > Fix this possible deadlock scenario by adding a new
> > > dmc620_pmu_get_irq_lock for protecting the call to
> > > __dmc620_pmu_get_irq()
> > > and taking dmc620_pmu_irqs_lock inside __dmc620_pmu_get_irq()
> > > only when dmc620_pmu_irqs is being searched or modified. As a
> > > result, cpuhp_state_add_instance_nocalls() won't be called with
> > > dmc620_pmu_irqs_lock held and cpu_hotplug_lock won't be acquired after
> > > dmc620_pmu_irqs_lock.
> > > 
> > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   drivers/perf/arm_dmc620_pmu.c | 18 ++++++++++++++----
> > >   1 file changed, 14 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/perf/arm_dmc620_pmu.c
> > > b/drivers/perf/arm_dmc620_pmu.c
> > > index 9d0f01c4455a..895971915f2d 100644
> > > --- a/drivers/perf/arm_dmc620_pmu.c
> > > +++ b/drivers/perf/arm_dmc620_pmu.c
> > > @@ -68,6 +68,7 @@
> > >     static LIST_HEAD(dmc620_pmu_irqs);
> > >   static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
> > > +static DEFINE_MUTEX(dmc620_pmu_get_irq_lock);
> > >     struct dmc620_pmu_irq {
> > >       struct hlist_node node;
> > > @@ -421,11 +422,18 @@ static irqreturn_t dmc620_pmu_handle_irq(int
> > > irq_num, void *data)
> > >   static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
> > >   {
> > >       struct dmc620_pmu_irq *irq;
> > > +    bool found = false;
> > >       int ret;
> > >   +    mutex_lock(&dmc620_pmu_irqs_lock);
> > 
> > Do we strictly need this? I'd hope that the outer release/acquire of
> > dmc620_get_pmu_irqs_lock already means we can't observe an invalid value
> > of irq->irq_num, and the refcount op should be atomic in itself, no?
> > Fair enough if there's some other subtlety I'm missing - I do trust that
> > you're more experienced in locking and barrier semantics than I am! -
> > and if it comes to it I'd agree that simple extra locking is preferable
> > to getting into explicit memory barriers here. locking
> 
> I guess we can use rcu_read_lock/rcu_read_unlock and
> list_for_each_entry_rcu() to avoid taking dmc620_pmu_irqs_lock here.

I thought we decided that we couldn't use RCU in:

https://lore.kernel.org/r/2f56057b-08ef-c3a6-8300-33f36d2c3916@arm.com

?
> > One other nit either way, could we clarify the names to be something
> > like irqs_list_lock and irqs_users_lock? The split locking scheme
> > doesn't exactly lend itself to being super-obvious, especially if we do
> > end up nesting both locks, so I think naming them after what they
> > semantically protect seems the most readable option. Otherwise, this
> > does pretty much look like what I originally had in mind.
> 
> I think it is a good to rename dmc620_pmu_irqs_lock to
> dmc620_pmu_irqs_list_lock. For the other lock, its purpose is to make sure
> that only one user can get to __dmc620_pmu_get_irq(), may be
> dmc620_irqs_get_lock. I can add some comment to clarify the nesting
> relationship.

Please do that and I'll pick the patch up for 6.6.

Will
