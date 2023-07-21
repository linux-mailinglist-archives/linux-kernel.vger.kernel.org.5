Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B531F75C580
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGULJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjGULID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5D30E6;
        Fri, 21 Jul 2023 04:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 859B1619D9;
        Fri, 21 Jul 2023 11:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A693C433C8;
        Fri, 21 Jul 2023 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689937471;
        bh=kLm2U5Pu52hMweuu3JvWp8RIyfl+fqT5TzNBsbBd25s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shPjxjQ5wh01SrsoFazMqcBR5iqM2AIV0qD4B/HKYJJToU2dCiKnberYbH0U5d+qk
         cUKnz2ERJRFo/ZMCV+Uj+8g7R+lHMMJZl1QeFsLddUu3qeBVBwQ8snFMQKjCbLdyCB
         cFEiD2vSZjAQ6+0HZHqmUIBXfBYCcRoDu1Nbc+p8=
Date:   Fri, 21 Jul 2023 13:04:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dingyan Li <18500469033@163.com>
Cc:     stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Message-ID: <2023072105-lethargic-saddling-ad97@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721084039.9728-1-18500469033@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:40:39PM +0800, Dingyan Li wrote:
> The usbfs interface does not provide any way to get specific
> superspeedplus rate, like Gen2x1, Gen1x2 or Gen2x2. Current
> API include an USBDEVFS_GET_SPEED ioctl, but it can only return
> general superspeedplus speed instead of any specific rates.
> Therefore we can't tell whether it's a Gen2x2(20Gbps) device.
> 
> This patch introduce a new ioctl USBDEVFS_GET_SSP_RATE to fix
> it. Similar information is already available via sysfs, it's
> good to add it for usbfs too.
> 
> Signed-off-by: Dingyan Li <18500469033@163.com>
> ---
>  drivers/usb/core/devio.c          | 3 +++
>  include/uapi/linux/usbdevice_fs.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 1a16a8bdea60..2f57eb163360 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -2783,6 +2783,9 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  	case USBDEVFS_GET_SPEED:
>  		ret = ps->dev->speed;
>  		break;
> +	case USBDEVFS_GET_SSP_RATE:
> +		ret = ps->dev->ssp_rate;
> +		break;

Shouldn't this new ioctl be documented somewhere?  What are the valid
values it can return?  What if it in't a superspeed device?  Who is
going to use this?

And we have traditionally only been adding new information like this to
sysfs, which was not around when usbfs was created.  Why not just use
that instead?  Are you wanting to see all of the sysfs-provided
information in usbfs also?

thanks,

greg k-h
