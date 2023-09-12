Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADB79D766
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjILRST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbjILRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:18:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C8310F4;
        Tue, 12 Sep 2023 10:18:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8967CC433C8;
        Tue, 12 Sep 2023 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694539093;
        bh=+2q46O7efDXVGtNITaVnlXpqniY/rjlpX0v8ey8+6L0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fgFTkWWLOfuQzE/RIqe1KySaJA0A6/r1GgKbxoH2HvpA9PiX4Fmq2wZ0+RIifXEFo
         ArgRoNDAQxa2IZjNtwQIwfwP25wDrnGaeOKu1p+6eRCIjTbuWjJVckt0t87hWvZwwn
         TJSM+HTmP8j6wQdDGbwVRGQuaI4wIdi/cQJNW0dKbK9+72cXNqOLqhmuRMq5kZ7P8M
         hU/pOqpFd121kKYuOotZJDhKqvZc85Dhcye8la7Fbim9Qfn+IB+nxo2/yVkSO0LMd+
         QKHBiiuths6GeyeGXHnEuncCEkVv7Y+XckSEvHTSvjZynHvLtr+P/9Nh7vzrcZNJ08
         aUdpNTF7QBH0g==
Message-ID: <82adb75659e0d278e25b65b0e81df99a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f67b354c-8a4b-49f5-6275-66b7d614301a@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-5-quic_luoj@quicinc.com> <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org> <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com> <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org> <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com> <92058c25fb11b75ee0a2298a684825e9.sboyd@kernel.org> <f67b354c-8a4b-49f5-6275-66b7d614301a@quicinc.com>
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for qca8386/qca8084
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Tue, 12 Sep 2023 10:18:11 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jie Luo (2023-09-12 05:07:02)
>=20
>=20
> On 9/12/2023 4:11 AM, Stephen Boyd wrote:
> > Quoting Jie Luo (2023-09-08 04:10:35)
> >>
> >> For example, when the uniphy works on PHY_INTERFACE_MODE_2500BASEX, th=
en
> >> the parent uniphy clock rate is 312.5M, which is decided by hardware a=
nd
> >> can't be changed. when a branch clock requires a 25M clock, the parent
> >> uniphy clock maybe updated to 125M by clock framework if the flag
> >> CLK_SET_RATE_PARENT is set here, but the actual hardware clock rate of
> >> uniphy is still 315.5M since the uniphy still works in the interface
> >> mode PHY_INTERFACE_MODE_2500BASEX.
> >>
> >=20
> > If the parent rate can't change because CLK_SET_RATE_PARENT is missing
> > and the hardware doesn't allow it, then perhaps instead of having a
> > frequency table we should have rcg clk ops for determine_rate that
> > simply looks at the parent rates and finds the rate closest to what is
> > desired. And for the set_rate clk_op we can have it be simple and just
> > program a fixed divider. The benefit is less frequency tables that don't
> > do anything and less hard-coding of the frequency. I thought we already
> > had those rcg clk_ops but I couldn't find them with a quick glance.
>=20
> Thanks Stephen for the suggestion.
> looks you are saying the clk ops clk_dp_ops for the fix parent rate?=20
> which seems not meet the clock requirement of this clock.

Yeah that is close, but the determine_rate clk_op needs to look at all
possible parents. With the dp clk_ops we assume that only one parent is
possible.

>=20
> For the device qca8k, it is also possible to switch the interface modes=20
> between PHY_INTERFACE_MODE_2500BASEX(312.5M) and=20
> PHY_INTERFACE_MODE_SGMII(125M) during the running time, and there are=20
> multiple parent clock source(P_UNIPHY0_RX or P_UNIPHY0_TX) for the RCG=20
> clocks to select according to the current work mode. so the parent_map=20
> and freq_tbl are necessary to this clock.

I still don't see why the freq_tbl is necessary.
