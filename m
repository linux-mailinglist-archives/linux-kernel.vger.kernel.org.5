Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50BB76E37F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjHCIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjHCIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:45:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258ACE7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:45:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so11256465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691052339; x=1691657139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PhbWBxVY+X984CPRnz7QaJ37DurdEVA6lT1+fWNC0g=;
        b=Y03cUb16S4u7JWepraB/aQaqdcrTw6zjp8z/Kc1ZDzxITLH2QzUbybF3xXh8T6vNrW
         6Swp24w8iRei4btmyMoP1AByhejWjczlQMYGmZWuZJH2UAcHtGrvics1Vy91gX93Rf3B
         bt2q+vzSCJGlEcJePDWARwD2ilbE/deOMRLJt2lJFHSlEYkQTsh76wScyV71zLIyxsXJ
         6gkbV2ZJ4jQZyyDPLjg3GCc9eF7Ipvdj6cxPgIQlBk+mWg++hlOKlXQoh3wC4jRCj70I
         rVXV53hZOWbkPak/qaSocJaihhU8sWHqVY5VaHhYU1SHI1ad+mU+n3Zuacn5S4Gbi5p6
         yqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052339; x=1691657139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PhbWBxVY+X984CPRnz7QaJ37DurdEVA6lT1+fWNC0g=;
        b=l9vQGfxSVkdlmEAJ5MNFdtER2plSRf9zpe0LOikuH2LElvT4iQ9y4h2Dc9D2RguHas
         2nKRbFXaQplZ9fhzx3J+skL18FZiKnhYlCGGjUsUzgBfK4SVu/JNQ/l5gjx0WglRsOSY
         SgA4z3xaD5a9T536g1B3JsLXoW2ZcRQO1RoXfY5JiiCu1ug1j8JFEok2EQ5InfMVFW1b
         zUbCVtJ9zUkQIkicyImHP2IORxS3NfSRFL07ndyrRK6mLkTq1VygiSJTjddoL5BfLfEV
         6HXnBlczl3ve/qgiBdJn9Tx081ps+AI659neE/jdpEj+r01PlEy+mnikJaUjFCOuMlAe
         7s/w==
X-Gm-Message-State: ABy/qLa1d2JKYAv+42WX9l/+ignrhCVih72fAQeogA3pA7Cf3RjNjTYl
        +tOUk4Wuu5XGBqMgFTfUj20BMA==
X-Google-Smtp-Source: APBJJlEwt1M3yHqPFF3L2huSu2UAQejahKFkCC30OB82otdVPa4mHl4vfFSwyyq1FMAC8UJD9NdNSw==
X-Received: by 2002:adf:f3c5:0:b0:314:475:bc6b with SMTP id g5-20020adff3c5000000b003140475bc6bmr7185650wrp.18.1691052339671;
        Thu, 03 Aug 2023 01:45:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v9-20020adfe4c9000000b00314374145e0sm11895052wrm.67.2023.08.03.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:45:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 03 Aug 2023 10:45:27 +0200
Subject: [PATCH v3 2/3] bluetooth: qca: use switch case for soc type
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-topic-sm8550-upstream-bt-v3-2-6874a1507288@linaro.org>
References: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
In-Reply-To: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16634;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gZ6z56Y+xNtNwTOZPHWpWEqp8UVn+xTpHdu3xVIIx1s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBky2kvHpp4kvIf9VgCrh4T559SjHoxwWya2snFVAAV
 KfXHskSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMtpLwAKCRB33NvayMhJ0cbcEA
 CLEfqsjfqNGvUgjo5jxkAJ/5fhRezGA88hjgjMX6TnF3A6C/AmmUBhxyzumVPOZPyLQs461JuMqez/
 pteL9BnbJjE4ozzR6je4sytK6Ra2voJSBD6gO86t3FVrM+Ql4YLtv7eGdZSNC29pRURFW4zwAT+Z4p
 h8cTZ5v315zHnwi8kcyx9ETma+dtsMgnM9pyqaDt+j8+diSngEs7EywMixa55lhqF1N/x0V6NLtYPN
 UO8Y9xxwMBiGtmgZFhb6VD0iKrEiqcqQLAjCNGLsP+c57yuvwl59pG8sle5mLeR41Lb6YOmGJcrskn
 la6MjU0aTSqy/APeL1Zii7e+1QcEc95AhnKHH34RYuQkGgpuhCCD7sAKD3GTtHaEApGVEEUZEV/Uhp
 7V5k0P/MG8MdpV2OI+x/aw3C08992GeGhLsX2M5lxnZV8M6E0Vlprax6oONeW65O4LDEhvxcBObPVf
 MUCJFem6Y+1y8XciJZvrtAzX+lFaTVuf0N+ffnD5imPSGsF9NMlTUh/dhtz7jF3k04uzFklixkFtad
 pxLIVxZoxGF5YHstBhe+SKUYJoTAX1b8jS0GhyG/m0vYJwtCkv8v9rxt/3w3ygCeiPExqcGJ+G48S8
 yLhg+huTLsKPc2dQPXs7aEjox4pCYmzvKAstGOmQWlnzlroEUXUjQY24Vvpw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use switch/case to handle soc type specific behaviour,
