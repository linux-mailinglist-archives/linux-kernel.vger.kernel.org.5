Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1327BAF43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjJEXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjJEXRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:17:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A82134
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:14:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ae65e8eb45so1021698b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696547677; x=1697152477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irJXSE0omX7Ex5LSZzNgKfqZeUDyCk8wvHecGIiPTPc=;
        b=Cs+gUPJ4qQLS5V+jWRjdw5/Dtz7zVJChF5shjDXymHNzsPAd4o6Ql5FRfGr7i2DBAv
         JkIyIeLQnuOUKUiESy0v+Vz7gTVnxYM6RoEEtuWSf98RrWxVK1eQhA5TPWOnrBieTDDj
         zZhPEoVHMgkVS3QEnGLRTBCHsGR/aExiLAMLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547677; x=1697152477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irJXSE0omX7Ex5LSZzNgKfqZeUDyCk8wvHecGIiPTPc=;
        b=MBdL4Q7UK6fcPE2LkhxX+MxOMYV5sNuSv7zBU+dXswCuNmJH3YBawHRJjTeuzVAl0H
         dLUR3Scnh0bwqw0FAd/HmrsLM1pju1NgYiGNrMnmktpj/4uHwiRw4yVmNAUYECACkxx1
         6Ckm7Ueyuy4cwJTECdNr+O2t5HIJ73QXM0G7EVWxip8ZHUdPd1Mrxi3U6ZOJFw7kFqjF
         bHeeCZVX5UncwnE4mjZ1eH8sRMGqNMv1/ib7AtHQuCRj8D4Gl+5/BsnMjoSuOXovpH9P
         XUiUnbQ/7e5as92+X/5+jADO+QLDJ4jSOnXozWizIchsD5xUehF6LqbRLkFaGzJnMV/F
         yHhg==
X-Gm-Message-State: AOJu0YzGOP/JdaN22dYQ11ND68oNKkzsfFl0/Vxe2dczPZxwPdDneNjF
        F/jffrFRlADkD3veZmUVQKLxqA==
X-Google-Smtp-Source: AGHT+IHBOijir4biZsLjBKOWnhShZC2IeLyv1yORJ7HB6ckpE5kbk4Cbl0nN0LtKeofidT5uyC7Sqg==
X-Received: by 2002:a05:6358:8824:b0:143:7d04:36bb with SMTP id hv36-20020a056358882400b001437d0436bbmr6454599rwb.6.1696547677527;
        Thu, 05 Oct 2023 16:14:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090abc8500b0026f4bb8b2casm4138869pjr.6.2023.10.05.16.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:14:36 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:14:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] liquidio: replace deprecated strncpy/strcpy with strscpy
Message-ID: <202310051610.01453F60F@keescook>
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:33:19PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as drvinfo is memset to 0:
> |	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> index 9d56181a301f..d3e07b6ed5e1 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> @@ -442,10 +442,11 @@ lio_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>  	oct = lio->oct_dev;
>  
>  	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));

struct ethtool_drvinfo {
        char    driver[32];
	...
        char    fw_version[ETHTOOL_FWVERS_LEN];
        char    bus_info[ETHTOOL_BUSINFO_LEN];

> -	strcpy(drvinfo->driver, "liquidio");
> +	strscpy(drvinfo->driver, "liquidio", sizeof(drvinfo->driver));

Yup, this is basically what FORTIFY_SOURCE will do automatically to
strcpy().

> -	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> -		ETHTOOL_FWVERS_LEN);
> +	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> +		sizeof(drvinfo->fw_version));

Yup, ETHTOOL_FWVERS_LEN == sizeof(drvinfo->fw_version)

> -	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
> +	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
> +		sizeof(drvinfo->bus_info));

Yup, ETHTOOL_BUSINFO_LEN == sizeof(drvinfo->bus_info)

>  }
>  
>  static void
> @@ -458,10 +459,11 @@ lio_get_vf_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>  	oct = lio->oct_dev;
>  
>  	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
> -	strcpy(drvinfo->driver, "liquidio_vf");
> -	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> -		ETHTOOL_FWVERS_LEN);
> -	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
> +	strscpy(drvinfo->driver, "liquidio_vf", sizeof(drvinfo->driver));
> +	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> +		sizeof(drvinfo->fw_version));
> +	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
> +		sizeof(drvinfo->bus_info));
>  }

Yup, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

>  
>  static int
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-b6932c0f80f1
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
