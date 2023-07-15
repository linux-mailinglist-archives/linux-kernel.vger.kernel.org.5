Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A9754A60
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGORGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGORGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1211FD4;
        Sat, 15 Jul 2023 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC8E60BDC;
        Sat, 15 Jul 2023 17:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0121DC433C8;
        Sat, 15 Jul 2023 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689440770;
        bh=MLejEykMJKj8A/MgI7/bT7n1FQkM4frnAM5tZ06lL/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAq/F0GwvataK9m/GiwGFRtNa9g+I2zA9JwvQFIY+MFSjjd9NzW1GP93Bd4YpDDsO
         6b2fQWmZFtzPf7riHfGHSjiy/HNFhn2mBpFmbp+wOyOZ2iXx/2kAKDUm6kSGvaxNgn
         xoToVOwejdgNau/oshD4EtP5w/pKjLqEdNbeiBnO2GMMvc2lbY/EbHM39nXT2Hv0PA
         WiyuDx39mzRZe5ufITcqoQaIHoXmjzot6rUnp+jmmqKReZ1q3bra9P8+BlZOEYO+mM
         d8vSs2hcY42SjWG3nQVxWGdqQZCs8hWjQ0r84Mx3/S5wILA/aJXJeSV/dNAugUW3Bu
         oV34Rio98DiIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v7 00/22] Restructure RPM SMD ICC
Date:   Sat, 15 Jul 2023 10:09:36 -0700
Message-ID: <168944095056.1619705.13623986680500066147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2023 15:04:25 +0200, Konrad Dybcio wrote:
> This series reshuffles things around, moving the management of SMD RPM
> bus clocks to the interconnect framework where they belong. This helps
> us solve a couple of issues:
> 
> 1. We can work towards unused clk cleanup of RPMCC without worrying
>    about it killing some NoC bus, resulting in the SoC dying.
>    Deasserting actually unused RPM clocks (among other things) will
>    let us achieve "true SoC-wide power collapse states", also known as
>    VDD_LOW and VDD_MIN.
> 
> [...]

Applied, thanks!

[01/22] dt-bindings: interconnect: Add Qcom RPM ICC bindings
        commit: 7296bd3f0046f87e089499865345ab337598f5ab
[02/22] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
        commit: cb0116090e4cff6da2e9abd1c29b8e16491af176
[03/22] soc: qcom: smd-rpm: Use tabs for defines
        commit: 82a793e2d3e3da748f23a0fbe0b4615292625fe8
[04/22] clk: qcom: smd-rpm: Move some RPM resources to the common header
        commit: e1e1267413d2e9fbe3a34c5a5f701b0f5fb0bf2c
[05/22] soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm
        commit: 410da7e344a69faf65af8a1e80d9963648a9e6a3
[06/22] interconnect: qcom: icc-rpm: Introduce keep_alive
        commit: b979049c38e170286158e97290c892957c836903
[07/22] interconnect: qcom: Add missing headers in icc-rpm.h
        commit: 40cdeed66933abc80a9b133f062770af616ce50a
[08/22] interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
        commit: 19ced2aec6cdff7d227e012f7ac63d28dae07288
[09/22] interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
        commit: a927eb09d49c73f5250d61d5b7a0b5de09ab6a28
[10/22] interconnect: qcom: Define RPM bus clocks
        commit: 918b86042b48da5ea86d0a12495dff95241dedd3
[11/22] interconnect: qcom: sdm660: Hook up RPM bus clk definitions
        commit: 70ab8dee97d66560cacf0c58ac6adfcdcab43922
[12/22] interconnect: qcom: msm8996: Hook up RPM bus clk definitions
        commit: 9258801ef94f166b519c3f4364f72c7766b9e7e4
[13/22] interconnect: qcom: qcs404: Hook up RPM bus clk definitions
        commit: a923b8bbeb145ba192b3f1402de1582eab5adc50
[14/22] interconnect: qcom: msm8939: Hook up RPM bus clk definitions
        commit: 258a64f26679523dadb8fd60e9dd1538cab811f1
[15/22] interconnect: qcom: msm8916: Hook up RPM bus clk definitions
        commit: 6424985edee17772a83c8e8d1313f511e458f649
[16/22] interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
        commit: 9d0a282c3e26c59c5a90d5fb4c167fe103f53bc8
[17/22] interconnect: qcom: icc-rpm: Control bus rpmcc from icc
        commit: 11f63efe58a052da3f4d179ba6fdccd128bc95ee
[18/22] clk: qcom: smd-rpm: Separate out interconnect bus clocks
        commit: d6edc31f3a68d8d0636e0cfcd9eced7460ad32f4
[19/22] interconnect: qcom: icc-rpm: Fix bucket number
        commit: 6ed0e5e60e444c135ce56169784695b5f5fcd1f9
[20/22] interconnect: qcom: icc-rpm: Set bandwidth on both contexts
        commit: 32846c4a8f2a80c0138aee07543e7c305d75abea
[21/22] interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
        commit: 3b7480106bf8ac2666d901e42bf9835959f79e7f
[22/22] interconnect: qcom: icc-rpm: Fix bandwidth calculations
        commit: 17fc623e0f728c35b82a0e79cd4f3b8aab495663

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
