Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB2A7E1C33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjKFI3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjKFI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:29:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F19D49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:29:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f613272so36970185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259341; x=1699864141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNu0NhO35ovIfiYPvGl781iKPTMgquYiMp0mZ7xCvVM=;
        b=hAqfMY8Ysmpfw86qHBPXNWGNbWKNHC3f9Qs0ZDoZKA6owl+DMyjwlcLLDLtYpQ/7Fk
         NwyOo21qtCOW07LQ93ntRCdPNhrR7tSPmiagPrA6Y02ZJB+x+x0E2cqpRg5yCfzb8L/e
         5qxgsEyoj+uiCdmyR/LlugYJFeAnJtacoUK9oDfhhlbomIrALlPr2GQDEtBDWElv8joc
         T5V0lR8QWHd8VtLfhpEUJPBQeonPckSpMvfoc3aCQ0dBUiL3juY0UuY9VeaI8HEq7h3N
         z20Xxwpm8YuA8+aGqcpRW+lb4wNuXmi8rf7Vve2jR0T5YaDJlvQCCAs5bwIH1CmHh4R3
         aCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259341; x=1699864141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNu0NhO35ovIfiYPvGl781iKPTMgquYiMp0mZ7xCvVM=;
        b=ghsJiiFzbLKE4LGw79tTFvF5dtHSlddAHehKMx2v0nstC6PGgCkaLOdryhrgsXNGHt
         fWukup8xfvYRSEvQZaCObfm7l7TDKH8JZRuGvnwUP6102nSimPX9lfXZtXL+HjtGdR4r
         UQHQX/bxSv52x897hBUp4a3T2pfMGtXnye4bL+n5AfkYdVLm+1egRpfbqdGut6gAEdTZ
         ES3WP77UmfQZ9zeCMUCK0FlKquRRob1+s6IaJjeBGlSRYHtUGM5cqMIXEvTmXqHNTSDS
         Ba973q0hN6DwCxsbweZErd5je9kHcd/jXwEuH7swZQGtRLAadNtYrjiaN5oQ8QkyPLaI
         imYg==
X-Gm-Message-State: AOJu0YzD83fAP1b2rYcBHuJxdQvhRUTiV9y+7bXAOo0B1zA35AvfcbPu
        ONdpIhNXtFri4pPAmO5YmytxXQ==
X-Google-Smtp-Source: AGHT+IFNSWvxCMuznflCmXVJC8pcrpQ0ahid6voOMeDpvpNi4pcVt2K3yxXoEO1C4Rrjz0biHXdA0A==
X-Received: by 2002:a5d:46ca:0:b0:32d:b289:4bda with SMTP id g10-20020a5d46ca000000b0032db2894bdamr23459681wrs.40.1699259340970;
        Mon, 06 Nov 2023 00:29:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p12-20020adfce0c000000b0032dc1fc84f2sm8796126wrn.46.2023.11.06.00.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:29:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:28:54 +0100
Subject: [PATCH v3 3/3] remoteproc: qcom: pas: Add SM8650 remoteproc
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-remoteproc-v3-3-dbd4cabaeb47@linaro.org>
References: <20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2575;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=V+hhGqyuT9McQl2wN0mZk+6+Al3b4CJGDt+P4+rXTSk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKPISG+tdQXIB8ruDIY47ZQKBf7rTWBmkxeTL4DC
 OcC4d+iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijyAAKCRB33NvayMhJ0eGXD/
 9YubQFacjudBzLyt+YWtzqUqEZlsQso7plhS2jq+5V2W77Nu381v3J1Z+KXagFZ8F/tP6f12Hx8y/6
 OUHXcSa9OqI/A9GZPW0RimcRCMUJYQDngCMi+jOJ2SdQ1Pye1Ccg1ulWnSpxVkYojtVERA2FkBu+9c
 nRuYyi02rslpVBWtUG1BvyiN7xfrk8LVZuxmhxwevAv08t2ZthajAU23/Hg4XjlZhJPgGIwYLIPyrM
 It9iaT50OfVkjMNdmxirxqR3AX0riZDAj+E6Kg7L7jeEl3sDg3vVazOIVPhEVV11gIQl8225cZWCWZ
 Hh7nq46XkMM6uEIbK1Kj56A+hncnyzhgyeruZG7MMukDkh8ySnsuwwf8laPHm4EhgfdlAORmxrew/o
 O2rg/GHgtkToDv287zwMZ28GASEqLN28ja0sFAaZbM9rlVDCbYptXiwykcxxAqXwbfbO9dXGJHduvw
 pQuVHaOCF8ck9ZeXFZNs05qXQrU/EWSmTsFXM+ZH+4ruDrsKrNKsVVYnp3D05Nz1RKtM8X75rX6lPH
 fu3QDfIbYIA5CUdDYVgEyndfpaPHRNaVpazd9zDEMIzH/2vUwK3HhZUtAEEPHSe5jbEXvzbzfqFYis
 uHhT5X/pjTzs+D7XLcgmNCnlU7q+RG0vASsCrMCjhjxCupyXRv+3kbsppfdw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DSP Peripheral Authentication Service support for the SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 2ea364a04d4c..8f7429d86a6f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1196,6 +1196,53 @@ static const struct adsp_data sm8550_mpss_resource = {
 	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
 };
 
+static const struct adsp_data sm8650_cdsp_resource = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.dtb_firmware_name = "cdsp_dtb.mdt",
+	.pas_id = 18,
+	.dtb_pas_id = 0x25,
+	.minidump_id = 7,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mxc",
+		"nsp",
+		NULL
+	},
+	.load_state = "cdsp",
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+	.region_assign_idx = 2,
+	.region_assign_count = 1,
+	.region_assign_shared = true,
+	.region_assign_vmid = QCOM_SCM_VMID_CDSP,
+};
+
+static const struct adsp_data sm8650_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.dtb_firmware_name = "modem_dtb.mdt",
+	.pas_id = 4,
+	.dtb_pas_id = 0x26,
+	.minidump_id = 3,
+	.auto_boot = false,
+	.decrypt_shutdown = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mss",
+		NULL
+	},
+	.load_state = "modem",
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+	.region_assign_idx = 2,
+	.region_assign_count = 2,
+	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
+};
+
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
@@ -1248,6 +1295,9 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
 	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
 	{ .compatible = "qcom,sm8550-mpss-pas", .data = &sm8550_mpss_resource},
+	{ .compatible = "qcom,sm8650-adsp-pas", .data = &sm8550_adsp_resource},
+	{ .compatible = "qcom,sm8650-cdsp-pas", .data = &sm8650_cdsp_resource},
+	{ .compatible = "qcom,sm8650-mpss-pas", .data = &sm8650_mpss_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);

-- 
2.34.1

