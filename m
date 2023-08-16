Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6F77DBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbjHPIHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbjHPIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:07:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091626BB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3197b461bb5so2108108f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692173214; x=1692778014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bi5+9HvNvXpvNBPYij9PWseIuCe8O1Z0ZYdcEqI4Cio=;
        b=THgmNnHmeuhCDktNNuU0dCYJGT0tfMEvlGc02K9OlyoqhUOSgMAqncHuJMhlgGuthT
         wy4T7VZ6SGFKk9/+BiXpyAXkBHmldv2ZhvDsnUlQ2cqPE6jPEEzvKpJdY/1aBphxcWsq
         akz+01UVbrlVJ4Eur/g3zj0/fkjm6/7Ns+mhCWbCqX4xZEHtC+uyqRQgBIqdjv3nRrmR
         WM48o3RwGQSJ7xQoYeVRf7QYGLLbYjuzvDdvSRIDEyiCv6XIMbNKmuK0of76RDy4YKor
         YPaRfPZmP/ZhqDWEku+E6SF1I6234CUHZ/v5eNp1z37V9zL1PT0l7l1EQucwsMoCg9eQ
         asKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173214; x=1692778014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi5+9HvNvXpvNBPYij9PWseIuCe8O1Z0ZYdcEqI4Cio=;
        b=MlnvTOXlEI/W9FKCTVJyChNCHFlYsdTu7FDAsf1N+ihbwElq39/ywwJrwvglr2bWLU
         DD40p+K6MYwAYtCQrUPG8+mTzKKaHpRQnAGYhbLe8EixYvE91twKX1TwOVhpyPtugzaP
         MHwCNmzYWUvDT2XMAfcrfW2AAG5lx3sZDrF90B/rXJVDQdhmer8rHdVx++U/mkUbyFUc
         HFbD1+HreYQ0+9CPJ6V/ucBHflYUPr2pTJ5iMQ1sIQ3Z4PnplT3Bss5GH+Nfp3FSux65
         x3na4P3IPlzfUVi3mQsjULvY/xN2Wu3rmbi+FsIOGyBrvXGiQ6uzXtjaTtsXGk2jNGAy
         LZoQ==
X-Gm-Message-State: AOJu0YxbJBWCwqTOcFL8nFAzjl+0T5EYPA1BqEnzcV0UESALf3qYo3yr
        lBJMxLUfm/NaBd095xcfraOr4Q==
X-Google-Smtp-Source: AGHT+IGE/uCdEjFbq//wD5jbJXsvc2HZzhyFU5GrGOb3aieJGN3MJLz3pVNSLTskEw5jNynlsJWxlA==
X-Received: by 2002:a5d:688b:0:b0:319:755c:3c1e with SMTP id h11-20020a5d688b000000b00319755c3c1emr943695wru.11.1692173213824;
        Wed, 16 Aug 2023 01:06:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdcc5000000b00317878d83c6sm20430428wrm.72.2023.08.16.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:06:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Aug 2023 10:06:48 +0200
