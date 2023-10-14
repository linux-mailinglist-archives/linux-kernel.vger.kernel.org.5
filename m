Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779D7C92EF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjJNGXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:23:17 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E2BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yFzlpkyvZPpAIoodnzAqzdRSObdnjJuYo39Mj5FNOmQ=;
  b=eXEh3NBJLfWVhwyl2lcUoAdjPzfbpjWCfIF9HQW00x8N1GW1u2LyLc2o
   H0RkghrxGuq/PxCITTFZ0JH2G9fxzFlVX4ZcumAclr9pwm0dE6GgQlIu5
   e6AFw8IUYBjHIAA6B/zia4er/+EEeBCS7an3UL42DTrhVbebr+9O1mKVh
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,224,1694728800"; 
   d="scan'208";a="131207271"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 08:23:12 +0200
Date:   Sat, 14 Oct 2023 08:23:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
cc:     outreachy@lists.linux.dev, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
In-Reply-To: <ZSoxLxs45bIuBrHg@gilbert-PC>
Message-ID: <alpine.DEB.2.22.394.2310140819450.3383@hadrien>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Oct 2023, Gilbert Adikankwu wrote:

> Reported by checkpatch:
>
> WARNING: else is not generally useful after a break or return
>
> The idea of the break statements in the if/else is so that the loop is
> exited immediately the value of status is changed. And returned
> immediately. For if/else conditionals, the block to be executed will
> always be one of the two. Introduce a bool type variable 's_sig' that
> evaluates to true when the value of status is changed within the if/else
> block.

The idea of the checkpatch warning is that eg

found = search();
if (!found)
  break;
else do_something();

is equvalent to:

found = search();
if (!found)
  break;
do_something();

Because now the normal computation is at top level and the if branches are
only used for error handling.

But that is not the case in your code.  In your code, it seems that there
are two cases where one would like to break out of the loop.  The code
would be better left as it is.

julia

>
> Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> ---
>  drivers/staging/qlge/qlge.h     | 1 +
>  drivers/staging/qlge/qlge_mpi.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
> index d0dd659834ee..b846bca82571 100644
> --- a/drivers/staging/qlge/qlge.h
> +++ b/drivers/staging/qlge/qlge.h
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/if_vlan.h>
> +#include <linux/types.h>
>
>  /*
>   * General definitions...
> diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
> index 96a4de6d2b34..44cb879240a0 100644
> --- a/drivers/staging/qlge/qlge_mpi.c
> +++ b/drivers/staging/qlge/qlge_mpi.c
> @@ -909,6 +909,7 @@ int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol)
>  static int qlge_idc_wait(struct qlge_adapter *qdev)
>  {
>  	int status = -ETIMEDOUT;
> +	bool s_sig = false;
>  	struct mbox_params *mbcp = &qdev->idc_mbc;
>  	long wait_time;
>
> @@ -934,14 +935,17 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
>  		} else if (mbcp->mbox_out[0] == AEN_IDC_CMPLT) {
>  			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
>  			status = 0;
> -			break;
> +			s_sig = true;
>  		} else {
>  			netif_err(qdev, drv, qdev->ndev,
>  				  "IDC: Invalid State 0x%.04x.\n",
>  				  mbcp->mbox_out[0]);
>  			status = -EIO;
> -			break;
> +			s_sig = true;
>  		}
> +
> +		if (s_sig)
> +			break;
>  	}
>
>  	return status;
> --
> 2.34.1
>
>
>
