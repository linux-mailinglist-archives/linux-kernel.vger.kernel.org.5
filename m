Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE379C09F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345671AbjIKVVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbjIKUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:11:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF601A7;
        Mon, 11 Sep 2023 13:11:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24984C433C8;
        Mon, 11 Sep 2023 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694463111;
        bh=ySOy1ntTpmfk22+fRD8pdPWyjkkC8+f/y/eC+bME0oE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MyPfMJI2SEc+Qk6sOGnLx9KeEb9kCrv+ifG7xCdKi/eQTgJ0CfIo4DzMU7NNUctKb
         u0aO0ODwRsmRtIYihB0AATXinrSBJhEUKVqykwPfNuvKfmh1RMUG0N+BPEL7nY8yU7
         vAUzQno0UmXmBpYEIn57u7JKaT+g9JBW63qulumsriu8Oi+Zf9VmwAhuoKlD1RYRi8
         9PJ3qGQPiOI0D/ysEPTgpCsankGzekBhB/wXPwSrgoAph9He1Fe7/boAgRChMg6iw4
         wap0FW6tVDyDfWxXo5VsnZ06U3dPBYrsHAFz2Qphhph/OpMS6/fT/+O0cntmYe6QOP
         ajD+WhJkpwvxQ==
Message-ID: <92058c25fb11b75ee0a2298a684825e9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-5-quic_luoj@quicinc.com> <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org> <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com> <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org> <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com>
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
Date:   Mon, 11 Sep 2023 13:11:48 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jie Luo (2023-09-08 04:10:35)
>=20
>=20
> Yes, the uniphy implements the clock provider that supports changing=20
> rate, which will be upstream later, and nss_cc_mac5_rx_clk_src is the=20
> special case, which is only used in the switch device qca8386.

Ok great.

>=20
> For the phy device qca8084(uniphy has only 312.5M fix clock which is=20
> registered by device tree), this clock nss_cc_mac5_rx_clk_src is not used.
>=20
> The issue for the switch device(qca8386) here is the clock rate of=20
> parent uniphy can't be changed because of the clock rate requirement of=20
> branch clock, since the uniphy clock rate is decided by the current=20
> working interface mode(PHY_INTERFACE_MODE_2500BASEX with 312.5M or=20
> PHY_INTERFACE_MODE_SGMII with 125M).

Got it.

>=20
> For example, when the uniphy works on PHY_INTERFACE_MODE_2500BASEX, then =

> the parent uniphy clock rate is 312.5M, which is decided by hardware and =

> can't be changed. when a branch clock requires a 25M clock, the parent=20
> uniphy clock maybe updated to 125M by clock framework if the flag=20
> CLK_SET_RATE_PARENT is set here, but the actual hardware clock rate of=20
> uniphy is still 315.5M since the uniphy still works in the interface=20
> mode PHY_INTERFACE_MODE_2500BASEX.
>=20

If the parent rate can't change because CLK_SET_RATE_PARENT is missing
and the hardware doesn't allow it, then perhaps instead of having a
frequency table we should have rcg clk ops for determine_rate that
simply looks at the parent rates and finds the rate closest to what is
desired. And for the set_rate clk_op we can have it be simple and just
program a fixed divider. The benefit is less frequency tables that don't
do anything and less hard-coding of the frequency. I thought we already
had those rcg clk_ops but I couldn't find them with a quick glance.
