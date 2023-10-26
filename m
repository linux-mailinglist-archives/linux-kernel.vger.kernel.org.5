Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C17D79F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjJZBHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjJZBHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:07:38 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1DA4;
        Wed, 25 Oct 2023 18:07:33 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SG6yv1NmRz9xn1w;
        Thu, 26 Oct 2023 09:04:55 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 26 Oct
 2023 09:07:24 +0800
Date:   Thu, 26 Oct 2023 09:07:24 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZTm7zMh6nWU4aJtR@fedora>
References: <ZRU/EjubEH/5QLlG@fedora>
 <pn2lkox4qj7ylx44jnqjf4kfpenaexbnw33xsebekeg4yz6yw4@y464o5qyj4f2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <pn2lkox4qj7ylx44jnqjf4kfpenaexbnw33xsebekeg4yz6yw4@y464o5qyj4f2>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 02:07:18PM -0400, Daniel Jordan wrote:
> Hello,
> 
> On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> > This is a refactored version with the following main changes:
> 
> The RFC overall is a nice simplification, and the basic approach of using an
> ordered workqueue seems to work.
> 
> > - The parallel workqueue no longer uses the WQ_UNBOUND attribute
> 
> What's the justification here?  If it improves performance, please show
> numbers.  Earlier tests[0] showed a large improvement when adding this
> flag.
> 
> [0] https://lore.kernel.org/linux-crypto/20190906014029.3345-1-daniel.m.jordan@oracle.com/
> 
When I wrote the email on September 28th, I only used the "pcrypt_aead01"
test case from LTP. Thank you for you and Steffen's responses. I now have
more test cases, but I haven't tested them yet.
> > - Removal of CPU-related logic, sysfs-related interfaces
> 
> I agree with Steffen that we should continue to honor the cpumasks that the
> user sets.
> 
> The simplest way I see to make the parallel mask work with your refactor is to
> just make the parallel workqueue unbound again, since setting workqueue
> attributes is only allowed for unbound, and bring back some of the plumbing
> that leads to the apply_workqueue_attrs call.
You've convinced me, and I agree with your stance on keeping the cpumask.
So, using WQ_UNBOUND is the right choice, and this will be reflected in
my upcoming patches.

> 
> The serial mask is trickier.  Changing attributes of an ordered workqueue (the
> cpumask in this case) makes the kernel throw a warning...
> 
> static int apply_workqueue_attrs_locked
>         ...
>         /* creating multiple pwqs breaks ordering guarantee */                   
>         if (!list_empty(&wq->pwqs)) {                                            
>                 if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))                  
>                         return -EINVAL;                                          
>                                                                                  
>                 wq->flags &= ~__WQ_ORDERED;                                      
>         }
> 
> ...but I'm not sure this is a fundamental limitation.  The changelog of
> 0a94efb5acbb ("workqueue: implicit ordered attribute should be overridable")
> says changes to "max_active and some attribute changes" are rejected, but it
> might be possible to relax the warning to allow setting a cpumask while still
> rejecting other changes.
Workqueue provides the alloc_ordered_workqueue method, which may be more suitable
for serial workers.

> 
> > Testing was conducted using ltp's pcrypt_aead01, and the execution time
> > comparison between the old and new versions is as follows:
> > 
> > Old Version:
> > real 0m27.451s
> > user 0m0.031s
> > sys 0m0.260s
> > 
> > New Version:
> > real 0m21.351s
> > user 0m0.023s
> > sys 0m0.260s
> 
> Great speedup.  A test that runs many requests for a long time in parallel is
> also good to run, such as [0].
> 
I will conduct the test as previously mentioned.
> > @@ -986,57 +281,27 @@ struct padata_instance *padata_alloc(const char *name)
> ...
> > +	pinst->serial_wq = alloc_ordered_workqueue ("%s_serial",
> > +									WQ_MEM_RECLAIM | WQ_FREEZABLE,
> > +									name);
> 
> Why add these two WQ_ flags?  Also, whitespace is kinda funky.
You're right, I need to adjust this part of the code.
