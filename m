Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1077E410
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbjHPOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjHPOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24F26A1;
        Wed, 16 Aug 2023 07:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80331669F0;
        Wed, 16 Aug 2023 14:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4C7C433C8;
        Wed, 16 Aug 2023 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692197064;
        bh=1NidlwFCJWKusvTUSHmHRXSv81J7kyryItSRczc7avY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8QXI+i3/stTnXhxTaGbK1QPzNo5mrGlWmp+xV7H1zAE8YsIgWaC69aKaAikyhGH+
         Enu3HQN5TyTAC5YUts1cdRRbbzDWh/2LhsvscfPo1z4PkiyFv5TOJM97Ue4GAgRS/K
         7M4TCJmzXSyC0M768eZlCSnS6wp9so7iUA3agHr0=
Date:   Wed, 16 Aug 2023 16:44:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Add IS_ERR_OR_NULL check for
 port->partner
Message-ID: <2023081611-utility-mankind-4f58@gregkh>
References: <20230816083051.132480-1-hhhuuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816083051.132480-1-hhhuuu@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:30:51AM +0000, Jimmy Hu wrote:
> port->partner may be an error or NULL. This will cause a NULL pointer
> dereference as below.
> 
> [91222.095236][  T319] typec port0: failed to register partner (-17)
> ...
> [91225.061491][  T319] Unable to handle kernel NULL pointer dereference
> at virtual address 000000000000039f
> [91225.274642][  T319] pc : tcpm_pd_data_request+0x310/0x13fc
> [91225.274646][  T319] lr : tcpm_pd_data_request+0x298/0x13fc
> [91225.308067][  T319] Call trace:
> [91225.308070][  T319]  tcpm_pd_data_request+0x310/0x13fc
> [91225.308073][  T319]  tcpm_pd_rx_handler+0x100/0x9e8
> [91225.355900][  T319]  kthread_worker_fn+0x178/0x58c
> [91225.355902][  T319]  kthread+0x150/0x200
> [91225.355905][  T319]  ret_from_fork+0x10/0x30
> 
> Add a check for port->partner to avoid dereferencing a NULL pointer.
> 
> Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5639b9a1e0bf..ca9b1f3a38bc 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1625,6 +1625,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (PD_VDO_VID(p[0]) != USB_SID_PD)
>  				break;
>  
> +			if (IS_ERR_OR_NULL(port->partner))
> +				break;
> +
>  			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
>  				typec_partner_set_svdm_version(port->partner,
>  							       PD_VDO_SVDM_VER(p[0]));
> -- 
> 2.41.0.694.ge786442a9b-goog
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
