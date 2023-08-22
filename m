Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D022784CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHVWix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjHVWiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DECCDD;
        Tue, 22 Aug 2023 15:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442E563D4B;
        Tue, 22 Aug 2023 22:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BACC433B6;
        Tue, 22 Aug 2023 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692743929;
        bh=U15eYY76gsnD/RHRrRp2WW4I4OCWvlLasJey1YPS3bA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jn4NXR0lfbWYS5Bph9NDsU+CUS6oKPixIBuJYm6y13c3Oey4zsZFxl5LEbilQxJik
         FeYi4hk81hW93Pito7BlDOIWLAaYnB0RhnPhbkxJtYjIwxdi5/i0pNyJyNN/nCccuI
         fmY+ssuFxpfa7I30gkLK8YDwU53i5SgxztwwtwOd89uEzAB/wmwwNcI4B7etE38nUX
         1KT94QzqmI87253Kc52MD6Y8fou1jBGiX1pJkpWJMnTdedMpWf+KZdUDC39Y5QFc9X
         pamJJqabcmOvoF7HZyud2tyJQOPli0tj7WP4SaXb0FkLx82tm9eotCxnMBwonE7SUu
         gzqa24AIGrPmA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so43872971fa.3;
        Tue, 22 Aug 2023 15:38:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZus2vU2dDMD/W5mtDf7ItNOiHAf94VYBt93eGRNIVi07Bba4y
        YLO+AhO3AfymF9WV/yf61eGt2ld82IGHHHEKPA==
X-Google-Smtp-Source: AGHT+IF0JLsyZnXZQBcgCFuF2kEmLMhxys3SoS78ueuZDPswTtorzz1H8NCRQqi/aO+jact/25/WQ07MKCBccdqUsKI=
X-Received: by 2002:a2e:9919:0:b0:2bb:8d96:6041 with SMTP id
 v25-20020a2e9919000000b002bb8d966041mr7975933lji.45.1692743927592; Tue, 22
 Aug 2023 15:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175008.4064592-1-robh@kernel.org> <CAJZ5v0i-OByOSjpxrj5d9S9QHRySK-MEUo+bK_J_4ihsCBmnSg@mail.gmail.com>
 <CAL_JsqLy22S5bTFu-ZKXhSMtMPPq9z1Gdb5kJMVmhui55miDsQ@mail.gmail.com> <CAJZ5v0hM63nVphwkYK1bL4uf_dXSew2+LBuG9kuhvvLdrhLxAw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hM63nVphwkYK1bL4uf_dXSew2+LBuG9kuhvvLdrhLxAw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Aug 2023 17:38:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGoDPLKgu8awJfuWpqzg8HOuruDa1z4s-Swb7Cm5OaJw@mail.gmail.com>
Message-ID: <CAL_JsqJGoDPLKgu8awJfuWpqzg8HOuruDa1z4s-Swb7Cm5OaJw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Explicitly include correct DT includes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 1:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Jul 14, 2023 at 9:53=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Fri, Jul 14, 2023 at 12:54=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Fri, Jul 14, 2023 at 7:51=E2=80=AFPM Rob Herring <robh@kernel.org>=
 wrote:
> > > >
> > > > The DT of_device.h and of_platform.h date back to the separate
> > > > of_platform_bus_type before it as merged into the regular platform =
bus.
> > > > As part of that merge prepping Arm DT support 13 years ago, they
> > > > "temporarily" include each other. They also include platform_device=
.h
> > > > and of.h. As a result, there's a pretty much random mix of those in=
clude
> > > > files used throughout the tree. In order to detangle these headers =
and
> > > > replace the implicit includes with struct declarations, users need =
to
> > > > explicitly include the correct includes.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > >
> > > or please let me know if you want me to pick this up.
> >
> > Single patch in your subsystem with no dependencies. Please pick it up.
>
> Done, thanks!

I'm not seeing this in linux-next.

Rob
