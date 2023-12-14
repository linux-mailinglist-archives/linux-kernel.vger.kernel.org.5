Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3C812407
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442891AbjLNAoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjLNAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73657D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702514649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00XBiI2/GjwYgdmGmgmI9vsz6zy2kiJraPjLIsuaPhU=;
        b=eVGvXY1aLheqhml2TxwToPoCfIHQB99PnoQMsjs69DxRYqV7vreMfjr+MQc7sqzJdxejyT
        AkOaKj+Di4c9jiqa8IwSpelI686iYbXGqx1YoqVSNGvthNXJeSBhaOx5FvCLkTYIuZxKgU
        6SIVWf8mQwkyljvOQxi4U6MEtmq5884=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-A8uzrfsRNs2QYDp84ekxSQ-1; Wed,
 13 Dec 2023 19:44:06 -0500
X-MC-Unique: A8uzrfsRNs2QYDp84ekxSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DA2E1C0BA59;
        Thu, 14 Dec 2023 00:44:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEAD02026D66;
        Thu, 14 Dec 2023 00:44:02 +0000 (UTC)
Date:   Thu, 14 Dec 2023 08:43:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/7] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXpPzoX1pcQZMyBw@fedora>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-4-yury.norov@gmail.com>
 <ZXgszD9tIKY1tC9r@fedora>
 <ZXiPvgzZvXyWfarS@yury-ThinkPad>
 <ZXj3deNs91Ga471c@fedora>
 <ZXnj1WhpSgdMXSfS@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnj1WhpSgdMXSfS@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On Wed, Dec 13, 2023 at 09:03:17AM -0800, Yury Norov wrote:
> On Wed, Dec 13, 2023 at 08:14:45AM +0800, Ming Lei wrote:
> > On Tue, Dec 12, 2023 at 08:52:14AM -0800, Yury Norov wrote:
> > > On Tue, Dec 12, 2023 at 05:50:04PM +0800, Ming Lei wrote:
> > > > On Mon, Dec 11, 2023 at 08:21:03PM -0800, Yury Norov wrote:
> > > > > Because nmsk and irqmsk are stable, extra atomicity is not required.
> > > > > 
> > > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > > ---
> > > > >  lib/group_cpus.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > > > > index 10dead3ab0e0..7ac94664230f 100644
> > > > > --- a/lib/group_cpus.c
> > > > > +++ b/lib/group_cpus.c
> > > > > @@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > > > >  		if (cpu >= nr_cpu_ids)
> > > > >  			return;
> > > > >  
> > > > > -		cpumask_clear_cpu(cpu, nmsk);
> > > > > -		cpumask_set_cpu(cpu, irqmsk);
> > > > > +		__cpumask_clear_cpu(cpu, nmsk);
> > > > > +		__cpumask_set_cpu(cpu, irqmsk);
> > > > >  		cpus_per_grp--;
> > > > >  
> > > > >  		/* If the cpu has siblings, use them first */
> > > > > @@ -33,8 +33,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > > > >  		sibl = cpu + 1;
> > > > >  
> > > > >  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > > > > -			cpumask_clear_cpu(sibl, nmsk);
> > > > > -			cpumask_set_cpu(sibl, irqmsk);
> > > > > +			__cpumask_clear_cpu(sibl, nmsk);
> > > > > +			__cpumask_set_cpu(sibl, irqmsk);
> > > > 
> > > > I think this kind of change should be avoided, here the code is
> > > > absolutely in slow path, and we care code cleanness and readability
> > > > much more than the saved cycle from non atomicity.
> > > 
> > > Atomic ops have special meaning and special function. This 'atomic' way
> > > of moving a bit from one bitmap to another looks completely non-trivial
> > > and puzzling to me.
> > > 
> > > A sequence of atomic ops is not atomic itself. Normally it's a sing of
> > > a bug. But in this case, both masks are stable, and we don't need
> > > atomicity at all.
> > 
> > Here we don't care the atomicity.
> > 
> > > 
> > > It's not about performance, it's about readability.
> > 
> > __cpumask_clear_cpu() and __cpumask_set_cpu() are more like private
> > helper, and more hard to follow.
> 
> No that's not true. Non-atomic version of the function is not a
> private helper of course.
>  
> > [@linux]$ git grep -n -w -E "cpumask_clear_cpu|cpumask_set_cpu" ./ | wc
> >     674    2055   53954
> > [@linux]$ git grep -n -w -E "__cpumask_clear_cpu|__cpumask_set_cpu" ./ | wc
> >      21      74    1580
> > 
> > I don't object to comment the current usage, but NAK for this change.
> 
> No problem, I'll add you NAK.

You can add the following words meantime:

__cpumask_clear_cpu() and __cpumask_set_cpu() are added in commit 6c8557bdb28d
("smp, cpumask: Use non-atomic cpumask_{set,clear}_cpu()") for fast code path(
smp_call_function_many()).

We have ~670 users of cpumask_clear_cpu & cpumask_set_cpu, lots of them
fall into same category with group_cpus.c(doesn't care atomicity, not in fast
code path), and needn't change to __cpumask_clear_cpu() and __cpumask_set_cpu().
Otherwise, this way may encourage to update others into the __cpumask_* version.


Thanks, 
Ming

