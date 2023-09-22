Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F47AB6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIVRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjIVRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:12:24 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A71A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:12:17 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 6232317CF10;
        Fri, 22 Sep 2023 19:12:14 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695402734; bh=08+W2X8NTqxCFp9Ygk497hS62sPAWUQWBs0yuvNxEns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OWuOt2vS6ut4F0JrTH5oVnFOTgE7xoj0Gedf+cIr35jJSBk2a49V7eJyKnqqVE/6s
         Pe5vhsiAHUd5O5YJ2HBFRThcgOzfVOJGAczd4wyQ5XoHmBEYoSwswxqX/6nEJBTl4E
         KEbDmbyVk39LSUQe50+jKfsLEPUS79yT4Xv0/ReXOkhF6udVzMLAgni27EixCL4E3t
         iKHJruYFvsY9f+u5Ie9WGi9+FpzOhx1s2WZLwa7/iWR6JbDwH+B5484cyIyyyWPnWk
         dA7+HorOsDgRyE1pKcdl7PCbi/mZS7d1i3kC87Q67qDbVT96QSSzaIQYzfUYYEULKw
         0rm3kQSw+MHuw==
Date:   Fri, 22 Sep 2023 19:12:13 +0200
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
Message-ID: <20230922191213.379d440a@meshulam.tesarici.cz>
In-Reply-To: <20230922153129.69b26975@meshulam.tesarici.cz>
References: <20230913114016.17752-1-petr@tesarici.cz>
        <20230913121403.GB4544@lst.de>
        <20230913142656.29e135d6@meshulam.tesarici.cz>
        <ZQNQscYr0rQWdw66@arm.com>
        <20230915111343.01496320@meshulam.tesarici.cz>
        <ZQSPyBRjnSISNFmD@arm.com>
        <20230917114741.01a23364@meshulam.tesarici.cz>
        <ZQhwnhOQbDp3j8y7@arm.com>
        <20230922153129.69b26975@meshulam.tesarici.cz>
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

On Fri, 22 Sep 2023 15:31:29 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

>[...]=20
> On Mon, 18 Sep 2023 16:45:34 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
>=20
> > On Sun, Sep 17, 2023 at 11:47:41AM +0200, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
>[...]
> > > Ah... You may have a point after all if this sequence of events is
> > > possible:
> > >=20
> > > - CPU 0 writes new value to mem->pools->next in swiotlb_dyn_alloc().
> > >=20
> > > - CPU 1 observes the new value in swiotlb_find_slots(), even though it
> > >   is not guaranteed by any barrier, allocates a slot and sets the
> > >   dev->dma_uses_io_tlb flag.
> > >=20
> > > - CPU 1 (driver code) writes the returned buffer address into its
> > >   private struct. This write is ordered after dev->dma_uses_io_tlb
> > >   thanks to the smp_wmb() in swiotlb_find_slots().
> > >=20
> > > - CPU 2 (driver code) reads the buffer address, and DMA core passes it
> > >   to is_swiotlb_buffer(), which contains smp_rmb().
> > >=20
> > > - IIUC CPU 2 is guaranteed to observe the new value of
> > >   dev->dma_uses_io_tlb, but it may still use the old value of
> > >   mem->pools->next, because the write on CPU 0 was not ordered
> > >   against anything. The fact that the new value was observed by CPU 1
> > >   does not mean that it is also observed by CPU 2.   =20
> >=20
> > Yes, that's possible. On CPU 1 there is a control dependency between the
> > read of mem->pools->next and the write of dev->dma_uses_io_tlb but I
> > don't think this is sufficient to claim multi-copy atomicity (if CPU 1
> > sees mem->pools->next write by CPU 0, CPU 2 must see it as well), at
> > least not on all architectures supported by Linux. memory-barriers.txt
> > says that a full barrier on CPU 1 is needed between the read and write,
> > i.e. smp_mb() before WRITE_ONCE(dev->dma_uses_io_tlb). You could add it
> > just before "goto found" in swiotlb_find_slots() since it's only needed
> > on this path. =20
>=20
> Let me check my understanding. This smp_mb() is not needed to make sure
> that the write to dev->dma_uses_io_tlb cannot be visible before the
> read of mem->pools->next. Since stores are not speculated, that
> ordering is provided by the control dependency alone.
>=20
> But a general barrier ensures that a third CPU will observe the write to
> mem->pools->next after the read of mem->pools->next. Makes sense.

Now that I'm writing the patch, I get your idea to replace WRITE_ONCE()
with smp_store_release(). Since a full memory barrier is required for
multicopy atomicity, it is not "more than I need". Instead, the
ordering contraints may be possibly restricted to "CPUs participating
in a release-acquire chain" if I also replace READ_ONCE() in
is_swiotlb_buffer() with smp_read_acquire().

I believe it does not matter that the CPU which writes a new value to
mem->pools->next in swiotlb_dyn_alloc() does not participate in the
chain, because the value must have been visible to the CPU which
executes swiotlb_find_slots() and which does participate in the chain.

Let me double-check this thinking with a litmus test.

> I think I can send a v2 of my patch now, with abundant comments on the
> memory barriers.

Eh, this must be delayed a bit again...

Petr T
