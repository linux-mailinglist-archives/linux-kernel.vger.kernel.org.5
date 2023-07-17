Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB016756038
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGQKRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:17:28 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25791B1;
        Mon, 17 Jul 2023 03:17:27 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 1B5DF163314;
        Mon, 17 Jul 2023 12:17:22 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689589042; bh=Bm0Hy13+JRi9NMlimeswrt8XBhWxLQOI9N21AQMkbyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQN14zd3XNWnsUCpxj8CAfDRLfHO3yKbIYH4Z1tY2NuUyB/tEAWXePMgXHClGElXV
         iclkVMk4nMw7f2dCGMBhAdc3436jIvQ3z8yKAco9Yv+innFM08daK23nD+0JAcJW+d
         SeEwDCP0ntZA0tOgBwjdzE+yAGotID6XvGHHT1DZyU/IAvL5pRZTbpVCELUjsw0pmk
         Fjduj/nTRd+WS55sOgt6m/O0blal5FJ8IM4Ma27TYBebyldrBxV45Rul1vue8rpAcD
         H03pbEhB1HqGfsRaZngbNzSDrUmBPA32acEzxYcaaIy38C9WCKNmg+OPDUsAVC/MnK
         KgQwEGVvlDo6Q==
Date:   Mon, 17 Jul 2023 12:17:20 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/8] swiotlb: make io_tlb_default_mem local to
 swiotlb.c
Message-ID: <20230717121720.093cb1cc@meshulam.tesarici.cz>
In-Reply-To: <45f89fee-6825-3f5d-9dfb-aad5d47c8c36@linaro.org>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
        <7f64111986f4f361a2deb4a1a1b6f588e63a851b.1689261692.git.petr.tesarik.ext@huawei.com>
        <45f89fee-6825-3f5d-9dfb-aad5d47c8c36@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 08:06:07 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Petr,
>=20
> On 13/7/23 17:23, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >=20
> > SWIOTLB implementation details should not be exposed to the rest of the
> > kernel. This will allow to make changes to the implementation without
> > modifying non-swiotlb code.
> >=20
> > To avoid breaking existing users, provide helper functions for the few
> > required fields.
> >=20
> > As a bonus, using a helper function to initialize struct device allows =
to
> > get rid of an #ifdef in driver core.
> >=20
> > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > ---
> >   arch/arm/xen/mm.c          |  2 +-
> >   arch/mips/pci/pci-octeon.c |  2 +-
> >   arch/x86/kernel/pci-dma.c  |  2 +-
> >   drivers/base/core.c        |  4 +---
> >   drivers/xen/swiotlb-xen.c  |  2 +-
> >   include/linux/swiotlb.h    | 25 +++++++++++++++++++++++-
> >   kernel/dma/swiotlb.c       | 39 +++++++++++++++++++++++++++++++++++++-
> >   7 files changed, 67 insertions(+), 9 deletions(-) =20
>=20
>=20
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 4e52cd5e0bdc..07216af59e93 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -110,7 +110,6 @@ struct io_tlb_mem {
> >   	atomic_long_t used_hiwater;
> >   #endif
> >   };
> > -extern struct io_tlb_mem io_tlb_default_mem;
> >  =20
> >   static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t =
paddr)
> >   {
> > @@ -128,13 +127,22 @@ static inline bool is_swiotlb_force_bounce(struct=
 device *dev)
> >  =20
> >   void swiotlb_init(bool addressing_limited, unsigned int flags);
> >   void __init swiotlb_exit(void);
> > +void swiotlb_dev_init(struct device *dev);
> >   size_t swiotlb_max_mapping_size(struct device *dev);
> > +bool is_swiotlb_allocated(void);
> >   bool is_swiotlb_active(struct device *dev);
> >   void __init swiotlb_adjust_size(unsigned long size);
> > +phys_addr_t default_swiotlb_start(void);
> > +phys_addr_t default_swiotlb_limit(void); =20
>=20
> Usually we use start/end, base/limit, low[est]/high[est] tuples.

I'm no big fan of start/end, because the "end" sometimes means "highest
within range" and sometimes "one past range", being responsible for an
impressive amount of off-by-one errors.

But I agree. When I decided against "end", I should have also replaced
"start" with "base". Well, this patch series will certainly see a v5,
so I'll change it there. Thanks for the suggestion!

Petr T

> Possibly clearer to rename, regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 2b83e3ad9dca..873b077d7e37 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c =20
>=20
>=20
> > @@ -958,6 +975,26 @@ bool is_swiotlb_active(struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(is_swiotlb_active);
> >  =20
> > +/**
> > + * default_swiotlb_start() - get the start of the default SWIOTLB
> > + *
> > + * Get the lowest physical address used by the default software IO TLB=
 pool.
> > + */
> > +phys_addr_t default_swiotlb_start(void)
> > +{
> > +	return io_tlb_default_mem.start;
> > +}
> > +
> > +/**
> > + * default_swiotlb_limit() - get the highest address in the default SW=
IOTLB
> > + *
> > + * Get the highest physical address used by the default software IO TL=
B pool. =20
>=20
> (note you describe lowest/highest).
>=20
> > + */
> > +phys_addr_t default_swiotlb_limit(void)
> > +{
> > +	return io_tlb_default_mem.end - 1;
> > +}
> > +
> >   #ifdef CONFIG_DEBUG_FS
> >  =20
> >   static int io_tlb_used_get(void *data, u64 *val) =20
>=20

