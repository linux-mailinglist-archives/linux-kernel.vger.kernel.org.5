Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAA7E1A88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjKFGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjKFGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:54:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE29C;
        Sun,  5 Nov 2023 22:54:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB6CC433C7;
        Mon,  6 Nov 2023 06:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699253665;
        bh=EntPlRifOGbbk3ujSL4xtP86KIkN/FnEjRD6b7R3YTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j26w1Ye4CDavLpD27dhAnMUk+A6+ndEv2dZYrG0Nabf1DRbw4XUOOFZm4kiuRkvor
         /Szn0pfh+ax9Om0u7x5WysEPZTqCWB+GkjlH4zc2hHqq9ctdeGocZhOUfLtkfeYcbr
         UCeqefaiBaRvD94JT2AfBaLK0WjUaNfK1Sz3V8Is=
Date:   Mon, 6 Nov 2023 07:54:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Kira <nyakov13@gmail.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com, Coiby Xu <coiby.xu@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Sven Joachim <svenjoac@gmx.de>,
        Ian Kent <raven@themaw.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Message-ID: <2023110655-swarm-parka-177d@gregkh>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030150400.74178-1-benjamin.poirier@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:04:00AM +1100, Benjamin Poirier wrote:
> This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.
> 
> On All Hallows' Eve, fear and cower for it is the return of the undead
> driver.
> 
> There was a report [1] from a user of a QLE8142 device. They would like for
> the driver to remain in the kernel. Therefore, revert the removal of the
> qlge driver.
> 
> [1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/

<snip>

> --- /dev/null
> +++ b/drivers/staging/qlge/TODO
> @@ -0,0 +1,28 @@
> +* commit 7c734359d350 ("qlge: Size RX buffers based on MTU.", v2.6.33-rc1)
> +  introduced dead code in the receive routines, which should be rewritten
> +  anyways by the admission of the author himself, see the comment above
> +  qlge_build_rx_skb(). That function is now used exclusively to handle packets
> +  that underwent header splitting but it still contains code to handle non
> +  split cases.
> +* truesize accounting is incorrect (ex: a 9000B frame has skb->truesize 10280
> +  while containing two frags of order-1 allocations, ie. >16K)
> +* while in that area, using two 8k buffers to store one 9k frame is a poor
> +  choice of buffer size.
> +* in the "chain of large buffers" case, the driver uses an skb allocated with
> +  head room but only puts data in the frags.
> +* rename "rx" queues to "completion" queues. Calling tx completion queues "rx
> +  queues" is confusing.
> +* struct rx_ring is used for rx and tx completions, with some members relevant
> +  to one case only
> +* the flow control implementation in firmware is buggy (sends a flood of pause
> +  frames, resets the link, device and driver buffer queues become
> +  desynchronized), disable it by default
> +* the driver has a habit of using runtime checks where compile time checks are
> +  possible (ex. qlge_free_rx_buffers())
> +* reorder struct members to avoid holes if it doesn't impact performance
> +* use better-suited apis (ex. use pci_iomap() instead of ioremap())
> +* remove duplicate and useless comments
> +* fix weird line wrapping (all over, ex. the qlge_set_routing_reg() calls in
> +  qlge_set_multicast_list()).
> +* remove useless casts (ex. memset((void *)mac_iocb_ptr, ...))
> +* fix checkpatch issues

In looking at this again, are you sure you all want this in the tree?
I'm glad to take the revert but ONLY if you are willing to then take a
"move this to drivers/net/" patch for the code as well, WITH an actual
maintainer and developer who is willing to do the work for this code.

In all the years that this has been in the staging tree, the listed
maintainers have not been active at all from what I can remember, and
obviously the above list of "things to fix" have not really been worked
on at all.

So why should it be added back?  I understand there is at least one
reported user, but for drivers in the staging tree, that's not a good
reason to keep them around if there is not an actual maintainer that is
willing to do the work.

Which reminds me, we should probably sweep the drivers/staging/ tree
again to see what we can remove given a lack of real development.
Normally we do that every other year or so, and this driver would fall
into the "no one is doing anything with it" category and should be
dropped.

thanks,

greg k-h
