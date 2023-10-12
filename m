Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D57C6567
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377344AbjJLGXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347067AbjJLGXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:23:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7CC0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:23:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-406402933edso6562415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697091795; x=1697696595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HT79hrObqSxBSC97lY+L6cqBvifnDEa24RG2fZwpdY=;
        b=Ri3IYuQYEVCX387youuvKmcreNWgZU+DHavhs2BJ0Pg+3cffy4pdCO6XMxjDA5E+jY
         6LznvxlQx8T2yMCft/ZNUTg0/LhPJteCodfNYrvpqwPiS5XQ32gxrCkScg7CR4jhL0Oa
         Kfv7D8uRtxTJABeZVwvaAvN58ORCqgyOxtuHJcWx5ahFHoPFlpCyZ/KweiwyZpKaUs5W
         XzqaF8FV0oq+LFZ3w75wG8A0SAMt6jW+Twl5VKot1tkeADJ4iCOGibbHD2PY1z7d+lxO
         BAR5BBaGIPRp29mXRpudEFrnpVMdH+IN/AQLT4ZlR4p1aAP5gab8vP3SQlizXzPk3reC
         9AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091795; x=1697696595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HT79hrObqSxBSC97lY+L6cqBvifnDEa24RG2fZwpdY=;
        b=NxCUG+ub4rXQ8gLsv2WLFhm3duxuCS+298ulwH4BR9EsHKi9SgkqiuPRQY/0dzA4Lc
         UmvzjWQJ4PRKtFPwHfEfMC8WWJuVT1axZhxw/3Qi1+Ixr1gdRU4gc4Wg8+kY+Sr52hGE
         cy58m7tu0U5eLQ1c1/wsksHFWQSdry1eXlsTvdE3fEQ1vPliPgCeMRAAFIOzMNjWbDk3
         ATt8zyafQXK2CJNp3tC9oPAjv5zbyfI53YFuZtTRiQ4zWLxG8tBTEj2cwrESuz3/yZaY
         f4sITSX2plHSI6k1OLPeOG+t3A/3ugbh5IRH21Rrfq46NDKkfjpUDa945AOZMCAM8x0r
         4sUg==
X-Gm-Message-State: AOJu0YwZfXnwFIvSrG1GAzRNc62vHP81lCNZYhTi+m+niz48oL0fGfse
        CAXVtV9oZxobANRIP9YJIn14TQ==
X-Google-Smtp-Source: AGHT+IFKoP5B7w8Y42/s61+wzwot43ZZei6mSsx6r/nkWwL/vfiXecTRrJxnumkImRNM8DZcpqepCw==
X-Received: by 2002:a05:600c:3652:b0:3fe:d1b9:7ea9 with SMTP id y18-20020a05600c365200b003fed1b97ea9mr19652329wmq.36.1697091795060;
        Wed, 11 Oct 2023 23:23:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b0040472ad9a3dsm18638405wmq.14.2023.10.11.23.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:23:14 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:23:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Message-ID: <428ef899-a5c4-4d93-beea-afd7ab6f6634@kadam.mountain>
References: <20231010155444.858483-1-arnd@kernel.org>
 <da777a72-55d1-4ee3-91c8-30afe7659f54@gmail.com>
 <db98d9ac-7650-4a72-8eb9-4def1f17ea0d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db98d9ac-7650-4a72-8eb9-4def1f17ea0d@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:22:32PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 11, 2023, at 20:13, Philipp Hortmann wrote:
> > On 10/10/23 17:27, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de> While looking at the old drivers 
> >> using the obsolete .ndo_do_ioctl() callback, I found a number of network 
> >> drivers that are especially obsolete, in particular for 802.11b 
> >> (11Mbit/s) or even older wireless networks, using non-busmaster 
> >> ISA/PCMCIA style bus interfaces, and using the legacy wireless extension 
> >> ioctls rather than the netlink interfaces that were meant to replace 
> >> them in 2007. All of these drivers are obsolete or orphaned. We had 
> >> previously discussed this topic, but nobody ever moved the files, so I 
> >> now went through the list to my best knowledge. These are the drivers 
> >> that I would classify as "probably unused" by now:
> >
> > I found a USB WLAN Stick with a rtl8192u. I got it last Saturday and 
> > found out that the firmware is missing in my ubuntu 20.04. I found it on 
> > the web and fixed it. When I started the driver my computer crashed. The 
> > missing part was: priv->priv_wq = alloc_workqueue("priv_wq", 0, 0); 
> > Fixing this the next error was a network = kzalloc(sizeof(*network), 
> > GFP_KERNEL); in wrong context with leads to a crash of my computer. 
> > Fixing this leads to another issue which lets my computer crash.
> >
> > For me the firmware of rtl8192u was intentionally missing because of the 
> > issues with the driver.
> >
> > What this has to do with your question?
> > Can we check for missing firmware in main distributions to know which 
> > drivers are considered to be old and unused?
> 
> Nice, thanks so much for testing.
> 
> I see the two bugs were introduced in 2016 by commit 1761a85c3bed3
> ("staging: rtl8192u: Remove create_workqueue()")

This one never made it to lore...  I think we wouldn't have merged it
without a lore review these days.  (There was a lot of moaning and
complaining at the time).

> and in 2021 by
> commit 061e390b7c87f ("staging: rtl8192u: ieee80211_softmac: Move a
> large data struct onto the heap"), so it's been broken for a while.

:/  No way would I have seen this in review.  Smatch is supposed to find
some of these "sleeping in invalid context" warnings but the sleeping in
IRQ stuff doesn't work and hasn't been released.

regards,
dan carpenter

