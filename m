Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215FA7849F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjHVTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHVTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D65ECD1;
        Tue, 22 Aug 2023 12:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 060AD63F0C;
        Tue, 22 Aug 2023 19:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423E6C433C7;
        Tue, 22 Aug 2023 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692731429;
        bh=eu9VEfAYz4xOHMvSGfeTJy1FSyA8KLmA3Mo65tCtRWg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F8DzFuQCUHOw1eYq0kub61a6e48jKYbrToANBn5UzrgTPQfr5gi/rF6JOwHMxloUc
         YaTD8qdgzndT7FD+RbaNZwVtQ59rU6CiaEAwyTFwo+v6yWXX8dncSeqG1o72UezOwt
         EqRk3r3Pn7QCXrWuzTfJtzk1SlhocDZ3Hms60HDBZRl0kW/42Go+emToHL4fUA38yu
         uMzVllBc+7LoyRlB8tvFcJuJxwC//A+LJr4QxV/SvzUDl3vhaSg3WtIWbfjy9Lg5QV
         U0WSTb57JW3OiuA5yDnIhzZWOIEPDBojG7kR+JJ4bmrjYByYwCUA0I9Jl/524QQNmf
         jY0i/uwhJQSng==
Message-ID: <6e781c2d21e346cdd7f84c3b7a57dafc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6ebdcbdc-409c-0c08-1e5d-f9aa0b92c3b2@quicinc.com>
References: <20230810115419.25539-1-quic_luoj@quicinc.com> <20230810115419.25539-4-quic_luoj@quicinc.com> <9dec09fa-a5a3-416c-9b4d-4b4c4e10320b@linaro.org> <9a55016f-0049-f185-f2be-d138fe33384b@quicinc.com> <631d5a82-7d24-49cd-9868-74c7b3c08bcd@linaro.org> <6ebdcbdc-409c-0c08-1e5d-f9aa0b92c3b2@quicinc.com>
Subject: Re: [PATCH v3 3/3] clk: qcom: add clock controller driver for qca8386/qca8084
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Jie Luo <quic_luoj@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, will@kernel.org
Date:   Tue, 22 Aug 2023 12:10:25 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jie Luo (2023-08-14 03:58:26)
>=20
>=20
> On 8/12/2023 6:56 PM, Konrad Dybcio wrote:
> > My main point is, why can't you use qcom_cc_really_probe?
> >=20
>=20
> Hi Konrad,
> qcom_cc_really_probe is taking the platform_device as the input=20
> parameter, but the nss_cc_qca8k_probe takes the mdio_device as the probe =

> parameter.

There's no real reason why it takes a platform device instead of a plain
struct device. You can have an earlier patch change that function to
take a struct device instead.
