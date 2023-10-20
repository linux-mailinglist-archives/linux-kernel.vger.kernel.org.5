Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45E7D1096
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377327AbjJTNhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:37:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138819E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:37:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5629fdbf8so5778971fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697809029; x=1698413829; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=s/4QVz4WiRPPNhmC81yxFrG4Euma7o0q2x66+hnNm/A=;
        b=lP+lQUX7hU2LtSJvWeMt1yPSs0xvEOwM54w935O6pbSROuKglM3cNDNWr584LrFCfh
         a8aA2G/GNwqMSfn80Rwwe6aFYRgyZKx2RUOb6zZ2KyN/VOWUuhWVg5y+TaenwUVYnxaI
         DPgXjU3R2NBIRKOSR1H8QgV9q403uD3/uPJLOyunQQ5f4e76gpV+9zqGI2w5ZWM0qZFm
         E/gX+JVr+T2ihHajPXanyJGGnmKkdPeQTKLz7mmg6PblQkWDwRACkpiNufZMlSfVkZNZ
         A44/2hLfhEKi4X1IFTCnwxd8w7e/QQlgcwCxtWNROCTDHRRQZTTz/b0zf89DB1wVmdAH
         LI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809029; x=1698413829;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/4QVz4WiRPPNhmC81yxFrG4Euma7o0q2x66+hnNm/A=;
        b=PqBqxTGMswEiw9nxEeRCIZOvtMunpnRTW9rwXH3DeWNHqDjcrJ2YItw/DcZd3z4PZS
         GSRLFDPS+HvM0AQFZq5osWQILR8WHmsOazFuTxFjaaZ4C9s7JU5ftpaqszU/g6nEjqE6
         qitsBz9d29GbuMHVJvmIpa9gTAMjq5wjM3oNLzmC4q3ctUeI5A/P6FVNN+7Bi3CEm7R+
         ROs5QFYqyRrjCJU4ZDdiZokbiu9rmqD7sONnItf6zm5dVdiTIr63GMuKWqH5eKKp03lk
         tQlhJ1why5ea+0V+EKoA9N0vdzuzrQEwHWTcYJ2FIkMwN/j9C6qWBifnQtvhMlnj9sOx
         0Nfg==
X-Gm-Message-State: AOJu0Ywo3pBtR2ii16oTubUG9s6tBnZVOIohWqCYPYk+parcUNP4qxZH
        Njog30T58qlFrEQkoQIFV5hF0Q==
X-Google-Smtp-Source: AGHT+IGN1aOFa5F/gq7N/SrwpyCQAbL/TaKgscRZTpTwJE4H9XiEkid4VycqErwR3y57xfWxRRKmbA==
X-Received: by 2002:a2e:a4cb:0:b0:2c5:55a:b6b5 with SMTP id p11-20020a2ea4cb000000b002c5055ab6b5mr1245550ljm.28.1697809029076;
        Fri, 20 Oct 2023 06:37:09 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f548:bdfb:ed67:dbbd])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b00407efbc4361sm6958098wme.9.2023.10.20.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:37:08 -0700 (PDT)
References: <20231020132036.1181762-1-arnd@kernel.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, Yu Tu <yu.tu@amlogic.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: S4: select CONFIG_COMMON_CLK_MESON_CLKC_UTILS
Date:   Fri, 20 Oct 2023 15:35:25 +0200
In-reply-to: <20231020132036.1181762-1-arnd@kernel.org>
Message-ID: <1jmswds9dn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 20 Oct 2023 at 15:19, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Without this, the newly added driver fails to link:
>
> aarch64-linux-ld: drivers/clk/meson/s4-pll.o: in function `meson_s4_pll_probe':
> s4-pll.c:(.text+0x13c): undefined reference to `meson_clk_hw_get'
>
> Fixes: e787c9c55edad ("clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/meson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index c5303e4c16043..3c28560b0faba 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -149,6 +149,7 @@ config COMMON_CLK_S4_PLL
>  	tristate "S4 SoC PLL clock controllers support"
>  	depends on ARM64
>  	default y
> +	select COMMON_CLK_MESON_CLKC_UTILS
>  	select COMMON_CLK_MESON_MPLL
>  	select COMMON_CLK_MESON_PLL
>  	select COMMON_CLK_MESON_REGMAP

Thx Arnd and sorry about this.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

Stephen, do you mind taking this directly ?
