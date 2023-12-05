Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3474805DD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbjLES2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLES2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:28:17 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D666C1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:28:23 -0800 (PST)
Received: (qmail 425898 invoked by uid 1000); 5 Dec 2023 13:28:23 -0500
Date:   Tue, 5 Dec 2023 13:28:23 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ferry Toth <ferry.toth@elsinga.info>,
        Ferry Toth <fntoth@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <e22ae13a-aafc-49da-8092-1a17f60ae420@rowland.harvard.edu>
References: <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <ZWYnECPRKca5Dpqc@arm.com>
 <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
 <ZWm-u2kV1UP09M84@arm.com>
 <5425cf42-0f49-41b5-b26d-1e099d5bdcc2@elsinga.info>
 <5093ce37-047e-4aa8-a9e8-2978da9d734a@rowland.harvard.edu>
 <ZWobHJqBji80CTm-@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWobHJqBji80CTm-@arm.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:42:52PM +0000, Catalin Marinas wrote:
> Indeed, so to be sure we don't trip over other false alarms, we'd also
> need to force ARCH_DMA_MINALIGN to be at least a cache-line size. That's
> used in some structures to force a static alignment of various members
> that take DMA transfers. After that, anything reported might actually be
> a potential issue, not a false alarm.
> 
> However, I wonder whether we'd actually hide some genuine problems.
> Let's say x86 gets some DMA corruption when it tries to DMA 8 bytes
> into two adjacent buffers because of some DMA buffer overflow, nothing
> to do with cache lines. You enable the DMA API debugging to see if it
> reports anything and it suddenly starts working because of the forced
> minimum alignment.

In the long run, it may turn out that trying to detect memory usage 
patterns that could cause problems for architectures other than the one 
currently running is not workable.  Certainly it is a bad idea to have a 
debugging infrastructure that changes the behavior of other parts of the 
system -- particularly when those other parts may be the ones you're 
trying to debug.

You may end up needing to make a choice here.  Which evil is lesser?

Alan Stern

