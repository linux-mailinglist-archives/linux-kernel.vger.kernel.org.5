Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50779C7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjILHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjILHOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:14:02 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F0B9;
        Tue, 12 Sep 2023 00:13:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [115.110.84.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8FAF3160123;
        Tue, 12 Sep 2023 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1694502836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJiVd3e0z3dt6zMqGmxvqDx/3/cysR+nCDjl2biifA0=;
        b=hx+evfRtb33AFfZeAWtF8UnmOMcU7u2JltcPjiZwjCScQ+UjHXfwEUhY6Tj+CcRqrETYao
        XWq1CjN0PtYIBRMmcNXmo5YvbALJzlIpoYijCLqD/JywndxOx6cI7M+6L/q4nz2wa5B2RN
        i2yalIpjkq/oiSvj5BtYLNcOzE3Wj6c=
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
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm845: cheza doesn't support LMh node
Date:   Tue, 12 Sep 2023 12:42:04 +0530
Message-Id: <20230912071205.11502-2-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912071205.11502-1-david@ixit.cz>
References: <20230912071205.11502-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cheza firmware doesn't allow controlling LMh from the operating system.

Fixes: 36c6581214c4 ("arm64: dts: qcom: sdm845: Add support for LMh node")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - moved power-domains removal from this patch to previous one, since
   it's not related to LMh support
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e0ee91225eec..e51bf02fbfe3 100644
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
-- 
2.40.1

