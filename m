Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D237A1A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjIOJN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjIOJNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:13:55 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA53170E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:13:47 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id DE6D517036E;
        Fri, 15 Sep 2023 11:13:44 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1694769225; bh=vowXLlBQDzac/DIAn54Or1EccUliC1HVC5mOJKoHhQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PKAWnQsN86kfZRfFObq1J1XpigYdswzCZLh0eZBJFfaoMUu5HPw9J9BjAFN3eNBvs
         uayrB8nViKO9BYNN8lzthb7eyuBAki+UuxSfphPHZafPTcgk1yEWthCIJ+p1IrZ/Jx
         MtOHcsyRGk4wuulNzWBwLiGWphrmSdUcMOp+YH20uFGEss9iv3jYOh0CoeJ0NOOckk
         fWBe0AvdRk7gLruISTNDJBHkoff12UY/5O0tAfpQZs4GoiIG+/+2fHw/7zUGbUXoqM
         C7mzS75wfWaCQJi8jroZ0z7yuIqQ+AsU+URUoAbfJ/Jb/Cqw6oEa1vUWFt7utMF0xc
         mwglschF//63w==
Date:   Fri, 15 Sep 2023 11:13:43 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <20230915111343.01496320@meshulam.tesarici.cz>
In-Reply-To: <ZQNQscYr0rQWdw66@arm.com>
References: <20230913114016.17752-1-petr@tesarici.cz>
        <20230913121403.GB4544@lst.de>
        <20230913142656.29e135d6@meshulam.tesarici.cz>
        <ZQNQscYr0rQWdw66@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 19:28:01 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Sep 13, 2023 at 02:26:56PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 13 Sep 2023 14:14:03 +0200
> > Christoph Hellwig <hch@lst.de> wrote: =20
> > > Thanks, I've applied this to get it into linux-next ASAP.  I'd love
> > > to have reviews before sending it on to Linus, though. =20
> >=20
> > Fully understood, given my past record. ;-)
> >=20
> > @Catalin Marinas: I have added you to the list of recipient, because you
> > spotted some issues with memory barriers in one of my previous attempts=
. =20
>=20
> I seem to have forgotten everything about that thread (trying to
> remember what I meant in
> https://lore.kernel.org/all/ZGJdtmP13pv06xDH@arm.com/ ;)).

Oh... Then I'm very much indebted to you for looking at this patch
nevertheless.

What happened is this: I originally wrote code which maintained a
per-device list of actively used swiotlb pools. The idea was rejected
in an internal review at Huawei, so I reverted to a simple flag to
reduce at least the impact on devices that do not use swiotlb. There
might be some left-overs...

> What do the smp_wmb() barriers in swiotlb_find_slots() and
> swiotlb_dyn_alloc() order? The latter is even more unclear as it's at
> the end of the function and the "pairing" comment doesn't help.

By the time swiotlb_find_slots() returns a valid slot index, the new
value of dev->dma_uses_io_tlb must be visible by all CPUs in
is_swiotlb_buffer(). The index is used to calculate the bounce buffer
address returned to device drivers. This address may be passed to
another CPU and used as an argument to is_swiotlb_buffer().

I am not sure that the smp_wmb() in swiotlb_dyn_alloc() is needed, but
let me explain my thinking. Even if the dev->dma_uses_io_tlb flag is
set, is_swiotlb_buffer() returns false unless the buffer address is
found in the RCU list of swiotlb pools, which is walked without taking
any lock. In some iterations of the patch series, there was a direct
call to swiotlb_dyn_alloc(), and a smp_wmb() was necessary to make sure
that the list of swiotlb pools cannot be observed as empty by another
CPU. You have already explained to me that taking a spin lock in
add_mem_pool() is not sufficient, because it does not invalidate a
value that might have been speculatively read by another CPU before
entering the critical section. OTOH swiotlb_dyn_alloc() is always
called through schedule_work() in the current version. If that
implicitly provides necessary barriers, this smp_wmb() can be removed.

FTR list_add_rcu() alone is not sufficient. It adds the new element
using rcu_assign_pointer(), which modifies the forward link with
smp_store_release(). However, list_for_each_entry_rcu() reads the head
with list_entry_rcu(), which is a simple READ_ONCE(); there is no
ACQUIRE semantics.

Actually, I wonder when a newly added RCU list element is guaranteed to
be visible by all CPUs. Existing documentation deals mainly with
element removal, explaining that both the old state and the new state
of an RCU list are valid after addition. Is it assumed that the old
state of an RCU list after addition is valid indefinitely?

> I found the "pairing" description in memory-barriers.txt not helping
> much and lots of code comments end up stating that some barrier is
> paired with another as if it is some magic synchronisation event. In
> general a wmb() barrier ends up paired with an rmb() one (or some other
> form of dependency, acquire semantics etc.) but they should be described
> in isolation first - what memory accesses on a CPU before and after the
> *mb() need ordering - and then how this pairing solves the accesses
> observability across multiple CPUs. The comments should also describe
> things like "ensure payload is visible before flag update" rather than
> "the wmb here pairs with the rmb over there".

Good point. I will improve my memory barrier comments accordingly.

> Presumably in swiotlb_find_slots(), the smp_wmb() needs to ensure the
> write to dev->dma_uses_io_tlb is visible before the *retpool write? For
> swiotlb_dyn_alloc(), I'm completely lost on what the smp_wmb() orders.
> You really need at least two memory accesses on a CPU for the barrier to
> make sense.

Thank you again for your time!

Petr T

