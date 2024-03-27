Return-Path: <linux-kernel+bounces-121923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C688EF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB52129E490
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2B15250B;
	Wed, 27 Mar 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw89/Rzp"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0015218E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568961; cv=none; b=Oqu/PsRoFylcdZsImRb9zdcdj/XTPB1DD9Kx6W/9ATNplkLnaI4k56/KA60rRQ6dgWYoCS7kdYub/jSb353SZAbvQIl8FKZAx0sxc/ayADXtmSo8wqCRbJCEUHG82w1DGUUI1fAsL+q7icB6m114aGOmDAW2KUPuZcG4K4P+ch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568961; c=relaxed/simple;
	bh=bAoVUdOEl5oXBjR4tVelpCyD6CLDNyMZESd4YDrAuM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=loSZXakP7d3RprC8XzFNR+z0qG0pYEBqpJRLov3g3oKoywNg2Faa+RXxkNXnWO1f8o+ghhunUSY8B0Z8iVZsFSnmNPTw5wVOFyezAhHHrAFl+TxzHBUZgQpj3JjDIZfrym5BiMBPWmnbmWpSK5JB9KRIyHHWrmYxr5x8TRgyMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw89/Rzp; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so1892051fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711568957; x=1712173757; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrM6H3f/CVd7EVIzLnLM60MDR7BLmyLxovfihEFCOqQ=;
        b=Iw89/RzpO8hhweIpjfpc1ZtMetOrHCUa3bxOUXQroCfUMUZL+WLvXFM1p05D7stQCc
         UcHlv4Q9tVeQDmzsNA3/OIj/DAPtryYRY8dN//gwCS96FFhbKxQ5T5hVyPloJw3/QN1q
         JCjUYtJPg0SFRdXzeJP5NdCTcFwFeVuCEQ4cMgs9ql+zQf/G37tCAjxyta8xz/oWn7gE
         yq5fmXNlTATX0IOoWQAXW2/AHV6DKNjFfL5tGUnsSsqJOiIZL8oCMcAjLMExlf+9KO1g
         dUYrt1hO9vZCkz6lDG9RfiKXo2e2i7XJAyWtXjlOM0AO+pyBREbSjL+kuZQLGM9SjjEu
         VlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568957; x=1712173757;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrM6H3f/CVd7EVIzLnLM60MDR7BLmyLxovfihEFCOqQ=;
        b=mWGO718xKS9r/Z6wGAwQAISKkNfoG9ysNQyRDF32nx3S3TZV/3eIuag4pDvVlKdqIr
         iOE2a/Aj9fGNZ/zvVS+q6mubRNQe1k9PN5rgYtz05UgwIHDAqI1lrLJ4CMSy32CRSDkM
         whiFciRRpzOHI+88MGsg83nIm0XQNXIaD9SECrC0VSQcKHg+VB8GqCWJGu7Tq8lhyfAr
         hq0sEnwMqdiR6vOc0vPzIIeco1DuXXiPCSlOz3J7dT+V9tmH47KsLkajgCgxg1zmylUi
         ceUjPxe//LJAOsCUBRrXEdYfVOKXRUKU97dsVkygEIS0cwmFr9LqRqH+PQJs5DXarbut
         MnRg==
X-Forwarded-Encrypted: i=1; AJvYcCUDfIFqaoZDuSsou0EKDXWYOZzEV1q44R4RNDQt5L/AAh4BLPQtgMBdj1pNj/xoUnJShL3cB33r4lWjdF1/N4XIRLY3xjopGygOFgE4
X-Gm-Message-State: AOJu0YyBty5pfPD0e8kURwCD6A2tF1QIP7cmsrQNePI5e0DA0WJ4gh9m
	XuY8Pc5DXssWpQd8lQquOoFnzGMw8Y3dNCyJIQtf2fuu/4mNiUqkU30tznarcfw=
X-Google-Smtp-Source: AGHT+IHCtMJ1TEGgYZ2P1PWlQMN4NWgMM7GEMX9FHTpjySwq9ILK2/Fx0WRham7uXLy8Cz1FLR1PZA==
X-Received: by 2002:a05:6512:311a:b0:512:d877:df6f with SMTP id n26-20020a056512311a00b00512d877df6fmr275280lfb.2.1711568956742;
        Wed, 27 Mar 2024 12:49:16 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4e0ce293cfsm582147ejb.41.2024.03.27.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:49:16 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] Qualcomm PCIe RC shutdown & reinit
Date: Wed, 27 Mar 2024 20:49:07 +0100
Message-Id: <20240210-topic-8280_pcie-v3-0-ee7af6f892a0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADN4BGYC/3WNywqDMBBFf0Vm3ZRxfBC76n8UKTYddaCYMBFpk
 fx7U/ddngP33B0iq3CES7GD8iZR/JKhOhXg5mGZ2MgzMxBSjVSiWX0QZyxZvAcnbFxXj40tG4v
 UQV4F5VHeR/HWZ54lrl4/x8FGP/u/tZFBUzoe60eLrbXV9SXLoP7sdYI+pfQFNGf5eq8AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711568954; l=1416;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bAoVUdOEl5oXBjR4tVelpCyD6CLDNyMZESd4YDrAuM8=;
 b=0Wa0d33D2z4AXCaHfFMONDdw/s4pXtOxIYRBCKa+l2mDNrEe1dXZ2x4VpPs+QKubuqUO4zDw4
 J+aFHTa71ZWC0yeleA69D3GRvDP+xm7MBIpGVj1ore3l/zyBouzjUIO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Changes in v3:
- Drop "Read back PARF_LTSSM register"
- Drop unnecessary inclusion of qcom,rpm-icc.h
- Fix a couple of commit msg typos
- Rebase, resolve some conflicts
- Link to v2: https://lore.kernel.org/r/20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org

Qualcomm PCIe RC shutdown & reinit

This series implements shutdown & reinitialization of the PCIe RC on
system suspend. Tested on 8280-crd.

Changes in v2:
* Rebase
* Get rid of "Cache last icc bandwidth", use icc_enable instead
* Don't permanently assert reset on clk enable fail in "Reshuffle reset.."
* Drop fixes tag in "Reshuffle reset.."
* Improve commit messages of "Reshuffle reset.." and "Implement RC shutdown.."
* Only set icc tag on RPMh SoCs
* Pick up rb
Link to v1: https://lore.kernel.org/linux-arm-msm/20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      PCI: qcom: reshuffle reset logic in 2_7_0 .init
      PCI: qcom: properly implement RC shutdown/power up

 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 176 ++++++++++++++++++++++++---------
 2 files changed, 133 insertions(+), 44 deletions(-)
---
base-commit: 26074e1be23143b2388cacb36166766c235feb7c
change-id: 20240210-topic-8280_pcie-c94f58158029

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


