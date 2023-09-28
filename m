Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961E7B290D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjI1XxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjI1XxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:53:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D223199;
        Thu, 28 Sep 2023 16:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C74C433C8;
        Thu, 28 Sep 2023 23:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695945202;
        bh=LgHeWUx0JGY5CAGIQsUbCEJNxNMNHJ6aWxCT60chWhs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ugY856GiT71C7tZvaYRtjifR7PXC7IzDlj//CbKQSWKBPCdrLnOdSVGEIN6/GYdAQ
         G82ungix+sKip9fdsSTLvkHlkWsbG9jeyjTu6geZBya3De199c8BRzoNuwG6ZoYOcY
         BlD3EGCUwslgVptUqiyGWfWXbSbgp9VZW+Ct8do87kBqTNozN9pfoi2sZmsmO7nLMN
         hrPt1KNjBFldaHrvhLnbU2Tlzj3fNlN4k0/KqV+GOPP/8eCNe2LvEGeoEd6FgeqRwb
         hvX21G+6jXMD8iu6TSG1XzF0V99CjmUehxzWtPbTfOiFb5G+YW/NGZRa3P0neO40H9
         OcodqH8pMwcvg==
Message-ID: <be6ec178bec389ee9094dc62692b7b07.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b6ded7b6-1818-402f-8826-2ab1ecd05056@linaro.org>
References: <20230913175612.8685-1-danila@jiaxyga.com> <539752971c7a61ce7a5deddc1478686a.sboyd@kernel.org> <b6ded7b6-1818-402f-8826-2ab1ecd05056@linaro.org>
Subject: Re: [PATCH] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     adomerlee@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Danila Tikhonov <danila@jiaxyga.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, dkatraga@codeaurora.org,
        mturquette@baylibre.com, quic_tdas@quicinc.com, vkoul@kernel.org
Date:   Thu, 28 Sep 2023 16:53:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-09-15 05:04:41)
> On 14.09.2023 18:20, Stephen Boyd wrote:
> > Quoting Danila Tikhonov (2023-09-13 10:56:11)
> >> Set .flags =3D CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: r=
cg
> >> didn't update its configuration" error.
> >>
> >> Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driv=
er for SM8150")
> >> Tested-by: Arseniy Velikanov <adomerlee@gmail.com>
> >> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> >> ---
> >>  drivers/clk/qcom/gcc-sm8150.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm81=
50.c
> >> index 41ab210875fb..05d115c52dfe 100644
> >> --- a/drivers/clk/qcom/gcc-sm8150.c
> >> +++ b/drivers/clk/qcom/gcc-sm8150.c
> >> @@ -774,7 +774,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src =3D {
> >>                 .name =3D "gcc_sdcc2_apps_clk_src",
> >>                 .parent_data =3D gcc_parents_6,
> >>                 .num_parents =3D ARRAY_SIZE(gcc_parents_6),
> >> -               .flags =3D CLK_SET_RATE_PARENT,
> >> +               .flags =3D CLK_OPS_PARENT_ENABLE,
> >>                 .ops =3D &clk_rcg2_floor_ops,
> >=20
> > In what case are we getting the rcg stuck? I thought that you could
> > write the rcg registers while the parent was off and switch to that
> > parent if the parent isn't enabled and it wouldn't get stuck.
> I think the better question here would be "why isn't
> OPS_PARENT_ENABLE the default for all qc clocks on all
> platforms" :/
>=20

We don't need that flag because of how the hardware works and how the
clk framework moves the enable of the parent from the old parent to the
new parent when changing rates. The RCGs only get stuck if we change the
parent of an RCG to a disabled parent when the current parent is enabled
and the RCG is enabled. Otherwise we're free to change the parent of the
RCG because it isn't trying to do a glitch free switch of clk frequency.

Is it possible that the clk is running out of boot on a parent that
is enabled in the hardware but doesn't look enabled to the clk framework
because of how we fail to hand off enable state? Maybe the mmc driver
then calls clk_set_rate() to change the rate (rcg is still off) and that
causes problems?
