Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0C78C54C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjH2N2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbjH2N16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:27:58 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE91A2;
        Tue, 29 Aug 2023 06:27:55 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d795e9a0816so3501297276.3;
        Tue, 29 Aug 2023 06:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693315674; x=1693920474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQtjCSCni+7C5O5VnAvqJgCasBYKOxd9nBefXlVFPAk=;
        b=Tbm6NIxcLzZTGt+aGT1NaTBlEjPZvPtO5KJT7+WMH2+alap8EEzN4LaImnxNrY20zX
         +LRe6B7ojRguyFU3u+pNXr8DFnx/mzgjvZ9Nw8Zopb0uSE94NuID8yGjL5ZcL8rYspSa
         Vhy8Z7M1pTBhgXDVaUn7jiWYCC5A+96mf8g9EyHmixlkbu9B5wGLruBwdHFcp+jOIwMZ
         XB34gB8ChJGJpplFdHjARYoDcIiuPyjDEjSshcrGS9/nM9/NkstQbW7hIpXq4EOxyj5o
         cLQKl/k4dRC708DvNCpIih/dYPv2tzLl4EPXKwack+1YtDFgecPjZpH+OfbUjXx9YEJQ
         7T/A==
X-Gm-Message-State: AOJu0Yy792KLbajH/yoegM3eJONRCh2nuwLvOgHqAvL/ErY7okr8tKZw
        7O1Q7gpzHTjQUU5IdG7dArhdNpt61qZnMh5+q8o=
X-Google-Smtp-Source: AGHT+IHtBH2bbRJiuiyR80YOw62jWW/Dlp1289hLPTjmSziAPSX4+jmdDFPRYyz+gz6lzvR9uEv6P3zIylolpBEMKJA=
X-Received: by 2002:a25:4157:0:b0:d78:1311:aa1b with SMTP id
 o84-20020a254157000000b00d781311aa1bmr11731206yba.48.1693315674549; Tue, 29
 Aug 2023 06:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230829104033.955-1-jszhang@kernel.org> <ZO3UuY9jKz8VenGA@shell.armlinux.org.uk>
 <ZO3WsHH1GDWdcLAU@xhacker> <CANBLGcwoiiA=ZOVenMZXM4pHSYn0dyGpzjm76i1Fin+8+NiqLA@mail.gmail.com>
In-Reply-To: <CANBLGcwoiiA=ZOVenMZXM4pHSYn0dyGpzjm76i1Fin+8+NiqLA@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 29 Aug 2023 15:27:43 +0200
Message-ID: <CANBLGcwz8GeK_9DNC_UDq9YbpxRVYFKd59LEVeJOTeGU9wdXEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 00/22] convert to devm_stmmac_probe_config_dt
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 15:22, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> On Tue, 29 Aug 2023 at 13:41, Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Tue, Aug 29, 2023 at 12:21:29PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Aug 29, 2023 at 06:40:11PM +0800, Jisheng Zhang wrote:
> > > > Russell pointed out there's a new devm_stmmac_probe_config_dt()
> > > > helper now when reviewing my starfive gmac error handling patch[1].
> > > > After greping the code, this nice helper was introduced by Bartosz in
> > > > [2], I think it's time to convert all dwmac users to this helper and
> > > > finally complete the TODO in [2] "but once all users of the old
> > > > stmmac_pltfr_remove() are converted to the devres helper, it will be
> > > > renamed back to stmmac_pltfr_remove() and the no_dt function removed."
> > >
> > > I think a useful final patch may be to make stmmac_probe_config_dt()
> > > static so there aren't any new uses of stmmac_probe_config_dt().
> >
> > Good idea!
>
> Once this is done are there any users of stmmac_pltfr_remove() left?
> If not it would be great to remove that too and maybe even remove the
> _no_dt from stmmac_pltfr_remove_no_dt().

Sorry about the noise. I should learn to read the full series before replying.

> > >
> > > Also note that net-next is now closed, so please wait until after -rc1
> > > for net-next to re-open, or post as RFC. Thanks.
> >
> > oops, I didn't notice this cycle of window is closed, I will wait for next
> > development window.
> >
> > Thank you
> > >
> > > --
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
