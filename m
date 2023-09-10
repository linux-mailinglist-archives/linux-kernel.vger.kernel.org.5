Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2B799E91
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346687AbjIJN5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIJN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:57:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A8CC5;
        Sun, 10 Sep 2023 06:57:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C9BC433C8;
        Sun, 10 Sep 2023 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694354233;
        bh=msSma7JeAnGtSAB/2hVF2hPfqZC05HK+fqnZnQOwubw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JHCY3VnNyIccxeUb4yhimP5OIdb1xsIqSG2cEdAyzpkkPMuyGHetr6fuSDYczo+bB
         z/vr/yH0jGjLE0vj7io5bpaaoZvw1DA454U8sPHGPD4DSEA4mPyv5zgvqRaxsHoNuS
         Iu2AhKs0KPQWQ93Yox0LUkMO+WHFzYlvs5sCYkElKRxlqpGpJKDxq4udsdFgUgO7j5
         2ZaoEY3RGL1+pZfw/p42uTOf30RUq8E4RdejReDX7hg5toFroxP4jkjh0l+8mD7c5W
         lvp4NPC4Z/O9J2LTYVdJgq7TVxh17p2HBnCRMSa3rP2ktsS/1ADzkthsq6o1/UY9mF
         Qeu2zJ8cQK3Kg==
Date:   Sun, 10 Sep 2023 14:57:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?5p2o5piO6YeR?= <magicyangmingjin@gmail.com>
Cc:     Mingjin Yang <mingjin.yang@unisoc.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Ling_Ling.Xu@unisoc.com,
        Jinfeng.Lin1@unisoc.com, Yangbin.Li@unisoc.com,
        Jiansheng.Wu@unisoc.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP
 serise pmic adc
Message-ID: <20230910145706.7cae84aa@jic23-huawei>
In-Reply-To: <CAKJtOf6N0P9Phqsm-2B1p1kCZ+Tezz3rZ8muLzAvXQoi=QFCtg@mail.gmail.com>
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
        <20230816080225.21482-3-mingjin.yang@unisoc.com>
        <20230828165709.56ffa299@jic23-huawei>
        <CAKJtOf5chsyPrnMZGv32YFvxG1x5cDtBQmzk7wRqCn7C2+cB=g@mail.gmail.com>
        <20230903121437.520e5da3@jic23-huawei>
        <CAKJtOf6N0P9Phqsm-2B1p1kCZ+Tezz3rZ8muLzAvXQoi=QFCtg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 10:59:33 +0800
=E6=9D=A8=E6=98=8E=E9=87=91 <magicyangmingjin@gmail.com> wrote:

> > > > > +static int sprd_adc_enable(struct sprd_adc_data *data, int chann=
el)
> > > > > +{
> > > > > +     int ret =3D 0;
> > > > > +     u32 reg_read =3D 0;
> > > > > +
> > > > > +     if (data->pm_data.clk_regmap) {
> > > > > +             ret =3D regmap_update_bits(data->pm_data.clk_regmap=
, data->pm_data.clk_reg,
> > > > > +                                      data->pm_data.clk_reg_mask,
> > > > > +                                      data->pm_data.clk_reg_mask=
);
> > > > > +             ret |=3D regmap_read(data->pm_data.clk_regmap, data=
->pm_data.clk_reg, &reg_read);
> > > > > +             if (ret) {
> > > > > +                     dev_err(data->dev, "failed to enable clk26m=
, channel %d\n", channel);
> > > > > +                     return ret;
> > > > > +             }
> > > > > +             dev_dbg(data->dev, "enable clk26m: ch %d, reg_read =
0x%x\n", channel, reg_read); =20
> > > >
> > > > Directly accessing the regmap of a clock seems unusual. Why not pro=
vide generic clock interfaces
> > > > for this? =20
> > >
> > > This register is used to vote to enable/disable the pmic 26m clk which
> > > is provided to modules like audio, typec and adc.
> > > Therefore, this clk cannot be disabled or enabled directly. =20
> >
> > clk_enable() and friends support reference counted enable and disable
> > so I don't understand why this needs something unusual. =20
>=20
> Through communication with internal clk colleagues,
> I learned that this register is not a traditional eb register,

eb?

Sorry, I'm not familiar with the term.

> so the current clk driver is not configured to support this.
>=20
> Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=883=E6=
=97=A5=E5=91=A8=E6=97=A5 19:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, 30 Aug 2023 15:15:12 +0800
> > =E6=9D=A8=E6=98=8E=E9=87=91 <magicyangmingjin@gmail.com> wrote:
> > =20
