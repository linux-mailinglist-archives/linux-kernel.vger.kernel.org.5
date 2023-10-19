Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5637CFD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbjJSOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbjJSOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:40:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46E18E;
        Thu, 19 Oct 2023 07:40:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9bdf5829000so981595766b.0;
        Thu, 19 Oct 2023 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726425; x=1698331225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSY+Q3S/YK4XQIguVFEmoJaZjehN9Q5LV7SrMSM6K5E=;
        b=WmWa1OWGEIX8+333RRWj1fXA84cFaDsvw8AvDhl8giwXrpBzetiq0LhhV6iu1B+0X3
         ONvia7/fC7FYxtw+jXGWX6MxbOr4OO3QbGQRKl9O7z1JGMoFOyGUSpBHu/GRvWtajiw8
         geeHQRBSPIVFuzAoQb52xhe5qtS5+SZ2tDR0WThimZEWOOXWb/IVwAtyTMBU6xa6A1eS
         GCa8ZpctUoYZ9IgRTFA3WMtDctWEVJ+H+xr+njts/VL6UPK9Oq31nli+ZkWS9l+KWxDi
         /c/VC0iKgItDPVuAodsOFcdvkhQoJwndSZxrmMjFXHp195JMekUDsV4mICfhSM7vxgfP
         gQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726425; x=1698331225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSY+Q3S/YK4XQIguVFEmoJaZjehN9Q5LV7SrMSM6K5E=;
        b=MFCEF0mF2+RCIRga+UkFDpMRIyk+87pn9gZdAP6uDxg1Tv+XRu+gMFWkKQ759Avqwf
         8Pef9aJS8wf/zwzB2TkyBWx45d5kdtgQVGLkeyzoo/lhvnQbYRZNhbfO19FitTNexLPZ
         YXKXaBFK0/iozQEXCTuptevvBixAPc7rasC6/dODvn3hFJLl1wC1QR3RhAFmbIg4P1Yo
         YSjF70Tt5BZxQODqJcb7v1Q5mVuRSsqaTbdf/KailvBkGW5/4KEs4lAhCVTuLl+OmAkW
         sZyTWbMyKhVTOVNiThNE+701ArsmBAXtUqQUsXiF84ffm34tZhUkhsS9KlSvp4lE985x
         3/ag==
X-Gm-Message-State: AOJu0Yzda0GXowhtrK2FVfrqZ/vKXh43N5v5yyY7NE6Ald/6bBl99sln
        JVsd0qRB7OOk4aC2VDvR9Xc=
X-Google-Smtp-Source: AGHT+IGETJBV9QkBTzlB91U/LGkd1pwzRiYAwX9szZp/irOUJNFYyLtBZCx7Ha1SVm9x9XzwDU443A==
X-Received: by 2002:a17:907:7d90:b0:9bd:f031:37b6 with SMTP id oz16-20020a1709077d9000b009bdf03137b6mr1864380ejc.49.1697726424599;
        Thu, 19 Oct 2023 07:40:24 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id hx10-20020a170906846a00b009a13fdc139fsm3652625ejc.183.2023.10.19.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:40:24 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:40:22 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231019144021.ksymhjpvawv42vhj@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Marek

On Wed, Oct 18, 2023 at 11:03:44AM +0200, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be switch@0.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 9eab2bb22134..c69cb4e191e5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -305,7 +305,7 @@ phy1: ethernet-phy@1 {
>  	};
>  
>  	/* switch nodes are enabled by U-Boot if modules are present */
> -	switch0@10 {
> +	switch@10 {

As the comment says: U-Boot
(https://elixir.bootlin.com/u-boot/latest/source/board/CZ.NIC/turris_mox/turris_mox.c#L728)
sets up status = "okay" for these nodes depending on the MOXTET
configuration. It doesn't look as if it's doing that by alias, just by
path ("%s/switch%i@%x").

I have a Turris MOX, please allow me some time to test if the node name
change is going to be significant and cause regressions. I expect the
answer to be yes (sadly).

>  		compatible = "marvell,mv88e6190";
>  		reg = <0x10>;
>  		dsa,member = <0 0>;
> @@ -430,7 +430,7 @@ port-sfp@a {
>  		};
>  	};
>  
> -	switch0@2 {
> +	switch@2 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;
>  		dsa,member = <0 0>;
> @@ -497,7 +497,7 @@ port@5 {
>  		};
>  	};
>  
> -	switch1@11 {
> +	switch@11 {
>  		compatible = "marvell,mv88e6190";
>  		reg = <0x11>;
>  		dsa,member = <0 1>;
> @@ -622,7 +622,7 @@ port-sfp@a {
>  		};
>  	};
>  
> -	switch1@2 {
> +	switch@2 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;
>  		dsa,member = <0 1>;
> @@ -689,7 +689,7 @@ port@5 {
>  		};
>  	};
>  
> -	switch2@12 {
> +	switch@12 {
>  		compatible = "marvell,mv88e6190";
>  		reg = <0x12>;
>  		dsa,member = <0 2>;
> @@ -805,7 +805,7 @@ port-sfp@a {
>  		};
>  	};
>  
> -	switch2@2 {
> +	switch@2 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;
>  		dsa,member = <0 2>;
