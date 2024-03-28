Return-Path: <linux-kernel+bounces-105722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C987E372
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC35281861
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A1224CE;
	Mon, 18 Mar 2024 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZCUVbMr"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE5224CC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741889; cv=none; b=pBylCaP3zvVesi5GOEm7lNOOmjQ6tJEb4p+Y6ycIxijZKdYuCTSXloSAT8QHCS+LUfGWDtndqGLky0QaZOCxuzgSHljUsZy6hv9/bkmoH179Cmg+yh5x/akBEKuc04ryfU70PZY40Gyr2FQKaySQ2qWQjTKUNCHNa8IOQSkgXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741889; c=relaxed/simple;
	bh=BwmRoHicbthPVJYp5WFTqYXbOTkG+56fPFTM88IX99E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eeYKLyb1MmWOiAmdovKdxK9d1vzbRMI3VdTugnyIGLvIAAxe2CMofJeHTYek1UjTRe3+rmOUWFGledy/MzZVL2adp21QZKTpvHc2/nRYoTTsk3jUB72/sgxge2lOAXa8jIuPDJpXr2ypQUm90P4QX/GBFL/PNM6sCxNXmXJWEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZCUVbMr; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c386c46068so445966b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710741886; x=1711346686; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56ysuS3InXneN4gQynFc+cu52Y35fc1FX0ysoZJyQf0=;
        b=MZCUVbMrWB3RWGisUXeMnpYfLk6KoR5dymvWAj1MB4o+ejeqoszdAUZ5kzptDx5zXt
         uuKNOMj0e6g0U7aAokKc3mTUnMwyBvl3OJXMOKRzqb13+Y7SY657YG99M+uAQOuM7zkD
         029Z3pGTO+TJs61BczrXJz7e/YwlO/1V26t+kY1rbNZTfodYrEJI/61j+k3yfCj367A1
         On7ThPulT44yQqNXXAua8fTzpgvkwKaCDyMND43ukn/TodKzSJkqbKSLh3JRHGWvUVpM
         nFvTpQ+OOQAx3Ufi+WPE0Kxce5S8Lxp3C7UzYf3mDnqcbe9LwkOLsE7ko/CGyI2ttjob
         +Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710741886; x=1711346686;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56ysuS3InXneN4gQynFc+cu52Y35fc1FX0ysoZJyQf0=;
        b=PS/NqMjWExZuBxSnFaID8xFWYv5po1AukiElfS/sXJBGBL7x5n5sHYrTRzJe0ExhGb
         XOYchixtzNRlxQh9GZpTvymsZUQeAckLZpAiHAhU02vzuap6oo+JPMSc3uN7AdeVedj2
         oH0pffT8F20GSNt51RHGmdx6ZkujBOp/YSDwlxfFZ2vsCxNMwQouGlzEdcdoffGJ9DBZ
         6eH1FFNYF9LnreQeFUJTf+5ahrZC0qr0YIcvf/A+Sqae9TTCf3HDXk78i8CsHVA2yRXL
         Au3Pg4cDFwYcT9MHxelLL1swvRGCBz1XR5SUB0wtTxW2sFim1GK4sWRj1hk3xJVJZ6Fr
         1Y+w==
X-Forwarded-Encrypted: i=1; AJvYcCU5DOocDnIweQrpSmllLynx59mZWZqC0UvZRzKXfPTW8TR91f30Y/hQ6OqHhbpJMIo/J+NAUALBmvXKrEqYq8CNPgqg+EoJMlUK3coO
X-Gm-Message-State: AOJu0YxmbiylVUjzCA5KSgh8q/156BHZ11rpf7peoQRiiDEyGI+Lv+jn
	CJgb2Q9U1/tD4ziRp1gRcanF8pxAYpHf+qXdcZ7yvOSQNWmMXQWY2j720/SpwQ==
X-Google-Smtp-Source: AGHT+IH44udjFeJ1oWfML1brU+gDs95G0u5a2KDdlFsmMHkGCpeJM+Wf8tlTJqbBQJ1bpZwV3DoyDQ==
X-Received: by 2002:a05:6808:1308:b0:3c1:f61c:a1d with SMTP id y8-20020a056808130800b003c1f61c0a1dmr12916726oiv.47.1710741885641;
        Sun, 17 Mar 2024 23:04:45 -0700 (PDT)
Received: from [127.0.1.1] ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id p12-20020a62ab0c000000b006e6c5b065f5sm7064268pff.28.2024.03.17.23.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 23:04:45 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/5] PCI: dwc: Add support for integrating HDMA with DWC
 EP driver
