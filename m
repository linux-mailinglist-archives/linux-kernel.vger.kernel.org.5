Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3F75A88F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGTICq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGTICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:02:42 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646D135;
        Thu, 20 Jul 2023 01:02:42 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 3ECD7164269;
        Thu, 20 Jul 2023 10:02:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689840159; bh=D7uejbPnusryYbx96m6L7cjLYp5Gmplm0qfp8geBlY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y5azLUXFqHfPiDcwLhK9RwnD6ejtiZ+5Q02Bj+zd22Fr+LTkHaT722JMUBsOsMObf
         d/uJjgs0CGt4ina28Lmi+hf5m9guZ+TRvuODDbwcLdrHc3ABi2F9r9nWpfci2kQrla
         Z2yA0zYxxpDaId3rWBew7EufpvEwO7go1DmYHTMzHoRlZ7WPskE92l6RVNhUeRWnKg
         fKAg7BCd5Gjf6KvOFOw4bkEQUU4pOxankJGS7I9GPQu8i9MLEdtCZumfu7B6IuuFen
         OKCplt0boWwWvjkRP8KQZMs+QBemLE/Tga0vCGYkGNdPfyg0bvUJ2CxXY0zZ+Agu45
         DanUaK6MSjTxA==
Date:   Thu, 20 Jul 2023 10:02:38 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
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
Subject: Re: [PATCH v4 8/8] swiotlb: search the software IO TLB only if a
 device makes use of it
Message-ID: <20230720100238.58f11c06@meshulam.tesarici.cz>
In-Reply-To: <20230720064744.GA4395@lst.de>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
        <a8d31d3fffa0867dce2b44b98dc2714289edfdc9.1689261692.git.petr.tesarik.ext@huawei.com>
        <20230720064744.GA4395@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 08:47:44 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Any reason this can't just do a list_empty_careful on the list
> instead of adding yet another field that grows struct device?

On which list?

The dma_io_tlb_pools list only contains transient pools, but a device
may use bounce buffers from a regular pool.

The dma_io_tlb_mem.pools list will always be non-empty, unless the
system runs without SWIOTLB.

On a system which does have a SWIOTLB, the flag allows to differentiate
between devices that actually use bounce buffers and devices that do
not (e.g. because they do not have any addressing limitations).

Petr T
