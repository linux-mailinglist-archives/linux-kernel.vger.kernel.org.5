Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F3754F55
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGPPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGPPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35981B7;
        Sun, 16 Jul 2023 08:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B6160D30;
        Sun, 16 Jul 2023 15:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65317C433C8;
        Sun, 16 Jul 2023 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520583;
        bh=TBe9iDjVnkR+UmC0zth4fQ+GS4Xe/RGNJO67dRLKtQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WX63MLrQ7bxnNctMb3HgCh4i2qCHQ3M5ugI6ZOkweVwbjM8/NoILt5biY78yW57Jo
         nnE63fWeaDDp8rZpmuEAYBjbo1sIY89rs131GVe1z51rlH6jaF8OQSlzecqtRcljbi
         s2c+TVGlaZ1Cm4Rje4UEBQk0NPGaag2HG8lcAsxc=
Date:   Sun, 16 Jul 2023 17:16:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yj.chiang@mediatek.com, Peter Korsgaard <peter@korsgaard.com>,
        Mike Snitzer <snitzer@kernel.org>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15] dm init: add dm-mod.waitfor to wait for
 asynchronously probed block devices
Message-ID: <2023071603-lustily-defraud-2149@gregkh>
References: <20230713055841.24815-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713055841.24815-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:58:37PM +0800, Mark-PK Tsai wrote:
> From: Peter Korsgaard <peter@korsgaard.com>
> 
> Just calling wait_for_device_probe() is not enough to ensure that
> asynchronously probed block devices are available (E.G. mmc, usb), so
> add a "dm-mod.waitfor=<device1>[,..,<deviceN>]" parameter to get
> dm-init to explicitly wait for specific block devices before
> initializing the tables with logic similar to the rootwait logic that
> was introduced with commit  cc1ed7542c8c ("init: wait for
> asynchronously scanned block devices").
> 
> E.G. with dm-verity on mmc using:
> dm-mod.waitfor="PARTLABEL=hash-a,PARTLABEL=root-a"
> 
> [    0.671671] device-mapper: init: waiting for all devices to be available before creating mapped devices
> [    0.671679] device-mapper: init: waiting for device PARTLABEL=hash-a ...
> [    0.710695] mmc0: new HS200 MMC card at address 0001
> [    0.711158] mmcblk0: mmc0:0001 004GA0 3.69 GiB
> [    0.715954] mmcblk0boot0: mmc0:0001 004GA0 partition 1 2.00 MiB
> [    0.722085] mmcblk0boot1: mmc0:0001 004GA0 partition 2 2.00 MiB
> [    0.728093] mmcblk0rpmb: mmc0:0001 004GA0 partition 3 512 KiB, chardev (249:0)
> [    0.738274]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
> [    0.751282] device-mapper: init: waiting for device PARTLABEL=root-a ...
> [    0.751306] device-mapper: init: all devices available
> [    0.751683] device-mapper: verity: sha256 using implementation "sha256-generic"
> [    0.759344] device-mapper: ioctl: dm-0 (vroot) is ready
> [    0.766540] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
> 
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  .../admin-guide/device-mapper/dm-init.rst     |  8 +++++++
>  drivers/md/dm-init.c                          | 22 ++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h
