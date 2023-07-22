Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D875DA1C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGVFOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGVFOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2223586;
        Fri, 21 Jul 2023 22:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B78260AF5;
        Sat, 22 Jul 2023 05:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B47C433CC;
        Sat, 22 Jul 2023 05:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002860;
        bh=N48eNrYOPVb4qA4aVnayJ5kxJHiGkGy/wJc//3LWd+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bW+V+YmxfeI3Va76g0M7sBxJ8iHj7s1rhagVsme3cWQbsLbj5iILfOZlroskupaJe
         LxuUeiGrERMhT9BeiyIzCsHsp0UmU54KPHl7g9m22MuYYu+HlKpCKzpVpkSCILDs32
         ZoKGrXUhbNJZdIKOI5d+M6f9hwbweLJa7w6EV2Z+7/eI9lVWIt8DgfB5N7orzn+YjY
         GqwmFU6HWuC/ErxAfjySzxEUx3XY2wzLoXrILuHNwPG4LrVF3oMYZ7M4jZMKKZMYke
         3aKGsPF/v1mGg0RLiZtD0cRaagE8XeC+fH1dxnqVbSGKBRixoR4N+SHcuqikHZEBL8
         Mo7t7LdD3NbMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/15] UFS: Add OPP and interconnect support
Date:   Fri, 21 Jul 2023 22:17:17 -0700
Message-ID: <169000304201.3611206.17689917610174130629.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
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


On Thu, 20 Jul 2023 11:10:45 +0530, Manivannan Sadhasivam wrote:
> This series adds OPP (Operating Points) support to UFSHCD driver and
> interconnect support to Qcom UFS driver.
> 
> Motivation behind adding OPP support is to scale both clocks as well as
> regulators/performance state dynamically. Currently, UFSHCD just scales
> clock frequency during runtime with the help of "freq-table-hz" property
> defined in devicetree. With the addition of OPP tables in devicetree (as
> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> both clocks and performance state of power domain which helps in power
> saving.
> 
> [...]

Applied, thanks!

[03/15] arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
        commit: 4b6ea15c0a1122422b44bf6c47a3c22fc8d46777
[04/15] arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
        commit: bbbef6e24bc4493602df68b052f6f48d48e3184a
[12/15] arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
        commit: 84e2e371f4f911337604e8ba9281e950230d1189
[13/15] arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
        commit: aeea56072cc8cb0af2b35798aa7d72047f4c8ffa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
