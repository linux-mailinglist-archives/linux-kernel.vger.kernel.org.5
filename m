Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9852D75BF38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGUHCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGUHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA8270B;
        Fri, 21 Jul 2023 00:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C51761335;
        Fri, 21 Jul 2023 07:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5606C433C7;
        Fri, 21 Jul 2023 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689922966;
        bh=L2m94TnnKw2R0igHJ+nBKpafFPAbLmadKrdMC6FjhJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqoJuXlRzX7oJLnh/5iwSWqtzj9JZwisokBGoA5wQvArO/OixN7Yoq9R/ajf7vve5
         7n9JAa2XgiXNgNXjm/pB293pJLkZQspBoL5PmL4CZA7Ln2oE4O9kidXxunYB0uIunJ
         maXjJYuE9Nw0eksjw2bYLkcohGsju5mV/XWRx0eQ=
Date:   Fri, 21 Jul 2023 09:02:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     agk@redhat.com, corbet@lwn.net, dm-devel@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, peter@korsgaard.com, snitzer@kernel.org,
        snitzer@redhat.com, stable@vger.kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH 5.15] dm init: add dm-mod.waitfor to wait for
 asynchronously probed block devices
Message-ID: <2023072117-skewed-engulf-2f32@gregkh>
References: <2023072033-hedge-buffing-8862@gregkh>
 <20230721063845.11676-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721063845.11676-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:38:45PM +0800, Mark-PK Tsai wrote:
