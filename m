Return-Path: <linux-kernel+bounces-48453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A9845C48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109CA1C2ACEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73915F337;
	Thu,  1 Feb 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IDZUWNIg"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B077A19
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802950; cv=none; b=us25EM2bXWHtGMf+BQrgm8F55d38F5TlPrM9Y63l+PIoeZUqiJtqSlcLg+k63oCj5X8qJE+7Z7uT1jAXKtE6alS3nlBnXMe+/21HfxFlT66gsIGZ56MeRPLa9E21NtCk6xZ9V0mle/ikE//rw4Yn+6Pdw7qfQ2IReblD0HppcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802950; c=relaxed/simple;
	bh=3K/Cdjx2pgKq+n/gO0neaSXQtnFdv6+flY2c/pit7cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2vWQbkb+u1V+IYdWaMmS3glC7dKjHMOAFPIYvqfZzWw3+bET+aZJYX9YmQHn//ZInY5/sIEQAmHeNcmZSycPvPNNq3obhPrNUYoLU6hAPwxq2tNOKXOeXP3OKMiEG3eJjudZV0RIEaAO8ffuex6BKqOfAUdd0mmo3qHbtT/yMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IDZUWNIg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392b045e0aso564399f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802946; x=1707407746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vP91cg8tLvyh4GtmMrotPK3fTbXOSpz9JyyYuJB36o=;
        b=IDZUWNIgZQ2oiD2yCoUInKTyQwX2ZYP/BY5qRTW2ptitveG+SRREnYnoRYo2elDaKz
         xyYXcBCD9r651yurghVVMCMRLQESuSQE7ZGbsghog+JvDAYnHpYEs5vCLoNcagl5GOb7
         1C6J1YpHFKXseBTelaLuqi6cehUYRdUurydmtAvOOFjVpmXhR9vAS2tz5q/ZmmuzrkvB
         enk4YmV87vdDIWyVS0uHa13b4rJZzcCMTfNeJrJV4r3KiBnAanV5NIlQiDNUb1RbcAUD
         RjKO0sNyI4eg++j0d4qemYVcdv/XcPnhFnAQWIsqwpmQcUHfeqxHiXO1XNLB0mZa+bHn
         x/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802946; x=1707407746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vP91cg8tLvyh4GtmMrotPK3fTbXOSpz9JyyYuJB36o=;
        b=bMWoAqIAzPe+4ramnzJ67MT/ym/hvgUnJRJuBywLLsumQ17y54Rmyapi1TC9pNoWY0
         jQSMaDL/4WJUZfvgf7jyr76VT2aWtcgU55RXogyd40dTlIGnmcOv8mn54xHBCZUlS9/Q
         BronszwDk8ffCaaYxdfNoY/+Pb9QK8Yfuse8e/9X1MnmLKTXmsMxcpBOxPlu8ICKQjwT
         CsR4/fRXNQ9tcJBZS87ygi8EaPL5UOkuJslBptHw8unt1mrE49MN1V+P7bG0rTleP7aB
         1K0SDvVDsgm5oZmLMbw12wsvY5C78MGW4qqlDb1VqUmHnHnaP7rk+FMCv0sOAVQWF8+A
         IaxQ==
X-Gm-Message-State: AOJu0YxrsDL88Y3mO2JbYM4n7642CsAMEyf9pFLt9bGeSW6Ks2i1Qs61
	rxhnrSNJkvcNleYZlpMpuUkVOHrKxoibYWVGBDrlmvUYeXFUOauktknc5LPWzBw=
X-Google-Smtp-Source: AGHT+IGMtXZKRCK9HK7sXoPe2PLmAVeG4j6TMigKchzmxTwgf1uc6ehY/ZKfz8Lq+Wl9moQnCGhwQQ==
X-Received: by 2002:a5d:55c4:0:b0:33b:1b4a:9971 with SMTP id i4-20020a5d55c4000000b0033b1b4a9971mr459697wrw.36.1706802946315;
        Thu, 01 Feb 2024 07:55:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXakd+908vg1WVK0epAZh+bow2uHG8Upjuu7Z/dWVUfMpc3q3BApJRZfsMsre9It1TR4XwtQBUuzLYEt/Jr3J9bLLJKQVJlsHHvrhjIS+fpQ5khwOIsG9cOlZ30GEfF+LtxreJD/Sxp9paEdhb7FvTf9mSctAXGJN7WAlQfrBPkCTHYKAqacMMb4DzfZCq/VDzHs6+0YWWbJjyQ1J5NcrUjzF2jyjj03cMLxdjckWF7xTG1sVKkYn+4J0vetSxwsKGikvVr0PyijkgH1fb377QQM5qtjhpO/+9mzYQz9XJH06cj89UWzJkzOKkQl5NKPL5eAZaoAmnuK2l/usluA/9E7Pz/8S7aeE8XXv1S1IHlXQkn6IhGVOMUVWrr8/VZ8mZKPFtS10b094x59k3EZzKhI5bw6TEBxl5MSEydCcRtBvW63ey5hVDxqZkvDTf+GjmCZht8LC0D9NTGqIeWGtlKBNvEDFOPpK7b75wB6+0T3kQOEL9GozxHjANbQZweI6Sy+Fc4qKRIDAGiF5UH9XAUJTjYxO4S6mE/5JaEC/FjmG6qGMpCJuLPSKtAdVlITev2OXWg8vn0zNYFbUbzdk3MRqGQxw2zmCyXBFAVpgPowJm9slqViRMFmh+L4nGKsOwsYUHTovOHz0b3hFnhzfTvr6GKwKaDOsRrDgpBPgdppz7lz0kZy2NjAmHmTm0RAUg+mx9AC4fK
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 5/9] Bluetooth: qca: use the power sequencer for QCA6390
Date: Thu,  1 Feb 2024 16:55:28 +0100
Message-Id: <20240201155532.49707-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the pwrseq subsystem's consumer API to run the power-up sequence for
the Bluetooth module of the QCA6390 package.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 94b8c406f0c0..21c306caafbc 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 #include <linux/mutex.h>
@@ -214,6 +215,7 @@ struct qca_power {
 	struct regulator_bulk_data *vreg_bulk;
 	int num_vregs;
 	bool vregs_on;
+	struct pwrseq_desc *pwrseq;
 };
 
 struct qca_serdev {
@@ -1791,6 +1793,11 @@ static int qca_power_on(struct hci_dev *hdev)
 		ret = qca_regulator_init(hu);
 		break;
 
+	case QCA_QCA6390:
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		ret = pwrseq_power_on(qcadev->bt_power->pwrseq);
+		break;
+
 	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
@@ -2160,6 +2167,10 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		}
 		break;
 
+	case QCA_QCA6390:
+		pwrseq_power_off(qcadev->bt_power->pwrseq);
+		break;
+
 	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
@@ -2298,12 +2309,25 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
 		if (!qcadev->bt_power)
 			return -ENOMEM;
+		break;
+	default:
+		break;
+	}
 
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
@@ -2344,6 +2368,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 		break;
 
+	case QCA_QCA6390:
+		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev);
+		if (IS_ERR(qcadev->bt_power->pwrseq))
+			return PTR_ERR(qcadev->bt_power->pwrseq);
+		fallthrough;
+
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-- 
2.40.1


