Return-Path: <linux-kernel+bounces-6754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB3819D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E377286FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75E20DC9;
	Wed, 20 Dec 2023 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="OzTUXXh1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [159.69.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEE20B03;
	Wed, 20 Dec 2023 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
	Content-ID:Content-Description;
	bh=dwDLdd2b/kYUmwZbTEH75R1JJBbL2t9FuMgP4hnOqJU=; b=OzTUXXh13dJxCS6VIBdrsnW+0l
	e04Vls6Ze0+GEWBmMx4zRVaWqJgocroKuqMGD2t0hCJkSQCXZs1TpG0IvH/76485IYP9mdulpFG2o
	/8DdNZyZTWpgruNoI2cwAtyd3Tu0/YOZmBohh5A3b7/ONN0qefw0Q9vh+rqjhR5hSByxNuJD1IDKs
	Pvy1Gf/IGFCmzSH6Bqk9+0i2N9xozECJKNzHU5Mvu2P8DUy2Mtmfaqcg8TnvhjKZ2DPAj1uoPfGD5
	Q2+p+fpkrV8+gr/norbIH9B7zI6BhRjayEygy50zZhnh4KZlaa2Mblqwq9RuI0gf3peh5LxvQJeDi
	fpZPml8w==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
	by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
	id 1rFtyY-00DKtz-14;
	Wed, 20 Dec 2023 11:38:54 +0100
From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v2 0/2] interconnect: qcom: Add MSM8909 interconnect
 provider driver
Date: Wed, 20 Dec 2023 11:38:48 +0100
Message-Id: <20231220-icc-msm8909-v2-0-3b68bbed2891@kernkonzept.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjEgmUC/23MQQ6CMBCF4auQWVtTBlLBFfcwLLTMyITQkpYQl
 fTuVtYu/5e8b4dIQSjCtdgh0CZRvMuBpwLseHdPUjLkBtRYlaiNEmvVHOem1a261IyNqQ0ztpA
 fSyCW16Hd+tyjxNWH94Fv5W/972yl0opJD4Op8EHM3UTBTd59aFnP1s/Qp5S+OPuyj6wAAAA=
To: Georgi Djakov <djakov@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>, 
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Add bindings and driver for the three MSM8909 NoCs/interconnects:
BIMC, SNoC and PCNoC. The driver allows scaling the bus bandwidths
for better power management.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v2:
- Fix compile error on next (.remove -> .remove_new, kernel test robot)
- Drop unnecessary headers, in particular of_platform.h (Rob)
  - Adapted changes from https://lore.kernel.org/linux-arm-msm/20231214-topic-6115iccfix-v1-1-9ad999683a7d@linaro.org/
- Clarify that snoc-mm downstream uses same clock as snoc (Konrad)
- Link to v1: https://lore.kernel.org/r/20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com

---
Adam Skladowski (2):
      dt-bindings: interconnect: Add Qualcomm MSM8909 DT bindings
      interconnect: qcom: Add MSM8909 interconnect provider driver

 .../devicetree/bindings/interconnect/qcom,rpm.yaml |    3 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/msm8909.c                | 1329 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8909.h    |   93 ++
 5 files changed, 1436 insertions(+)
---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20231206-icc-msm8909-74f28646ff29

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth


