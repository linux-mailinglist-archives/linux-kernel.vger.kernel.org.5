Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC2809A53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573074AbjLHD2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjLHD23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DE10C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702006113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fw+TZLy2pjeD88xqozW/G6MQcy71CGObq/BZJWgm1yk=;
        b=RJJP89jBuVhXgoA1fXRTndF3JLGSaKyekPI8iUbkFTUB+tZLefPBY6Ioh0TUcHFayTniiC
        ti3XnEyn69qOTwBKuI4IowrqEVs/T8aOZQiHndr4YWdJQhE5vo4Nz4T9nr/ziv7Yd63DaQ
        npfiNx5XXFDLfc72LguVjt+Lc6qQdAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-YFg4AkRCOuaGFmOGJdqYKw-1; Thu, 07 Dec 2023 22:28:30 -0500
X-MC-Unique: YFg4AkRCOuaGFmOGJdqYKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB88C8371C1;
        Fri,  8 Dec 2023 03:28:29 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F31D48CD0;
        Fri,  8 Dec 2023 03:28:25 +0000 (UTC)
Date:   Fri, 8 Dec 2023 11:28:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/6] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXKNVRu3AfvjaFhK@fedora>
References: <20231207203900.859776-1-yury.norov@gmail.com>
 <20231207203900.859776-3-yury.norov@gmail.com>
 <ZXJx72/YOGn0l4pI@fedora>
 <ZXKEMJZRPrPDOKV/@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXKEMJZRPrPDOKV/@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:49:20PM -0800, Yury Norov wrote:
> On Fri, Dec 08, 2023 at 09:31:27AM +0800, Ming Lei wrote:
> > On Thu, Dec 07, 2023 at 12:38:56PM -0800, Yury Norov wrote:
> > > Because nmsk and irqmsk are stable, extra atomicity is not required.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  lib/group_cpus.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > > index ee272c4cefcc..8eb18c6bbf3b 100644
> > > --- a/lib/group_cpus.c
> > > +++ b/lib/group_cpus.c
> > > @@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > >  		if (cpu >= nr_cpu_ids)
> > >  			return;
> > >  
> > > -		cpumask_clear_cpu(cpu, nmsk);
> > > -		cpumask_set_cpu(cpu, irqmsk);
> > > +		__cpumask_clear_cpu(cpu, nmsk);
> > > +		__cpumask_set_cpu(cpu, irqmsk);
> > >  		cpus_per_grp--;
> > >  
> > >  		/* If the cpu has siblings, use them first */
> > > @@ -34,9 +34,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > >  			sibl = cpumask_next(sibl, siblmsk);
> > >  			if (sibl >= nr_cpu_ids)
> > >  				break;
> > > -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> > > -				continue;
> > > -			cpumask_set_cpu(sibl, irqmsk);
> > > +			__cpumask_clear_cpu(sibl, nmsk);
> > > +			__cpumask_set_cpu(sibl, irqmsk);
> > >  			cpus_per_grp--;
> > 
> > Here the change isn't simply to remove atomicity, and the test
> > part of cpumask_test_and_clear_cpu() is removed, so logic is changed,
> > I feel the correct change should be:
> > 
> > 	if (cpumask_test_cpu(sibl, nmsk)) {
> > 		__cpumask_clear_cpu(sibl, nmsk);
> > 		__cpumask_set_cpu(sibl, irqmsk);
> >   		cpus_per_grp--;
> > 	}
> 
> Ohh. My mistake is that I put this patch prior to the #3, so people
> bisecting the kernel may hit this problem... 
> 
> You're right here, but check the following patch: it switches the
> for() loop to for_each_cpu_and_from(sibl, siblmsk, nmsk), and it means
> that inside the loop sibl indexes set bits in both siblmsk and nmsk.
> 
> Now, because both masks are stable when the grp_spread_init_one() is
> called, there's no chance to get nmks.sibl cleared suddenly, and it
> means we can just drop the check.
> 
> Does this makes sense to you?
> 
> I can send v3 with a proper order of patches, if needed.

v3 is correct, and I'd suggest to either fix v2 or re-order v3,
otherwise both patch 2 and 3 are not easy to follow.


Thanks,
Ming

