Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134AF76EFED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjHCQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHCQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A333ABF;
        Thu,  3 Aug 2023 09:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB4B461E4D;
        Thu,  3 Aug 2023 16:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A5CC433C7;
        Thu,  3 Aug 2023 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691081295;
        bh=7ih77e1O1WRRHs0N4JvX9JDljcQRbssPj1LkTZtl7Jc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NRHLNhARAMl8lYehiE0faYX2zFBDY8X1+qIEZkiV1gXU/GtAiEDYaEy4yorCNtNPi
         m8wFMTIDzXp9lisRixB4A8mKSZTo30XlfeADvm6ktksCquOAmNSVloYGP9dNhLZGXN
         iT2JudKZyAAAp0PVHMzXMnrtdpJF19k7upG8IPZxPmSKiWuSyjNJtvAYn7ht6V3Z1b
         cqvgeIhqjUdz0UnLjAqi5V3SWXfp7NAZMZ5a3vN/iHIquHQeXdjwwqPhANAVW2pF0M
         faHgHYfADJbUXZirxovfuycyBsFPD55rAgO181D9B0qxNWf4iGT95SMp0Ya0x1e9ID
         jaxXBVcYqTPHw==
Message-ID: <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
Date:   Thu, 3 Aug 2023 19:48:08 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
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

Hi Konrad,

On 11.07.23 15:17, Konrad Dybcio wrote:
> Many parts of Qualcomm SoCs are entirely independent of each other and can
> run when the other parts are off. The RPMh system architecture embraces
> this by giving each (loosely defined) subsystem its own connection (as in,
> physical wires) to the AOSS, terminated by per-subsystem RSCs (Resource
> State Coordinators) that barter for power, bandwidth etc.
> 
> This series introduces the groundwork necessary for voting for resources
> through non-APPS RSCs. It should allow for lower-latency vote adjustments
> (e.g. for very high bandwidth / multiple displays) and could potentially
> allow for full APSS collapse while keeping e.g. MDSS operating (say
> refreshing an image from a RAM buffer).

This is good stuff. Thanks for working on it! Actually the path tagging,
that have been introduced some time ago could be used for supporting the
multiple RSCs. Today we can get the tags from DT, and tag the path with
some DISP_RSC flag (for example) and avoid the qcom,bcm-voter-idx property.

Mike has been also looking into this, so maybe he can share his thoughts.

> 
> On top of that, a rather necessary and overdue cleanup is performed to
> stop adding more and more arguments to the insane preprocessor macros.
> 

Retiring the DEFINE_QNODE is good clean-up, but some patches failed to
apply so a re-base would be needed.

Thanks,
Georgi

