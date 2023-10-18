Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D277CE5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjJRSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjJRSFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5698
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697652270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNX9ozbgtkYe/902nvplA8K4eAYG6mgmEEowb1wlWxM=;
        b=JeKmWKiK4mBIZG3nkVZsq34y5Mon3ClQ2PQweqdVSORM5xDFyagfVq8sIfNymaabvylnIt
        o/v/A481hYjpIQVj9P5ueRsikfBvWGql6Z55+m2Kx0CS4ojb4y0YOeOMW8i2sxiJw2DsRx
        Ta0aKLnSeTosxx4MFDr87/hPqbyTq2Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-KNbde5mMNWGHhNGBuhDZ6w-1; Wed, 18 Oct 2023 14:04:26 -0400
X-MC-Unique: KNbde5mMNWGHhNGBuhDZ6w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d155fc53eso83082286d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652266; x=1698257066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNX9ozbgtkYe/902nvplA8K4eAYG6mgmEEowb1wlWxM=;
        b=O7wC2i8NSbaJTwwrLrJmXipRph/KG8Nbo0+bPaA8mlx8QhMD28QZOfFeUiAmoTL7Lg
         PxuQNBIerp9xZG6FCLZVNVcUsvETuDB+aDZL5NM5PNp9s2hrc5pDKXBop6p2bs4aHAly
         eJ8eHoXX3qyoJubLVM8uuYEG+spWNXZxcR327s+IIM+8VxiUnxev7h3FOx2iHO1Vae0R
         IW1voAebzGxwCsVVY74RbcrCEQrfWd8l6smYQk2gIfqr3shhvoKdDbi5tyFAkr9OqaGW
         iqG8xZ0XB94AVjN7csREt7LUfofMtbshzlfFvJXGDNA7oPSkxAFg9h7nj6APnpzWiYn/
         IlRA==
X-Gm-Message-State: AOJu0YzsD/bKrZWvHp0Lh3TaUniWp4hozy3XV0Fzjyj8GsQct9Q+k0mE
        +gMw5Rk64/6WtQnPfcG+UQ/gKgJuVFaf9NAGQrM6RgTAG6T12hDK097pJYTEIUxRx3LEB6ACf++
        SHwnBvBQvxrVlDFI3dHFO8/9i
X-Received: by 2002:a05:6214:d6f:b0:66d:2eb6:f3f6 with SMTP id 15-20020a0562140d6f00b0066d2eb6f3f6mr6947769qvs.32.1697652266313;
        Wed, 18 Oct 2023 11:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7r9g/qf8M8D2pt4ix0jigNXIfJ7i7p7JdUBou8gXLcKPUUtGgDEa3SJxF8BWKbyqCqnVUHw==
X-Received: by 2002:a05:6214:d6f:b0:66d:2eb6:f3f6 with SMTP id 15-20020a0562140d6f00b0066d2eb6f3f6mr6947734qvs.32.1697652266044;
        Wed, 18 Oct 2023 11:04:26 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p5-20020a0cfd85000000b0065b2f4dd300sm127154qvr.90.2023.10.18.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:04:25 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:04:23 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, vee.khee.wong@linux.intel.com,
        tee.min.tan@intel.com, rmk+kernel@armlinux.org.uk,
        bartosz.golaszewski@linaro.org, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/5] net: stmmac: simplify debug message on
 stmmac_enable()
Message-ID: <vkf6xerp5o7owkvvlbxvd6hkzaj7mml6yutrpaxyowcryh3nlu@qeourmcxk5x3>
References: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v2-1-51d5f56542d7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v2-1-51d5f56542d7@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:09:53AM +0200, Johannes Zink wrote:
> Simplify the netdev_dbg() call in stmmac_enable() in order to reduce code
> duplication. No functional change.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> 
> ---
> 
> Changelog:
> 
> v1 -> v2: no changes
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 1be06b96c35f..f110b91af9bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -203,14 +203,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>  			/* Enable External snapshot trigger */
>  			acr_value |= priv->plat->ext_snapshot_num;
>  			acr_value |= PTP_ACR_ATSFC;
> -			netdev_dbg(priv->dev, "Auxiliary Snapshot %d enabled.\n",
> -				   priv->plat->ext_snapshot_num >>
> -				   PTP_ACR_ATSEN_SHIFT);
> -		} else {
> -			netdev_dbg(priv->dev, "Auxiliary Snapshot %d disabled.\n",
> -				   priv->plat->ext_snapshot_num >>
> -				   PTP_ACR_ATSEN_SHIFT);
>  		}
> +		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
> +			   priv->plat->ext_snapshot_num >> PTP_ACR_ATSEN_SHIFT,
> +			   on ? "enabled" : "disabled");
>  		writel(acr_value, ptpaddr + PTP_ACR);
>  		mutex_unlock(&priv->aux_ts_lock);
>  		/* wait for auxts fifo clear to finish */
> 
> -- 
> 2.39.2
> 

