Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A377043C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHDPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjHDPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63949E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17F6E61F6E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3B0C433C7;
        Fri,  4 Aug 2023 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162388;
        bh=3N0bkV5TRHkrXO8pWt66dKSeJ+i+DWdZ25VNCKRjndc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDeAC7OgqIFHcLVbnxOlTKH33OVpLZJxGcw/M+8KEswpIXoDRpF0IUoCcvpSZ1vGM
         e8h/VeCal6Y//47GQxUNaEXeJT9CKUQTnWaM+drUGHcVPTUL/t5pn6fmSCXLQ0M8He
         gY7B1uuzwB17Dj7AUb36ezP2OayvAGjhzWwxBfDl/mf9xTCZzqBe9gH+Vhj22XSbP3
         W6SHONbwNXhDhuzEGkvwqEKqOLOGtQZ6w0QSFjPalinExTjTGc1aW8PD23VanmayqE
         VvswP03ydwAZNNwrb+qgZiWf0jJ2Jb//378LchFSUbwghCs5N1SzxvfzQ/diaxsPyR
         zPxVNenz/udxQ==
Date:   Fri, 4 Aug 2023 09:19:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZM0XEUw0xKgzXvi+@kbusch-mbp>
References: <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
 <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0tttn7vs3.fsf_-_@amazon.de>
 <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0350y7tg7.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0350y7tg7.fsf@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:50:16PM +0200, Pratyush Yadav wrote:
> With this patch, I get the below affinities:

Something still seems off without effective_affinity set. That attribute
should always reflect one CPU from the smp_affinity_list.

At least with your patch, the smp_affinity_list looks as expected: every
CPU is accounted for, and no vector appears to share the resource among
CPUs in different nodes.
 
>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>     >   done
>     8
>     8
>     16-17,48,65,67,69
> 
>     18-19,50,71,73,75
> 
>     20,52,77,79
> 
>     21,53,81,83
> 
>     22,54,85,87
> 
>     23,55,89,91
> 
>     24,56,93,95
> 
>     25,57,97,99
> 
>     26,58,101,103
> 
>     27,59,105,107
> 
>     28,60,109,111
> 
>     29,61,113,115
> 
>     30,62,117,119
> 
>     31,63,121,123
> 
>     49,51,125,127
> 
>     0,32,64,66
> 
>     1,33,68,70
> 
>     2,34,72,74
> 
>     3,35,76,78
> 
>     4,36,80,82
> 
>     5,37,84,86
> 
>     6,38,88,90
> 
>     7,39,92,94
> 
>     8,40,96,98
> 
>     9,41,100,102
> 
>     10,42,104,106
> 
>     11,43,108,110
> 
>     12,44,112,114
> 
>     13,45,116,118
> 
>     14,46,120,122
> 
>     15,47,124,126
> 
> The blank lines are because effective_smp_affinity is blank for all but the first interrupt.
> 
> The problem is, even with this I still get the same performance
> difference when running on Node 1 vs Node 0. I am not sure why. Any
> pointers?

I suspect effective_affinity isn't getting set and interrupts are
triggering on unexpected CPUs. If you check /proc/interrupts, can you
confirm if the interrupts are firing on CPUs within the
smp_affinity_list or some other CPU?