the permit dropping the qca_is_xxx() inline functions
and maked the code clearer and easier to update for new
SoCs.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/bluetooth/btqca.c   |  87 +++++++++++------
 drivers/bluetooth/btqca.h   |  36 -------
 drivers/bluetooth/hci_qca.c | 233 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 236 insertions(+), 120 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 6f2187fab55f..e301f571e971 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -604,26 +604,34 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	if (soc_type == QCA_WCN3988) {
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/apbtfw%02x.tlv", rom_ver);
-	} else if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crbtfw%02x.tlv", rom_ver);
-	} else if (soc_type == QCA_QCA6390) {
+		break;
+	case QCA_WCN3988:
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/apbtfw%02x.tlv", rom_ver);
+		break;
+	case QCA_QCA6390:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
-	} else if (soc_type == QCA_WCN6750) {
+		break;
+	case QCA_WCN6750:
 		/* Choose mbn file by default.If mbn file is not found
 		 * then choose tlv file
 		 */
 		config.type = ELF_TYPE_PATCH;
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/msbtfw%02x.mbn", rom_ver);
-	} else if (soc_type == QCA_WCN6855) {
+		break;
+	case QCA_WCN6855:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpbtfw%02x.tlv", rom_ver);
-	} else {
+		break;
+	default:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
 	}
@@ -639,33 +647,44 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
-	if (firmware_name)
+	if (firmware_name) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/%s", firmware_name);
-	else if (soc_type == QCA_WCN3988)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/apnv%02x.bin", rom_ver);
-	else if (qca_is_wcn399x(soc_type)) {
-		if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
+	} else {
+		switch (soc_type) {
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
+				snprintf(config.fwname, sizeof(config.fwname),
+					 "qca/crnv%02xu.bin", rom_ver);
+			} else {
+				snprintf(config.fwname, sizeof(config.fwname),
+					 "qca/crnv%02x.bin", rom_ver);
+			}
+			break;
+		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/crnv%02xu.bin", rom_ver);
-		} else {
+				 "qca/apnv%02x.bin", rom_ver);
+			break;
+		case QCA_QCA6390:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/htnv%02x.bin", rom_ver);
+			break;
+		case QCA_WCN6750:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/msnv%02x.bin", rom_ver);
+			break;
+		case QCA_WCN6855:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hpnv%02x.bin", rom_ver);
+			break;
+
+		default:
 			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/crnv%02x.bin", rom_ver);
+				 "qca/nvm_%08x.bin", soc_ver);
 		}
 	}
