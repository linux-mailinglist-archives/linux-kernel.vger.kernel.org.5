Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA707B7324
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbjJCVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbjJCVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:14:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E83B0;
        Tue,  3 Oct 2023 14:14:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b281a2aa94so253145766b.2;
        Tue, 03 Oct 2023 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696367652; x=1696972452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPz2uBJ8rBwKPCCgJ+fxTjcXA7wMdv/YCDeLnT8vXMw=;
        b=AXWTTjBSRvE+J5xC8dsra/msJQEOR1gcBV29O7LnBzO+LjKskvtoJZdimOoHcwIv6B
         nOZ+yMYq7Nd66aBIbfmlg3UPWYbCtUQNCK05Ps2/0MZgVB6tjDnnJKIneYcmvY2KBlQx
         8LcV2x0oTQtgssfzjL5SXksRAhY7yPObD9WolD7GEFTqCXS+sDp/30mRDeGnn6eeBn1B
         VwcMStS++z2+/9spq0Vh6w/bPjpYnGE7Ft675mBw/3MHO3kDi9Lrw8DaWMAcayJBLgZg
         KxwkoAdC8PtViObIYMwvoP+dl/oDen4et0wfO8RhBkxt1u7U/d6jNOpx6TVWBV5tTIfo
         NRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367652; x=1696972452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPz2uBJ8rBwKPCCgJ+fxTjcXA7wMdv/YCDeLnT8vXMw=;
        b=UsmT6S6JlyHGv3lXjpsTg49NQUwOyAFCfcFiHdWRRYDgPmzhcsseSMCWGghYY9BTi+
         QVDwJdckJ/W9WfX8FRuqZkLM8rEpwLa1FGiWKGaDQUxE3RRuQ8HX75tKfB+O9esfIFr7
         dHwEnITkpdK69LlsQ1UXHzBx3HRb1he1fW4yt7XcI9xOqS0L8BHa7WCLfBHwPRKJgPeM
         YrPLOPYqz88OdmKjjXaJcOvPDs086hsLyrezieHb7F/J/2z1eqzUjPVMh5UlLK/pe7eS
         hyzAcaWdoPecX9tjhMg7X5gwx+N1OEok6+GoUNyNcs20twYfvjm7K0w16rilU1deFAhi
         61xg==
X-Gm-Message-State: AOJu0Yz6KmyMyFkPUp/9dmBddumA0Bil0Lf5zJMgaoSrzFSi0IWTjvBy
        BIFt0e8eAQGx6u4+Qb0QdzI=
X-Google-Smtp-Source: AGHT+IEE/gVZj1T0rl7ECmIVbM44xWznSNAh06ICBbGgLsWWBJZaMTGMvm2YA5g67fa3uYZnJwC6Qg==
X-Received: by 2002:a17:906:76cf:b0:9b2:a7e5:c47 with SMTP id q15-20020a17090676cf00b009b2a7e50c47mr343017ejn.9.1696367651907;
        Tue, 03 Oct 2023 14:14:11 -0700 (PDT)
Received: from skbuf ([188.25.255.218])
        by smtp.gmail.com with ESMTPSA id kt13-20020a170906aacd00b009adce1c97ccsm1637590ejb.53.2023.10.03.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:14:11 -0700 (PDT)
Date:   Wed, 4 Oct 2023 00:14:09 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <20231003211409.4enff3ee3bb762ai@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-3-paweldembicki@gmail.com>
 <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
 <20230926230346.xgdsifdnka2iawiz@skbuf>
 <CAJN1KkwktmT_aV5s8+7i=6CW08R48V4Ru9D+QzwpiON+XF8N_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkwktmT_aV5s8+7i=6CW08R48V4Ru9D+QzwpiON+XF8N_g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

On Tue, Oct 03, 2023 at 10:45:45PM +0200, Paweł Dembicki wrote:
> I plan to make rgmii delays configurable from the device tree. Should I?
> a. switch to phy_interface_is_rgmii in the current patch?
> b. add another patch in this series?
> c. wait with change to phy_interface_is_rgmii for patch with rgmii
> delays configuration?

If you want to configure the RGMII delays in the vsc73xx MAC, you should
look at the "rx-internal-delay-ps" and "tx-internal-delay-ps" properties
in the MAC OF node, rather than at the phy-mode. The phy-mode is for the
internal delays from the PHY.

In any case, you should accept any phy_interface_is_rgmii() regardless
of whether internal delays are configurable in the MAC. And yes, parsing
those MAC OF properties should be a separate change.

If the series exceeds 15 patches, I would consider splitting it per
topic and submitting separate series (link management would be one,
tag_8021q/bridging/VLAN would be another). If they don't conflict and
can be applied independently, you could also send the 2 series
simultaneously.
