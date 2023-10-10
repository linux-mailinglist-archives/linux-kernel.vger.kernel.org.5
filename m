Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842E27BF988
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjJJLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJJLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:20:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079A0A4;
        Tue, 10 Oct 2023 04:20:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso8487959a12.0;
        Tue, 10 Oct 2023 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696936854; x=1697541654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQsOgeceEIsXhp0lkWDt2Tm0RKONRcHVaKqhgdrpmWA=;
        b=SrwP2Dr+nbYMbywpyMpPVXsAA1CiPs/F+/1HdiuOTSpyxrcnq1dI72tWpnTJ61QFrO
         BSOEG6k8hwpaE59h5fV7OGpU9BH5VUv+T+68zw8k0gySQJVDYA5Ed7IL1GCC+JIc4Q6P
         ZUwjAyxLA5kHO47CHNcO/a/6Y/KQg+RfH87AovJcIHxnRwp8zKGUz/sl7bPkRE00T+Py
         +EeOTRVFcYZtEnzcx/37cv+61E3PVWcJ4MYN8u0RWH7bxzHZtw6Ix/M9WpBTvzvkHho7
         tMfCRtlUDmvwTwN38/qb670gS7Tf3rYd37GuUM1Omw1+CU3+XkoppZSTCE9IOocYbreU
         ta1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936854; x=1697541654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQsOgeceEIsXhp0lkWDt2Tm0RKONRcHVaKqhgdrpmWA=;
        b=CGgmqooMh0q8XLTN+vsjQTY8gH3tT81HZcoYp2zps6qIZDqmQPwmXDhv5LX9vxHCPh
         a0td6doGrFJ401eppygBvzmVIx+VPut3peC/R+cfxli/Db8HdbxKGDDXay1hWEoDXSqp
         6IaMLrJhRkcGI+BCK/OVzogjUtr/r01xgKGQ5/t+g8RV+RQQpvmWArKAcmf57XgRsKxX
         dwaMp7W9zhPv2kTnNJ+/xMYPxxW7hLz2lYHDB9T++D0FTACDidU8jgwZw3NrtdLu/rno
         AZbcXS1Sc9646IHSVh1xUPvwD+J8hk1jTaCJhIjQwpc+G9aDy9dcS3bqZ6moLA7Xfoja
         +IEg==
X-Gm-Message-State: AOJu0YzHgtmh4iYOEG2rKNgTl8QVyCgGcY17nToS1FPGDyZ3cAZjrWLt
        HAvht7bAhkrS6c+1zNor8Ls=
X-Google-Smtp-Source: AGHT+IHQg5XnMxa+WG+1BhKXXbSTRxIr71eh+hShfTQmwO35pOdo02/EP4obh3cA9lf1wm2F7dDO/A==
X-Received: by 2002:a05:6402:5190:b0:534:6b86:eda2 with SMTP id q16-20020a056402519000b005346b86eda2mr10776212edd.21.1696936854308;
        Tue, 10 Oct 2023 04:20:54 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id r14-20020a05640251ce00b0053da777f7d1sm281611edd.10.2023.10.10.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:20:54 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:20:51 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <20231010112051.zgefbx2c3tjneudz@skbuf>
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
 <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
 <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:54:37PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 4f09e7438f3b..09955fdea2ff 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -928,7 +928,8 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  	const struct vsc73xx_counter *cnt;
>  	struct vsc73xx *vsc = ds->priv;
>  	u8 indices[6];
> -	int i, j;
> +	u8 *buf = data;
> +	int i;
>  	u32 val;
>  	int ret;
>  
> @@ -948,10 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  	indices[5] = ((val >> 26) & 0x1f); /* TX counter 2 */
>  
>  	/* The first counters is the RX octets */
> -	j = 0;
> -	strncpy(data + j * ETH_GSTRING_LEN,
> -		"RxEtherStatsOctets", ETH_GSTRING_LEN);
> -	j++;
> +	ethtool_sprintf(&buf, "RxEtherStatsOctets");

Here you don't use "%s", but everywhere else you do. Can't you just pass
the counter name everywhere, without "%s"?

>  
>  	/* Each port supports recording 3 RX counters and 3 TX counters,
>  	 * figure out what counters we use in this set-up and return the
> @@ -962,22 +960,16 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  	for (i = 0; i < 3; i++) {
>  		cnt = vsc73xx_find_counter(vsc, indices[i], false);
>  		if (cnt)
> -			strncpy(data + j * ETH_GSTRING_LEN,
> -				cnt->name, ETH_GSTRING_LEN);
> -		j++;
> +			ethtool_sprintf(&buf, "%s", cnt->name);

The code conversion is not functionally identical, and I think it's a
bit hard to make it identical.

The VSC7395 has 45 port counters, but it seems that it can only monitor
and display 8 of them at a time - 2 fixed and 6 configurable through
some windows.

vsc73xx_get_strings() detects which counter is each window configured
for, based on the value of the CNT_CTRL_CFG hardware register (VSC73XX_C_CFG
in the code). It displays a different string depending on the hardware
value.

The code must deal with the case where vsc73xx_find_counter() returns
NULL, aka the hardware window is configured for a value that vsc73xx_tx_counters[]
and vsc73xx_rx_counters[] don't know about.

Currently, the way that this is treated is by skipping the strncpy()
(and thus leaving an empty string), and incrementing j to get to the
next ethtool counter, and next window.

The order of the strings in vsc73xx_get_strings() needs to be strongly
correlated to the order of the counters from vsc73xx_get_ethtool_stats().
So, the driver would still print counter values for the unknown windows,
it will just not provide a string for them.

In your proposal, the increment of j basically goes into the "if (cnt)"
block because it's embedded within ethtool_sprintf(), which means that
if a hardware counter is unknown, the total number of reported strings
will be less than 8. Which is very problematic, because vsc73xx_get_sset_count()
says that 8 strings are reported. Also, all the counter strings after
the unknown one will be shifted to the left.

I suggest that "if (!cnt)", you should call ethtool_sprintf() with an
empty string, to preserve the original behavior.

>  	}
>  
>  	/* TX stats begins with the number of TX octets */
> -	strncpy(data + j * ETH_GSTRING_LEN,
> -		"TxEtherStatsOctets", ETH_GSTRING_LEN);
> -	j++;
> +	ethtool_sprintf(&buf, "TxEtherStatsOctets");
>  
>  	for (i = 3; i < 6; i++) {
>  		cnt = vsc73xx_find_counter(vsc, indices[i], true);
>  		if (cnt)
> -			strncpy(data + j * ETH_GSTRING_LEN,
> -				cnt->name, ETH_GSTRING_LEN);
> -		j++;
> +			ethtool_sprintf(&buf, "%s", cnt->name);
>  	}
>  }
>  
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-1cfd0ac2d81b
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

