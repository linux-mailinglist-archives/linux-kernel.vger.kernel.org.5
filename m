Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9A761BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjGYOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGYOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAEC1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9928D61781
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB4C433C7;
        Tue, 25 Jul 2023 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295721;
        bh=WWBebdUOHAwGjNmUd0BLD5EBUj4u21H/flsLVNiSGyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IerEz7osX93i6yK1JNW2zmIpgHzJcMB+j3yDUJPtDvwWOGcSkxCx31sDEIcFaOk9n
         GuErLPO0vaQXJjmS0o/WAOEaDFhC9kM3e3RpS4VcbumZRO2tWHRvdoJAGcmKXxPb7v
         r91/m6ZY1VwuUPMLl6g8giZgnu1HsBa4wZUgmiP93ByjBWGNGEIlYSUePSrGu2KEsb
         IcYci2QbXP0UkLRNW2M5VYVotMEzA9e87AI6Dw/y6AAGXsj40bS3RsIZot3n8LeoBk
         xEQ6gPTeG5N0p9QioniD/xm6JBhSsUTTBMAFi1fSIjl9FtG4Qpue3a/thTAm/J2s4+
         w49bXwqQu0ZPA==
Date:   Tue, 25 Jul 2023 08:35:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725110622.129361-1-ptyadav@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:06:22PM +0200, Pratyush Yadav wrote:
> If a device has no NUMA node information associated with it, the driver
> puts the device in node first_memory_node (say node 0). As a side
> effect, this gives an indication to userspace IRQ balancing programs
> that the device is in node 0 so they prefer CPUs in node 0 to handle the
> IRQs associated with the queues. For example, irqbalance will only let
> CPUs in node 0 handle the interrupts. This reduces random access
> performance on CPUs in node 1 since the interrupt for command completion
> will fire on node 0.
>
> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
> information for the NVMe devices. This means all NVMe devices have
> NUMA_NO_NODE by default. Without this patch, random 4k read performance
> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
> both nodes get similar performance (around 315k IOPS).

irqbalance doesn't work with this driver though: the interrupts are
managed by the kernel. Is there some other reason to explain the perf
difference?
