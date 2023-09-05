Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B4792706
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbjIEQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354318AbjIEKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:41:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45AA1AE;
        Tue,  5 Sep 2023 03:41:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 782EA42425;
        Tue,  5 Sep 2023 15:41:25 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693910486; bh=FNIibyarmPCAlhz6Ut7njgzIVJSbI2KFycVZdOK+Y8k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jVRHYAPuFwcBzBq3OM4gqA2V1jKYKbe7tl4k8iQL0B3hP7g6v0yPMIrVUSCsCWM14
         6Ulya6cHdZmB/5c8XrrEWhTOYOlkfUwobCRKE2GZBYr/zBx3PxJohtEOY41fEy4r5H
         aUNAA7bfNdWuM+L9b8uVeaZWzRCrfq1gat5uV+8dl0yRWgQ+PlCbmVHHO92HbSkEx+
         6gD3F91RfavcoLHigg1lcl0wNlGNaTw9yZUilgi05djKh9Dkt91849zkOEsCgWaxBy
         8y8wRgu/t/V7Upd01hjg05sGERkpi8C+TLr4kQ+TYthMW38qTy5hEoffbD7o/ZneX8
         96NXjdfPGES2g==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 15:41:05 +0500
Subject: [PATCH v2 2/4] remoteproc: qcom: pas: Add sc7180 adsp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v2-2-8ab7f299600a@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
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
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9wXSdXpuqquc9zOeOuVZKyipoF7wARAYEaovj
 6NrvwsAXoCJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPcF0gAKCRBDHOzuKBm/
 dV7hEACgIYyv1e5XGRTTLqaKQs7YYbjQVpET7tHenKQF9hm6XJWZ3XJ2JOhasO/s4YC5QMpTc7p
 WTxHmGiTkfu373RgkULXYk+ndTECVFpArH6TmednqlOHuLOhFAtVxwPwvicxaPbz4Un0g6XGdcc
 MZAhtsL8CeakenfOWfBiLPec1aP9uOIwuCRGjkXfcFKwdOcuTwfmM+3Eoe0TJUl8WO1tngQ3w92
 Bnhstjzpk8VAK0HFsKXpQgBwnhdOYXl8+lRtF+s2qMXpaKIpQOKpWxOSC6INInbX44lx3puSvjW
 GuD0Gy2GwAkNsuTtZYibPMfI1BS90u6HFuxDdMNQb4P67bvLQuTh4BpkFtD4SKRpW6peA6QU2ix
 sT4oI7v6R+Xcu29MpuZ4yK5WdEj0SreOyvsNVCytaxBD5McsvgN9xUgQGJI0YrISn1hl0sXPzn/
 RF/JJ32TGuiH2ZmyxNt9iiFDgEHskzGvYSrFAuGy6xt77wXkoDO12lEVghvO9zMfwFqsgll61rb
 UCeoW2c859qJs/XUogBjvp5A76C/pqoqu8oKQ2ixQjo3Jzu1EwGjNYxABCfCMpg7Y1SRLK5gn6j
 3ySoseJe+ysKImwq64zC6gfDKv4rMaXdGR90yqUEKWLsgTU8Qm8mFvA8AJDzZENXDTG2znxc8m8
 4ekcc1wWfEsDEBQ==
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