Date: Mon, 18 Mar 2024 11:34:24 +0530
Message-Id: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjZ92UC/2XMQQ6CMBCF4auQrq0ZpgXFlfcwLmg7hSZKTWuqh
 nB3CxsxLN9kvn9kkYKjyE7FyAIlF50f8qh2BdN9O3TEncmbIaAELGtuXrw395bX0hgNjVUCFMv
 fj0DWvZfS5Zp37+LTh88STjhft42EHLiSKLABEFaK880NbfB7Hzo2R5JYQVxBkaG2Wh3LQ2k1y
 g2UPyhgBWWGjSVTQU1NpegPTtP0BQty0+ERAQAA
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=BwmRoHicbthPVJYp5WFTqYXbOTkG+56fPFTM88IX99E=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl99lyQIA5fNWu6GUJNokIH3uQIzohPK9vWoXjc
 1xX8GtFEbCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZffZcgAKCRBVnxHm/pHO
 9VanB/wPHjCG06VtYHDvhvzmH71Xexxy6V5tLa8IIGf8INS2r/RaJq1C4+WDxej+YbjWKQkffuZ
 +ahHLkST0HBc8RkCR0pa6lQrvi1QjIPAzJbo3Wmz8kCM/43T9tybPAa952zt1AZINaa3bPUDC2x
 4alM27FWI0byDrQjsM0OydO7/+SPnfUHVqOVOwUgWxNB7+/V4La+zq015K5nZX3ZFLu7PGJeko3
 j2gcB8hKONkIi8xGHFe9oPjjpRvEdW4BS+7lo6NfY6hVGBJH/1OC5xKgv9dTwANYs04Udh6hPaC
 dL96P7KjoTHqoEF2o9siv06qKXAapRKY+OGXZ9l+BKOvfcF0
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series adds support for integrating HDMA with the DWC EP driver.

Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only unroll
mapping format and doesn't support auto detecting the read/write channels.

Hence, this series modifies the existing eDMA code to work with HDMA by
honoring the platform supplied mapping format and read/write channels
count.

The platform drivers making use of HDMA should pass the EDMA_MF_HDMA_NATIVE
flag and provide channels count. In this series, HDMA support is added for
the Qcom SA8775P SoC and the DMA support in enabled in MHI EPF driver as
well.

Testing
-------

Tested on Qualcomm SA8775P Ride board.

Dependency
----------

Depends on:
https://lore.kernel.org/dmaengine/20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com/
https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/

NOTE: I've taken over this series from Mrinmay who posted v1:
https://lore.kernel.org/linux-pci/1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com/

- Mani

Changes in v5:

- Addressed comments from Sergey for patches 1 and 2
- Collected review tags
- Link to v4: https://lore.kernel.org/r/20240306-dw-hdma-v4-0-9fed506e95be@linaro.org

Changes in v4:

- Rolled back the code refactoring done in v2 for patch 1 (Sergey)
- Reworked the channels count auto detection (Sergey)
- Collected tags 
- Link to v3: https://lore.kernel.org/r/20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org

Changes in v3:

- Collected review tags
- Minor code refactoring (Siddharth)
- Link to v2: https://lore.kernel.org/r/20240216-dw-hdma-v2-0-b42329003f43@linaro.org

Changes in v2:

- Dropped dmaengine patches (Sergey)
- Reworked dw_pcie_edma_find_chip() to support both eDMA and HDMA (Sergey)
- Skipped MF and channel detection if glue drivers have provided them (Sergey)
- Addressed review comments in pcie-qcom-ep and pci-epf-mhi drivers (Mani)

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (3):
      PCI: dwc: Refactor dw_pcie_edma_find_chip() API
      PCI: dwc: Skip finding eDMA channels count for HDMA platforms
      PCI: dwc: Pass the eDMA mapping format flag directly from glue drivers

Mrinmay Sarkar (2):
      PCI: qcom-ep: Add HDMA support for SA8775P SoC
      PCI: epf-mhi: Enable HDMA for SA8775P SoC

 drivers/pci/controller/dwc/pcie-designware.c | 65 +++++++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  5 +--
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 23 +++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  1 +
 5 files changed, 75 insertions(+), 21 deletions(-)
---
base-commit: fdd10aee7740a53c370a867b8743a8c8945d1db1
change-id: 20240216-dw-hdma-64ddc09fb30b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


