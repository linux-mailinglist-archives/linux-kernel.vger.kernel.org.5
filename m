Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A87BFB65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjJJM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjJJM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA3E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696940770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woj9XhL8JgSgE6+vruavLKNx3l7zR2+zaW86usKMxog=;
        b=YjTJClzLKd8fTrdZ80oWPM1ASitQCczrN8Fq+aA29zAmynnwLa74rhQAsks+Y4O38tlp0l
        7c7DPMOiGGP23bW1VuoZS71rcbfXhRpxXoia/o7Q7l83nCQDoOTOZIGAwZLKqBeEZz9lHk
        tpfDAflexK1hSW10AYzX41w8QN3aVS0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-I4Uj0AoKNgWcPY_mO7i75w-1; Tue, 10 Oct 2023 08:26:04 -0400
X-MC-Unique: I4Uj0AoKNgWcPY_mO7i75w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B0A41C09A42;
        Tue, 10 Oct 2023 12:26:04 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A78F9CC;
        Tue, 10 Oct 2023 12:26:03 +0000 (UTC)
Date:   Tue, 10 Oct 2023 08:26:00 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] sched/fair: Use printk_deferred instead of printk in
 pick_eevdf()
Message-ID: <20231010122600.GA477540@lorien.usersys.redhat.com>
References: <20231010032541.339606-1-yu.c.chen@intel.com>
 <20231010075928.GA377@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010075928.GA377@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:59:28AM +0200 Peter Zijlstra wrote:
> On Tue, Oct 10, 2023 at 11:25:41AM +0800, Chen Yu wrote:
> > When no eligible entity is found in pick_eevdf(), it has to pick
> > the entity with smallest vruntime. This indicates a potential issue
> > and scheduler will print this error.
> > 
> > However this printk could introduce possible circular locking issue
> > because when the code path reaches here with the rq lock held, the
> > printk could trigger further scheduling which loops back to the
> > scheduler.
> > 
> > Use printk_deferred() to defer the console write from current context
> > to the irq work in the next tick.

Chen: I was not actually suggesting you make this change, just answering your
question about printk/rq lock.  You don't need to put that line in there.

> 
> No.. I detest printk_deferred with a passion. This is effectively a WARN
> and we don't do silly buggers for them either.
>

Sure, printk_deferred is not ideal, but is getting this message in the right
order worth locking up people's machines?  Not sure you get the message at
all when that happens.  I have to dig the code location out of the crash
dump to find which sched warning fired and took down the (usually virtual)
machine.


Cheers,
Phil

-- 

