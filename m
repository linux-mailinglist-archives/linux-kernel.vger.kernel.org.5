Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8057F13BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjKTMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:48:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489710C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:48:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso12842545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700484499; x=1701089299; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iULhMJEvBuZulS3R6eM6+QPD3+upNpla2MgygEvT0Sk=;
        b=C1ynnwVpv9QKeqo7ypFi+ma0xWO1X71e+fg5e8Nj9svQcgJCMvG+WyhmqaJpr2ppHG
         tpntcl6jk7j0SRIqd8UG1x6GH7oNUJnNz4iagNBAcV08fRLbX1hlNtLYcjWy2+o8r0R7
         bEHUiU0BLbr/Z5b/NXBREIFnqKPz3bYvQYLg8p9fYLnyzKpLTQmHx8YhwybHM/UkZFck
         CuKi2ElsWxf1xWbNIP9UP0mNgOolppapN0GoHmCB0FoJpFTeLTOlJrrJpDyVgxbvwRHH
         XhVZcbNhloRr+7J7VOd1rrG9dsmIkaUO61tJKptzp5nE2yyziXgG/9YTF88VZ+m4qn45
         zhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700484499; x=1701089299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iULhMJEvBuZulS3R6eM6+QPD3+upNpla2MgygEvT0Sk=;
        b=cKqmYii/FDRi/gVqN8R82snN6qlNPZTFVsb5xD526D0BD+Hh4a3oda1/wN3cgu2UHL
         tYZME3c79eNFtQ9CzCi0t3VUu6Ka/L5Y3GSGOjJ7qWgRT0vq+wd1lZ4F6H35cfkM8uV9
         nD0OVnFuhj5IpYf6DsGbULYbBdZYWHwpP/4yuAZ2O18FWnKDhoz+zBdVLf4DKK44la3K
         XFX7+z5BP3zz77xCpkpp1g4b1wOW4hA9729qhelh4YYj/d3z1wvt9vYR8/kM0fOyGtqa
         ORg01bk5D7hlDCL047zWOs3t4gYONzS675lrpqijeVcdbdTg1D/3i7CTRE1aB8wFSyQc
         0epw==
X-Gm-Message-State: AOJu0YwMZpKhrCB8u2N+xTUo/e5bkFf29qfrtcm97lw63vDl/JFdAX73
        GJqjhKDQ4X0yz3kVMf3SK62YDA==
X-Google-Smtp-Source: AGHT+IEcj8eyEIw+EleLn28+Gu2Rxb9D5+njypV1+ljFqUelDha0PRwFdE+Tw+weAoFpUecO1dSWNA==
X-Received: by 2002:a05:600c:354a:b0:40a:3e41:7d6f with SMTP id i10-20020a05600c354a00b0040a3e417d6fmr5908383wmq.32.1700484498651;
        Mon, 20 Nov 2023 04:48:18 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id je12-20020a05600c1f8c00b0040839fcb217sm13392102wmb.8.2023.11.20.04.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:48:18 -0800 (PST)
Date:   Mon, 20 Nov 2023 13:48:16 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: Aw: [PATCH 6/6] crypto: rockchip: add rk3588 driver
Message-ID: <ZVtVkACNHTcCjqGp@Red>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-7-clabbe@baylibre.com>
 <trinity-a0ee3146-f23d-4f6c-b29c-5fe446c4d4ad-1699797868421@3c-app-gmx-bs50>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-a0ee3146-f23d-4f6c-b29c-5fe446c4d4ad-1699797868421@3c-app-gmx-bs50>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Nov 12, 2023 at 03:04:28PM +0100, Frank Wunderlich a écrit :
