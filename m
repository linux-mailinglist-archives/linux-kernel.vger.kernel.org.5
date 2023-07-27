Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFC7658A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjG0Q3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjG0Q3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE6272C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690475322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toVBVAz1OxBBYx0VbDRCYiafp7ZNjBpmo+lGlr0R1k8=;
        b=Zw6z5W1nRg3QruyZDvBIe+FhKROTr58frW06ZmnwsNU5AW0TjDGapESyU0gPOOR3NmbCh8
        4q1KSx1e1uTgqstzxrSorO4j8Th7nHOz51MnxJdAa7m+2owuDz1Jr/lU8K9duiBNaPAQZW
        Q9TyC6F0CE2s+8fvtCd5X7+Sp4StHIc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-GVMIv20GPKeNZJQQ6vh4Hw-1; Thu, 27 Jul 2023 12:28:41 -0400
X-MC-Unique: GVMIv20GPKeNZJQQ6vh4Hw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcfdaaa52so68752666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475320; x=1691080120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toVBVAz1OxBBYx0VbDRCYiafp7ZNjBpmo+lGlr0R1k8=;
        b=N9Df+7ZDr1lgwYjRw5NEF3uC3C8K+DBhZFLvjed9GkFBNGSDiJAlXQeo9UTR0BimB4
         NFaHutcagoQe2cxW+yW4XX5K582c9mFT1ZqTtM8drCSlmuC7B8/LOge9tg+uzDLkzNw9
         92Kn/ABIyhRXreVbf74X3w623eIMhElggj5Ina+nyuPCO75vEeLHQ5w+ISv/boxQEGKY
         vi4Z8LWv34L0XiZWcR+osUOkyhrgxANBdb3gLVwpJj+yxSEv0HF+DP0BuHg2ccN+aaJT
         mf1i4SFml3JkdEDK7XJn7uEh7XikdYp0DE/tjgUHkMmbLX3/2ZkdOYhk4PEz8dtiB6QW
         NmVw==
X-Gm-Message-State: ABy/qLbImvjKbWtK88AHj5WuK7wj/R0+5FOAUAfkpklKTgyATdBbXmJU
        lDoFtZVbYLaDqDvKaNK8T3A7fqkBxSd1XVYjSO+KUC09lhc1e103sKY3tRRWnKjgbg0gl74IWcS
        wg29OFJGEAN2jDIojar4iCkOT
X-Received: by 2002:a17:906:32cb:b0:993:f4cd:34b3 with SMTP id k11-20020a17090632cb00b00993f4cd34b3mr2293547ejk.43.1690475320096;
        Thu, 27 Jul 2023 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3YtxPETqtKUOx9JfM+KLOVBhceIZLv/6TmR6aB0iePf58cstzHPz933BmmCnfiJO30ff4Wg==
X-Received: by 2002:a17:906:32cb:b0:993:f4cd:34b3 with SMTP id k11-20020a17090632cb00b00993f4cd34b3mr2293528ejk.43.1690475319784;
        Thu, 27 Jul 2023 09:28:39 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id lz7-20020a170906fb0700b0099b6b8a0d04sm955404ejb.157.2023.07.27.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:28:39 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:28:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230727122633-mutt-send-email-mst@kernel.org>
References: <20230726190744.14143-1-dtatulea@nvidia.com>
 <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:02:16PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-07-26 at 15:26 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea wrote:
> > > The ndev was accessed on shutdown without a check if it actually exists.
> > > This triggered the crash pasted below. This patch simply adds a check
> > > before using ndev.
> > > 
> > >  BUG: kernel NULL pointer dereference, address: 0000000000000300
> > >  #PF: supervisor read access in kernel mode
> > >  #PF: error_code(0x0000) - not-present page
> > >  PGD 0 P4D 0
> > >  Oops: 0000 [#1] SMP
> > >  CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-
> > > rc2_for_upstream_min_debug_2023_07_17_15_05 #1
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-
> > > gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > >  RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > >  RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
> > >  RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 0000000000000017
> > >  RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff888109d28000
> > >  RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 0000000000000001
> > >  R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109d28000
> > >  R13: ffff888109d28080 R14: 00000000fee1dead R15: 0000000000000000
> > >  FS:  00007f4969e0be40(0000) GS:ffff88852c800000(0000)
> > > knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 0000000000370eb0
> > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >  Call Trace:
> > >   <TASK>
> > >   ? __die+0x20/0x60
> > >   ? page_fault_oops+0x14c/0x3c0
> > >   ? exc_page_fault+0x75/0x140
> > >   ? asm_exc_page_fault+0x22/0x30
> > >   ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > >   device_shutdown+0x13e/0x1e0
> > >   kernel_restart+0x36/0x90
> > >   __do_sys_reboot+0x141/0x210
> > >   ? vfs_writev+0xcd/0x140
> > >   ? handle_mm_fault+0x161/0x260
> > >   ? do_writev+0x6b/0x110
> > >   do_syscall_64+0x3d/0x90
> > >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > >  RIP: 0033:0x7f496990fb56
> > >  RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
> > >  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496990fb56
> > >  RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
> > >  RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 0000000000000000
> > >  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> > >  R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc7bde2b8
> > >   </TASK>
> > >  CR2: 0000000000000300
> > >  ---[ end trace 0000000000000000 ]---
> > > 
> > > Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassing")
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 9138ef2fb2c8..e2e7ebd71798 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct auxiliary_device
> > > *auxdev)
> > >         mgtdev = auxiliary_get_drvdata(auxdev);
> > >         ndev = mgtdev->ndev;
> > >  
> > > -       free_irqs(ndev);
> > > +       if (ndev)
> > > +               free_irqs(ndev);
> > >  }
> > >  
> > 
> > something I don't get:
> > irqs are allocated in mlx5_vdpa_dev_add
> > why are they not freed in mlx5_vdpa_dev_del?
> > 
> That is a good point. I will try to find out. I also don't get why free_irq is
> called in the vdpa dev .free op instead of mlx5_vdpa_dev_del. Maybe I can change
> that in a different refactoring.

as it is I have no idea whether e.g. ndev can change
between these two call sites. that would make the check
pointless.

> > this is what's creating all this mess.
> > 
> > 
> Not quite: mlx5_vdpa_dev_del (which is a .dev_del of for struct
> vdpa_mgmtdev_ops) doesn't get called on shutdown. At least that's what I see. Or
> am I missing something?

and why do we care whether irqs are freed on shutdown?

> > >  static const struct auxiliary_device_id mlx5v_id_table[] = {
> > > -- 
> > > 2.41.0
> > 
> 

