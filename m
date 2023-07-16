Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3A754F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGPPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGPPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB0E5D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689521800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SjKpqR/un+xqnmH4u/xs4cWkynkrba3RxsIKpUmzl5A=;
        b=e4goNhhTIF7jP7Saio+B9w5kryDdEBKXTi8lBWA4wBWRRUGw3NfcEQqh9xcWw1Tb8v5F+4
        Tw+KsrtcXA80xE/Xsducrf+Z1EPX7gzcg8gWwQ/YYSHCxo60YhwVow3fogWErmHmbI+cd5
        bzNTwqPOHKdF/gkz65C8WHEGnwISKy0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-8aE3dtpfOvO2MBFtdIlY6A-1; Sun, 16 Jul 2023 11:36:39 -0400
X-MC-Unique: 8aE3dtpfOvO2MBFtdIlY6A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7679e5ebad2so561706385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689521799; x=1692113799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjKpqR/un+xqnmH4u/xs4cWkynkrba3RxsIKpUmzl5A=;
        b=CQBr+Ks90BZCeUR1aAsQO5fjYLmOwh9Jbj2cpYZK6M2s5J58vy0sJTirLWuOPD2AFh
         dKwhlrRiMQz/paUyt88Vb/7Q3p/J6PUWVvdEhdervrrjTwSrf1t4+atmEElQoEoto3vt
         TxHEeRDG6x7UjYcVBgAtsX03biU33E5bdWjIrVqB9YheYPkLe0M7JZZX7Q44m6FpztX5
         99cxSI9p6BeXEMYLaiZpqQRfOp32eA1MH7Z3i1lP9YUJPkTY7owK+qXKOuy9zjddiWCk
         Pxrtt6DYYiwWikbn5dm4tA1wRvZVOWRmFGFNnydYUjuBA4DI9XjofuUSb+wUjP4rMQ4X
         HJHQ==
X-Gm-Message-State: ABy/qLahv/w3khUGuqOglHy9ySGqNFyneiXD1Bo+pO38aJs6nFGDILqf
        nKRDforQJyZyrOa6a4KBzbD4mlF4gRwke8/fB2s4580CzDv8CZjSfoZQoEhtszmvi+gOra5dvaO
        RqZPz/HhjpNa85p6XlkgXzjs=
X-Received: by 2002:a05:620a:e1b:b0:767:f130:8f8a with SMTP id y27-20020a05620a0e1b00b00767f1308f8amr11678569qkm.49.1689521798779;
        Sun, 16 Jul 2023 08:36:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGf+9RMl8b0IZ7BAM8vVkiIbftoUFL/qQ02Lwshk7jN2Z9DSLREpZmbP00aTzB4D/vKmJjFrA==
X-Received: by 2002:a05:620a:e1b:b0:767:f130:8f8a with SMTP id y27-20020a05620a0e1b00b00767f1308f8amr11678558qkm.49.1689521798519;
        Sun, 16 Jul 2023 08:36:38 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id g7-20020ae9e107000000b0075cd80fde9esm5405203qkm.89.2023.07.16.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 08:36:37 -0700 (PDT)
Date:   Sun, 16 Jul 2023 11:36:36 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Alasdair Kergon <agk@redhat.com>,
        "development, device-mapper" <dm-devel@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yj.chiang@mediatek.com, Peter Korsgaard <peter@korsgaard.com>,
        Mike Snitzer <snitzer@kernel.org>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15] dm init: add dm-mod.waitfor to wait for
 asynchronously probed block devices
Message-ID: <CAH6w=aztzhm3Sa-afN2Xk-7mp1BVtTKNXJ=JyXqJvm3wtEnd3Q@mail.gmail.com>
References: <20230713055841.24815-1-mark-pk.tsai@mediatek.com>
 <2023071603-lustily-defraud-2149@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023071603-lustily-defraud-2149@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023, 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 13, 2023 at 01:58:37PM +0800, Mark-PK Tsai wrote:
> > From: Peter Korsgaard <peter@korsgaard.com>
> > 
> > Just calling wait_for_device_probe() is not enough to ensure that
> > asynchronously probed block devices are available (E.G. mmc, usb), so
> > add a "dm-mod.waitfor=<device1>[,..,<deviceN>]" parameter to get
> > dm-init to explicitly wait for specific block devices before
> > initializing the tables with logic similar to the rootwait logic that
> > was introduced with commit  cc1ed7542c8c ("init: wait for
> > asynchronously scanned block devices").
> > 
> > E.G. with dm-verity on mmc using:
> > dm-mod.waitfor="PARTLABEL=hash-a,PARTLABEL=root-a"
> > 
> > [    0.671671] device-mapper: init: waiting for all devices to be 
> available before creating mapped devices
> > [    0.671679] device-mapper: init: waiting for device PARTLABEL=hash-a 
> ...
> > [    0.710695] mmc0: new HS200 MMC card at address 0001
> > [    0.711158] mmcblk0: mmc0:0001 004GA0 3.69 GiB
> > [    0.715954] mmcblk0boot0: mmc0:0001 004GA0 partition 1 2.00 MiB
> > [    0.722085] mmcblk0boot1: mmc0:0001 004GA0 partition 2 2.00 MiB
> > [    0.728093] mmcblk0rpmb: mmc0:0001 004GA0 partition 3 512 KiB, 
> chardev (249:0)
> > [    0.738274]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
> > [    0.751282] device-mapper: init: waiting for device PARTLABEL=root-a 
> ...
> > [    0.751306] device-mapper: init: all devices available
> > [    0.751683] device-mapper: verity: sha256 using implementation 
> "sha256-generic"
> > [    0.759344] device-mapper: ioctl: dm-0 (vroot) is ready
> > [    0.766540] VFS: Mounted root (squashfs filesystem) readonly on 
> device 254:0.
> > 
> > Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  .../admin-guide/device-mapper/dm-init.rst     |  8 +++++++
> >  drivers/md/dm-init.c                          | 22 ++++++++++++++++++-
> >  2 files changed, 29 insertions(+), 1 deletion(-)
>
> What is the git commit id of this change in Linus's tree?
>
> thanks,
>
> greg k-h
>
>

Hey Greg,

This change shouldn't be backported to stable@. It is a feature, if
Mark-PK feels they need it older kernels they need to carry the change
in their own tree. Or at a minimum they need to explain why this
change is warranted in stable@.

But to answer your original question the upstream commit is:

035641b01e72 dm init: add dm-mod.waitfor to wait for asynchronously probed block devices

Thanks,
Mike

