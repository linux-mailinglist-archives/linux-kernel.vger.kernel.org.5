Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CC7C4381
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJJWKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjJJWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:10:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B498;
        Tue, 10 Oct 2023 15:10:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso657505a12.0;
        Tue, 10 Oct 2023 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975834; x=1697580634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeAgAoGuacPUndTYsrbXZvSuEm/6HwNwZXCSR8W2lS0=;
        b=IviyG/bGjJPyPNhyVEBb4rjn4TKuCo0Rk5eaw5qlJWvB7aNMHJmoE4cKyoP9TzqKf0
         47+zKEGxy8McpDzRd8cKbPvYaZXc2JClbu2zFaV+Tk3VZa5yo/UhEx3PZW1ie/069cYt
         cj+FYrTi4PFtpPOO+TDeCe+ot5LdVZto9V5dAuEr7Ia2GM/8CuKApk7Pq8dVAk5Z/L72
         fs2PD89hW7qNDPYT9hiW7Z63U7FN1EBrdE/aw1DgAL7MdOSmz3xN43cYoAlVGMz1DS0i
         F5Cd5SnfqndaNA2u7SQ0q0d9k0E6QbLe1//o+U+i32s7o3EF3SCq0GnshGvmLN5IhUyL
         7GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975834; x=1697580634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeAgAoGuacPUndTYsrbXZvSuEm/6HwNwZXCSR8W2lS0=;
        b=j0Gu2NfjvUl2AauUzaIf+8+C+iLPojmnsKuxrOyzNvLo3lLjiVcx++dXRaFKa63ysZ
         kRlULBJO5UhyzQ9geJOt7v8wPo/UfvDoO8HzagCB39rLeVjx2Qn4MbvKsOpHbsTgsu2b
         0U2/eolQVwG48xTtXMCcH7kXOQAQUIJy/LjwXEL1Pvreg+Rr5MTX9Vlgol5WvtMXWl6q
         gowHEQ56+7XjZ6MueV0MXUmPEyK5LgyKtdCSxe4gwnZIeusQIVJHRsXt0bDQn7u7urkb
         tsNEfZz2nq3il/KaabZRZ3yvBd4Co8bXUnudkcyDE9fYUNlhn4eo9MRE9JMvfTIUh/Z7
         CHdw==
X-Gm-Message-State: AOJu0YwDuBVoTgk/vIcSY6ZmxpzFjCHnXumR5b/naKU91UmgA7ALmz80
        3S1j7feEaTLTnD2v6tmuVfWijItmY5Y/Uw==
X-Google-Smtp-Source: AGHT+IErL1oAkp/52wDnHDYZusiMXPM+2eJUJLtoD9cJU9QrTsjGv1SbDOb+bwCWomjqgR+uOekBHQ==
X-Received: by 2002:a05:6402:2708:b0:52c:f73:3567 with SMTP id y8-20020a056402270800b0052c0f733567mr13346094edd.13.1696975833819;
        Tue, 10 Oct 2023 15:10:33 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id bf14-20020a0564021a4e00b005362bcc089csm7962307edb.67.2023.10.10.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:10:33 -0700 (PDT)
Date:   Wed, 11 Oct 2023 01:10:31 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <20231010221031.vnp2nf6rbjueitvf@skbuf>
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:47:37PM +0000, Justin Stitt wrote:
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
>  drivers/net/dsa/realtek/rtl8366-core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realtek/rtl8366-core.c
> index dc5f75be3017..b13766a3acbb 100644
> --- a/drivers/net/dsa/realtek/rtl8366-core.c
> +++ b/drivers/net/dsa/realtek/rtl8366-core.c
> @@ -395,16 +395,13 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  			 uint8_t *data)
>  {
>  	struct realtek_priv *priv = ds->priv;
> -	struct rtl8366_mib_counter *mib;
>  	int i;
>  
>  	if (port >= priv->num_ports)
>  		return;
>  
>  	for (i = 0; i < priv->num_mib_counters; i++) {
> -		mib = &priv->mib_counters[i];
> -		strncpy(data + i * ETH_GSTRING_LEN,
> -			mib->name, ETH_GSTRING_LEN);
> +		ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);
>  	}

Nitpick, you don't need to resend for this. But if there's just a single
line remaining in the "for" loop, you could have dropped the braces too.

>  }
>  EXPORT_SYMBOL_GPL(rtl8366_get_strings);
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-60a0f0ddc5cc
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
