Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507E5763C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjGZQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjGZQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A72F268C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE47961BB3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A53C433C8;
        Wed, 26 Jul 2023 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690388243;
        bh=EzXddJxdLCYjjaFLuW2hCq3oDwt9vioK1ChWO2Mwx8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q06Z4ihIpUy+7SKUtFzFVavPTBeQavAX3BgEqflbadf8w+4hCjOuVpbKAYKUaB7Lf
         nqzj8nF+wZ250iGYlYL5rhE7bqDiSswYvwgKkt1LyBKXSeQil04tT7FzKMiegLL0E7
         xPBSCs31s9usjL9nVoqgmcsvx77Hwd9p25c4ld5ErkeWHTjjAKTeSXhS9sYDxYphnF
         OZi+jNvnGBGXY118qbP/jkJJ4raskWDJTPiyxcnBPHerXvK5EjbUPsOd1imz4gvF8L
         tjPz9mtKR26a8HOAego60n7FvpCH2FZ4dxPdUbnXljxRl2So+rX/84Y7TP8oAJ52eb
         Q7xM3XoMMwCXw==
Date:   Wed, 26 Jul 2023 10:17:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cz0e8zc6.fsf_-_@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:30:33PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 26 2023, Christoph Hellwig wrote:
> > On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
> >>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
> >>>> information for the NVMe devices. This means all NVMe devices have
> >>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
> >>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
> >>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
> >>>> both nodes get similar performance (around 315k IOPS).
> >>>
> >>> irqbalance doesn't work with this driver though: the interrupts are
> >>> managed by the kernel. Is there some other reason to explain the perf
> >>> difference?
> 
> Hmm, I did not know that. I have not gone and looked at the code but I
> think the same reasoning should hold, just with s/irqbalance/kernel. If
> the kernel IRQ balancer sees the device is on node 0, it would deliver
> its interrupts to CPUs on node 0.
> 
> In my tests I can see that the interrupts for NVME queues are sent only
> to CPUs from node 0 without this patch. With this patch CPUs from both
> nodes get the interrupts.

Could you send the output of:

  numactl --hardware

and then with and without your patch:

  for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    cat /proc/irq/$i/{smp,effective}_affinity_list; \
  done

?
