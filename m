Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3D77D4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbjHOVHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbjHOVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F8A1B2;
        Tue, 15 Aug 2023 14:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE7D659BB;
        Tue, 15 Aug 2023 21:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D912AC433CA;
        Tue, 15 Aug 2023 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692133625;
        bh=aUjeA8TDXxec5uQfQ22Hm9VJ5mfTMfSZTvWkNRoYaHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C24SITg5PXu6rhloJjEou7wk7y6Jt2ocA9i7owyx947HN1EhagcPg5cvRhPuLcAw2
         FyHeKqt21GrTNg9pxMgzUFJ/7/Abt4tg0NfMGFV6stw+Aq+n44sUMxE/eyKZpwo+ri
         JpDm7d/H54/gj8j9ARNnZ3hLy/px/Lg127Pt7gbA=
Date:   Tue, 15 Aug 2023 23:07:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     richard.leitner@linux.dev, wsa+renesas@sang-engineering.com,
        mhocko@suse.com, surenb@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] drivers: usb: Removes use of assignment in if
 condition
Message-ID: <2023081550-absurd-sprint-65e5@gregkh>
References: <20230815204141.51972-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815204141.51972-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:11:41AM +0530, Atul Kumar Pant wrote:
> This patch fixes following checkpatch.pl issue:
> ERROR: do not use assignment in if condition
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/usb/core/devio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index e501a03d6c70..56899fed6bd4 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -2333,9 +2333,10 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
>  		}
>  	}
>  
> +	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
>  	if (ps->dev->state != USB_STATE_CONFIGURED)
>  		retval = -EHOSTUNREACH;
> -	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
> +	else if (!intf)

Did you mean to change the logic here by doing the calculation always?
Does that change functionality?

The existing code is fine, running checkpatch on code outside of
drivers/staging/ or on new patches you are writing, is generally
discouraged as the code usually is older than checkpatch is :)

thanks,

greg k-h
