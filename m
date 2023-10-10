Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5817C444D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjJJWiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjJJWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:38:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A2B91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:38:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a25040faffso280460939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977487; x=1697582287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zNGcN7ioUMQHb8bk2NzBsCzcqOrQO1iAEOkrmKrYXM=;
        b=E7BMPnEqbUnReC5NX/8rBBtNufSYSsYSDLZMigLvdwKu5awAcfe3FLG5nAv72nMnOq
         UIy9GuEqrDS8/WWF2Zc87atJ8TAkNhVCJYjE545VR5KmSzs+kfvS0TUo9GBKucoabuxR
         /0Alc4vScDhECR+jxEnqYu48DMNy7cvr2jqh7h+3gcS1nMetD3Gq3nT/+Qh6pv5bRul9
         OH9LxZkQm8O+z+48OplUlpvRgMXPL0sqSH0RFziil3xFq4brt97tsTMu1wt7kP+xZpTr
         UyX2ak0K63ybJnsreMBDDdTiePggWDNdw4JUok4yfdsRmi0bjJ4I2zYX0RS+Lqnbeeys
         9MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977487; x=1697582287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zNGcN7ioUMQHb8bk2NzBsCzcqOrQO1iAEOkrmKrYXM=;
        b=DiReJHYp0BTFGVsLVoMx5VqYs5Rg20aYa4gx6ymogkgHW7EkEQu1YqKwNve9rr+yaC
         kCeavkItrwbOPOrrPtJ5xXvJBWCMnTP63U9eetHqT30GcPbafeADkALA9sjW+y3kcmN6
         gOf6cpcJTTX9mfbo7xFvxwc+GDq4zVzpylsOcmS275BUAdQWVH3rnx3GUjLFNf5eYGHe
         WgLNLP4mEnpUB3nJIsSotIv9oyXcoD55vjyqV6+e1oWU6PaCOtaJUGZAdMh4GB/+eaip
         HVcE8ovO4poc+ohZjnfyqLNRYzizodIPkKEteKB7YRCFANXuR0hTETVaZnA7Vq1XI4hz
         ocFg==
X-Gm-Message-State: AOJu0YyywTP9b3eRdLU5zotiW+rAruOGfMIPjyqFPyoOeEmxYKMRH/qk
        48wCj3+8PXEbUvt8hgcPRBtrZw==
X-Google-Smtp-Source: AGHT+IF6Um4LnbDBI26Vqf3dh+kOKLT+6rSoMobUgThSalliqR7ZTUfixHvuAF0JcRuwo3IeNTy0Iw==
X-Received: by 2002:a5d:8059:0:b0:791:385c:f8b0 with SMTP id b25-20020a5d8059000000b00791385cf8b0mr22710127ior.3.1696977486725;
        Tue, 10 Oct 2023 15:38:06 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id g8-20020a02cd08000000b00445630238cfsm3054749jaq.48.2023.10.10.15.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:38:06 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:38:03 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i40e: use scnprintf over strncpy+strncat
Message-ID: <20231010223803.idmaw2sskmzj4d3e@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:53:00PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> Moreover, `strncat` shouldn't really be used either as per
> fortify-string.h:
>  * Do not use this function. While FORTIFY_SOURCE tries to avoid
>  * read and write overflows, this is only possible when the sizes
>  * of @p and @q are known to the compiler. Prefer building the
>  * string with formatting, via scnprintf() or similar.
>
> Instead, use `scnprintf` with "%s%s" format string. This code is now
> more readable and robust.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index 0e72abd178ae..ec25e4be250f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -438,10 +438,9 @@ int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash)
>  		char profile_name[sizeof(I40E_DDP_PROFILE_PATH)
>  				  + I40E_DDP_PROFILE_NAME_MAX];
>
> -		profile_name[sizeof(profile_name) - 1] = 0;
> -		strncpy(profile_name, I40E_DDP_PROFILE_PATH,
> -			sizeof(profile_name) - 1);
> -		strncat(profile_name, flash->data, I40E_DDP_PROFILE_NAME_MAX);
> +		scnprintf(profile_name, sizeof(profile_name), "%s%s",
> +			  I40E_DDP_PROFILE_PATH, flash->data);
> +
>  		/* Load DDP recipe. */
>  		status = request_firmware(&ddp_config, profile_name,
>  					  &netdev->dev);
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-dd7f20b7ed5d
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
