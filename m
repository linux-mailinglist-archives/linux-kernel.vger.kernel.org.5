Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E980FBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377703AbjLMAHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377801AbjLMAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C25BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702426020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJ4KbsvY2/ywK+sqBP6N+RhYq5r1N/+Z719Qf3le3yQ=;
        b=VvNyeZ3wwcxGnSL54XP4kZ/sU5SEDbfBlZrFVmhrUClKMdM08GS+qOFyOXjYqGLZJNeb5F
        IiFdGdm53IWfnFlSEKNK/rOwpExJZ5RjJHUmQvfsW2yg2rrrAuUxNwuSFWJBTBdM43NrDA
        DApf13WBH9tKopU9aIHn05dRrKU17L8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-AP-7cYdjOrKENm1rXQUcrQ-1; Tue,
 12 Dec 2023 19:06:58 -0500
X-MC-Unique: AP-7cYdjOrKENm1rXQUcrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 198371C05EA4;
        Wed, 13 Dec 2023 00:06:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AACE5492BE6;
        Wed, 13 Dec 2023 00:06:53 +0000 (UTC)
Date:   Wed, 13 Dec 2023 08:06:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        ming.lei@redhat.com
Subject: Re: [PATCH v3 2/7] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZXj1mGAKz5cWy+Nr@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-3-yury.norov@gmail.com>
 <ZXgsDcM21H/2BTck@fedora>
 <ZXiSk9J2ZBdsTnk0@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXiSk9J2ZBdsTnk0@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:04:19AM -0800, Yury Norov wrote:
> On Tue, Dec 12, 2023 at 05:46:53PM +0800, Ming Lei wrote:
> > On Mon, Dec 11, 2023 at 08:21:02PM -0800, Yury Norov wrote:
> > > The loop starts from the beginning every time we switch to the next
> > > sibling mask. This is the Schlemiel the Painter's style of coding
> > > because we know for sure that nmsk is clear up to current CPU, and we
> > > can just continue from the next CPU.
> > > 
> > > Also, we can do it nicer if leverage the dedicated for_each() iterator,
> > > and simplify the logic of clearing a bit in nmsk.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  lib/group_cpus.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > > index ee272c4cefcc..10dead3ab0e0 100644
> > > --- a/lib/group_cpus.c
> > > +++ b/lib/group_cpus.c
> > > @@ -30,14 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > >  
> > >  		/* If the cpu has siblings, use them first */
> > >  		siblmsk = topology_sibling_cpumask(cpu);
> > > -		for (sibl = -1; cpus_per_grp > 0; ) {
> > > -			sibl = cpumask_next(sibl, siblmsk);
> > > -			if (sibl >= nr_cpu_ids)
> > > -				break;
> > > -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> > > -				continue;
> > > +		sibl = cpu + 1;
> > 
> > It doesn't have to 'cpu + 1', see below comment.
> > 
> > > +
> > > +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > > +			cpumask_clear_cpu(sibl, nmsk);
> > >  			cpumask_set_cpu(sibl, irqmsk);
> > > -			cpus_per_grp--;
> > > +			if (cpus_per_grp-- == 0)
> > 
> > 			if (--cpus_per_grp == 0)
>  
> That's right, I'll send a new version this weekend.
> 
> > > +				return;
> > 
> > I think for_each_cpu_and() should work just fine, cause cpu has been cleared
> > from nmsk, so the change can be something like, then patch 1 isn't
> > necessary.
>  
> It works just fine except that it's O(N^2), where O(N) is easily
> achievable. Again, it's not about performance, it's about coding
> habits.

Both for_each_cpu_and() and for_each_cpu_and_from() are O(N), aren't
they? Given both two are based on find_next_and_bit().

for_each_cpu_and() is simpler and more readable, and more
importantly, we can save one single-user public helper.

>  
> > 		for_each_cpu_and(sibl, siblmsk, nmsk) {
> > 			cpumask_clear_cpu(sibl, nmsk);
> >   			cpumask_set_cpu(sibl, irqmsk);
> > 			if (--cpus_per_grp == 0)
> > 				return;
> > 		}


Thanks,
Ming

