Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09A57BF931
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjJJLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjJJLHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:07:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C08A9;
        Tue, 10 Oct 2023 04:07:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bdcade7fbso940582766b.1;
        Tue, 10 Oct 2023 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696936040; x=1697540840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxYIKEiG6ukaTBM9h6qF8OGxEw0D7VZs6H4jG50DssU=;
        b=eoJf6tFtZqhePcDy6q0d4h3tciGtJOmudphCy5GcYPJRDfqYSYdik4Fn+sAcleP+1u
         aLTBu2QQ0TT79yvsYZZd3mDeeXBpApt4bKFpXe4CyMwCdVXDvIv4a7Mbeo5Dp6JihBsW
         RBVv6y7LTTa741kT0B3Fof/JkQ8GHX7Pk6FswPSQaq4kPZrZKTO5x5nEo6Nc4YLQU40B
         CSJf3FNB/ydgs8xaUtSo9dpnrho4Aq3sTmF+jXtFVfHwZ295n/CqdjYVRqoru6wUlrSo
         xC2k+tSrF9gax4VzZZEKwNxy7UK1Kqx34H8xYRItcxZPBuGbEdoCFvFo5KwDaKa1k81s
         nYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936040; x=1697540840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxYIKEiG6ukaTBM9h6qF8OGxEw0D7VZs6H4jG50DssU=;
        b=Lmlo27cFBZl0pB6qRcuXRlrIo377ToTB1mQ78Qv4omBnRFiVCCXD67qhHeTNcArIP9
         q95Blqvc1esNh8bDL5zfvoObccPkMbixNgdc6W3mzpcSfa0XH15mhRD4oYmCOgXbzxBC
         xxj83FYla0bg6i10RWRU+udgVmuA0P3vhhhOM/Nrqc/QgD/whvVeuviOAL7Gh/O39iN2
         sPZ55o49U+hDHfWY6ruDLdUN474j7GrfTr0l0B7Erhm75jhuLck+5SmakeqzvjkRxkCQ
         SSx/etOb0JO0RIIiHQQlWcHsZUYitqEH5t/j4BVdC01Rz/BNSDa6GazgkXCKXbfg44Ay
         hi4Q==
X-Gm-Message-State: AOJu0YzzvobmPYx9sCxfFIoLORHzaSl0KcV3TOdPEGZ3jzZOzWD5JGrL
        naSJKpF6LzxyAHUc5D5lq10=
X-Google-Smtp-Source: AGHT+IEYPZp0tr9ONlPxfhIYkRElPfNwZm0mIx5/NZu6JdaArxgZ8NLCb2OrW2ymI80lISBM+r6xDA==
X-Received: by 2002:a17:906:156:b0:9a6:4f54:1da6 with SMTP id 22-20020a170906015600b009a64f541da6mr16623638ejh.57.1696936040293;
        Tue, 10 Oct 2023 04:07:20 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906230c00b009920e9a3a73sm8277193eja.115.2023.10.10.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:07:20 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:07:17 +0300
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
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Message-ID: <20231010110717.cw5sqxm5mlzyi2rq@skbuf>
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Justin,

On Mon, Oct 09, 2023 at 10:43:59PM +0000, Justin Stitt wrote:
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
>  drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> index 41ea3b5a42b1..d171c18dd354 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> @@ -1303,8 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_switch *ds, int port, u32 stringset
>  
>  	for (i = 0; i < RTL8365MB_MIB_END; i++) {
>  		struct rtl8365mb_mib_counter *mib = &rtl8365mb_mib_counters[i];
> -
> -		strncpy(data + i * ETH_GSTRING_LEN, mib->name, ETH_GSTRING_LEN);
> +		ethtool_sprintf(&data, "%s", mib->name);

Is there any particular reason why you opted for the "%s" printf format
specifier when you could have simply given mib->name as the single
argument? This comment applies to all the ethtool_sprintf() patches
you've submitted.
