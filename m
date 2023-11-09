Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3D7E6CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjKIPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjKIPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:05:25 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEE35A1;
        Thu,  9 Nov 2023 07:05:22 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id BDA6E185566;
        Thu,  9 Nov 2023 16:05:18 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1699542319; bh=MvMT179DCwTKc122LzpmtozfbprvHehFjajEI1qFjxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSVeiC+bM6MQRJZDlmBfD8oLJHcKPYUONZyx7lOzh6xzzVdIMWQEsLFgfHbgMVRCU
         4L1vR9TnEyRu/WDoc6G70B9S7uz2ET3zS5/nYdLn3mNkO/EsD259l7UP+Sii6g00uI
         qs9lO6+2jDSvQ/xyTj3/s0wUeDrBJjZh4SbmRpQspmc+kC7hpEg/tENRFAsVyNiZCB
         8NE3xqt5uYXlcINMSwmQUVU2zXa1/08aPk7raALNkYWkt2Y3COL188vKUxKaMb8kTD
         kjQt28geU8zJqospvEqi30iw0zzoYx0Pp9cbXmnz23ee3ZF7hT+TmkyGIuoG6UD7lZ
         0bTm1dEL76Qfw==
Date:   Thu, 9 Nov 2023 16:05:17 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Halil Pasic <pasic@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations with
 CONFIG_SWIOTLB_DYNAMIC
Message-ID: <20231109160517.3d1c1e17@meshulam.tesarici.cz>
In-Reply-To: <32af4ed531a6cf8e289d4dc9e1dbc5fb14bc1813.camel@linux.ibm.com>
References: <20231108111249.261-1-petrtesarik@huaweicloud.com>
        <20231108132120.0538a778@meshulam.tesarici.cz>
        <32af4ed531a6cf8e289d4dc9e1dbc5fb14bc1813.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023 13:24:48 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On Wed, 2023-11-08 at 13:21 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed,  8 Nov 2023 12:12:49 +0100
> > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> >  =20
> > > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > >=20
> > > Limit the free list length to the size of the IO TLB. Transient pool =
can be
> > > smaller than IO_TLB_SEGSIZE, but the free list is initialized with the
> > > assumption that the total number of slots is a multiple of IO_TLB_SEG=
SIZE.
> > > As a result, swiotlb_area_find_slots() may allocate slots past the en=
d of
> > > a transient IO TLB buffer. =20
> >=20
> > Just to make it clear, this patch addresses only the memory corruption
> > reported by Niklas, without addressing the underlying issues. Where
> > corruption happened before, allocations will fail with this patch.
> >=20
> > I am still looking into improving the allocation strategy itself.
> >=20
> > Petr T =20
>=20
> I know this has already been applied but for what its worth I did
> finally manage to test this with my reproducer and the allocation
> overrun is fixed by this change. I also confirmed that at least my
> ConnectX VF TCP/IP test case seems to handle the DMA error gracefully
> enough.

Thank you for testing!

Inded, the failed request is often retried at a later time. For example
I tested with a SCSI driver, and by the time the SCSI layer retried the
request, a new standard pool was already available. But this situation
is not ideal. If nothing else, it incurs an unnecessary delay.

Petr T
