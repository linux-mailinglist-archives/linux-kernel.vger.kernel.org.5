Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE0D7C70E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378304AbjJLPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJLPES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:04:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2F4B8;
        Thu, 12 Oct 2023 08:04:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D8C433CD;
        Thu, 12 Oct 2023 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697123056;
        bh=Wg+9RqFKlFhtVv8OJE3FcYAhzK8o4Jsak7+oQ9IdYv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RquMVZnHtNudVG7LgNUC2XAWr5xF9/mkQH7o5pl+5k4hvtJ43KUxF7gsLLtJ9bRFx
         1qXo0R3XCt251Vt/MYiPzVdW4cwmcbHRAAYbVMf51YQkNP0Dlam5Q7lkAlT7OWOg6Y
         HvxTbwK7M9GKbYU2NoxawFdypoyYSrqlMcM/xVatmPBnMZRnemPNqDqXHnUswnMFmK
         VjwpFPhdmsbHtJnW6HoIq3kzbmXj9JsBB+ujequAAJYAD7M65wAgm6qgyeXuTEZMj9
         k3KV6pv4vfHLhAySscU/JItfJX2hiKrb0681ODh6FHBm2x7zkcZBWdBE8HfKVy7Q3r
         zwnPffk1Avm5A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50305abe5f0so1516194e87.2;
        Thu, 12 Oct 2023 08:04:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YzkPDh/eh/7xFUJ9ezdKvoQcOHPuCBgavALTtWeYxpNpewgBMuH
        fLq7cCDehqRVirVKTX/jiNiFAU17vaH3uQts+A==
X-Google-Smtp-Source: AGHT+IHIvQVJksv+cxRwuuB70cl4gPO5kN5IBSa3Kgn2Ca6c2r1lJhrSWvp9g3KCs3skbUuscijBaovAs8kQVvAkYKs=
X-Received: by 2002:a05:6512:10c9:b0:504:3807:22a4 with SMTP id
 k9-20020a05651210c900b00504380722a4mr24937247lfg.23.1697123054598; Thu, 12
 Oct 2023 08:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231009211356.3242037-3-robh@kernel.org> <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
 <20231012092618.GF8314@google.com>
In-Reply-To: <20231012092618.GF8314@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Oct 2023 10:04:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK22vWx1VPnrwEh+N-6vy5a7npFSW-=gp1uabTPSG2PpA@mail.gmail.com>
Message-ID: <CAL_JsqK22vWx1VPnrwEh+N-6vy5a7npFSW-=gp1uabTPSG2PpA@mail.gmail.com>
Subject: Re: [PATCH] mfd: Use device_get_match_data()
To:     Lee Jones <lee@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 4:26=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 10 Oct 2023, Chen-Yu Tsai wrote:
>
> > On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > Use preferred device_get_match_data() instead of of_match_device() to
> > > get the driver match data. With this, adjust the includes to explicit=
ly
> > > include the correct headers.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/mfd/axp20x.c           | 22 +++-------------------
> >
> > I'd keep the error message, but otherwise for axp20x,
> >
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >
> > >  drivers/mfd/hi6421-pmic-core.c |  9 +++------
> > >  drivers/mfd/mxs-lradc.c        |  9 ++-------
> > >  drivers/mfd/qcom-spmi-pmic.c   |  6 ++++--
> > >  drivers/mfd/qcom_rpm.c         |  8 ++++----
> > >  drivers/mfd/tps65910.c         | 11 ++---------
> > >  drivers/mfd/twl4030-power.c    |  9 +++------
> > >  drivers/mfd/twl6030-irq.c      | 10 +++++-----
> > >  8 files changed, 26 insertions(+), 58 deletions(-)
>
> FYI, this patch is not in my inbox.

There seems to be some issue with kernel.org delivering my mails. You
are not the only one. I thought it was just ones with large numbers of
recipients, but seems to be something else. Konstantin has been
looking into it. Do you see any pattern of mails you do receive from
me? Sent via google vs. kernel.org?

Rob
