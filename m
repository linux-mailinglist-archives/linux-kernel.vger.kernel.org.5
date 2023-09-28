Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6FB7B1361
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjI1Gx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjI1Gx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:53:26 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B7AF;
        Wed, 27 Sep 2023 23:53:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65E3940007;
        Thu, 28 Sep 2023 06:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695884003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OReqblEEvau13fBxegnIsM+9N/VACcGD37SP4szyU/I=;
        b=TaUHaVYt9TnFTD/8oZWmCi+lYprkZJyCoeWm15WUr1DXd8mVexfw3JkiJMj0QyFQj+Upzp
        MHcylsujykkGzk9TPSMLRRxb9GPxGxQhh7A5/qgb2bpyNHVNzKHFFKXIKn9fSZ9FWd3uI5
        dh0QSP9nBCrBVk0emU6PtdcSozbV2Wj7RdEAUODzQ7WBTOMQgjSPfzjMPW56gJ3LxV1vlC
        e1UaeTIY2+hgAdQlp72UkvdA2eERdcG2K8vh7EKoZ3xz0syWJaEKK+9o/YJXnqYVQb2bqw
        5badb6K6nmMF1hwVCe3G+xgsE8xMDdMWMckDwbyfLbyQT8LV78tUobwRlT5IGQ==
Date:   Thu, 28 Sep 2023 08:53:19 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Prathamesh Shete <pshete@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: tegra: Add support to display pin function
Message-ID: <20230928085319.0b09bf7d@booty>
In-Reply-To: <CACRpkdbZ0cxA_y=6j_QQpF1SQ1q4hw-qUyeOnEK-+cLBd=gjCg@mail.gmail.com>
References: <0cf720bf-ae4b-5780-bda4-5c9bbb2d1d67@nvidia.com>
        <20230714113547.15384-1-pshete@nvidia.com>
        <20230925183049.10a40546@booty>
        <CACRpkdbZ0cxA_y=6j_QQpF1SQ1q4hw-qUyeOnEK-+cLBd=gjCg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Prathamesh,

On Wed, 27 Sep 2023 10:54:15 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Sep 25, 2023 at 6:30=E2=80=AFPM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
>=20
> > The symptom is that i2c3 is not working anymore, the I2C lines being
> > always high. No other known issues at the moment. =20
>=20
> Hm....
>=20
> >> +     {"nvidia,function",             TEGRA_PINCONF_PARAM_FUNCTION}, =
=20
> >
> > FYI, I reduced your patch to only this line plus the one in the
> > pinctrl-tegra.h and the problem appears as well. =20
>=20
> I think there is a conflict now, that the pinconf is "stealing" the funct=
ion
> assignment from the pinmux call.
>=20
> It's just a debugprint, I will revert the patch, Luca can investigate and=
 you

Thanks for the quick revert Linus.

> can test a new patch then we will merge that.

Prathamesh, if you send a new patch it would be great if you can Cc: me so I
can test it.

Best regards,
Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
