Return-Path: <linux-kernel+bounces-103474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8287BFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607B01C21C34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8771B40;
	Thu, 14 Mar 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlYqSTHf"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1071B32
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429848; cv=none; b=hEaFGtKLPnSHYh8XTbPqUbt7z9QP27um6XMWx9uG6nJTjw1RTYcKHrqdmoQbE5aguYYPNounImntVWp/SdSiMZ0u1Y/LIgZRD8HfRD0x8TQ66cytkHaDVqt5m46yi131SIsJqTQ0nc12AE9xo/lhVhkUGAJ5b6ybU2IMXsdNG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429848; c=relaxed/simple;
	bh=+XqMRpYE8HYIeYnArh9TOIJOZHL3dBFs8VCBPD9Q15c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L57WF6vVbkt6CaL2NThk0ddWToP1DcPEY3thkY1j0K/vAkq/xtc705PeEykD6wdZ9EGSdbTR58pTN2em7tbxmk7vrxjcoUawBqp7jWVqTW0ReuNazXUnXlvlKBLEaHKUg6eO0D6m8vOgZ2MiBCasQttgYXIK3onEQX5XBoyFlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlYqSTHf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso340891b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429846; x=1711034646; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uipF2nWjwEvJ8FinmI/99ZEfUz9FMdfPX7qMJmCrSQo=;
        b=BlYqSTHfD9UyaO7QVLhiSf54KlVc81u084CL0d6bDiHMVx3Qds5aFDQ+qTDpErSu2D
         XlsgTVI4RKjJVl3UMQktfDuibqduqOrh1HGRbdLv75+58BKu63/lUGl5jZhh+LuGrVLs
         8kpUs91JFZ+pfZUqE8+qm/rDtiTKciCLiRsD8O+HI+vtJ/KpVxNc2zfqKLDYN/40kpwD
         3oWLUx15fqU9rXyhUW7NKKBqoX5elZUesr90pwDIwyR/XrH9T9agOWbd4tynlBEo7H3t
         fTgegKj4w9RFNTSUWX97cUYfkHQhJSFpsxWMNnwlE72cPxLUDAkPfjtXOj2yfVGrKzCV
         3s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429846; x=1711034646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uipF2nWjwEvJ8FinmI/99ZEfUz9FMdfPX7qMJmCrSQo=;
        b=FgK+awBSifoZrX5wfxW94fuLLRXd0O3GYBhoZIhnI7pETqo9o/NoC9jWRMk8dBhJlN
         N5Uv3VjsgDo7HUcNrjJw5F6utyXbU7Qv0VIrrzRuMWVvKbUOCBGZ2DAMbeSuxH1wkVXQ
         IMIgLgKUztcWUwMLsZWj0/zazsAUOScKRaHTOVoD1WTBZoUBs1iBb2YIqmCz2+Yt2fxM
         hA/Uynsx8/F1aOkjbnw7qMFUMfo6P9kVTYowHjZPPk+nOA8ssla9/zOb247IwCkJOSxO
         K68wdVssumR9JhBR7c1D+lByCsrn/mvjUE9ZuoMU6E521x+huDFqp3icFIWZB/aVqvL1
         PvUg==
X-Forwarded-Encrypted: i=1; AJvYcCVw41c6YUuhK00uBUTlZQ9ZKeovfVTWXrnHjAhYju92gmA4W5/cGkYdzH7o7TD7GXueZpF3P1IYg3iN1dX5oY6GFVM4Qjk6LsS8o49/
X-Gm-Message-State: AOJu0YydheJ4s4uCxUkZ6pf8EEATIWWcYWDS3Pb1m85Flnfu1sfylbm3
	ewULVvA9xgQ77LMBalG/sSe/UkRPu5KAmjn/otCFcaJscLf3W8r9tQXNrb95oQ==
