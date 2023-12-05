Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA2805195
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbjLELJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376557AbjLELJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08AC12C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:09:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c0a11a914so22229425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701774553; x=1702379353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYTGnhkqGwWYczwtIdABCmZR2C7e/8FCJmHj5tNfaFU=;
        b=AriwKoZqI3g2eUZ7tfm3UnQesl5Af+lwFZ6KCntpq7857sQoOFEc4F1UzlGt2i0R44
         EWW+Uu3JGELbY9dLnpe/ebQ2FlmWVZhfXp3YXv/vL3rZJnvEVJUeAjgcoX4daDeUgBCp
         Bzcl2MMkgbLGlZOXG49vMR2geRlwsomPptj66AuTOlMWDvMMeaRV6JIGW4N5njCezdw4
         RYBVjexYeumMlApt3UnNSKkbAIxSVG3cUA0AGVmSg/kiX12ooKvG9jVMYdTINhHsHWXB
         T1Es8vluHM6+Y/xtN/x+ggq9rLAKz5fDW+zNQyYuQur7RN7NCeEy2awvJNy+F1SkNGu0
         ibgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774553; x=1702379353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYTGnhkqGwWYczwtIdABCmZR2C7e/8FCJmHj5tNfaFU=;
        b=i0dW16e5ilNL4ZgoCmEYwRGzqj+qnZBu07H29DEpxlbsh5HHp5QWQ4tKngdFMqdpSo
         DiTIBPRBMSC6hHte1hLbwL3SqPpCjQ/tDED8Yo9vFk4NP+z3ICmLmlGlxw9ZAD/olRmF
         6ezkFAR7jwRsqV7EeczysL4ISMYlBkVSh5/FbN4nXXHgWVbf1u3WTimtozgaF0VSzf1q
         RbzJ2m3aK9YEf+XzLwoV4rZ8KgkqjGlk+p5Wtqns5iwIwepGKq7O1LpxA3qu28EEnOJ4
         kCWZ2ACXtAEl1XvceI8XPBgzbScreMegPYmTaC5ARAmHACJXAKZsYpANeYXWWgNld0WD
         lMQA==
X-Gm-Message-State: AOJu0Yzxwe5Vhv2zynYkXEw8CTinpfDeXSu6D1iDeLiu9zu6Tv9PxEjU
        YAqpV9fQsnJfXai8hW8TRI3x1Q==
X-Google-Smtp-Source: AGHT+IFuuXyyJdBBfJwb4MoIOZkXw4s5AF/QSxcpiM9U0ZGQathPtLg2/v3mEvMGLTwB2kEKnfcAxQ==
X-Received: by 2002:a05:600c:3ba3:b0:40b:5e21:cc23 with SMTP id n35-20020a05600c3ba300b0040b5e21cc23mr347905wms.78.1701774553286;
        Tue, 05 Dec 2023 03:09:13 -0800 (PST)
Received: from brgl-build.home ([2a01:cb1d:334:ac00:2efb:ffdf:fa22:d5ee])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0040b45282f88sm21798166wmq.36.2023.12.05.03.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:09:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] Bluetooth: qca: run the power-on/off sequence for QCA6390 too
Date:   Tue,  5 Dec 2023 12:09:03 +0100
Message-Id: <20231205110903.68898-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205110903.68898-1-brgl@bgdev.pl>
References: <20231205110903.68898-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The Bluetooth module on QCA6390 needs to be powered-on by enabling the
relevant regulators and driving the enable GPIO high. We can reuse the
power sequence for the WNC models.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7f25931a946e..351ba904c8c2 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1788,6 +1788,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -2137,6 +2138,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_QCA6390:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -2284,6 +2286,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2394,6 +2397,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		if (power->vregs_on) {
 			qca_power_shutdown(&qcadev->serdev_hu);
 			break;
-- 
2.40.1