> Partially reverting (or reimplementing the revert) [1] will be necessary
> to coordinate the rather complex relationship between the DPU and RSC
> drivers.
> 
> The "Point x paths to the x RSC" patches won't do anything (check the
> compatibility workaround qcom_icc_pre_aggregate()) until disp_rsc is
> properly described in the device tree, along with its BCM voter),
> but they prepare ground for when that happens.
> 
> I was able to test sending requests through the DISP_RSC on SM8450, but
> I had to hack its clocks (_rscc_ in dispcc) to be always-on, as we don't
> have any clk handling for qcom,rpmh-rsc today.
> 
> Boot-tested on SM8350 and SM8450, nothing exploded.
> 
> [1] https://patchwork.kernel.org/project/dri-devel/patch/1521827074-28424-1-git-send-email-ryadav@codeaurora.org/
> 
> Dependencies:
> [2] https://lore.kernel.org/linux-arm-msm/113b50f8-35f6-73fc-4fc9-302262927c5e@quicinc.com/
> [3] https://lore.kernel.org/linux-arm-msm/20230703-topic-8250_qup_icc-v2-0-9ba0a9460be2@linaro.org/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (53):
>        dt-bindings: interconnect: qcom,icc: Introduce fixed BCM voter indices
>        dt-bindings: interconnect: qcom,bcm-voter: Add qcom,bcm-voter-idx
>        interconnect: qcom: icc-rpmh: Store direct BCM voter references
>        interconnect: qcom: icc-rpmh: Retire dead code
>        interconnect: qcom: icc-rpmh: Implement voting on non-APPS RSCs
>        interconnect: qcom: sc7180: Retire DEFINE_QNODE
>        interconnect: qcom: sdm670: Retire DEFINE_QNODE
>        interconnect: qcom: sdm845: Retire DEFINE_QNODE
>        interconnect: qcom: sdx55: Retire DEFINE_QNODE
>        interconnect: qcom: sdx65: Retire DEFINE_QNODE
>        interconnect: qcom: sm6350: Retire DEFINE_QNODE
>        interconnect: qcom: sm8150: Retire DEFINE_QNODE
>        interconnect: qcom: sm8250: Retire DEFINE_QNODE
>        interconnect: qcom: sm8350: Retire DEFINE_QNODE
>        interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
>        interconnect: qcom: sc7180: Retire DEFINE_QBCM
>        interconnect: qcom: sdm670: Retire DEFINE_QBCM
>        interconnect: qcom: sdm845: Retire DEFINE_QBCM
>        interconnect: qcom: sdx55: Retire DEFINE_QBCM
>        interconnect: qcom: sdx65: Retire DEFINE_QBCM
>        interconnect: qcom: sm6350: Retire DEFINE_QBCM
>        interconnect: qcom: sm8150: Retire DEFINE_QBCM
>        interconnect: qcom: sm8250: Retire DEFINE_QBCM
>        interconnect: qcom: sm8350: Retire DEFINE_QBCM
>        interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
>        interconnect: qcom: qdu1000: Explicitly assign voter_idx
>        interconnect: qcom: sa8775p: Explicitly assign voter_idx
>        interconnect: qcom: sc7280: Explicitly assign voter_idx
>        interconnect: qcom: sc8180x: Explicitly assign voter_idx
>        interconnect: qcom: sc8280xp: Explicitly assign voter_idx
>        interconnect: qcom: sm8450: Explicitly assign voter_idx
>        interconnect: qcom: sm8550: Explicitly assign voter_idx
>        arm64: dts: qcom: qdu1000: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sa8775p: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sc7180: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sc7280: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sc8180x: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sc8280xp: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sdm670: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sdm845: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sdx75: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sm6350: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sm8150: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sm8250: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sm8350: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sm8450: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sm8550: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sdx55: add qcom,bcm-voter-idx
>        arm64: dts: qcom: sdx65: add qcom,bcm-voter-idx
>        interconnect: qcom: sm8350: Point display paths to the display RSC
>        interconnect: qcom: sm8450: Point display paths to the display RSC
>        interconnect: qcom: sm8550: Point display paths to the display RSC
>        interconnect: qcom: sm8550: Point camera paths to the camera RSC
> 
>   .../bindings/interconnect/qcom,bcm-voter.yaml      |   10 +
>   arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |    1 +
>   arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |    1 +
>   arch/arm64/boot/dts/qcom/qdu1000.dtsi              |    2 +
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi              |    1 +
>   arch/arm64/boot/dts/qcom/sc7180.dtsi               |    1 +
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sc8180x.dtsi              |    2 +
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |    2 +
>   arch/arm64/boot/dts/qcom/sdm670.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sdx75.dtsi                |    2 +
>   arch/arm64/boot/dts/qcom/sm6350.dtsi               |    1 +
>   arch/arm64/boot/dts/qcom/sm8150.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sm8250.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sm8350.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sm8450.dtsi               |    2 +
>   arch/arm64/boot/dts/qcom/sm8550.dtsi               |    2 +
>   drivers/interconnect/qcom/bcm-voter.c              |   75 +-
>   drivers/interconnect/qcom/bcm-voter.h              |    9 -
>   drivers/interconnect/qcom/icc-rpmh.c               |   53 +-
>   drivers/interconnect/qcom/icc-rpmh.h               |   14 +-
>   drivers/interconnect/qcom/qdu1000.c                |   11 +
>   drivers/interconnect/qcom/sa8775p.c                |   28 +
>   drivers/interconnect/qcom/sc7180.c                 | 1637 +++++++++++++++--
>   drivers/interconnect/qcom/sc7280.c                 |   27 +
>   drivers/interconnect/qcom/sc8180x.c                |   23 +
>   drivers/interconnect/qcom/sc8280xp.c               |   27 +
>   drivers/interconnect/qcom/sdm670.c                 | 1410 +++++++++++++--
>   drivers/interconnect/qcom/sdm845.c                 | 1683 ++++++++++++++++--
>   drivers/interconnect/qcom/sdx55.c                  |  863 ++++++++-
>   drivers/interconnect/qcom/sdx65.c                  |  850 ++++++++-
>   drivers/interconnect/qcom/sm6350.c                 | 1551 +++++++++++++++--
>   drivers/interconnect/qcom/sm8150.c                 | 1714 ++++++++++++++++--
>   drivers/interconnect/qcom/sm8250.c                 | 1772 +++++++++++++++++--
>   drivers/interconnect/qcom/sm8350.c                 | 1830 ++++++++++++++++++--
>   drivers/interconnect/qcom/sm8450.c                 |   24 +
>   drivers/interconnect/qcom/sm8550.c                 |   42 +
>   include/dt-bindings/interconnect/qcom,icc.h        |    8 +
>   39 files changed, 12320 insertions(+), 1370 deletions(-)
> ---
> base-commit: 82cee168d497ffcb79e4889fe3c7384788e89f4d
> change-id: 20230708-topic-rpmh_icc_rsc-f897080fb207
> 
> Best regards,

