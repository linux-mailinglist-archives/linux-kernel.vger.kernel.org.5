Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490F57B77E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbjJDGhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbjJDGhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:37:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77757BF;
        Tue,  3 Oct 2023 23:36:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9356EC433C8;
        Wed,  4 Oct 2023 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696401416;
        bh=pa7PlYE1f7PRJnLxkIzhxGZmwYROa1YY5M3fNWKm49w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeDiCfkA6r/wSRXjjzfbJh5Nvt3ZVWZQVDAMOnPgQD2hIP8PL3m85ZEqpwwU6vXHV
         hppiah+BeLZB5G3+T3AF3O6oFt+SgrXxwOP4kQOq9bhL9zAvJAmTLnA4L/U/Ne8xo2
         v4XjZyo75kC7/eKfaj2AjZZY88dg0mfvXIdl5Pcs=
Date:   Wed, 4 Oct 2023 08:36:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Woo-kwang Lee <wookwang.lee@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sj1557.seo@samsung.com
Subject: Re: [PATCH] usb: core: add bos NULL pointer checking condition
Message-ID: <2023100439-king-salute-5cd5@gregkh>
References: <CGME20231004062700epcas1p16fe36bf6b6a6e5d9d4adeaef32937480@epcas1p1.samsung.com>
 <20231004062642.16431-1-wookwang.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004062642.16431-1-wookwang.lee@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:26:42PM +0900, Woo-kwang Lee wrote:
> This issue occurs when connecting Galaxy S22 and abnormal SEC Dex Adapter.
> When the abnormal adapter is connected, kernel panic always occurs after a
> few seconds.
> This occurs due to unable to get BOS descriptor, usb_release_bos_descriptor
> set dev->bos = NULL.
> 
> - usb_reset_and_verify_device
>   - hub_port_init
>   - usb_release_bos_descriptor
>     - dev->bos = NULL;
> 
> hub_port_connect_change() calls portspeed(), and portspeed() calls hub_is_s
> uperspeedplus().
> Finally, hub_is_superspeedplus() calls hdev->bos->ssp_cap.
> It needs to check hdev->bos is NULL to prevent a kernel panic.
> 
> usb 3-1: new SuperSpeed Gen 1 USB device number 16 using xhci-hcd-exynos
> usb 3-1: unable to get BOS descriptor set
> usb 3-1: Product: USB3.0 Hub
> Unable to handle kernel NULL pointer dereference at virtual address 0000018
> 
> Call trace:
>  hub_port_connect_change+0x8c/0x538
>  port_event+0x244/0x764
>  hub_event+0x158/0x474
>  process_one_work+0x204/0x550
>  worker_thread+0x28c/0x580
>  kthread+0x13c/0x178
>  ret_from_fork+0x10/0x30
> 
> - hub_port_connect_change
>   - portspeed
>     - hub_is_superspeedplus
> 
> Fixes: 0cdd49a1d1a4 ("usb: Support USB 3.1 extended port status request")
> Signed-off-by: Woo-kwang Lee <wookwang.lee@samsung.com>
> ---
>  drivers/usb/core/hub.h | 2 ++
>  1 file changed, 2 insertions(+)

Are you sure this isn't already fixed by commit f74a7afc224a ("usb: hub:
Guard against accesses to uninitialized BOS descriptors") in linux-next?

thanks,

greg k-h
