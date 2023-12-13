Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE089811B17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441913AbjLMRbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjLMRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:31:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0299C10F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:31:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94620C433CB;
        Wed, 13 Dec 2023 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702488711;
        bh=WYg99u3oYCV70ieWzKifcKaZ5J0do6axiMJ6JXN+PN8=;
        h=From:To:Cc:Subject:Date:From;
        b=qSK9zqs1XFYvKBMPCU0/mde3b1+CccZfagTz5zhX+L7LS+JDOqzBfI8o4Ev3oD3Y0
         ACUZ1NgRHiQvRBVqqgJRqjsGb+Ly9bmy7cwaLBPNdn2te7W9L9Zstp8Jn4KFbBIols
         cu4nBAODjuMXxnbJTjLN36n/wJqSy8Xck5LKGKsyo1rIJ6S4nHOKBZTnydwEqp0sIm
         L2LLPFPICODwnM4633YXEuwK4c7o1iI5EPXTtXX+OKcif9clh2UnyNr+FQWyPqH+iO
         X7gcmWiQklFdepMUHf7am1VG+kwl5zyXW2gIex4dBCV7WZsU6NvPFmbW1iI939waxa
         wCnQLCZBoskGA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rDT5I-0007f7-0j;
        Wed, 13 Dec 2023 18:31:48 +0100
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
Subject: [PATCH 0/3] ARM: dts: qcom: sdx55: fix USB wakeup interrupts
Date:   Wed, 13 Dec 2023 18:31:28 +0100
Message-ID: <20231213173131.29436-1-johan+linaro@kernel.org>
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

Thanks to Krishna for providing the PDC interrupt vectors.

Note that these patches have not even been compile tested.

Johan


Johan Hovold (3):
  ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
  ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts
  ARM: dts: qcom: sdx55: fix USB SS wakeup

 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0

