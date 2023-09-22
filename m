Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832B7AB2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjIVNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjIVNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:42 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D272B192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:31:33 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 280A917C98B;
        Fri, 22 Sep 2023 15:31:31 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695389491; bh=d4bZp4FCpu0ifwd91koBvu3QjGysMx8UU3tJ5jeZ3SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aa71HdOGTwJroT3Yclfk1uEv9izIB7VUF7FvILVh8HZaQy536PORMm2eT+C5q+Txx
         dr90hVFbgnggQx80aHwSHlcENCEAlZc516VanEmLef5s5Vyydx8Gxe4ebHoRahvbBq
         1V7APBB5Lp87wqP861Vvevl3Xq00m/lusntHl+43mu/bFFUV2rSwt7fhmVhCyJtZGY
         OiFY6JucSSGo7GR4i5jyjv0+LL/62JY4AovnWzMPb2z6uJdujoAEMCmyVtngUvIfoy
         7lSCc+dZTfK7ZO4Wc6P3QjUnn08ZVyqhPZoWnzYqSwcuxNi1CDvdxGpJyPODpK+cb0
         ElUQLxNPToIPg==
Date:   Fri, 22 Sep 2023 15:31:29 +0200
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
Message-ID: <20230922153129.69b26975@meshulam.tesarici.cz>
In-Reply-To: <ZQhwnhOQbDp3j8y7@arm.com>
References: <20230913114016.17752-1-petr@tesarici.cz>
        <20230913121403.GB4544@lst.de>
        <20230913142656.29e135d6@meshulam.tesarici.cz>
        <ZQNQscYr0rQWdw66@arm.com>
        <20230915111343.01496320@meshulam.tesarici.cz>
        <ZQSPyBRjnSISNFmD@arm.com>
        <20230917114741.01a23364@meshulam.tesarici.cz>
        <ZQhwnhOQbDp3j8y7@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

thanks again for your reply. I'm sorry for being slow. This world of
weakly ordered memory models is complex, and I was too distracted most
of this week, but I hope I have finally wrapped my head around it.

On Mon, 18 Sep 2023 16:45:34 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Sun, Sep 17, 2023 at 11:47:41AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 15 Sep 2023 18:09:28 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote: =20
> > > On Fri, Sep 15, 2023 at 11:13:43AM +0200, Petr Tesa=C5=99=C3=ADk wrot=
e: =20
> > > > On Thu, 14 Sep 2023 19:28:01 +0100
> > > > Catalin Marinas <catalin.marinas@arm.com> wrote:   =20
> > > > > What do the smp_wmb() barriers in swiotlb_find_slots() and
> > > > > swiotlb_dyn_alloc() order? The latter is even more unclear as it'=
s at
> > > > > the end of the function and the "pairing" comment doesn't help.  =
 =20
> > > >=20
> > > > By the time swiotlb_find_slots() returns a valid slot index, the new
> > > > value of dev->dma_uses_io_tlb must be visible by all CPUs in
> > > > is_swiotlb_buffer(). The index is used to calculate the bounce buff=
er
> > > > address returned to device drivers. This address may be passed to
> > > > another CPU and used as an argument to is_swiotlb_buffer().   =20
> > >=20
> > > Ah, I remember now. So the smp_wmb() ensures that dma_uses_io_tlb is
> > > seen by other CPUs before the slot address (presumably passed via oth=
er
> > > memory write). It may be worth updating the comment in the code (I'm
> > > sure I'll forget it in a month time). The smp_rmb() before READ_ONCE()
> > > in this patch is also needed for the same reasons (ordering after the
> > > read of the address passed to is_swiotlb_buffer()). =20
>[...]
> > > BTW, you may want to use WRITE_ONCE() when setting dma_uses_io_tlb (it
> > > also matches the READ_ONCE() in is_swiotlb_buffer()). Or you can use
> > > smp_store_mb() (but check its semantics first). =20
> >=20
> > I can use WRITE_ONCE(), although I believe it does not make much
> > difference thanks to the barrier provided by smp_wmb(). =20
>=20
> WRITE_ONCE() is about atomicity rather than ordering (and avoiding
> compiler optimisations messing things). While I don't see the compiler
> generating multiple accesses for a boolean write, using these accessors
> also helps tools like kcsan.

While I still believe a simple assignment works just fine here, I agree
that WRITE_ONCE() is better. It can prevent potential bugs if someone
ever turns the boolean into something else.

>[...]
> > Ah... You may have a point after all if this sequence of events is
> > possible:
> >=20
> > - CPU 0 writes new value to mem->pools->next in swiotlb_dyn_alloc().
> >=20
> > - CPU 1 observes the new value in swiotlb_find_slots(), even though it
> >   is not guaranteed by any barrier, allocates a slot and sets the
> >   dev->dma_uses_io_tlb flag.
> >=20
> > - CPU 1 (driver code) writes the returned buffer address into its
> >   private struct. This write is ordered after dev->dma_uses_io_tlb
> >   thanks to the smp_wmb() in swiotlb_find_slots().
> >=20
> > - CPU 2 (driver code) reads the buffer address, and DMA core passes it
> >   to is_swiotlb_buffer(), which contains smp_rmb().
> >=20
> > - IIUC CPU 2 is guaranteed to observe the new value of
> >   dev->dma_uses_io_tlb, but it may still use the old value of
> >   mem->pools->next, because the write on CPU 0 was not ordered
> >   against anything. The fact that the new value was observed by CPU 1
> >   does not mean that it is also observed by CPU 2. =20
>=20
> Yes, that's possible. On CPU 1 there is a control dependency between the
> read of mem->pools->next and the write of dev->dma_uses_io_tlb but I
> don't think this is sufficient to claim multi-copy atomicity (if CPU 1
> sees mem->pools->next write by CPU 0, CPU 2 must see it as well), at
> least not on all architectures supported by Linux. memory-barriers.txt
> says that a full barrier on CPU 1 is needed between the read and write,
> i.e. smp_mb() before WRITE_ONCE(dev->dma_uses_io_tlb). You could add it
> just before "goto found" in swiotlb_find_slots() since it's only needed
> on this path.

Let me check my understanding. This smp_mb() is not needed to make sure
that the write to dev->dma_uses_io_tlb cannot be visible before the
read of mem->pools->next. Since stores are not speculated, that
ordering is provided by the control dependency alone.

But a general barrier ensures that a third CPU will observe the write to
mem->pools->next after the read of mem->pools->next. Makes sense.

I think I can send a v2 of my patch now, with abundant comments on the
memory barriers.

> Another thing I noticed - the write in add_mem_pool() to mem->nslabs is
> not ordered with list_add_rcu(). I assume swiotlb_find_slots() doesn't
> need to access it since it just walks the mem->pools list.

That's correct. Writes to mem->nslabs are known to be racy, but it
doesn't matter. This is explained in commit 1aaa736815eb ("swiotlb:
allocate a new memory pool when existing pools are full"):

- swiotlb_tbl_map_single() and is_swiotlb_active() only check for non-zero
  value. This is ensured by the existence of the default memory pool,
  allocated at boot.
   =20
- The exact value is used only for non-critical purposes (debugfs, kernel
  messages).

Petr T
