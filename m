Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C537FB26B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjK1HQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK1HQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:16:10 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E637138;
        Mon, 27 Nov 2023 23:16:15 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 2DFB41A71BB;
        Tue, 28 Nov 2023 08:16:12 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1701155772; bh=s04RxWy3zIlE9UTQSGNYqjvMzSlBKupZZjbzsW8zx48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T8vArpDQPUBGqncPtDpRLYD0zqwqLVsKmTuOaiOS3KyrgB0ax2CzPaV7iKk0Klrph
         0stWB9AP21JSoozk1FPTDazokzL2anT8AR8kHuDUiYHPmFmCaiA39alAY3x5OMyM2U
         3Ba3qT8qbINfzJSKw6uOARNHs3gmjkSt3NBpsePdskqDPY2XPwsdAlfABj+eGL30CP
         PaTuewKFJNRcx4RfZDBK9dRPfn0NYvkwRxAGQilTYpC72Uj54la8joiRDNe6CK4KyQ
         ME2QlSC+EjXaxkpiggVUmHbu9ZrNZrQRPVEyo1DWcnDpg2OP6RjOk39RQWHD4A9sxR
         A7s7m7zw4SiMA==
Date:   Tue, 28 Nov 2023 08:16:10 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jianxiong Gao <jxgao@google.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231128081610.5616ef14@meshulam.tesarici.cz>
In-Reply-To: <20231127155913.GA1468@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103171447.02759771.pasic@linux.ibm.com>
        <20231103214831.26d29f4d@meshulam.tesarici.cz>
        <20231107182420.0bd8c211.pasic@linux.ibm.com>
        <20231108101347.77cab795@meshulam.tesarici.cz>
        <20231123111608.17727968@meshulam.tesarici.cz>
        <20231127155913.GA1468@lst.de>
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

On Mon, 27 Nov 2023 16:59:13 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Nov 23, 2023 at 11:16:08AM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > > To sum it up, there are two types of alignment:
> > >=20
> > > 1. specified by a device's min_align_mask; this says how many low
> > >    bits of a buffer's physical address must be preserved,
> > >=20
> > > 2. specified by allocation size and/or the alignment parameter;
> > >    this says how many low bits in the first IO TLB slot's physical
> > >    address must be zero. =20
>=20
> Both are correct.

Great! Thank you for confirmation. Unfortunately, that's not quite how
the code works now.

I'm on it to fix things.

Petr T