-	else if (soc_type == QCA_QCA6390)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/htnv%02x.bin", rom_ver);
-	else if (soc_type == QCA_WCN6750)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/msnv%02x.bin", rom_ver);
-	else if (soc_type == QCA_WCN6855)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/hpnv%02x.bin", rom_ver);
-	else
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/nvm_%08x.bin", soc_ver);
 
 	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
 	if (err < 0) {
@@ -673,16 +692,24 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
-	if (soc_type >= QCA_WCN3991) {
+	switch (soc_type) {
+	case QCA_WCN3991:
+	case QCA_QCA6390:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		err = qca_disable_soc_logging(hdev);
 		if (err < 0)
 			return err;
+		break;
+	default:
+		break;
 	}
 
 	/* WCN399x and WCN6750 supports the Microsoft vendor extension with 0xFD70 as the
 	 * VsMsftOpCode.
 	 */
 	switch (soc_type) {
+	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index fc6cf314eb0e..fe51c632d772 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -161,27 +161,6 @@ int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type);
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev);
-static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
-{
-	switch (soc_type) {
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
-		return true;
-	default:
-		return false;
-	}
-}
-static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
-{
-	return soc_type == QCA_WCN6750;
-}
-static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
-{
-	return soc_type == QCA_WCN6855;
-}
-
 #else
 
 static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
@@ -209,21 +188,6 @@ static inline int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
-static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
-{
-	return false;
-}
-
-static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
-{
-	return false;
-}
-
-static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
-{
-	return false;
-}
-
 static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 011822519602..548157119b75 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -607,9 +607,18 @@ static int qca_open(struct hci_uart *hu)
 	if (hu->serdev) {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 
-		if (qca_is_wcn399x(qcadev->btsoc_type) ||
-		    qca_is_wcn6750(qcadev->btsoc_type))
+		switch (qcadev->btsoc_type) {
+		case QCA_WCN3988:
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+		case QCA_WCN6750:
 			hu->init_speed = qcadev->init_speed;
+			break;
+
+		default:
+			break;
+		}
 
 		if (qcadev->oper_speed)
 			hu->oper_speed = qcadev->oper_speed;
@@ -1341,12 +1350,19 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
 
 	/* Give the controller time to process the request */
-	if (qca_is_wcn399x(qca_soc_type(hu)) ||
-	    qca_is_wcn6750(qca_soc_type(hu)) ||
-	    qca_is_wcn6855(qca_soc_type(hu)))
+	switch (qca_soc_type(hu)) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		usleep_range(1000, 10000);
-	else
+		break;
+
+	default:
 		msleep(300);
+	}
 
 	return 0;
 }
@@ -1419,13 +1435,19 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 
 static int qca_check_speeds(struct hci_uart *hu)
 {
-	if (qca_is_wcn399x(qca_soc_type(hu)) ||
-	    qca_is_wcn6750(qca_soc_type(hu)) ||
-	    qca_is_wcn6855(qca_soc_type(hu))) {
+	switch (qca_soc_type(hu)) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
-	} else {
+		break;
+
+	default:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1454,14 +1476,28 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		/* Disable flow control for wcn3990 to deassert RTS while
 		 * changing the baudrate of chip and host.
 		 */
-		if (qca_is_wcn399x(soc_type) ||
-		    qca_is_wcn6750(soc_type) ||
-		    qca_is_wcn6855(soc_type))
+		switch (soc_type) {
+		case QCA_WCN3988:
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
 			hci_uart_set_flow_control(hu, true);
+			break;
 
-		if (soc_type == QCA_WCN3990) {
+		default:
+			break;
+		}
+
+		switch (soc_type) {
+		case QCA_WCN3990:
 			reinit_completion(&qca->drop_ev_comp);
 			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+			break;
+
+		default:
+			break;
 		}
 
 		qca_baudrate = qca_get_baudrate_value(speed);
@@ -1473,12 +1509,22 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qca_is_wcn399x(soc_type) ||
-		    qca_is_wcn6750(soc_type) ||
-		    qca_is_wcn6855(soc_type))
+		switch (soc_type) {
+		case QCA_WCN3988:
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
 			hci_uart_set_flow_control(hu, false);
+			break;
 
-		if (soc_type == QCA_WCN3990) {
+		default:
+			break;
+		}
+
+		switch (soc_type) {
+		case QCA_WCN3990:
 			/* Wait for the controller to send the vendor event
 			 * for the baudrate change command.
 			 */
@@ -1490,6 +1536,10 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 			}
 
 			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+			break;
+
+		default:
+			break;
 		}
 	}
 
@@ -1651,12 +1701,20 @@ static int qca_regulator_init(struct hci_uart *hu)
 		}
 	}
 
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		/* Forcefully enable wcn399x to enter in to boot mode. */
 		host_set_baudrate(hu, 2400);
 		ret = qca_send_power_pulse(hu, false);
 		if (ret)
 			return ret;
+		break;
+
+	default:
+		break;
 	}
 
 	/* For wcn6750 need to enable gpio bt_en */
