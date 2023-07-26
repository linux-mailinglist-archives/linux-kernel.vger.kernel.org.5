Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6795763F83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGZT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGZT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2895212D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690399572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkdPaek5f1FanK35487dKzMjIw8QbmtgDnYh28e2FyU=;
        b=TN60DIw7jcAsKKx3ya647BKjifOVx9Gx8ii2Wh+oXXqsVGm1F4/Qsap1HWMX5IVE6k9DGO
        8Tw6Lm/lFbewJf2RTOh4y0KzdRZNS2NHiEqzfaw47XhnohWnPX4AbQt5S6WYtDaa/uR7XT
        e6aOCEpi9L7Z9sTf3gXi6n+eWdq36Bk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ui-v-OOrN4CxmJ9OX9G4Wg-1; Wed, 26 Jul 2023 15:26:10 -0400
X-MC-Unique: ui-v-OOrN4CxmJ9OX9G4Wg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98e1085308eso141533766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399569; x=1691004369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkdPaek5f1FanK35487dKzMjIw8QbmtgDnYh28e2FyU=;
        b=Mxg6aMV0lvLx1AGRmHLJd1AdjzVb99N7C0mZIbuu65VMxb+soJk1hAs+Gh3aWZoa9L
         uYUM9Ysm0rJQwDH2j7JzrDH9gkBrfAWo0QIMTD6NgaKsY3ebLNJ9p+MuoLGJhQlOTkXu
         TlB9sRyxcYcR+yDNOf31FxlshbYEVuc9+6i3g7aukj61pNQhtOMFkaEe02da9Kpg4/EI
         B63VzeOGJ7o8/VIbfGe+cZP1VlB+StyYs9VYo9yYIOFwt9d00Mv0gppSKcQHvoGknVMp
         sXn3WWHFPIlJ0lrcx54HMFkMBG/c+YtzRQzDhHFlQZFkCpcDHzpl7t73L7WT2bY362/F
         xPaQ==
X-Gm-Message-State: ABy/qLYihT0JNpc1LkAm+2AVXQNUkkX3Xfgpojp2JdkutnlaR0FZ1kLc
        85hVSLM2rBicOJjnp7sh0b4J9OHBnSqhI9ji0LdR3Vpzi+Sw+UNXseAeyZrzycp66mf9d3bDc8W
        oOjNRhM5hfvt59mWd3bsJZyBd
X-Received: by 2002:a17:906:7a1a:b0:98f:8481:24b3 with SMTP id d26-20020a1709067a1a00b0098f848124b3mr10144ejo.37.1690399569535;
        Wed, 26 Jul 2023 12:26:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1DJIMjJPX08OnwgjVJDKrkbXm/nIe3Nj2diSzSRP5PXQM82cX2dmpXgUNgZAmCrFVe02K0w==
X-Received: by 2002:a17:906:7a1a:b0:98f:8481:24b3 with SMTP id d26-20020a1709067a1a00b0098f848124b3mr10130ejo.37.1690399569230;
        Wed, 26 Jul 2023 12:26:09 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id se10-20020a170906ce4a00b0098dfec235ccsm9894085ejb.47.2023.07.26.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:26:06 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:26:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Saeed Mahameed <saeedm@nvidia.com>, stable@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230726152258-mutt-send-email-mst@kernel.org>
References: <20230726190744.14143-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726190744.14143-1-dtatulea@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea wrote:
> The ndev was accessed on shutdown without a check if it actually exists.
> This triggered the crash pasted below. This patch simply adds a check
> before using ndev.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000300
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP
>  CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-rc2_for_upstream_min_debug_2023_07_17_15_05 #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
>  RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
>  RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 0000000000000017
>  RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff888109d28000
>  RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 0000000000000001
>  R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109d28000
>  R13: ffff888109d28080 R14: 00000000fee1dead R15: 0000000000000000
>  FS:  00007f4969e0be40(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 0000000000370eb0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x60
>   ? page_fault_oops+0x14c/0x3c0
>   ? exc_page_fault+0x75/0x140
>   ? asm_exc_page_fault+0x22/0x30
>   ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
>   device_shutdown+0x13e/0x1e0
>   kernel_restart+0x36/0x90
>   __do_sys_reboot+0x141/0x210
>   ? vfs_writev+0xcd/0x140
>   ? handle_mm_fault+0x161/0x260
>   ? do_writev+0x6b/0x110
>   do_syscall_64+0x3d/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  RIP: 0033:0x7f496990fb56
>  RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496990fb56
>  RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
>  RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>  R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc7bde2b8
>   </TASK>
>  CR2: 0000000000000300
>  ---[ end trace 0000000000000000 ]---
> 
> Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassing")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9138ef2fb2c8..e2e7ebd71798 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct auxiliary_device *auxdev)
>  	mgtdev = auxiliary_get_drvdata(auxdev);
>  	ndev = mgtdev->ndev;
>  
> -	free_irqs(ndev);
> +	if (ndev)
> +		free_irqs(ndev);
>  }
>  

something I don't get:
irqs are allocated in mlx5_vdpa_dev_add
why are they not freed in mlx5_vdpa_dev_del?

this is what's creating all this mess.



>  static const struct auxiliary_device_id mlx5v_id_table[] = {
> -- 
> 2.41.0