> Hi Corentin
> 
> thanks for working on it
> 
> > Gesendet: Dienstag, 07. November 2023 um 16:55 Uhr
> > Von: "Corentin Labbe" <clabbe@baylibre.com>
> > An: davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
> > Cc: ricardo@pardini.net, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Corentin Labbe" <clabbe@baylibre.com>
> > Betreff: [PATCH 6/6] crypto: rockchip: add rk3588 driver
> >
> > RK3588 have a new crypto IP, this patch adds basic support for it.
> > Only hashes and cipher are handled for the moment.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/crypto/Kconfig                        |  29 +
> >  drivers/crypto/rockchip/Makefile              |   5 +
> >  drivers/crypto/rockchip/rk2_crypto.c          | 739 ++++++++++++++++++
> >  drivers/crypto/rockchip/rk2_crypto.h          | 246 ++++++
> >  drivers/crypto/rockchip/rk2_crypto_ahash.c    | 344 ++++++++
> >  drivers/crypto/rockchip/rk2_crypto_skcipher.c | 576 ++++++++++++++
> >  6 files changed, 1939 insertions(+)
> >  create mode 100644 drivers/crypto/rockchip/rk2_crypto.c
> >  create mode 100644 drivers/crypto/rockchip/rk2_crypto.h
> >  create mode 100644 drivers/crypto/rockchip/rk2_crypto_ahash.c
> >  create mode 100644 drivers/crypto/rockchip/rk2_crypto_skcipher.c
> >
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index 79c3bb9c99c3..b6a2027b1f9a 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -660,6 +660,35 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
> >  	  the number of requests per algorithm and other internal stats.
> >
> >
> > +config CRYPTO_DEV_ROCKCHIP2
> > +	tristate "Rockchip's cryptographic offloader V2"
> > +	depends on OF && ARCH_ROCKCHIP
> > +	depends on PM
> 
> it should depend on CONFIG_CRYPTO_DEV_ROCKCHIP as rockchip folder is not included without it
> 
> drivers/crypto/Makefile
> obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
> 

Hello

I will move all rockchip kconfig in the rockchip directory like I did for Allwinner, this will fix this.

