Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648C57CFF32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbjJSQLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjJSQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:11:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF0131;
        Thu, 19 Oct 2023 09:11:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso12994222a12.1;
        Thu, 19 Oct 2023 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697731896; x=1698336696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X32GunGHAK2140SJxVQVQfNtK2QC/jeLmazDGROMOOY=;
        b=BYg7Eka51OAb6+D7Re3L3yLEhZ91MDLhE5jFXxwpSfm7zm2VsUS0Se34BgBjdVqiBQ
         ozxHZ5nTxWByR76u5iGJBJqb7ftF4a40tNJT9ltysqcbD5a2a8z+Q/mOQ/Ym5lOjCrQo
         g3Qz0w07yUUgpyMg6IZut2OgstBxrw5bFp3pzW4SSStEAYGkoe7VfOXKJ6s0bJ20Y68G
         L94o+JRfgwiFBLK0E4zMM0M3Otg1a9ndKtgCTznvjXyeDi/46G8ZzSeglN4gt14YEjE1
         9hZrcTFOrq6HeQCCcbPOqIJmwtZn54Ol3rYpkyGW31LsVxFuaP4DSfkC6Rnw2OL/BJiv
         lWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731896; x=1698336696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X32GunGHAK2140SJxVQVQfNtK2QC/jeLmazDGROMOOY=;
        b=MdP/X9RET7Olp0qPsZ7FMzv05qEyCPcBtTLE4r4rULXSsgPFZ9pL9EDma3d06WdIzq
         Q0DZPTQj+hc6o5hi+Emfak5cpxcayHmbAlqN2AGo8PtLBn5+JPdEu95Fhm7e5fmwwZVD
         7udZfwQZ1CVzf4mfk/fQJpFA0FA8bjJiQqiwJr7ZmOfq4S5c30nSLFOXqVUocHr3/3mD
         YCgC/lyaFrQ4wNDYjH2QAN+AF7HMexO3QUGwtkYETVrbCo76cHrELDTZGHbKKp1d6EZA
         baJLlrpcrfuSxFiMBB6wzOXUWrkq+ECML6ZKiYjxMNz3m/mjt0SNrnvAzrW7eOqifNw6
         0a4A==
X-Gm-Message-State: AOJu0Yzsm6F989ZVZR71ODQI6UnVkpeh7UsTrrPcEfdHlWSxq/ZUBmxh
        5ArGkhL3xiHi4fNnXaeJR8c=
X-Google-Smtp-Source: AGHT+IHY+o8DsaC0r/9+4lEIrMX/sedP3iT7Pw3eQ1iwcKm7sYN1yH+7U61MsQeH4xScEluX4QndhQ==
X-Received: by 2002:a05:6402:5186:b0:53e:2a65:1d9c with SMTP id q6-20020a056402518600b0053e2a651d9cmr1927370edd.25.1697731895574;
        Thu, 19 Oct 2023 09:11:35 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id t29-20020a50ab5d000000b0053ed70ebd7csm4740536edc.31.2023.10.19.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:11:35 -0700 (PDT)
Date:   Thu, 19 Oct 2023 19:11:32 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
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
Subject: Re: [PATCH net-next v4 7/7] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
Message-ID: <20231019161132.24hcgqfufotg7w7e@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-7-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-7-3ee0c67383be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-7-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-7-3ee0c67383be@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:03:46AM +0200, Linus Walleij wrote:
> The Marvell MV88E6060 is one of the oldest DSA switches from
> Marvell, and it has DT bindings used in the wild. Let's define
> them properly.
> 
> It is different enough from the rest of the MV88E6xxx switches
> that it deserves its own binding.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6060.yaml        | 90 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 91 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
> new file mode 100644
> index 000000000000..787f328551f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6060.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MV88E6060 DSA switch
> +
> +maintainers:
> +  - Andrew Lunn <andrew@lunn.ch>
> +
> +description:
> +  The Marvell MV88E6060 switch has been produced and sold by Marvell
> +  since at least 2010. The switch has one pin ADDR4 that controls the
> +  MDIO address of the switch to be 0x10 or 0x00, and on the MDIO bus
> +  connected to the switch, the PHYs inside the switch appear as
> +  independent devices on address 0x00-0x04 or 0x10-0x14, so in difference
> +  from many other DSA switches this switch does not have an internal
> +  MDIO bus for the PHY devices.

Where does 2010 come from (both here and in the other Marvell schema)?
Lennert Buytenhek added Linux support for this switch family in 2008.

Anyway,

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
