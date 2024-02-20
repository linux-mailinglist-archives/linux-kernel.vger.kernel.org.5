Return-Path: <linux-kernel+bounces-73576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1D85C46C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD731C22E82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54AD134CEF;
	Tue, 20 Feb 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoBzwloR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE196A8D0;
	Tue, 20 Feb 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456445; cv=none; b=WIKCQDqqzwxwP3Pu6wUZX8Zs1iq2os3XomiXluAuXx55IXCjplQQQwwYOfxH7ZTbLHkCVVn5VOZpGFVRHqfF1XjJhh1BaHn6eLA6EnNNplpY91Rl4yqh8Iwqib9hwMgXjQQQskDFIsN8V3vmMNOEW92h9QbjXpQj/WeQzWxD78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456445; c=relaxed/simple;
	bh=Vj/ZTfzxphIR8gVetdnx24KOvZPHcYyzRAok6VpGq0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I/5PKr++26BocL0LrA82a1RkLWGKFf4J8CWVf7Kp62uPLsxNTvJm0kA19M1CjGcxGFm4ffPLBH4l3dEc2um6cXyfFcEAIpZrwwfc3e/nlzl/QNFpvD6Y4qfRQwkrpkNsIXGT/5plH8wV4D1V7qU77v2An6Hurell/H8DHppEMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoBzwloR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41272d44adcso2418155e9.3;
        Tue, 20 Feb 2024 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708456442; x=1709061242; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBBZEpewC9BLRC+ZISwlxkj/pUQLQpzkfsio0tQwFB0=;
        b=ZoBzwloRr+1vuo9jWJat6uR7bqNKIGQ6U+lt2jAomtctCkp4C2BWBZYlfuqvNAhsva
         kkcRd098aFDRMxb8iRxtMNAP5+bgXsTQN6GRNmSBsiW8ZRpl55FDUC/6Jj88XfCWb76Q
         gNiboC9BT89MNpKAsji68chZfekZy/Nk39MRjv3orlMCa3Y+ZdPZGC27jrJGr8wKIuv+
         JRjI0dtYTGdoJjVfeLszTr4KHHRRimUV7Ac5x3QL5tYqAsuQk0kBt5dBqfH3DQQp/Ehe
         SaM8dibDK9WuPymCeIThRXe7HllnxYEzia0C8SC5WuPU5YJIdIrGN4CFeF0zq41POb0g
         4gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456442; x=1709061242;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBBZEpewC9BLRC+ZISwlxkj/pUQLQpzkfsio0tQwFB0=;
        b=G8koPxt743Ui2wxdq3iicc2l8HRyBkjN60TH4Oy5SLY0xRfidCp34UthsyP+76Crfg
         CBQWgFHOHmA4iGKpjDTuTAd7rWvYi3TKLqOsCskqtlzdhrKzZ/sNufHXD2alktaejY4f
         SbU4laQ9oDk0XyZaFu+ArSdlB0qrOv7qB0/tRk1wfjzSgnmD8WhEJnGC8ppXgcd4OWOb
         NJBxNQl7m6yAlGUZLLxv3A3r9XTOplwuH9MhtpYu00UQpvCcd10OwmiSFLJWn3vmBdFU
         vW7m/PmLz4uqse0NkDCsSSsi+FwmuD78KRN49x71YjTBcZS1vvlyXIFn36ov8eUKCQN8
         hfAg==
X-Forwarded-Encrypted: i=1; AJvYcCWWpzZEKV577+wnxY1/hu1jHRbcDEdi/4UBnQZb/Vs3VHKe7iKjGf4hLXglCAHIRA+a6X1MJC/oEtgB87hJj4Y84eGxC+P3HvOlmTIM
X-Gm-Message-State: AOJu0YzZdGwb5D0S4jjCbxvlQsXICoAMPkTmzTgHvuJXFD1M+nO+TPQo
	3yDjiS4gBxo+oEOLiUpFbxtqzQoD1LkVPMB9Ngc06jjiaqptl91Z
X-Google-Smtp-Source: AGHT+IHBXdNX8jfFHVljuYY+fDBgzTiYvU4aoKgQpeXGTMPlWv5Vyn2OpBFMl+BtOqoPl7MZSe+EhQ==
X-Received: by 2002:a05:600c:1391:b0:410:e41a:fc0d with SMTP id u17-20020a05600c139100b00410e41afc0dmr12504690wmf.24.1708456441861;
        Tue, 20 Feb 2024 11:14:01 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id i6-20020a05600c354600b004107686650esm15807564wmq.36.2024.02.20.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:14:01 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 20 Feb 2024 20:13:47 +0100
Subject: [PATCH] phy: qcom: m31: match requested regulator name with dt
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOr51GUC/x3MwQ5EMBCA4VeROe8kbSnhVTZ7KAaToEyXEPHuG
 sfvP/wXBBKmAFVygdDOgf0coT8JNIObe0Juo8EokyljFC7DiWvjJ5xSjUL9Nrq/F+z4wLKw1ro
 st6rWEAeLUMzv/Pu77wdEwVPabAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
supply regulator must be defined via the 'vdd-supply' property.
The driver however requests for the 'vdda-phy' regulator which
results in the following message when the driver is probed on
a IPQ5018 based board with a device tree matching to the schema:

  qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
  qcom-m31usb-phy 5b000.phy: Registered M31 USB phy

This means that the regulator specified in the device tree never
gets enabled.

Change the driver to use the 'vdd' name for the regulator as per
defined in the schema in order to ensure that the corresponding
regulator gets enabled.

Fixes: 08e49af50701 ("phy: qcom: Introduce M31 USB PHY driver")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-m31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
index c2590579190a..9d84858ba1db 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -297,7 +297,7 @@ static int m31usb_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(qphy->phy),
 				     "failed to create phy\n");
 
-	qphy->vreg = devm_regulator_get(dev, "vdda-phy");
+	qphy->vreg = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(qphy->vreg))
 		return dev_err_probe(dev, PTR_ERR(qphy->phy),
 				     "failed to get vreg\n");

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240220-phy-qcom-m31-regulator-fix-97555a4650b1

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


