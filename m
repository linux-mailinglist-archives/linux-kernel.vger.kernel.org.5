Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D068794189
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbjIFQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjIFQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:30:30 -0400
Received: from out-230.mta0.migadu.com (out-230.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2541BD5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:30:05 -0700 (PDT)
Date:   Wed, 6 Sep 2023 16:29:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694017802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEgnp9Jqgw+nMxjxuhnJ3/9gomqpg02qsQ9hOL23ty4=;
        b=ake6scgq2A1YXiCc77F2VTncDUTrhHSaH3KayngKZjFIey4i2QD/G62GEzbz6N5WlfSU7b
        +HMdMJSo9gje09hYnyt4C6aXEH8YaNjS+WlMHhLW3AS/0czZPtAs2Jynn4WYQQxmw8pgLh
        6Q+UuKNp8fIwd49LJgzLSq6lH8zJ4HI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        qperret@google.com, ricarkol@google.com, tabba@google.com,
        bgardon@google.com, zhenyzha@redhat.com, yihyu@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH] KVM: arm64: Fix soft-lockup on relaxing PTE permission
Message-ID: <ZPipBOzdM9lj/uO9@linux.dev>
References: <20230904072826.1468907-1-gshan@redhat.com>
 <ZPWPoEgBETeI1um1@linux.dev>
 <0f93a015-4f10-b53e-f67f-a84db43ca533@redhat.com>
 <ZPduJ08GKaKXwIhM@linux.dev>
 <bfdafdc5-4abf-a387-0857-e8cb84e4b3d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdafdc5-4abf-a387-0857-e8cb84e4b3d7@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gavin,

On Wed, Sep 06, 2023 at 08:26:24AM +1000, Gavin Shan wrote:

[...]

> It seems I didn't make it clear enough. The reason why I had the concern
> to avoid reading ctr_el0 is we read ctr_el0 for twice in the following path,
> but I doubt if anybody cares. Since it's a hot path, each bit of performance
> gain will count.
> 
>   invalidate_icache_guest_page
>   __invalidate_icache_guest_page   // first read on ctr_el0, with your code changes
>   icache_inval_pou(va, va + size)
>   invalidate_icache_by_line
>     icache_line_size               // second read on ctr_el0

That can be addressed by shoving the check deep into
invalidate_icache_by_line, which would benefit _all_ use cases of
I-cache invalidation by VA. I haven't completely made up my mind about
that, though, because of the consequences of a global invalidation.

> > > @size is guranteed to be PAGE_SIZE or PMD_SIZE aligned. Maybe
> > > we can just aggressively do something like below, disregarding the icache thrashing.
> > > In this way, the code is further simplified.
> > > 
> > >      if (size > PAGE_SIZE) {
> > >          icache_inval_all_pou();
> > >      } else {
> > >          icache_inval_pou((unsigned long)va,
> > >                           (unsigned long)va + size);
> > >      }                                                          // parantheses is still needed
> > 
> > This could work too but we already have a kernel heuristic for limiting
> > the amount of broadcast invalidations, which is MAX_TLBI_OPS. I don't
> > want to introduce a second, KVM-specific hack to address the exact same
> > thing.
> > 
> 
> Ok. I was confused at the first glance since TLB isn't relevant to icache.
> I think it's fine to reuse MAX_TLBI_OPS here, but a comment may be needed.
> Oliver, could you please send a formal patch for your changes?

Yeah, I think I may have said it before, but this thing needs to be
called 'MAX_DVM_OPS'. I-cache invalidations and TLB invalidations become
DVMOps (Distributed Virtual Memory) in terms of CHI, which pile up at the
miscellaneous node in the mesh.

Give me a day or two to convince myself of the right way to go about
this and I'll send out what I have.

-- 
Thanks,
Oliver
