Return-Path: <linux-kernel+bounces-101458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102687A767
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD871F242DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E93FE52;
	Wed, 13 Mar 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dH8hHJWQ"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D73FB0F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331774; cv=none; b=McGxtpkoT8htIHKdd46wB6TrZzyVSNw3BOsEvhBal+l4rpyoPO4ZOv9mey382PZ62k9wlPtqU2bWLnHecRYa6JnlNDzV5gSvhBE54eiaNvm3Fg1roPsjntKnk7sihpfrxzMfUL39mxn+t3aoogERlyVGH0D2y2VznMByLAl2HDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331774; c=relaxed/simple;
	bh=PaWJKUsVlyLQ/OT+v64+m7jQDF3xuZkRa2uz3Sn7OxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p32w/lsgmOUp2Dj9pOpbGvedxCai+nzTkIunAU32AcpgqSPTFkrZKdDtMiD4VcdL7vATj0qWmGJ6Em8vTCbVZQrupIRplOR+R+i781vWEHkA+d4nMQRCvkb4NQPoBOnJnBV74vdcCjyt8E/+B7FYGQL4f7SkYI6U38baUHooX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dH8hHJWQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a029c8e62so41993671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710331771; x=1710936571; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkFrCRZ7REzYM7HPzWkHOB/qAAg9L6SN2KGBi6tV2U8=;
        b=dH8hHJWQTphkmvll8n04qLSgOH6UD1A5rEMG3lCbztiAMf2NJpUQZEDQQc8B+pxuic
         R+M/ufkF2CUg0aF+M4bcBDrcmt3ll3+gZR8sdE8CrhwoNN7LYdaMXiZiNnViHMtCJIcg
         V6YKE8gfIrN066Z5NGlovIfT8RuBmg7F++Qu5uVRBawQEW5XSRQ8ad5qQVoDW0nMuoeS
         U48jQ5odB/8jqDEFh8rrahQfNGnT3IzOXWP8YypdlRv2qFLhVB/KMBLKurRT+xAkfE+4
         rg3flKBVb4+D/5KzE5Y0oSWuM+ceJSgI0GMqy73GznzYvvs8tCG2SNNjq2YAcYQyLa7W
         usWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710331771; x=1710936571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkFrCRZ7REzYM7HPzWkHOB/qAAg9L6SN2KGBi6tV2U8=;
        b=rt/LE9zabSSWgLd5UFhihx+x6tp03odzDQLAftF3GMTAg7NU6pUBX13+WZUrWnfxm2
         4bLUFRGJPb6DHNxGdnBD3Qq2HSKgNKAEFbdlo4iUUuBUXnNih1ZUWU43eqM5YH+9AcH0
         p3ezedh/mUgjM+0KmtT/xX/ju4Ygt2NpZ5WmdGFFHo5p47WUaiF8IzcxPFbCovfi1ofu
         L+BcC6GeqzAL2JfY+OLvu54EaqONNjCaUWUYwiaLra2+Rata15wd5UB5MND5FPkZieDR
         d3XQSbLJeicmE65YfKLJYVYgbpow3qp7fUmZmGBChafVwbhN2NEMn9ImbjxTwbHtlrJT
         F/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUXonDTCkZhh9lbzbgvunBxWw802OQ/JPjA+Zbr8gUXtJSfuVWy4Wj3FdY9Y1nCdtczhdYFulwoSyGp1suyn6Gr0n2KEQPf0lJLDNjj
X-Gm-Message-State: AOJu0Yy+MHeiZG+zfSrwFyT73z1AB3xspiSrdYyYSPOGV60pq6Ld5S96
	ZMsZ5hwowsYRfkk47g68fSu71i+eC/4uWFnyrf501iCr32MODn+FPK+yOEhbsQ==
X-Google-Smtp-Source: AGHT+IHPxYLeojC3Nitb0DmAlBOP7LbnLK4ua+fvpOeNRBl6nokaZyXh6+ry66CSHzQIQg+NuA8cRw==
X-Received: by 2002:ac8:5d93:0:b0:42d:ff64:edf with SMTP id d19-20020ac85d93000000b0042dff640edfmr16590169qtx.7.1710331771443;
        Wed, 13 Mar 2024 05:09:31 -0700 (PDT)
Received: from [127.0.1.1] ([117.213.99.94])
        by smtp.gmail.com with ESMTPSA id c19-20020ac85193000000b0042f3098f410sm4773377qtn.48.2024.03.13.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:09:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 13 Mar 2024 17:39:22 +0530
Subject: [PATCH] PCI: qcom: Implement shutdown() callback to properly reset
 the endpoint devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-pci-qcom-shutdown-v1-1-fb1515334bfa@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHGX8WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Nj3YLkTN3C5Pxc3eKM0pKU/PI83RQLMyNLC0MLM1MzAyWgvoKi1LT
 MCrCZ0bG1tQDplwVAYwAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=PaWJKUsVlyLQ/OT+v64+m7jQDF3xuZkRa2uz3Sn7OxQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8Zd3NreNMGV1X4mPgyzeV4pVF/YH7jniwvnhZ
 kUQ7Nmn8cWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfGXdwAKCRBVnxHm/pHO
 9ZmjB/9LYaEXk/pWFVtsJAONhGfusM3PQ5aJyKzT/pwsoVwdaoJXRCI4mphSKlEr+AXmTPTsEfK
 nVupmE5l1DMclwJEbhWgKGVE3EOs7tHWIjxkzX+Yc/ldJS9L8weqyoW4g3fDlljKxow0q9nT2V5
 Vc8vPomJhwh2EEEmxftxXx7CiUycP8W5IDuB60PclK6tGa0TLWYSSuIdpEje3yGa0FRvVlC4yuy
 qC1vgkeJpDR2J6/AbrNJxyTrP7by4Zu6PJjdjzk4EVlJOkn+rirka15APc4p01Au7jNqffSjdMG
 yaiP7ssFZwRxuYohCAgmKMP/f5NDVhVV0yJ1VtQprVRrve9F
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe host controller drivers are supposed to properly reset the endpoint
devices during host shutdown/reboot. Currently, Qcom driver doesn't do
anything during host shutdown/reboot, resulting in both PERST# and refclk
getting disabled at the same time. This prevents the endpoint device
firmware to properly reset the state machine. Because, if the refclk is
cutoff immediately along with PERST#, access to device specific registers
within the endpoint will result in a firmware crash.

To address this issue, let's call qcom_pcie_host_deinit() inside the
shutdown callback, that asserts PERST# and then cuts off the refclk with a
delay of 1ms, thus allowing the endpoint device firmware to properly
cleanup the state machine.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3bd932b..41434bc4761a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1618,6 +1618,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+
+	qcom_pcie_host_deinit(&pcie->pci->pp);
+}
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
@@ -1670,5 +1677,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

---
base-commit: 51459eb30f88651d3688b9e95fed0f97767ececb
change-id: 20240313-pci-qcom-shutdown-d86298186560

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


