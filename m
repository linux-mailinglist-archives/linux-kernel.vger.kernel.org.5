Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800BA80E426
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjLLGDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:03:36 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE40EA1;
        Mon, 11 Dec 2023 22:03:42 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 1FA7A20B74C0; Mon, 11 Dec 2023 22:03:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FA7A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1702361022;
        bh=hx1+thlCTOb6QRHlrdBHJnO7+AxZwUlT544NfeaPGRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqJE/uNxjAsQMBeeD90Q8CIovDZz74GDXWCDdkLHKi3KwsbFvb+6O8FQO6nyF8tJa
         kjJrDlFG4Mo3ycLQCcf4Z24dxY1Abhklo40uGZwia8y7/oMKR6Si4ruaOYjZBlIjKi
         YYVAfZf3gbUPqqgN+wtbcyqo8i1THT19WPzPFoeY=
Date:   Mon, 11 Dec 2023 22:03:42 -0800
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        paulros@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <20231212060342.GA16802@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <ZXOQb+3R0YAT/rAm@yury-ThinkPad>
 <20231211065323.GB4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXcV9pXmg+GE2BCF@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcV9pXmg+GE2BCF@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 06:00:22AM -0800, Yury Norov wrote:
> On Sun, Dec 10, 2023 at 10:53:23PM -0800, Souradeep Chakrabarti wrote:
> > On Fri, Dec 08, 2023 at 01:53:51PM -0800, Yury Norov wrote:
> > > Few more nits
> > > 
> > > On Fri, Dec 08, 2023 at 06:03:40AM -0800, Yury Norov wrote:
> > > > On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > > > > Existing MANA design assigns IRQ to every CPU, including sibling
> > > > > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > > > > in the same core and may reduce the network performance with RSS.
> > > > 
> > > > Can you add an IRQ distribution diagram to compare before/after
> > > > behavior, similarly to what I did in the other email?
> > > > 
> > > > > Improve the performance by assigning IRQ to non sibling CPUs in local
> > > > > NUMA node. The performance improvement we are getting using ntttcp with
> > > > > following patch is around 15 percent with existing design and approximately
> > > > > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > > > > if enough cores are present.
> > > > 
> > > > How did you measure it? In the other email you said you used perf, can
> > > > you show your procedure in details?
> > > > 
> > > > > Suggested-by: Yury Norov <yury.norov@gmali.com>
> > > > > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > > > > ---
> > > > 
> > > > [...]
> > > > 
> > > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
> > > > >  1 file changed, 83 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > index 6367de0c2c2e..18e8908c5d29 100644
> > > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > > > >  	r->size = 0;
> > > > >  }
> > > > >  
> > > > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > > > > +{
> > > > > +	int w, cnt, cpu, err = 0, i = 0;
> > > > > +	int next_node = start_numa_node;
> > > > 
> > > > What for this?
> > > > 
> > > > > +	const struct cpumask *next, *prev = cpu_none_mask;
> > > > > +	cpumask_var_t curr, cpus;
> > > > > +
> > > > > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> > > 
> > > alloc_cpumask_var() here and below, because you initialize them by
> > > copying
> > I have used zalloc here as prev gets initialized after the first hop, before that
> > it may contain unwanted values, which may impact cpumask_andnot(curr, next, prev).
> > Regarding curr I will change it to alloc_cpumask_var().
> > Please let me know if that sounds right.
> 
> What? prev is initialized at declaration:
Yes, I will remove the zalloc and will change it to alloc in V6.
Thanks for pointing.
>         
>         const struct cpumask *next, *prev = cpu_none_mask;
