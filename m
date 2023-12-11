Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7780BFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjLKDRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKDRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:17:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329CE8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 19:17:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA229C433C7;
        Mon, 11 Dec 2023 03:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702264626;
        bh=vZ6FAmeEuhuEnQfZxh3RBh9KdTxrTAeJpbw4mAMqY4Q=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=kjo3TH6hDFYhV6s9qjHD4dXiPk3ygO8EOmdfkVCbZXG1tEuzfi12Gh0TGZVlKRRsy
         eDtpS9LkhV402Zq7ydrUUEukFOz/hH6jUJUQyMcuGFUzaAeb8XCFbnLGHLVqFUemT+
         KNPcCv54PYBDsIaKpqCgNFLP2yO4Edgh90q+I40TPnrSHmgf70Da1qK8xXlgMoBSKG
         AIVt5visiS6vs38/7tykqhpn2a855dftokVWb7qMvDmd3oyOvi3oc/W/5ECtDaXeQ7
         XZOHrt04JWhMLp8TpWrkFm/wlBMWfXBwaxwuQ2JhOp6HNTL8I0hVUQ2jaRrE0HL66D
         emB8w2QIJDw5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id AD034C4167B;
        Mon, 11 Dec 2023 03:17:06 +0000 (UTC)
From:   Fenglin Wu via B4 Relay 
        <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH 0/4] Add pm8010 RPMH regulators for sm8550 boards
Date:   Mon, 11 Dec 2023 11:16:58 +0800
Message-Id: <20231211-pm8010-regulator-v1-0-571e05fb4ecc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACp/dmUC/x3MTQ5AMBBA4avIrDWZtkS5ilgUg0n8ZYpIxN01l
 t/ivQcCCVOAKnlA6OLA2xqh0wS6ya8jKe6jwaCx2mCu9sWhRiU0nrM/NlFoM9e1ukRXeIjZLjT
 w/S/r5n0/2fy0AWIAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702264624; l=1011;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=vZ6FAmeEuhuEnQfZxh3RBh9KdTxrTAeJpbw4mAMqY4Q=;
 b=HC3xI1nwGgSj0NizbiQXsnost3cz/SrXXU3YNnwjV1rMxvOW8SkP6NCPJJFouhI6iLqbVNGDg
 DDMW+jy+WhYCFVBpqdhJ5WlkRuCW6+pmPy3XZ2Xk6NMiLyfKa/Fdpfh
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 PM8010 PMICs present in sm8550-mtp/sm8550-qrd boards and
each of them exposes 7 LDOs. Add RPMH regulator support for them.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Fenglin Wu (4):
      regulator: qcom-rpmh: extend to support multiple linear voltage ranges
      regulator: qcom,rpmh: add compatible for pm8010 RPMH regultor
      regulator: qcom-rpmh: add support for pm8010 regulators
      arm64: dts: qcom: Add pm8010 regulators for sm8550 boards

 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  14 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            | 120 ++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            | 120 ++++++++++++++
 drivers/regulator/qcom-rpmh-regulator.c            | 177 ++++++++++++++++++---
 4 files changed, 405 insertions(+), 26 deletions(-)
---
base-commit: 753e4d5c433da57da75dd4c3e1aececc8e874a62
change-id: 20231205-pm8010-regulator-0348cb19087a

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>