> > On Mon, Jul 17, 2023 at 09:57:28AM +0800, Mark-PK Tsai wrote:
> > > > On Sun, Jul 16, 2023, 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > > On Thu, Jul 13, 2023 at 01:58:37PM +0800, Mark-PK Tsai wrote:
> > > > > > From: Peter Korsgaard <peter@korsgaard.com>
> > > > > > 
> > > > > > Just calling wait_for_device_probe() is not enough to ensure that
> > > > > > asynchronously probed block devices are available (E.G. mmc, usb), so
> > > > > > add a "dm-mod.waitfor=<device1>[,..,<deviceN>]" parameter to get
> > > > > > dm-init to explicitly wait for specific block devices before
> > > > > > initializing the tables with logic similar to the rootwait logic that
> > > > > > was introduced with commit  cc1ed7542c8c ("init: wait for
> > > > > > asynchronously scanned block devices").
> > > > > > 
> > > > > > E.G. with dm-verity on mmc using:
> > > > > > dm-mod.waitfor="PARTLABEL=hash-a,PARTLABEL=root-a"
> > > > > > 
> > > > > > [    0.671671] device-mapper: init: waiting for all devices to be 
> > > > > available before creating mapped devices
> > > > > > [    0.671679] device-mapper: init: waiting for device PARTLABEL=hash-a 
> > > > > ...
> > > > > > [    0.710695] mmc0: new HS200 MMC card at address 0001
> > > > > > [    0.711158] mmcblk0: mmc0:0001 004GA0 3.69 GiB
> > > > > > [    0.715954] mmcblk0boot0: mmc0:0001 004GA0 partition 1 2.00 MiB
> > > > > > [    0.722085] mmcblk0boot1: mmc0:0001 004GA0 partition 2 2.00 MiB
> > > > > > [    0.728093] mmcblk0rpmb: mmc0:0001 004GA0 partition 3 512 KiB, 
> > > > > chardev (249:0)
> > > > > > [    0.738274]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
> > > > > > [    0.751282] device-mapper: init: waiting for device PARTLABEL=root-a 
> > > > > ...
> > > > > > [    0.751306] device-mapper: init: all devices available
> > > > > > [    0.751683] device-mapper: verity: sha256 using implementation 
> > > > > "sha256-generic"
> > > > > > [    0.759344] device-mapper: ioctl: dm-0 (vroot) is ready
> > > > > > [    0.766540] VFS: Mounted root (squashfs filesystem) readonly on 
> > > > > device 254:0.
> > > > > > 
> > > > > > Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> > > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > > > > ---
> > > > > >  .../admin-guide/device-mapper/dm-init.rst     |  8 +++++++
> > > > > >  drivers/md/dm-init.c                          | 22 ++++++++++++++++++-
> > > > > >  2 files changed, 29 insertions(+), 1 deletion(-)
> > > > >
> > > > > What is the git commit id of this change in Linus's tree?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > >
> > > > >
> > > > 
> > > > Hey Greg,
> > > > 
> > > > This change shouldn't be backported to stable@. It is a feature, if
> > > > Mark-PK feels they need it older kernels they need to carry the change
> > > > in their own tree. Or at a minimum they need to explain why this
> > > > change is warranted in stable@.
> > > 
> > > Thanks for your comment.
> > > The reason why we think this should be backported to stable kernel is
> > > that it actually fix the potential race condition when make block
> > > device probe async in stable kernel.
> > > And we'd like to fix this upstream rather than just take it in
> > > our custom tree.
> > 
> > Potential race condition, is this actually able to be hit in real life?
> 
> Yes it hanppened, and it can lead the kernel init process stuck in
> the root wait loop.
> 
> Below is the log.
> (I add 20 seconds delay in mtk_mci probe to quick reproduce it.)
> 
> * Before apply this pactch
> [    0.368594][    T1] device-mapper: init: waiting for all devices to be available before creating mapped devices
> [   21.673047][   T45] probe of 1c660000.mtk-mmc-fcie returned 0 after 21541020 usecs
> [   21.673061][   T45] mtk_mci 1c660000.mtk-mmc-fcie: driver mtk_mci async attach completed: 0
> [   21.680006][    T1] device-mapper: table: 254:0: verity: Data device lookup failed <--------------- start after mtk_mci probe done
> [   21.680012][    T1] device-mapper: ioctl: error adding target to table <--------------------------- won't create /dev/dm-0
> [   21.680067][   T67] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [   21.680184][   T67] bus: 'mmc': __driver_probe_device: matched device mmc0:0001 with driver mmcblk
> [   21.680192][   T67] bus: 'mmc': really_probe: probing driver mmcblk with device mmc0:0001
> [   21.680500][   T67] mmcblk0: mmc0:0001 016G01 14.5 GiB 
> [   21.683404][   T67]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29
> [   21.686152][   T67] mmcblk0boot0: mmc0:0001 016G01 8.00 MiB 
> [   21.687166][   T67] mmcblk0boot1: mmc0:0001 016G01 8.00 MiB 
> [   21.687955][   T67] mmcblk0rpmb: mmc0:0001 016G01 4.00 MiB, chardev (238:0)
> [   21.687977][   T67] driver: 'mmcblk': driver_bound: bound to device 'mmc0:0001'
> [   21.688004][   T67] bus: 'mmc': really_probe: bound device mmc0:0001 to driver mmcblk
> [   21.688010][   T67] probe of mmc0:0001 returned 0 after 7819 usecs
> [   21.688166][    T1] Waiting for root device /dev/dm-0...
> [   41.023192][    T1] driver_probe_done: probe_count = 0
> ... can't exit from the root wait loop
> 
> * After apply this patch and add dm-mod.waitfor="PARTLABEL=rootfs"
> [    0.368417][    T1] device-mapper: init: waiting for all devices to be available before creating mapped devices
> [   21.672749][   T45] probe of 1c660000.mtk-mmc-fcie returned 0 after 21540992 usecs
> [   21.672767][   T45] mtk_mci 1c660000.mtk-mmc-fcie: driver mtk_mci async attach completed: 0
> [   21.672774][    T1] device-mapper: init: waiting for device PARTLABEL=rootfs ...
> [   21.672869][   T43] mtk_mci 1c660000.mtk-mmc-fcie: eMMC: HS400 5.1 200MHz
> [   21.679743][   T43] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [   21.679852][   T43] bus: 'mmc': __driver_probe_device: matched device mmc0:0001 with driver mmcblk
> [   21.679858][   T43] bus: 'mmc': really_probe: probing driver mmcblk with device mmc0:0001
> [   21.680204][   T43] mmcblk0: mmc0:0001 016G01 14.5 GiB 
> [   21.682866][   T43]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29
> [   21.685579][   T43] mmcblk0boot0: mmc0:0001 016G01 8.00 MiB 
> [   21.686631][   T43] mmcblk0boot1: mmc0:0001 016G01 8.00 MiB 
> [   21.687533][   T43] mmcblk0rpmb: mmc0:0001 016G01 4.00 MiB, chardev (238:0)
> [   21.687559][   T43] driver: 'mmcblk': driver_bound: bound to device 'mmc0:0001'
> [   21.687585][   T43] bus: 'mmc': really_probe: bound device mmc0:0001 to driver mmcblk
> [   21.687591][   T43] probe of mmc0:0001 returned 0 after 7732 usecs
> [   21.687838][    T1] device-mapper: init: all devices available <---------------------------------- start after PARTLABEL=rootfs is ready
> [   21.688155][    T1] device-mapper: verity: sha1 using implementation "sha1-generic"
> [   21.688975][    T1] device-mapper: ioctl: dm-0 (dm-verity) is ready
> 

Ok, seems sane, I'll queue this up for 6.1.y and 5.15.y now.

thanks,

greg k-h
