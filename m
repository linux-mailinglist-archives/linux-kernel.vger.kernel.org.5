Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB175C587
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjGULJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGULJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DB4219;
        Fri, 21 Jul 2023 04:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDEBF60B9B;
        Fri, 21 Jul 2023 11:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC18C433C7;
        Fri, 21 Jul 2023 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689937700;
        bh=O2L5ATkGkLFIMmq2P5x7QrJjHGdRqU2IoeObSb6RXw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpnNjS2O2aUjx3NTlmIMzpGUwWKqZUsmgIMQLzJa7Eb674JXQBemkluAL1TSzIYtZ
         682EAHb08U2/Q9v7drEG+2xTv5hQY7h3pcCSTajoyFBObDJZnpD5hiJOLvCd8Gxf+P
         1ZbrJKwYm46CwQMCYNOMcijW6AI2w2CUt9P+JNZE=
Date:   Fri, 21 Jul 2023 13:08:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:bugfix a controller halt error
Message-ID: <2023072153-module-wannabe-5637@gregkh>
References: <20230721100015.27124-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721100015.27124-1-liulongfang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
> On systems that use ECC memory. The ECC error of the memory will
> cause the USB controller to halt. It causes the usb_control_msg()
> operation to fail.

Why does ECC memory matter here?

> At this point, the returned buffer data is an abnormal value, and
> continuing to use it will lead to incorrect results.
> 
> Therefore, it is necessary to judge the return value and exit.
> 
> Signed-off-by: liulongfang <liulongfang@huawei.com>
> ---
>  drivers/usb/core/hub.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a739403a9e45..6a43198be263 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4891,6 +4891,16 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  					USB_DT_DEVICE << 8, 0,
>  					buf, GET_DESCRIPTOR_BUFSIZE,
>  					initial_descriptor_timeout);
> +				/* On systems that use ECC memory, ECC errors can
> +				 * cause the USB controller to halt.
> +				 * It causes this operation to fail. At this time,
> +				 * the buf data is an abnormal value and needs to be exited.
> +				 */
> +				if (r < 0) {
> +					kfree(buf);
> +					goto fail;
> +				}

Are you sure this is correct?  How was this tested?  Seems to me that
this will still return "success" if this code path ever happens, what am
I missing?

thanks,

greg k-h
