Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8316D805B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjLEReD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbjLERd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:33:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1388D50
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:34:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F253C433A9;
        Tue,  5 Dec 2023 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701797645;
        bh=jgbfGbZsBewA51hOqnV3bW8oStFg/dIzf/WIRR7nJ1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ed+fczkAv4EknCnLYlOvj2wiiJNrkWIgDfUzHEIAZG7ya5RsdMc0xMe9jBzcbl3du
         oJPL8B8kemEQcMD2/WjDoIsiepE51ryxa7bVvouNiqx9q/k1uH+Vg0OpYQaSSDC3mF
         buifRcZXf4IqzZszVKuUicz6PTYPipl34IyydYzM=
Date:   Wed, 6 Dec 2023 02:33:58 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     benjamin.tissoires@redhat.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@keeping.me.uk, lee@kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: fix report descriptor allocation
Message-ID: <2023120650-scroll-studio-1083@gregkh>
References: <20231205085404.175-1-aladyshev22@gmail.com>
 <20231205085404.175-2-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205085404.175-2-aladyshev22@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 11:54:03AM +0300, Konstantin Aladyshev wrote:
> The commit "usb: gadget: f_hid: fix f_hidg lifetime vs cdev"
> (89ff3dfac604614287ad5aad9370c3f984ea3f4b) has introduced a bug
> that leads to hid device corruption after the replug operation.

Nit, this should be written as
	89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
right?

> Reverse device managed memory allocation for the report descriptor
> to fix the issue.
> 
> Tested:
> This change was tested on the AMD EthanolX CRB server with the BMC
> based on the OpenBMC distribution. The BMC provides KVM functionality
> via the USB gadget device:
> - before: KVM page refresh results in a broken USB device,
> - after: KVM page refresh works without any issues.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

We need a Fixes: tag here and also a cc: stable so that this gets
properly backported.

> ---
>  drivers/usb/gadget/function/f_hid.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index ea85e2c701a1..3c8a9dd585c0 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -92,6 +92,7 @@ static void hidg_release(struct device *dev)
>  {
>  	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
>  
> +	kfree(hidg->report_desc);
>  	kfree(hidg->set_report_buf);
>  	kfree(hidg);
>  }
> @@ -1287,9 +1288,9 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>  	hidg->report_length = opts->report_length;
>  	hidg->report_desc_length = opts->report_desc_length;
>  	if (opts->report_desc) {
> -		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
> -						 opts->report_desc_length,
> -						 GFP_KERNEL);
> +		hidg->report_desc = kmemdup(opts->report_desc,
> +					    opts->report_desc_length,
> +					    GFP_KERNEL);

Yet one more reason why devm_*() functions are dangerous to use :(

Nice fix.

thanks,

greg k-h
