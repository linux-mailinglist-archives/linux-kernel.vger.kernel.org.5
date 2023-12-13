Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E781065C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjLMAQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378052AbjLMAPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62002D51
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702426497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrOsn2y3KPHnbMuEkFCu/8T/VhjzG1Tr6VnplESBRyU=;
        b=HxUVQT9b+yD/DKOlc27mWZbFflKhBi2LHrky1W6t0YYsh8NrPSKOJZquaCTPI3Co1b1wdw
        Ct+6EwseRWN6lAxSV25DPtLt/RSoBB1HtTNXW9orx0HD256raVQ7zalRkID72G16W64/jI
        IjBgIFqmrteypylIBPMAa23zVX+UO+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-20Upbt2qPKekpDbquNwUuw-1; Tue, 12 Dec 2023 19:14:54 -0500
X-MC-Unique: 20Upbt2qPKekpDbquNwUuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D965B83DDE5;
        Wed, 13 Dec 2023 00:14:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 861082166B32;
        Wed, 13 Dec 2023 00:14:49 +0000 (UTC)
Date:   Wed, 13 Dec 2023 08:14:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/7] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXj3deNs91Ga471c@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-4-yury.norov@gmail.com>
 <ZXgszD9tIKY1tC9r@fedora>
 <ZXiPvgzZvXyWfarS@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXiPvgzZvXyWfarS@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

On Tue, Dec 12, 2023 at 08:52:14AM -0800, Yury Norov wrote:
> On Tue, Dec 12, 2023 at 05:50:04PM +0800, Ming Lei wrote:
> > On Mon, Dec 11, 2023 at 08:21:03PM -0800, Yury Norov wrote:
> > > Because nmsk and irqmsk are stable, extra atomicity is not required.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  lib/group_cpus.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > > index 10dead3ab0e0..7ac94664230f 100644
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
> > > @@ -33,8 +33,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > >  		sibl = cpu + 1;
> > >  
> > >  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > > -			cpumask_clear_cpu(sibl, nmsk);
> > > -			cpumask_set_cpu(sibl, irqmsk);
> > > +			__cpumask_clear_cpu(sibl, nmsk);
> > > +			__cpumask_set_cpu(sibl, irqmsk);
> > 
> > I think this kind of change should be avoided, here the code is
> > absolutely in slow path, and we care code cleanness and readability
> > much more than the saved cycle from non atomicity.
> 
> Atomic ops have special meaning and special function. This 'atomic' way
> of moving a bit from one bitmap to another looks completely non-trivial
> and puzzling to me.
> 
> A sequence of atomic ops is not atomic itself. Normally it's a sing of
> a bug. But in this case, both masks are stable, and we don't need
> atomicity at all.

Here we don't care the atomicity.

> 
> It's not about performance, it's about readability.

__cpumask_clear_cpu() and __cpumask_set_cpu() are more like private
helper, and more hard to follow.

[@linux]$ git grep -n -w -E "cpumask_clear_cpu|cpumask_set_cpu" ./ | wc
    674    2055   53954
[@linux]$ git grep -n -w -E "__cpumask_clear_cpu|__cpumask_set_cpu" ./ | wc
     21      74    1580

I don't object to comment the current usage, but NAK for this change.


Thanks,
Ming

