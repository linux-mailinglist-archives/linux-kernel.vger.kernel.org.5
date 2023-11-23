Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43087F5C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbjKWKQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:16:09 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE79F;
        Thu, 23 Nov 2023 02:16:13 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 4ED651A1F9E;
        Thu, 23 Nov 2023 11:16:10 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1700734570; bh=IdlZbZ9FL5iny9zKRN7ZMCUL5Jenf+2OfYnJsvJqcig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDPSK0lGkfZJHOQZNuLlkLCLbHz1wjzqVXLySg3Q8z8v7t5gijyPAbAiww7BW4rQr
         X2EHNtMdFNvELQGkgNrK29IfFgUDgjQUmz9dd+wWZuWnxYFT9HUPPY/tIjAr/4Z7Al
         LCbuCRwmyx01ek0FkLAGYG8vqjsa3KscngzQWmOLXmSMp5woK+anXKMYENadtfWAxO
         4mvc7VDKq40/5hTwubz8kifMxUhkDWkl8oEpJYxKuIkSGXypzDhcoE9I4CU5hYWWQ1
         4JPUyw025ZJ6Qux1IpbkqUH/wC+OyAm2Y3txJyL3Mm0XJYDyM6WznR/dLWgi1+vEqY
         AdxDvgM/iHMNg==
Date:   Thu, 23 Nov 2023 11:16:08 +0100
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
Message-ID: <20231123111608.17727968@meshulam.tesarici.cz>
In-Reply-To: <20231108101347.77cab795@meshulam.tesarici.cz>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103171447.02759771.pasic@linux.ibm.com>
        <20231103214831.26d29f4d@meshulam.tesarici.cz>
        <20231107182420.0bd8c211.pasic@linux.ibm.com>
        <20231108101347.77cab795@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I don't think I have ever seen an answer to my question regarding
alignment constraints on swiotlb bounce buffers:

On Wed, 8 Nov 2023 10:13:47 +0100
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

>[...]
> To sum it up, there are two types of alignment:
>=20
> 1. specified by a device's min_align_mask; this says how many low
>    bits of a buffer's physical address must be preserved,
>=20
> 2. specified by allocation size and/or the alignment parameter;
>    this says how many low bits in the first IO TLB slot's physical
>    address must be zero.
>=20
> I hope somebody can confirm or correct this summary before I go
> and break something. You know, it's not like cleanups in SWIOTLB
> have never broken anything.  ;-)

If no answer means that nobody knows, then based on my understanding the
existing code (both implementation and users), I can assume that this
is the correct interpretation.

I'm giving it a few more days. If there's still no reaction, expect a
beautiful documentation patch and a less beautiful cleanup patch in the
next week.

Petr T
