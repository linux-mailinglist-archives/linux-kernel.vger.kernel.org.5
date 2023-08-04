Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7561770682
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHDQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHDQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002D1994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6546B620B7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73BDC433C8;
        Fri,  4 Aug 2023 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168388;
        bh=PNFOMbmUZdgVT+kh12TTuTIEeamPyZ6PuMBUMdB/kVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZ4XbrRbIl86NxQzlvhvul5wzaQkmFJIXJllRkH5or5FFfBnJkDTz/fIOqRE6QPxi
         TFpzXHGIQAh03K5L270HIMuBDgNnknu7x8+i/vVIBGBo+EqugzvASjKbD3pYH/87Ph
         DkwPzfsdH/NxYgV4hWSy2eaHYkaAOiP/nVzlTEs8EGonGr4pCypK/tMt/RKXdVQYog
         wQd2s5zikFfXHdA/OpxGcfnEkCGs4rZAUX56DyFX8W4XSnmqRIPlk/0ZkPPvHSNoon
         W02BwlixBdOZnWaZmSFWcvMnjVWIUoENpb6L96+9UGiEjKiM9jXQlf/3DeFTigDEgu
         S536Rb901R5Fw==
Date:   Fri, 4 Aug 2023 17:59:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Message-ID: <20230804165943.GG30679@willie-the-truck>
References: <20230722031729.3913953-1-longman@redhat.com>
 <20230728150614.GF21718@willie-the-truck>
 <62d4b353-0237-9ec6-a63e-8a7a6764aba5@redhat.com>
 <20230804162812.GC30679@willie-the-truck>
 <458ac4d2-bb8a-0359-f198-dd53f4c84bd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <458ac4d2-bb8a-0359-f198-dd53f4c84bd3@redhat.com>
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

On Fri, Aug 04, 2023 at 12:51:47PM -0400, Waiman Long wrote:
> On 8/4/23 12:28, Will Deacon wrote:
> > > > >    struct dmc620_pmu {
> > > > > @@ -423,9 +424,14 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
> > > > >    	struct dmc620_pmu_irq *irq;
> > > > >    	int ret;
> > > > > -	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
> > > > > -		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
> > > > > +	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node) {
> > > > > +		if (irq->irq_num != irq_num)
> > > > > +			continue;
> > > > > +		if (!irq->valid)
> > > > > +			return ERR_PTR(-EAGAIN);	/* Try again later */
> > > > It looks like this can bubble up to the probe() routine. Does the driver
> > > > core handle -EAGAIN coming back from a probe routine?
> > > Right, I should add code to handle this error condition. I think it can be
> > > handled in dmc620_pmu_get_irq(). The important thing is to release the
> > > mutex, wait a few ms and try again. What do you think?
> > I don't really follow, but waiting a few ms and trying again sounds like
> > a really nasty hack for something which doesn't appear to be constrained
> > by broken hardware. In other words, we got ourselves into this mess, so
> > we should be able to resolve it properly.
> 
> From my point of view, the proper way to solve the problem is to reverse the
> locking order. Since you don't to add a EXPORT statement to the core kernel
> code, we will have to find a way around it by not holding the
> dmc620_pmu_irqs_lock when cpuhp_state_add_instance_nocalls() is called.
> Another alternative that I can think of is to add one more mutex that we
> will hold just for the entirety of  __dmc620_pmu_get_irq() and take
> dmc620_pmu_irqs_lock only when the linked list is being modified. That will
> eliminate the need to introduce arbitrary wait as other caller of
> __dmc620_pmu_get_irq() will wait in the new mutex. Will this work for you?

Yes. To be honest, I think we've both spent far too much time trying to
fix this (and I admire your persistence!), so adding a mutex to make it
"obviously" correct sounds like the right thing to me. We can look at
optimisations later if anybody cares.

Cheers,

Will
