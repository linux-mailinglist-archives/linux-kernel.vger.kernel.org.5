Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109157529F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGMRiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGMRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF782702;
        Thu, 13 Jul 2023 10:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA7A61B0F;
        Thu, 13 Jul 2023 17:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E3AC433C7;
        Thu, 13 Jul 2023 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689269885;
        bh=cPHXnkrWCGZfLGF4pteF6cvNZy/RFWB1yAQYsM3jZXU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zvzuze6KmY+7yXkLyxwoXJlboJ7ayq8+PQ1FcMUdGQJZIyTU31+dQTcieundP5pGQ
         A508b+6ovFLERHWgMnRbqgsfKccMJyWs0vW8I1LlcMwHX7x/8dx/I2J19quHlVNaBv
         eiugCCbbukh9MZjQ2S9KCWte5omqGJ2rdAAIHrG2LcdhjqFinL5bBLdhV2BwmolqRf
         OMl+0416Bzy162zJzPH4YvnFCjSTEKVpzdEGKMr/1h5GHdUTlQ3Qtamzsz4qao+BUM
         pe5PO6SoIFtI77I/fuWrofA3IRXs7yFMd3WZtZDBpKTftPk3lBVlksUiM5lI546dov
         RtsGtqGWM/jQw==
Message-ID: <de875511-7356-32cd-514a-ac532d75a8fd@kernel.org>
Date:   Thu, 13 Jul 2023 20:37:57 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v7 00/22] Restructure RPM SMD ICC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 16:04, Konrad Dybcio wrote:
> This series reshuffles things around, moving the management of SMD RPM
> bus clocks to the interconnect framework where they belong. This helps
> us solve a couple of issues:
> 
> 1. We can work towards unused clk cleanup of RPMCC without worrying
>     about it killing some NoC bus, resulting in the SoC dying.
>     Deasserting actually unused RPM clocks (among other things) will
>     let us achieve "true SoC-wide power collapse states", also known as
>     VDD_LOW and VDD_MIN.
> 
> 2. We no longer have to keep tons of quirky bus clock ifs in the icc
>     driver. You either have a RPM clock and call "rpm set rate" or you
>     have a single non-RPM clock (like AHB_CLK_SRC) or you don't have any.
> 
> 3. There's less overhead - instead of going through layers and layers of
>     the CCF, ratesetting comes down to calling max() and sending a single
>     RPM message. ICC is very very dynamic so that's a big plus.
> 
> The clocks still need to be vaguely described in the clk-smd-rpm driver,
> as it gives them an initial kickoff, before actually telling RPM to
> enable DVFS scaling.  After RPM receives that command, all clocks that
> have not been assigned a rate are considered unused and are shut down
> in hardware, leading to the same issue as described in point 1.
> 
> We can consider marking them __initconst in the future, but this series
> is very fat even without that..
> 
> Apart from that, it squashes a couple of bugs that really need fixing..
> 
> --- MERGING STRATEGY ---
> If Stephen and Georgi agree, it would be best to take all of this through
> the qcom tree, as it touches on heavily intertwined components and
> introduces compile-time dependencies between icc and clk drivers.
> 
> Tested on SM6375 (OOT), MSM8998 (OOT), MSM8996.
> 
> MSM8974 conversion to common code and modernization will be handled separately.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v7:
> - Rebase on next-20230619
> - Throw some consts at "Separate out interconnect bus clocks"
> - Link to v6: https://lore.kernel.org/r/20230526-topic-smd_icc-v6-0-263283111e66@linaro.org
> 
> Changes in v6:
> - Fix argument naming in "Add rpmcc handling skeleton code"
> - Fix missing clk.h and reorder patch "Add missing headers in icc-rpm.h",
>    drop Dmitry's rb
> - Pick up tags
> - Link to v5: https://lore.kernel.org/r/20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org
> 
> Changes in v5:
> - Pass RPM context id to qcom_icc_rpm_set_bus_rate()
> - Fix min_t call cutting off bits 32-63 in set() path
> - Pick up tags
> - Link to v4: https://lore.kernel.org/r/20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org
> 
> Changes in v4:
> - Only set clk rate on a context if necessary
> - Mention qcom,icc.h is not the correct header in "Control bus rpmcc form icc"
> - Fix the bindings (BIT vs 1<<)
> - Fix one more wrong use of qcom,icc.h in "Fix bucket numer" and uninclude it
> - Drop "Allow negative QoS offset" (will be handled separately)
> - Export icc clocks descriptions to unbreak =m builds
> - Pick up tags
> - Link to v3: https://lore.kernel.org/r/20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org
> 
> Changes in v3:
> - Use devm_clk_get_optional and only get() the clock once
> - Drop unnecessary NULL-checks for qp->bus_clk
> - Handle ARM32 CCF limitations, add an explicit comment about them
> - Use Stephan's alternative rpmcc readiness check
> - Fix one more wrong usage of QCOM_ICC_NUM_BUCKETS in icc-rpm.h
> - Introduce new dt-bindings for icc rpm tags
> - Mention the rpm tags situation in the commit message of
>    "Fix bucket number"
> - Pick up tags
> - Link to v2: https://lore.kernel.org/r/20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org
> 
> Changes in v2:
> - Sort entries properly in "Add missing headers in icc-rpm.h"
> - Fix the check for no clocks on a given provider
> - Replace "Divide clk rate by src node bus width" with a proper fix
> - Add "Set correct bandwidth through RPM bw req"
> - Split "Add QCOM_SMD_RPM_STATE_NUM" into 2 logical changes
> - Move "Separate out interconnect bus clocks" a bit later in the series
> - Link to v1: https://lore.kernel.org/r/20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org
> 
> ---
> Konrad Dybcio (21):
>        dt-bindings: interconnect: Add Qcom RPM ICC bindings
>        soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
>        soc: qcom: smd-rpm: Use tabs for defines
>        clk: qcom: smd-rpm: Move some RPM resources to the common header
>        interconnect: qcom: icc-rpm: Introduce keep_alive
>        interconnect: qcom: Add missing headers in icc-rpm.h
>        interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
>        interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
>        interconnect: qcom: Define RPM bus clocks
>        interconnect: qcom: sdm660: Hook up RPM bus clk definitions
>        interconnect: qcom: msm8996: Hook up RPM bus clk definitions
>        interconnect: qcom: qcs404: Hook up RPM bus clk definitions
>        interconnect: qcom: msm8939: Hook up RPM bus clk definitions
>        interconnect: qcom: msm8916: Hook up RPM bus clk definitions
>        interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
>        interconnect: qcom: icc-rpm: Control bus rpmcc from icc
>        clk: qcom: smd-rpm: Separate out interconnect bus clocks
>        interconnect: qcom: icc-rpm: Fix bucket number
>        interconnect: qcom: icc-rpm: Set bandwidth on both contexts
>        interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
>        interconnect: qcom: icc-rpm: Fix bandwidth calculations
> 
> Stephan Gerhold (1):
>        soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm
> 
>   drivers/clk/qcom/clk-smd-rpm.c                  | 314 +++++++++++-------------
>   drivers/interconnect/qcom/Makefile              |   2 +-
>   drivers/interconnect/qcom/icc-rpm-clocks.c      |  77 ++++++
>   drivers/interconnect/qcom/icc-rpm.c             | 220 +++++++++--------
>   drivers/interconnect/qcom/icc-rpm.h             |  56 ++++-
>   drivers/interconnect/qcom/msm8916.c             |   5 +-
>   drivers/interconnect/qcom/msm8939.c             |   6 +-
>   drivers/interconnect/qcom/msm8974.c             |   2 +-
>   drivers/interconnect/qcom/msm8996.c             |  10 +-
>   drivers/interconnect/qcom/qcm2290.c             |   8 +-
>   drivers/interconnect/qcom/qcs404.c              |   5 +-
>   drivers/interconnect/qcom/sdm660.c              |   8 +-
>   drivers/interconnect/qcom/smd-rpm.c             |  23 +-
>   drivers/interconnect/qcom/smd-rpm.h             |  15 --
>   drivers/soc/qcom/smd-rpm.c                      |  17 +-
>   include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +
>   include/linux/soc/qcom/smd-rpm.h                |  20 +-
>   17 files changed, 456 insertions(+), 345 deletions(-)

Thank you, Konrad!

Acked-by: Georgi Djakov <djakov@kernel.org>
