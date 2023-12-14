Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2A8129A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443413AbjLNHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjLNHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:43:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22B109
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:43:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECA3C433C8;
        Thu, 14 Dec 2023 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702539819;
        bh=OEMk/nxMTR+a3ksA2UJ1yTut+dCnmQnWva7ppIneGCc=;
        h=From:To:Cc:Subject:Date:From;
        b=osFoWmK9rwckrPYfephyKYoWACTfSb/oyYSpzZ71wSgHuVd5F+y0II14i2SQ4SLRQ
         3N3GPkj7/NQMtXu/JbC+z8gFSjlBufcTnavtSou6wrB1CutW29Jk8d6axLfuMgreFF
         I5qVRxdgkmgnCq9IHdiGWWZ01QuQM5hz+bcax6GrPzuDWqjuSl+nROJPBj+RixWP97
         QRGQBObLS7S7G77H4+hBMxkNvNyrwgKzc2WOtNVchvG7wcGYUPzJO78UST0I3oWVb+
         OG2GEkef9Cz32wddWMrqn0aV4eXSYK8ihOlCGMX1kAvBfr2XZLCXuNrQLyLKCQzVTJ
         ODq5tQBWGGOpA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rDgNe-0002s4-1A;
        Thu, 14 Dec 2023 08:43:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] arm64: dts: qcom: fix USB wakeup interrupts again (pt 2)
Date:   Thu, 14 Dec 2023 08:43:16 +0100
Message-ID: <20231214074319.11023-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states and to be able to detect disconnect events, which requires
triggering on falling edges.

A recent commit updated the trigger type but failed to change the
interrupt provider as required. This leads to the current Linux driver
failing to probe instead of printing an error during suspend and USB
wakeup not working as intended.

While at it, fix also the SS PHY interrupt so that it too can be used to
wakeup the system up.

Thanks to Konrad and Krishna for providing the sdm670 PDC interrupts
numbers. The sc8180x SS PHY vectors I inferred from sdm670/sdm845/sm8150
which appear to use the name configuration.

After this series, only sm6375 remains to be fixed and I believe Bjorn
is trying to dig out the corresponding vectors.

Also note that these patches have only been compile tested.

Johan


Johan Hovold (3):
  arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY interrupts
  arm64: dts: qcom: sdm670: fix USB SS wakeup
  arm64: dts: qcom: sc8180x: fix USB SS wakeup

 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sdm670.dtsi  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.41.0