X-Google-Smtp-Source: AGHT+IFklPwK5lYnqo3cgyMR3pbXaUxnP8BhUJMkvG0Mpsc5bJGrHi6YT+MWzcxtRkOPSBXX0DpvhA==
X-Received: by 2002:a05:6a21:99a2:b0:1a1:5a12:9119 with SMTP id ve34-20020a056a2199a200b001a15a129119mr8387816pzb.3.1710429846330;
        Thu, 14 Mar 2024 08:24:06 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/11] PCI: endpoint: Make host reboot handling more robust
Date: Thu, 14 Mar 2024 20:53:39 +0530
Message-Id: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsW82UC/x3MQQqAIBBA0avIrBtQs6KuEi2sphqCkhEqCO+et
 HyL/1+IJEwROvWC0MWRzyPDFAqmzR8rIc/ZYLV1ujQOw8RIYUGh+5QdfU11NRpd+qaFHAWhhZ9
 /2A8pfYuAfZ5gAAAA
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+XqMRpYE8HYIeYnArh9TOIJOZHL3dBFs8VCBPD9Q15c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaJsDnRXWXOn639N6QSYpQWMRYVyNmaaXhJa
 fn0bkPxFe2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWiQAKCRBVnxHm/pHO
 9aycB/9b/o4Li6j8PqMVlSnWfc7wdfhcraMkEMFGScwUc/THnarLDa5UEMcMICzCyb9OLOWRndt
 oCBxFCx4BL1ZKDe4PUbQUdo47vJm12TLIoq5bnXsy8rl7eUSaxklwzQaG1HxCbenXX6Ob93oo3M
 nOaWZ/FWBuLztkGRERM5PsXEcw0ViOcPwn3IlQ/1qBvKdBCQ+bJEtrJFih8ES1wXtxMCeeeBMem
 0kVbsWosc0pA5xP6Q8EKQfQRX3VLIpRuoL1MmkEA+yQTL03Au8rJS8JowKwbh/MjtDwv+XSiSUu
 Xx+afP9RJhNfpvDPNHIJ/UKyy2Hhztd6xfR07xVMgfhQgjzZ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This is the follow up series of [1], to improve the handling of host reboot in
the endpoint subsystem. This involves refining the PERST# and Link Down event
handling in both the controller and function drivers.

Testing
=======

This series is tested on Qcom SM8450 based development board with both MHI_EPF
and EPF_TEST function drivers.

Dependency
==========

This series depends on [1].

- Mani

[1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (11):
      PCI: qcom-ep: Disable resources unconditionally during PERST# assert
      PCI: endpoint: Decouple EPC and PCIe bus specific events
      PCI: endpoint: Rename core_init() callback in 'struct pci_epc_event_ops' to init()
      PCI: epf-test: Refactor pci_epf_test_unbind() function
      PCI: epf-{mhi/test}: Move DMA initialization to EPC init callback
      PCI: endpoint: Introduce EPC 'deinit' event and notify the EPF drivers
      PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: epf-test: Handle Link Down event
      PCI: qcom-ep: Rework {start/stop}_link() callbacks implementation
      PCI: tegra194: Rework {start/stop}_link() callbacks implementation

 drivers/pci/controller/dwc/pcie-designware-ep.c |  93 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  30 +++----
 drivers/pci/controller/dwc/pcie-tegra194.c      |  25 +++---
 drivers/pci/endpoint/functions/pci-epf-mhi.c    |  47 ++++++++---
 drivers/pci/endpoint/functions/pci-epf-test.c   | 108 +++++++++++++++++-------
 drivers/pci/endpoint/pci-epc-core.c             |  53 +++++++++---
 include/linux/pci-epc.h                         |   1 +
 include/linux/pci-epf.h                         |  27 ++++--
 9 files changed, 265 insertions(+), 124 deletions(-)
---
base-commit: d65c75fc384ada26392a975c351689ec4e069c50
change-id: 20240314-pci-epf-rework-a6e65b103a79

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


