Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29F7D01AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJSSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJSSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:34:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7117CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:34:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE12C433C7;
        Thu, 19 Oct 2023 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697740485;
        bh=TKx6dkVqJNWINz/u+c4Dwx5bP37eMI5QshzqdkWaob0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNLrX2w8Af8RLacMF4aHM8lfEw6I6mMCGNgrF5xpUFD9s5W1SKIhxknAbl+KmbMoS
         kn8sGiSwq+FRXfOuPZWFN/mz51WX/PBQwN5KT2w2gPb4Qm3nOfhfSn+gXdpPkBpeoJ
         YGIuS8X0oH+/022HGDuWhu9W03XaWK4GBhbZFypo=
Date:   Thu, 19 Oct 2023 20:34:41 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>
Cc:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <josejavier.rodriguez@duagon.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>
Subject: Re: [RESEND PATCH 1/1] mcb: fix error handling for different
 scenarios when parsing
Message-ID: <2023101912-unloaded-escalate-1060@gregkh>
References: <20231019141434.57971-1-jorge.sanjuangarcia@duagon.com>
 <20231019141434.57971-2-jorge.sanjuangarcia@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019141434.57971-2-jorge.sanjuangarcia@duagon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:15:34PM +0000, Sanjuán García, Jorge wrote:
> chameleon_parse_gdd() may fail for different reasons and end up
> in the err tag. Make sure we at least always free the mcb_device
> allocated with mcb_alloc_dev().
> 
> If mcb_device_register() fails, make sure to give up the reference
> in the same place the device was added.
> 
> Fixes: 728ac3389296 ("mcb: mcb-parse: fix error handing in chameleon_parse_gdd()")
> Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> ---
>  drivers/mcb/mcb-core.c  | 1 +
>  drivers/mcb/mcb-parse.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
> index 2f23b9c3b751..f797d078978f 100644
> --- a/drivers/mcb/mcb-core.c
> +++ b/drivers/mcb/mcb-core.c
> @@ -247,6 +247,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
>  	return 0;
>  
>  out:
> +	put_device(&dev->dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
> index 656b6b71c768..1ae37e693de0 100644
> --- a/drivers/mcb/mcb-parse.c
> +++ b/drivers/mcb/mcb-parse.c
> @@ -106,7 +106,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
>  	return 0;
>  
>  err:
> -	put_device(&mdev->dev);
> +	mcb_free_dev(mdev);
>  
>  	return ret;
>  }
> -- 
> 2.34.1


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
