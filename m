Return-Path: <linux-kernel+bounces-79603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60228624A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A48728205A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C3C2D600;
	Sat, 24 Feb 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIWdqlm6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445E14B800
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775144; cv=none; b=Gq1CIMhFhoimA/biRng8ykpA8Sg2r66q/ocmTUXD5e7xyXM8swm287EF88oaFAg0SmofShxnqtCFS8A9MZBtm77re+G6OEpjXEtM8/DXvzR8xRAfRBA6koSWJUlYdsocpiu3LGv96SiocJ4U5Chu5Vx/Yqz3MJa6CY8mnk68ddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775144; c=relaxed/simple;
	bh=f6Fti03sXHFWnCBDOOFZrfSXZyNiTIPfQyUBx3OJpAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K4LAZyI6NWUxmEEhYO0BFh89M02FY5vwyeU/3f7zb0XYF7bB0OQdkWNYBYllId19HuyXaKclbru9awJB6j128eL0frD+FcN3bTIHWGcPLTB9PPIun7zTVmFdwBO75uSOJEl7cdRZNuXsKZ1EBXF9scJHf06VCkwCBXyfMg4rByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIWdqlm6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso221036566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775140; x=1709379940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJphviWQyzYt9jz/ibUVvRn+gLeZ56sd9QnZ6RAXsLo=;
        b=LIWdqlm6CxHgeW6QoLHF/0wfd3vp/amOJWarsSWDNIbvsLkxfDyhabBZZhnB4Mj4Y4
         h3+xEvBOMS74Kd83SJTFcNZ5LeQ7LfEEW3GeFtjhDITNAISuOqeH6SlpfyJBiJWFbFk2
         ElX96SA7mmXIozXXs1zvjQbioFWsmFInOkIavVFI+z3xeWbGTU10MAVdkbAAoenNXh45
         SbPgiG2qo6CstkKhrXWrkwTZ5Q2O8WkUbPpuTEsPruFbNBf7aXoq5luWXTY5vHi465j/
         onU3CbBMSbILQnRWOesUZ/ILYDrRz6v6wXCUkuJDA104znFT0vrd9quW3d6qkcdsVHey
         bV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775140; x=1709379940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJphviWQyzYt9jz/ibUVvRn+gLeZ56sd9QnZ6RAXsLo=;
        b=fAQL6wxR55NEZtkJMevRAzCwlRgL9XTuarfUQvZEIe7sNFjOM0hP+hF/EQd3O9QPAb
         DaBo26Cgf92vbopQU/cEOcpNIOi8CFAu8HIcVAIQM9+wET6vzGeQM5Aejl1Kg0mYa5zk
         j0WkRHzCX3SQMzhkK74Xy1B+zhv9Y6I21Hxfe29KzvuxCtdQgYM/b9w4nnjo2rLXD7Ja
         ARmLuP202+95ln7dN26n/wpTljczAx6jUjxAshpKFPTPib/YbSfd96VPL+twEwlh7XPr
         6YPqKDnfNtujIRK8aAyGQkXjhicRsO3tDDT83gGR8Wnh58YltFDQ1cIAcwUJcOTyPy62
         Isjg==
X-Gm-Message-State: AOJu0Yw72BaNVdBmeHbbnF5miewsrTkWY+2CDXoDP58ydumi6bNPAtwx
	9TdA+mgd72L60Daou75OQJuPB+ixuxu2ibfJUGg0KP2HOU1/vq4Iz2niiI+TOXyHYUJopaRoeQo
	8
X-Google-Smtp-Source: AGHT+IHoKdr8r1s7XR4DOtVMkwrkSL5rOSAxCbm/uf3Aswqgw8ESoZ+bZD/VXEe2SPqOUYTCb2UeGg==
X-Received: by 2002:a17:906:394:b0:a3f:48c1:9b9e with SMTP id b20-20020a170906039400b00a3f48c19b9emr1436508eja.20.1708775140612;
        Sat, 24 Feb 2024 03:45:40 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:40 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/11] nvmem: patches(set 1) for 6.9
Date: Sat, 24 Feb 2024 11:45:05 +0000
Message-Id: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nMyg55HQaCjbLIyWESyUWk1F8WhPzv/qUbNNrfIUhaM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLKc3U5kvpGhyamprnky2u8fL0Sw9BgJSDF PMQ+HDsM3SJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N3KCB/9u2OTNkQRsvmI1MVN1HBxVrYVe5pgeRq5ujjm78ZMqNS90nZt8xy/f260FqOMxPFfIiyS bendFchX/qx7m+F/b4LoMRLAOcut1XCcrjHICGQEK5lJRlzTuO5MYHlh6bwaEZ13N/upYjpDIFO LQRZccMZvN6MJ7+yAQkE1XH+VM6g6lUcztj/gAajwbi2WcYU0jy2cIKg2u1i/mt99ees77btYOm FYLEAJZxmxUPKBSChRRm35EScqWq1TuOBHjspMa3iJF21av5nTZi9zQBrWnZMSXFLatVpLrOs8r k+LcKNCPga2C5K5xQsthuiKhFLya3rHFpgWrAOj6tFBisV3G
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in nvmem for 6.9 that includes
- make nvmem bus const
- few dt schema enhancements
- add Xilinx socinfo driver from nvmem provider.
- add xilink: Zynqmp write support
- few enhancements to mtk-fuse provider

Can you please queue them up for 6.9.

Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Chen-Yu Tsai (1):
  nvmem: mtk-efuse: Drop NVMEM device name

Krzysztof Kozlowski (1):
  dt-bindings: nvmem: add common definition of nvmem-cell-cells

Markus Schneider-Pargmann (1):
  nvmem: core: Print error on wrong bits DT property

Praveen Teja Kundanala (5):
  dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
  firmware: xilinx: Add ZynqMP efuse access API
  nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
  nvmem: zynqmp_nvmem: Add support to access efuse
  MAINTAINERS: Add maintainers for ZynqMP NVMEM driver

Ricardo B. Marliere (1):
  nvmem: core: make nvmem_layout_bus_type const

Rob Herring (1):
  nvmem: fixed-cell: Simplify nested if/then schema

William-tw Lin (1):
  nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse

 .../bindings/nvmem/layouts/fixed-cell.yaml    |  22 +-
 .../bindings/nvmem/nvmem-provider.yaml        |  18 ++
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  46 ----
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     |  42 ++++
 MAINTAINERS                                   |   8 +
 drivers/firmware/xilinx/zynqmp.c              |  25 ++
 drivers/nvmem/core.c                          |   5 +
 drivers/nvmem/layouts.c                       |   2 +-
 drivers/nvmem/mtk-efuse.c                     |  20 +-
 drivers/nvmem/zynqmp_nvmem.c                  | 215 +++++++++++++++---
 include/linux/firmware/xlnx-zynqmp.h          |   8 +
 11 files changed, 320 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml

-- 
2.25.1