Subject: [PATCH v4 3/3] Bluetooth: qca: add support for WCN7850
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-topic-sm8550-upstream-bt-v4-3-2ea2212719f6@linaro.org>
References: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
In-Reply-To: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eL/qL4uyJI4grmSytkM8eZWJRrxrVCwakNuTJSdjak4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk3IOYiL9PuB4dpI0ceNYJpBRlpENtoSO4NQkVJViD
 WTQrhFCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNyDmAAKCRB33NvayMhJ0R+DD/
 96ghtdVal/Pq4gPjwNHN3gYRUujke6gM0ZwisooutAJ1Q30DWoDm/pSOWrfVBcoOTPRI/a9MqbnnT6
 wtgtQDvc6U2GQRAMUxSf3RTnDZNs1fDQsTwK4eAXXjGOZTdztPSSlqZzZf9qRTxitxEcegOsQSOEq6
 PicQULf1tsfcTrQaZEcKxSfwaKncnfODLpqeZ5/p3rz+kXiBmllu6bdWX7Eqi+Pz+IaFbo3hcKhb7A
 cAbIlwrv4c+KkAnWzyO6vqbFrC8MKwdQT1ReTJYAqhonlfg3d4RVuz3dF5QkFy+Fy2U5CYmZVfPJs9
 96TDFUWc4qVpjBddksP5Sx4wbD8oawFH6k6BQA4vKyy5irFREf5QoBWV+KCMYv7WCwSRfR846PDtA4
 WQZN1/2HWJ9iEYZK9OHofvZeG3cqwO5Dekt3TPUt3FjaWE9Y+A3qY5udsd4S4yUaLIXQh4qy2jyUbJ
 VaF+kpr0lr1r8mXkBC2JeqmilaX/O3vmjJSU0xH6vSWRLu3HqJPxsYauuoMIrO7iMExLKGgME5i2fa
 GbGnu8CDYWR/PwMkuJsfq2akMLHCPnEKRkqrSxILgFDuim4R62mg+taeht4MLcETEkiCD+9i0HHCIT
 kpkll1Vfie0iq0B8Eoa9578HKxF9RZYWEKaLkkVjuo6MSDDCg6bAEHNVns2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the WCN7850 Bluetooth chipset.

Tested on the SM8550 QRD platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/bluetooth/btqca.c   | 10 ++++++++++
 drivers/bluetooth/btqca.h   |  1 +
 drivers/bluetooth/hci_qca.c | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index e301f571e971..5a35ac4138c6 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -631,6 +631,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpbtfw%02x.tlv", rom_ver);
 		break;
+	case QCA_WCN7850:
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hmtbtfw%02x.tlv", rom_ver);
+		break;
 	default:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
@@ -679,6 +683,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/hpnv%02x.bin", rom_ver);
 			break;
+		case QCA_WCN7850:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hmtnv%02x.bin", rom_ver);
+			break;
 
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
@@ -697,6 +705,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_QCA6390:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		err = qca_disable_soc_logging(hdev);
 		if (err < 0)
 			return err;
@@ -731,6 +740,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		/* get fw build info */
 		err = qca_read_fw_build_info(hdev);
 		if (err < 0)
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index fe51c632d772..03bff5c0059d 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -149,6 +149,7 @@ enum qca_btsoc_type {
 	QCA_QCA6390,
 	QCA_WCN6750,
 	QCA_WCN6855,
+	QCA_WCN7850,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 548157119b75..4b57e15f9c7a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1357,6 +1357,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		usleep_range(1000, 10000);
 		break;
 
@@ -1442,6 +1443,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1483,6 +1485,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN3998:
 		case QCA_WCN6750:
 		case QCA_WCN6855:
+		case QCA_WCN7850:
 			hci_uart_set_flow_control(hu, true);
 			break;
 
@@ -1516,6 +1519,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN3998:
 		case QCA_WCN6750:
 		case QCA_WCN6855:
+		case QCA_WCN7850:
 			hci_uart_set_flow_control(hu, false);
 			break;
 
@@ -1783,6 +1787,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -1851,6 +1856,10 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "wcn6855";
 		break;
 
+	case QCA_WCN7850:
+		soc_name = "wcn7850";
+		break;
+
 	default:
 		soc_name = "ROME/QCA6390";
 	}
@@ -1872,6 +1881,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
@@ -1901,6 +1911,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		break;
 
 	default:
@@ -2057,6 +2068,20 @@ static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
+static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
+	.soc_type = QCA_WCN7850,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 5000 },
+		{ "vddaon", 26000 },
+		{ "vdddig", 126000 },
+		{ "vddrfa0p8", 102000 },
+		{ "vddrfa1p2", 257000 },
+		{ "vddrfa1p9", 302000 },
+	},
+	.num_vregs = 6,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static void qca_power_shutdown(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
@@ -2240,6 +2265,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2269,7 +2295,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 					       GPIOD_IN);
 		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
-		     data->soc_type == QCA_WCN6855))
+		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_WCN7850))
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
@@ -2348,6 +2375,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		if (power->vregs_on) {
 			qca_power_shutdown(&qcadev->serdev_hu);
 			break;
@@ -2540,6 +2568,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
+	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

-- 
2.34.1

