Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7B7CD4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJRHEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjJRHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:04:11 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD71722
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NWad4ezdKyh7fVlIm7RYq8OCRyT0bSyjdlIaCm1giqw=;
  b=lJ8eLjOkyt075eOOu6aYmoWK+MuD+PtkhmyoeGHj9+66MZqeja+DE+B+
   qiBWWogZQqMePb+86D6gsGbyuUWJKuag3pqa3L6pxZm5iCrHusiAlu7Jo
   KgQLv9R4LOxp6538N0D7oFaMTPxG7oUI90DYqqihSq0dspxzP2XgfA22+
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="131810198"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 09:03:39 +0200
Date:   Wed, 18 Oct 2023 09:03:39 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     kenechukwu maduechesi <maduechesik@gmail.com>
cc:     outreachy@lists.linux.dev, shreeya.patel23498@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
In-Reply-To: <20231018004300.GA3189@ubuntu>
Message-ID: <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
References: <20231018004300.GA3189@ubuntu>
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



On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:

> Replace udelay() with usleep_range() for more precise delay handling.
>
> Reported by checkpatch:
>
> CHECK: usleep_range is preferred over udelay

This message is typically not a good candidate for outreachy patches,
because you need access to the device to be sure that any change is
correct.

julia

>
> Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
> ---
>  drivers/staging/rts5208/sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index 74c4f476b3a4..059f99b0a727 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -865,7 +865,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>  						     PHASE_CHANGE);
>  			if (retval)
>  				return retval;
> -			udelay(50);
> +			usleep_range(50);
>  			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
>  						     PHASE_CHANGE |
>  						     PHASE_NOT_RESET |
> @@ -877,14 +877,14 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>  						     CHANGE_CLK, CHANGE_CLK);
>  			if (retval)
>  				return retval;
> -			udelay(50);
> +			usleep_range(50);
>  			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
>  						     PHASE_NOT_RESET |
>  						     sample_point);
>  			if (retval)
>  				return retval;
>  		}
> -		udelay(100);
> +		usleep_range(100);
>
>  		rtsx_init_cmd(chip);
>  		rtsx_add_cmd(chip, WRITE_REG_CMD, SD_DCMPS_CTL, DCMPS_CHANGE,
> @@ -918,7 +918,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>  				return retval;
>  		}
>
> -		udelay(50);
> +		usleep_range(50);
>  	}
>
>  	retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
> @@ -1416,7 +1416,7 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
>  			retval = STATUS_SUCCESS;
>  			break;
>  		}
> -		udelay(100);
> +		usleep_range(100);
>  	}
>  	dev_dbg(rtsx_dev(chip), "SD_DATA_STATE: 0x%02x\n", val);
>
> --
> 2.25.1
>
>
>
