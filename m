Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DFD791E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjIDUxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjIDUxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:53:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A51AB;
        Mon,  4 Sep 2023 13:53:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so391554866b.0;
        Mon, 04 Sep 2023 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693860788; x=1694465588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHjfIBjwCFBAgwZfRF3IlRMeOawfvSH0PIg6BJi4ttA=;
        b=Nu8DDiJ/JK6b/p3dPS39aeI9KcZZyGg321aZm3kknmKoSORQw8T40Y2LuDCSu2nxCc
         5j3aNNh9U+xdqOBr+JJJ7a3pZPQu0uFX9UY2+DZugFWcCg3gQPgO2HJnTCG8ed6kljGT
         UG5meZiXkcTAvYnH547qI7++jsreuLOyt//zlO3+ng5veGiaeCpzDXTq4Ms3Ow83pFet
         15LVRD5tvodwdK18fgOf3ij0UaXKUCZBeLuWrCCyHkJGsADfgd/7hH40bAgiDmBFfRID
         UJo4WApHSlcHpT1VjPXlzyOwsj7EcFMg46Xx+41TB1IfODR9ch5cDAi54LqS5ANBnUr3
         hnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693860788; x=1694465588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHjfIBjwCFBAgwZfRF3IlRMeOawfvSH0PIg6BJi4ttA=;
        b=M0BfpODGvjxjc95O+zGeOuwBx03q3XGLeJgOcsnDXCuxWZPkui4WutjTFhpE4sdWEn
         uFoQST6VU3Xm7ERDt5PBYSsKHCrl/n6YZ6Z0e6zS5uD4QW+urKsAV8J2Hr+qqacQfvJZ
         wjCevfmQgsOptM0EemrrAc+ao0YDrwr9+ivdY7NlNXELUI0pPfZR8R6BNkdRpKgvCdO8
         d86u7Z8AivCe93dk0v+1NTRUQ/4qfN5w3qhnCXQZKRgkkrRZM6zrGi4Y72ckZqVu/0fN
         cJK660Gz84eqMiDqfYGXdusDm/5bDKjI6gIodjkyji4qCFpLUE18NxGzdFjP5MirGwBM
         pWQg==
X-Gm-Message-State: AOJu0YzV9Amaum9GT71Wh++X4/RqToYB/9ObhiJy30csyj7YMUAOo46n
        pFO79jcLyqyGAhylzWAs3Q4=
X-Google-Smtp-Source: AGHT+IEaWJhnR9T7MdmYsuNVL1416i0ekktpnad7n+r3rz7HjgR4a6OUCagul3fLhDwi2HCn65/FKw==
X-Received: by 2002:a17:907:2715:b0:9a5:a543:2744 with SMTP id w21-20020a170907271500b009a5a5432744mr9425483ejk.33.1693860787615;
        Mon, 04 Sep 2023 13:53:07 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b009920a690cd9sm6616015ejb.59.2023.09.04.13.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 13:53:07 -0700 (PDT)
Date:   Mon, 4 Sep 2023 23:53:04 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <20230904205304.h3fdjqcijytztlpb@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904120209.741207-5-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 02:02:09PM +0200, Lukasz Majewski wrote:
> This patch provides the common KSZ (i.e. Microchip) DSA code with support
> for HSR aware devices.
> 
> To be more specific - generic ksz_hsr_{join|leave} functions are provided,
> now only supporting KSZ9477 IC.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - None
> 
> Changes for v3:
> - Do not return -EOPNOTSUPP for only PRP_V1 (as v2 will not be caught)
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 69 ++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 579fde54d1e1..91d1acaf4494 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -16,6 +16,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/if_bridge.h>
>  #include <linux/if_vlan.h>
> +#include <linux/if_hsr.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_mdio.h>

This conflicts with commit f44a90104ee5 ("net: dsa: Explicitly include
correct DT includes") from July, merged through net-next.

"New features" material for networking goes through this tree, please
submit patches that were formatted (and tested) on top of the most
recent version of the "main" branch, and use git-send-email
--subject-prefix "[RFC PATCH vN net-next]" to denote that.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/

If patches fail to apply to the target kernel, you lose the benefit of
automatic build testing (which would have highlighted a problem that
exists since v3). With RFC patches, the kbuild test robot sends build
breakage reports only to you - with normal patches it sends them to
everybody.

Please wait for more feedback before posting RFC v5. I will review in
more detail, but it will take some time.

Thanks.
