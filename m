Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E292808475
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378627AbjLGJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjLGJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:12:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25878172B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:12:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso10075465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701940333; x=1702545133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abIGam56kSZ3DhSDuEO3BjQb5HXWW5MMfEQ3kw2b1bA=;
        b=NUWxowhsMgLiuMreM/JfPoF26hF9hNWz1eKHez7UJrpbNzRFYPqmxs9o8vI9dOaO/7
         lU7aSIjQH8z5bUabkqqE6rHOYOouLQiRtdFjEKgknz9Nef+2RimeEwBKf6nSyT6bbRPa
         66gKuDlvx/ozQncRf1OFY8NmHY3cINfSv8C/LqClbTc2c5NGsk2nuLrQKSMnkvWSSmcK
         PRaw1ufVLFi+qhoJQwRpmAz/4Tc0G1oQJV7fdwGitT9fm7XMqJczogIrdEXZArWPnWNR
         nvGZCex9xmgU66Oxnu52SbB60nlC9FfRoRWRDousEuYcC0QL309Icmj8/iIOvL0uS4IA
         LZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940333; x=1702545133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abIGam56kSZ3DhSDuEO3BjQb5HXWW5MMfEQ3kw2b1bA=;
        b=h5ivCjdgM2uZ0Hq0Gifx1UE3Agu+EfLnEg7lqmupMY1Hb7vUbX/Y0X8H2rS0X/eOZT
         1Mu9lhLsgaU3ykQVIqRV6CbaUz8wtr7/JZPidAVimu+EHb9L4CHgR6bgr+owWxgE53+n
         yZOKxxJQ2uswp65DoLQSQf5fTMBNkzYsQO54rCt4RXrN22n9N/OHXgjSem6mRFmUkmSP
         oqAhu6TW+LhYw1LA+o51TuyritqECe2oCdoBZFJAZaJfFiES8uM35cnTTsX0C25nnLZ2
         vAzmnA3VoxjtShLZhGoy9JKDvH2P2Q/cPCugkaEgQAxPSXSNLYSvXdYcuwonFOyR0XAt
         t6kQ==
X-Gm-Message-State: AOJu0YwVz0O0RhwHbvJ5ZXvcwI8ZGLKgtU+G0eLiKKY4kjihCX0j2hK2
        iT8LDhk6yvThl0GIR+VNhAp47g==
X-Google-Smtp-Source: AGHT+IFPy6rDPC84jLuaSGV9bgwyFSV/vFR4KlGp8lebRYr+5pOBmJ32Bs+S3ip1jKFNvcx/lCuWyQ==
X-Received: by 2002:a7b:ca4c:0:b0:40c:2c2d:78da with SMTP id m12-20020a7bca4c000000b0040c2c2d78damr154975wml.170.1701940333379;
        Thu, 07 Dec 2023 01:12:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:de32:8b0f:dc9a:4dce])
        by smtp.gmail.com with ESMTPSA id y3-20020adff6c3000000b0033334c3acb6sm896009wrp.98.2023.12.07.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:12:12 -0800 (PST)
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
Subject: [PATCH v2 3/3] Bluetooth: qca: run the power-on/off sequence for QCA6390 too
Date:   Thu,  7 Dec 2023 10:12:02 +0100
Message-Id: <20231207091202.19231-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091202.19231-1-brgl@bgdev.pl>
References: <20231207091202.19231-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The Bluetooth module on QCA6390 needs to be powered-on by enabling the
relevant regulators and driving the enable GPIO high. We can reuse the
power sequence for the WNC models if we add the list of required
regulators to the OF match data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 35f74f209d1f..b27be08a1f6f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1788,6 +1788,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -2044,7 +2045,15 @@ static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
 
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
-	.num_vregs = 0,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 20000 },
+		{ "vddaon", 100000 },
+		{ "vddpmu", 1250000 },
+		{ "vddrfa0p9", 200000 },
+		{ "vddrfa1p3", 400000 },
+		{ "vddrfa1p9", 400000 },
+	},
+	.num_vregs = 6,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
@@ -2129,6 +2138,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_QCA6390:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -2276,6 +2286,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2386,6 +2397,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		if (power->vregs_on) {
 			qca_power_shutdown(&qcadev->serdev_hu);
 			break;
-- 
2.40.1

