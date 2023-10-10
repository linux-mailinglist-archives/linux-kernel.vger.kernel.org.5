Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11C7BFA22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjJJLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjJJLoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFE9D;
        Tue, 10 Oct 2023 04:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57613C433C9;
        Tue, 10 Oct 2023 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696938292;
        bh=VC+x3Y/F4Qrg2tx3eHXgksT4LBINTp7diDgIAns//EE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLfERQnEFbPfemzTphhNmBNQ/alGED5ET/yZctDg3dKrzyqNcu6UJXB8OFe2W67Fp
         aHIaHszIrQztKk8QJmLUlWNPqNFoPLpnYQDdkTa+NCmuHbihGRYUSWx2jVcVL0dj4j
         Yoyl3jVWIVkUMuzkZtmcDQAsOZAgI0I0lz83N3hWluEKwzWVHYEPSWeT/57lugaQVq
         kAQlfHwAMTRRxua90XxwY1m5WvrHUGnGUlBE8K7PkicU30DH5CcgVKaK/t4NbjMs+B
         JO1fvPNu8WGWqq0w1mpNTTQoEXyq2xLI9n729i3Zgi2SkK3oSMyUp2gIhWpaQ74Zhh
         5wFGG461dGQbw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-504427aae4fso8074084e87.1;
        Tue, 10 Oct 2023 04:44:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YyQ794ifvUiHM4x7iqTbbNG9+Dft1qtFSOBxIwQUAs00IZmQga9
        OicUkZDRtrqJlCx6DDb/5Mn5/wL/spubplsiRg==
X-Google-Smtp-Source: AGHT+IGAClhimcIf+YAzz2GCzR0wdzr7YTMHCXm3mvTiQBxYs/lkyUsWdSQuybb0savjSn2f8QaT9SjgK+8co/BPV8g=
X-Received: by 2002:ac2:5a10:0:b0:503:224f:9c55 with SMTP id
 q16-20020ac25a10000000b00503224f9c55mr12742893lfn.8.1696938290524; Tue, 10
 Oct 2023 04:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231009211356.3242037-3-robh@kernel.org> <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
In-Reply-To: <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Oct 2023 06:44:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4yCNnvg=CfY6_NbcgED9FuExK6SDTxDERFHK7Hp9-+g@mail.gmail.com>
Message-ID: <CAL_JsqJ4yCNnvg=CfY6_NbcgED9FuExK6SDTxDERFHK7Hp9-+g@mail.gmail.com>
Subject: Re: [PATCH] mfd: Use device_get_match_data()
To:     wens@csie.org
Cc:     Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 3:27=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/mfd/axp20x.c           | 22 +++-------------------
>
> I'd keep the error message, but otherwise for axp20x,

Why? It can't happen. We already matched successfully in order to
probe, so matching again in probe is redundant and won't fail.

> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks.

Rob
