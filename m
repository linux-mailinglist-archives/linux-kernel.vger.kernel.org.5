Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C687C86BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjJMNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjJMNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:24:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9EBF;
        Fri, 13 Oct 2023 06:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E57AC433C8;
        Fri, 13 Oct 2023 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697203482;
        bh=DXD2n3lw7R9QASaArWId5yVPhw2darOc4gEAixH7m+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CpKFHdhDblXEUaU8fSL9OQ7xwrIDt31Mc2wsgd+K24qRYXBcmkHoF7c4fRMdes7Gp
         pyzXHJIdrQJetG+NuE3a4wUaJ0/oE9bz8frF7+bJB2/BNrrsvKrJUn2BgxSsZDHDdb
         bTtYL0mNVr9xoJ6P7uF8CEM20rpn5ptBG2h6cEyzjpCQpf6d8VHCnwBVoNWXn+10s5
         QoVrpQdIab2hFHoDFDNeZ77KZgZfqM9hyiA18PXf2gyHUUTQLGErkQAof/IW/WGiM1
         +aJe+AvKZYKbOfu9H2lEnw9ywaj3xRBWQf+Hr8ZJpEx9qq/XGz4tDJKTk24mIA8xpJ
         smm5immSKJ/aw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so135311e87.0;
        Fri, 13 Oct 2023 06:24:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YwgA8wADbg5nX9KuVAhO7hKu7GoqXlNyaRTTzE0j44EJ9zGO7Sr
        e961gUEOkeGMjTv0SVyvfu6MvUrUW5QbeaD+Wg==
X-Google-Smtp-Source: AGHT+IHHroMmww0agiEPVzEVo0tjPHXH3HK14ikXDF+BcgDzedCjEui9M7NjZsUiDMzkjtfCZfMSaiHT+CXMkpmXT2M=
X-Received: by 2002:ac2:5e9d:0:b0:507:9a06:7db2 with SMTP id
 b29-20020ac25e9d000000b005079a067db2mr87070lfq.1.1697203480364; Fri, 13 Oct
 2023 06:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231009211356.3242037-3-robh@kernel.org> <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
 <20231012092618.GF8314@google.com> <CAL_JsqK22vWx1VPnrwEh+N-6vy5a7npFSW-=gp1uabTPSG2PpA@mail.gmail.com>
 <20231013101734.GJ8314@google.com>
In-Reply-To: <20231013101734.GJ8314@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Oct 2023 08:24:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKkO1EqQfnYdhuno-KPPtL311m_sSGRz0CGW_CeOdTayA@mail.gmail.com>
Message-ID: <CAL_JsqKkO1EqQfnYdhuno-KPPtL311m_sSGRz0CGW_CeOdTayA@mail.gmail.com>
Subject: Re: [PATCH] mfd: Use device_get_match_data()
To:     Lee Jones <lee@kernel.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, Shawn Guo <shawnguo@kernel.org>,
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

On Fri, Oct 13, 2023 at 5:17=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 12 Oct 2023, Rob Herring wrote:
>
> > On Thu, Oct 12, 2023 at 4:26=E2=80=AFAM Lee Jones <lee@kernel.org> wrot=
e:
> > >
> > > On Tue, 10 Oct 2023, Chen-Yu Tsai wrote:
> > >
> > > > On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Rob Herring <robh@kernel.or=
g> wrote:
> > > > >
> > > > > Use preferred device_get_match_data() instead of of_match_device(=
) to
> > > > > get the driver match data. With this, adjust the includes to expl=
icitly
> > > > > include the correct headers.
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  drivers/mfd/axp20x.c           | 22 +++-------------------
> > > >
> > > > I'd keep the error message, but otherwise for axp20x,
> > > >
> > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > >  drivers/mfd/hi6421-pmic-core.c |  9 +++------
> > > > >  drivers/mfd/mxs-lradc.c        |  9 ++-------
> > > > >  drivers/mfd/qcom-spmi-pmic.c   |  6 ++++--
> > > > >  drivers/mfd/qcom_rpm.c         |  8 ++++----
> > > > >  drivers/mfd/tps65910.c         | 11 ++---------
> > > > >  drivers/mfd/twl4030-power.c    |  9 +++------
> > > > >  drivers/mfd/twl6030-irq.c      | 10 +++++-----
> > > > >  8 files changed, 26 insertions(+), 58 deletions(-)
> > >
> > > FYI, this patch is not in my inbox.
> >
> > There seems to be some issue with kernel.org delivering my mails. You
> > are not the only one. I thought it was just ones with large numbers of
> > recipients, but seems to be something else. Konstantin has been
> > looking into it. Do you see any pattern of mails you do receive from
> > me? Sent via google vs. kernel.org?
>
> How would I know which emails I haven't received from you? :)

Compare what you have to this:

https://lore.kernel.org/all/?q=3Df%3Arobh+tc%3Alee%40kernel.org

Rob
