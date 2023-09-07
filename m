Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10A797AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjIGRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245657AbjIGRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:48:00 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1A1FCA;
        Thu,  7 Sep 2023 10:47:40 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9C77442458;
        Thu,  7 Sep 2023 15:03:06 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694080987; bh=FNIibyarmPCAlhz6Ut7njgzIVJSbI2KFycVZdOK+Y8k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hHanS4TA/Iznd0l18LShVGXLxevYyPmWfjmxKJNP+QCwba+tWrL1LDH5KospReRel
         Zod6gB3MSGX7gbpHMv0qIe8Ki8BV8E0RlDaeYODC9HDbGFpo+twJWqFbotzWSpx9B9
         BqEumZCcTJYGTZ7MJI0JPif5oEgZ0uUaffe9atkd5fdTX4hDXbkBm9EM7iwCm5ufFA
         uM2BlqJxGnQd9kjr/oD+1SCVxA5gM0ygWQx40Wbi9s7AMHrRZI/99JjAx9EFAvGX8f
         cff8vJfgpcGfO/vnnfilFuAh/P492FRBzOXt3kcVIFsDEyx3E4tz2jr4l4x66NkdVY
         U9Dnggsob9Q+Q==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 07 Sep 2023 15:02:35 +0500
Subject: [PATCH v3 2/4] remoteproc: qcom: pas: Add sc7180 adsp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-sc7180-adsp-rproc-v3-2-6515c3fbe0a3@trvn.ru>
References: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
In-Reply-To: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=FNIibyarmPCAlhz6Ut7njgzIVJSbI2KFycVZdOK+Y8k=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk+Z/XWGIHKV9LtS/kaJFlmhh9V6OSlR4C636Cj
 6LqFciJPx6JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPmf1wAKCRBDHOzuKBm/
 dWqiD/wKDJvYnFP+A/getQteeoWbURpaqo/5aKW8AOtEo/CsT6UA/ZgP49NNXSLPnhM9Fet8QPB
 Z+rDe2ATJigMcxuT14NJuhe4UlPFpWpzIcn54H691eXriRnpmC+CVNmxJll5IFMUYbeFj/c7stq
 j5PIg/aDmQ3lUmhpusvSOYnnJdK/SrbzXDwhdT8/kQehr1WqSW03m14Pf8JQ4/So2YzkXCN7KQI
 ZwURZFwO2uQdw0s775ofXERFOAa/cm2qBmmcq7r7+Mgp/fnmj+SHDKIKbF7Ctpo/uOHlkWlvUwz
 aLGa3gGgRnGkEFl9AWS6HzH5XUwSxnFDnPHuDSzw+QLpB0YV/CSPTrC/pc0jyu6hhyrvcEr/bMC
 +etPPEZnDKNO2s886+toVyxy5vSLE8inWBZZuEPUaEIDN+PsA0miSiDCyI5o+ITv66aR5q+Qkbr
 HZ8E/1nIlG2QhT76afM3OY9TNRha/MSTkUaHQRknZL5dseOpLsDhbBM9QHWs38FHjifJgTxV+KO
 vH3cKllPJSVFYod6TzvYKL+G5+lSRjlQuvnQhzU2gooUS0UJhJVYF/tKypK1+84ZHZsOP9uB6Hu
 z3o8nvGtHrcWPgtWgOfXqaYT3166XBEELZ9ARTNOOzPbuyucyajr4n9pYT+v/wOK9InROIH799y
 yw5alrt1fAXzXJg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 has a dedicated ADSP similar to the one found in sm8250.
Add it's compatible to the driver reusing the existing config so
the devices that use the adsp can probe it.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b5447dd2dd35..55fafc68200e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1161,6 +1161,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
 	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
 	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
+	{ .compatible = "qcom,sc7180-adsp-pas", .data = &sm8250_adsp_resource},
 	{ .compatible = "qcom,sc7180-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sc7280-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sc8180x-adsp-pas", .data = &sm8150_adsp_resource},

-- 
2.41.0

