Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACEF764218
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGZW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGZW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5244D1FC9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3EE961CC2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ADCC433C7;
        Wed, 26 Jul 2023 22:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690410361;
        bh=wW3sbzAZlnJ8lvGPenB+aQcF09jFTfbsbkAqfnPVEcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRAK3tu9EPTvlY2flUiDPhQMa8p2llzCW2FPjrvbRdoD0NUocO6DhS+yksOHz3Uh6
         TvBa02aBCY76XvifCzr8R3ZqPPMOaioDhLsI6cLyNcUv/OpcuucTNmwNzLGU1LU50B
         YouEdV3E1HL0k99O5oV60RKL90I64RRoP6LzE1uyMMYzcD/+ZJkHBIWd91D7z6f+b6
         XXDWmGI9jMevVfKD3jxJQiPb6dPItP2KnZaphUfj1HH0FnfMegmBXh+9chvG4WRsQb
         k1HxumXj81Jx0JKsXPOFU/DaoBFqIpPVdIdYBZNuxPZr/Y0EQktt+17qFYYvarEsmd
         gt2DmWo9MV44A==
Date:   Wed, 26 Jul 2023 16:25:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs08rb28o4u.fsf_-_@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:32:33PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 26 2023, Keith Busch wrote:
> > Could you send the output of:
> >
> >   numactl --hardware
> 
> $ numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> node 0 size: 245847 MB
> node 0 free: 245211 MB
> node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> node 1 size: 245932 MB
> node 1 free: 245328 MB
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
> 
> >
> > and then with and without your patch:
> >
> >   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
> >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
> >   done
> 
> Without my patch:
> 
>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>     >   done

Hm, I wonder if there's something wrong with my script. All the cpu's
should be accounted for in the smp_affinity_list, assuming it captured
all the vectors of the nvme device, but both examples are missing half
the CPUs. It looks like you have 32 vectors. Does that sound right?

This does show the effective affinity is indeed always on node 0 without
your patch. I don't see why, though: the "group_cpus_evenly()" function
that spreads the interrupts doesn't know anything about the device the
resource is being grouped for, so it shouldn't even take its NUMA node
into consideration. It's just supposed to ensure all CPUs have a shared
resource, preferring to not share across numa nodes.

I'll emulate a similar CPU topology with similar nvme vector count and
see if I can find anything suspicious. I'm a little concerned we may
have the same problem for devices that have an associated NUMA node that
your patch isn't addressing.

>     41
>     40
>     33
>     33
>     44
>     44
>     9
>     9
>     32
>     32
>     2
>     2
>     6
>     6
>     11
>     11
>     1
>     1
>     35
>     35
>     39
>     39
>     13
>     13
>     42
>     42
>     46
>     46
>     41
>     41
>     46
>     46
>     15
>     15
>     5
>     5
>     43
>     43
>     0
>     0
>     14
>     14
>     8
>     8
>     12
>     12
>     7
>     7
>     10
>     10
>     47
>     47
>     38
>     38
>     36
>     36
>     3
>     3
>     34
>     34
>     45
>     45
>     5
>     5
> 
> With my patch:
> 
>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>     >   done
>     9
>     9
>     15
>     15
>     5
>     5
>     23
>     23
>     38
>     38
>     52
>     52
>     21
>     21
>     36
>     36
>     13
>     13
>     56
>     56
>     44
>     44
>     42
>     42
>     31
>     31
>     48
>     48
>     5
>     5
>     3
>     3
>     1
>     1
>     11
>     11
>     28
>     28
>     18
>     18
>     34
>     34
>     29
>     29
>     58
>     58
>     46
>     46
>     54
>     54
>     59
>     59
>     32
>     32
>     7
>     7
>     56
>     56
>     62
>     62
>     49
>     49
>     57
>     57