@@ -1673,10 +1731,18 @@ static int qca_regulator_init(struct hci_uart *hu)
 
 	qca_set_speed(hu, QCA_INIT_SPEED);
 
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		ret = qca_send_power_pulse(hu, true);
 		if (ret)
 			return ret;
+		break;
+
+	default:
+		break;
 	}
 
 	/* Now the device is in ready state to communicate with host.
@@ -1710,11 +1776,17 @@ static int qca_power_on(struct hci_dev *hdev)
 	if (!hu->serdev)
 		return 0;
 
-	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type) ||
-	    qca_is_wcn6855(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		ret = qca_regulator_init(hu);
-	} else {
+		break;
+
+	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
@@ -1748,6 +1820,7 @@ static int qca_setup(struct hci_uart *hu)
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
+	const char *soc_name;
 
 	ret = qca_check_speeds(hu);
 	if (ret)
@@ -1762,10 +1835,26 @@ static int qca_setup(struct hci_uart *hu)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	bt_dev_info(hdev, "setting up %s",
-		qca_is_wcn399x(soc_type) ? "wcn399x" :
-		(soc_type == QCA_WCN6750) ? "wcn6750" :
-		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		soc_name = "wcn399x";
+		break;
+
+	case QCA_WCN6750:
+		soc_name = "wcn6750";
+		break;
+
+	case QCA_WCN6855:
+		soc_name = "wcn6855";
+		break;
+
+	default:
+		soc_name = "ROME/QCA6390";
+	}
+	bt_dev_info(hdev, "setting up %s", soc_name);
 
 	qca->memdump_state = QCA_MEMDUMP_IDLE;
 
@@ -1776,16 +1865,22 @@ static int qca_setup(struct hci_uart *hu)
 
 	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 
-	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type) ||
-	    qca_is_wcn6855(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
 			goto out;
-	} else {
+		break;
+
+	default:
 		qca_set_speed(hu, QCA_INIT_SPEED);
 	}
 
@@ -1799,9 +1894,16 @@ static int qca_setup(struct hci_uart *hu)
 		qca_baudrate = qca_get_baudrate_value(speed);
 	}
 
-	if (!(qca_is_wcn399x(soc_type) ||
-	      qca_is_wcn6750(soc_type) ||
-	      qca_is_wcn6855(soc_type))) {
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+		break;
+
+	default:
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
@@ -1980,11 +2082,18 @@ static void qca_power_shutdown(struct hci_uart *hu)
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		host_set_baudrate(hu, 2400);
 		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
-	} else if (soc_type == QCA_WCN6750 || soc_type == QCA_WCN6855) {
+		break;
+
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -1992,7 +2101,9 @@ static void qca_power_shutdown(struct hci_uart *hu)
 			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
 			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
 		}
-	} else if (qcadev->bt_en) {
+		break;
+
+	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
 
@@ -2117,11 +2228,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
-	if (data &&
-	    (qca_is_wcn399x(data->soc_type) ||
-	     qca_is_wcn6750(data->soc_type) ||
-	     qca_is_wcn6855(data->soc_type))) {
+	if (data)
 		qcadev->btsoc_type = data->soc_type;
+	else
+		qcadev->btsoc_type = QCA_ROME;
+
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2165,12 +2283,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			BT_ERR("wcn3990 serdev registration failed");
 			return err;
 		}
-	} else {
-		if (data)
-			qcadev->btsoc_type = data->soc_type;
-		else
-			qcadev->btsoc_type = QCA_ROME;
+		break;
 
+	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
@@ -2226,13 +2341,23 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct qca_power *power = qcadev->bt_power;
 
-	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
-	     qca_is_wcn6750(qcadev->btsoc_type) ||
-	     qca_is_wcn6855(qcadev->btsoc_type)) &&
-	    power->vregs_on)
-		qca_power_shutdown(&qcadev->serdev_hu);
-	else if (qcadev->susclk)
-		clk_disable_unprepare(qcadev->susclk);
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+		if (power->vregs_on) {
+			qca_power_shutdown(&qcadev->serdev_hu);
+			break;
+		}
+		fallthrough;
+
+	default:
+		if (qcadev->susclk)
+			clk_disable_unprepare(qcadev->susclk);
+	}
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }

-- 
2.34.1

