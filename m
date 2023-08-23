Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1478635F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbjHWW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbjHWW2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:28:09 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE5E6F;
        Wed, 23 Aug 2023 15:28:07 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 90843160BE6;
        Thu, 24 Aug 2023 00:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1692829685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCK2WNotr4hmxebZmoxcgnrvEUC2V3hAd2qFE7HTVso=;
        b=uMEpw0J7f6sRaIvetqb9by2sqnToxmDbNIp2MDiyqVhRHGBI7X+9fEqRubNWHeDlfikyq8
        xX05Nl5YlHA7fy5WeHMUx8uql3MOO7X8Wz7+HeEnkSWJT5Vza7qb6OcWES4wNAo+gU6ipX
        TSFkQIw/usMr4dL1pdnL4ufjQp4n9fU=
From:   David Heidelberg <david@ixit.cz>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845: cheza doesn't support LMh node
Date:   Thu, 24 Aug 2023 00:27:41 +0200
Message-Id: <20230823222741.89584-2-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230823222741.89584-1-david@ixit.cz>
References: <20230823222741.89584-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cheza firmware doesn't allow controlling LMh from the operating system.

Fixes: 36c6581214c4 ("arm64: dts: qcom: sdm845: Add support for LMh node")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index d86b0d112110..8cc8fc290fd3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -143,6 +143,10 @@ panel_in_edp: endpoint {
 	};
 };
 
+&cpufreq_hw {
+	/delete-property/ interrupts-extended; /* reference to lmh_cluster[01] */
+};
+
 &psci {
 	/delete-node/ power-domain-cpu0;
 	/delete-node/ power-domain-cpu1;
@@ -275,6 +279,14 @@ &BIG_CPU_SLEEP_1
 			   &CLUSTER_SLEEP_0>;
 };
 
+&lmh_cluster0 {
+	status = "disabled";
+};
+
+&lmh_cluster1 {
+	status = "disabled";
+};
+
 /*
  * Reserved memory changes
  *
@@ -338,6 +350,8 @@ flash@0 {
 
 
 &apps_rsc {
+	/delete-property/ power-domains;
+
 	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
-- 
2.40.1