> > +	select CRYPTO_ECB
> > +	select CRYPTO_CBC
> > +	select CRYPTO_AES
> > +	select CRYPTO_MD5
> > +	select CRYPTO_SHA1
> > +	select CRYPTO_SHA256
> > +	select CRYPTO_SHA512
> > +	select CRYPTO_SM3_GENERIC
> > +	select CRYPTO_HASH
> > +	select CRYPTO_SKCIPHER
> > +	select CRYPTO_ENGINE
> > +
> > +	help
> > +	  This driver interfaces with the hardware crypto offloader present
> > +	  on RK3566, RK3568 and RK3588.
> > +
> > +config CRYPTO_DEV_ROCKCHIP2_DEBUG
> > +	bool "Enable Rockchip V2 crypto stats"
> > +	depends on CRYPTO_DEV_ROCKCHIP2
> > +	depends on DEBUG_FS
> > +	help
> > +	  Say y to enable Rockchip crypto debug stats.
> > +	  This will create /sys/kernel/debug/rk3588_crypto/stats for displaying
> > +	  the number of requests per algorithm and other internal stats.
> > +
> >  config CRYPTO_DEV_ZYNQMP_AES
> >  	tristate "Support for Xilinx ZynqMP AES hw accelerator"
> >  	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
> > diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/Makefile
> > index 785277aca71e..452a12ff6538 100644
> 
> else i did some tests, but it does not seem that the offloader is used (requests stay at initial value after the bootup test)
> 
> i wonder about the last 3 lines in dmesg (fallback), seems i miss something for these.
> 
> root@bpi-r2pro:~# dmesg | grep crypto
> [    0.150643] alg: extra crypto tests enabled.  This is intended for developer use only.
> [    2.718110] rk2-crypto fe380000.crypto: will run requests pump with realtime priority
> [    2.720605] rk2-crypto fe380000.crypto: Registers crypto algos
> [    2.721910] rk2-crypto fe380000.crypto: Register ecb(aes) as ecb-aes-rk2
> [    2.724435] rk2-crypto fe380000.crypto: Register cbc(aes) as cbc-aes-rk2
> [    2.725072] rk2-crypto fe380000.crypto: Register xts(aes) as xts-aes-rk2
> [    2.725731] rk2-crypto fe380000.crypto: Register md5 as rk2-md5 3
> [    2.726310] rk2-crypto fe380000.crypto: Register sha1 as rk2-sha1 4
> [    2.726901] rk2-crypto fe380000.crypto: Register sha256 as rk2-sha256 5
> [    2.727521] rk2-crypto fe380000.crypto: Register sha384 as rk2-sha384 6
> [    2.728142] rk2-crypto fe380000.crypto: Register sha512 as rk2-sha512 7
> [    2.728763] rk2-crypto fe380000.crypto: Register sm3 as rk2-sm3 8
> [    3.502442] rk2-crypto fe380000.crypto: Fallback for xts-aes-rk2 is xts-aes-ce
> [    3.770678] rk2-crypto fe380000.crypto: Fallback for cbc-aes-rk2 is cbc-aes-ce
> [    3.939055] rk2-crypto fe380000.crypto: Fallback for ecb-aes-rk2 is ecb-aes-ce
> 
> root@bpi-r2pro:~# cat /sys/kernel/debug/rk2_crypto/stats
> rk2-crypto fe380000.crypto requests: 581
> ecb-aes-rk2 ecb(aes) reqs=132 fallback=1994
>         fallback due to length: 342
>         fallback due to alignment: 1648
>         fallback due to SGs: 0
> cbc-aes-rk2 cbc(aes) reqs=156 fallback=2182
>         fallback due to length: 329
>         fallback due to alignment: 1841
>         fallback due to SGs: 6
> xts-aes-rk2 xts(aes) reqs=137 fallback=2143
>         fallback due to length: 116
>         fallback due to alignment: 739
>         fallback due to SGs: 0
> rk2-md5 md5 reqs=14 fallback=739
> rk2-sha1 sha1 reqs=28 fallback=716
> rk2-sha256 sha256 reqs=25 fallback=654
> rk2-sha384 sha384 reqs=32 fallback=656
> rk2-sha512 sha512 reqs=34 fallback=638
> rk2-sm3 sm3 reqs=23 fallback=712
> root@bpi-r2pro:~# kcapi-rng -b 512 > rng.bin
> root@bpi-r2pro:~# cat /sys/kernel/debug/rk2_crypto/stats
> rk2-crypto fe380000.crypto requests: 581
> ecb-aes-rk2 ecb(aes) reqs=132 fallback=1994
>         fallback due to length: 342
>         fallback due to alignment: 1648
>         fallback due to SGs: 0
> cbc-aes-rk2 cbc(aes) reqs=156 fallback=2182
>         fallback due to length: 329
>         fallback due to alignment: 1841
>         fallback due to SGs: 6
> xts-aes-rk2 xts(aes) reqs=137 fallback=2143
>         fallback due to length: 116
>         fallback due to alignment: 739
>         fallback due to SGs: 0
> rk2-md5 md5 reqs=14 fallback=739
> rk2-sha1 sha1 reqs=28 fallback=716
> rk2-sha256 sha256 reqs=25 fallback=654
> rk2-sha384 sha384 reqs=32 fallback=656
> rk2-sha512 sha512 reqs=34 fallback=638
> rk2-sm3 sm3 reqs=23 fallback=712
> root@bpi-r2pro:~#
> 
> if needed this is my current defconfig/tree:
> 
> https://github.com/frank-w/BPI-Router-Linux/blob/6.6-r2pro2/arch/arm64/configs/quartz64_defconfig#L924
> 

You are using kcapi-rng but the driver do not support RNG yet. (and probably never if I continue to fail having good results with it).
So it is normal values does not change.

Thanks for your test
Regards
