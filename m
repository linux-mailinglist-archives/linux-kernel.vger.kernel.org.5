Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8776766A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjG1Tes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjG1Teq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E330D3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6397621D3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB423C433C7;
        Fri, 28 Jul 2023 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572884;
        bh=j8jNcmTYYntq9pAVo2UzJdRoU3x1ihUFJCes2YsaF/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJtVHE1oCeKXFQ2YOPpEvTEVZW6WSuvjT+4P7eaX6T5Uf5dTTbHVJFaiA9BFwPTaS
         H9IMeFpMevEQQKjqRFGvrvkwAtQC+gb4b3p5ee3vHF+fiIwycWYCCjDsoXzYgH9xBm
         63X7w/U3dkPG09uiHZUbwMxBo0v+ySrscND2ZbTGFMN3kx4P+kbpXEm6Zu8jsqt8pW
         rFXgI97jdb/6sEFGxM14NkB1Dgnge/dDvmuoqKndSuOE7w0n1d6pRGBzIWC3lWdIMd
         m99opBLE4qgS7OJaJ/Ea+s1YVPCTZl3zpC86thlNo0TmUaUe9PsMMj4zETHc+Gs1S0
         qkeA6dhtaxEmQ==
Date:   Fri, 28 Jul 2023 13:34:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
 <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0tttn7vs3.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0tttn7vs3.fsf_-_@amazon.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:09:32PM +0200, Pratyush Yadav wrote:
> 
> I am guessing you are looking at irq_create_affinity_masks(). Yeah, It
> does not take into account the NUMA information. In fact, even if it
> did, the NUMA node associated with the IRQ is NUMA_NO_NODE
> (/proc/$irq/node == -1).
> 
> I did some more digging over the week to figure out what is going on. It
> seems like the kernel _does_ in fact allow all CPUs in the affinity. I
> added some prints in set_affinity_irq() in
> drivers/xen/events/events_base.c (since that is the irqchip for the
> interrupt). I see it being called with mask: ffffffff,ffffffff.
> 
> But I later see the function being called again with a different mask:
> 00000000,00008000. The stack trace shows the call is coming from
> ksys_write(). The process doing the write is irqbalance.
> 
> So I think your earlier statement was incorrect. irqbalance does in fact
> balance these interrupts and it probably looks at the NUMA information
> of the device to make that decision. My original reasoning holds and
> irqbalance is the one picking the affinity.
> 
> With this explanation, do you think the patch is good to go?

irqbalance still writes to the /proc/<irq>/smp_affinity to change it,
right? That's just getting I/O errors on my machines because it fails
irq_can_set_affinity_usr() for nvme's kernel managed interrupts (except
the first vector, but that one is not used for I/O). Is there another
path irqbalance is using that's somehow getting past the appropriate
checks? Or perhaps is your xen irq_chip somehow bypassing the managed
irq property?
