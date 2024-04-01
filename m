Return-Path: <linux-kernel+bounces-126527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD989391C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B926CB21249
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD00B10A12;
	Mon,  1 Apr 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoPw3f60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEFCA4A;
	Mon,  1 Apr 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960780; cv=none; b=oDrBC0BvZGGV8Gj0Xc2RYBMfJ6ztivurZg/J+VtIgJNmCG9p0lr2yfc+4uRho+ltNh6L3upnvbpSlaYoX7/HpFPu4klokfrgl5kStlTXV1xGT60uwR21k7GBUu3lFYBDjf7OK9ZdRlHAxHpz3kulK/68ylmSCBgwhOoDrsSxNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960780; c=relaxed/simple;
	bh=9sR5QfNpiTPaletTSuPl2Qr1q1tOHKLjI3foe7yAieE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VGJujciXs+/qygahaAVNDjq2HhRrw/CZbOIQzx7WmfJViAek/HfMD3mLviv8351ZeWrGLrM3OTejVB9E4UIQ/WjLqRxP3mmpZKLsCLNCJ3kJQS1Aqh9PBVmINOMU2qJvChBwvKfov7GYDfUFeNTVuDyVtgVGPtKdtzeox8n3MjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoPw3f60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70BC5C433F1;
	Mon,  1 Apr 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711960779;
	bh=9sR5QfNpiTPaletTSuPl2Qr1q1tOHKLjI3foe7yAieE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RoPw3f60TujtkMdT3uUOU2yHDntIYg+7fAV3rdnKZZph5zdOpCkuB1YRK4/SSela6
	 /6b2mQ5JyalEAn7H+KDZ2hAi+T8C7VXy7akVbZYki17yowUdSBsgOanwMZvs2yiY2C
	 XlzwwxAz11j/HU6Q6nbD+G4GGiPplhY4VNUXET1qlNbxrZz3C/ZFKrTOMieN4uT7PH
	 k1VszBb0afNHcWt0J0kY9nTkAgoA/SWz+mbWxYN4PoExYCT8qV3B7Hih0sX6rATioZ
	 g9Nltc9ZxiMdbUzWh9vIhl1E6TiCdtb4luxWlkyG3aA7lOSbvsvKQMoJExfJGEvot1
	 R2803hmownmOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B61CD1288;
	Mon,  1 Apr 2024 08:39:39 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH v8 0/3] Add support for vibrator in multiple PMICs
Date: Mon, 01 Apr 2024 16:38:49 +0800
Message-Id: <20240401-pm8xxx-vibrator-new-design-v8-0-6f2b8b03b4c7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpyCmYC/x3MQQqDMBAF0KvIrDugqcLUq0gXafPVWTTKRGxAv
 LvB5du8gxJMkaivDjLsmnSJBfKo6Dv7OIE1FJOrXVs/nfD6k5wz7/oxvy3GEX8OSDpFRidN40P
 3gngqwWoYNd/58D7PCwrs4JNsAAAA
To: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711960777; l=2439;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=9sR5QfNpiTPaletTSuPl2Qr1q1tOHKLjI3foe7yAieE=;
 b=vxSSjcoZjDjlM71j+pfG1Y2wEW2s+9FhbNnW1W0eQbYIaeR0k9Im7UNqBBj+ksAxOq/rZ2b6f
 D8E1ZG/OTUBABS7NGj2cDsd7Ra/oPmXceOeC/2UlRusN6Xal2aAHPl6
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

Add SW support for the vibrator module inside PMI632, PM7250B, PM7325B, PM7550BA.
It is very similar to the vibrator module inside PM8916 which is supported in
pm8xxx-vib driver but just the drive amplitude is controlled with 2 registers,
and the register base offset in each PMIC is different.

Changes in v8:
  1. Remove hw_type, and still keep the register info in match data
  2. Update to use register offset in pm8xxx_regs, and the base address
     defined in DT for SPMI vibrator will be added in register access
  3. Update voltage output range for SPMI vibrator which has 2 bytes drive
     registers

Changes in v7:
  1. Fix a typo: SSBL_VIB_DRV_REG --> SSBI_VIB_DRV_REG
  2. Move the hw_type switch case in pm8xxx_vib_set() to the refactoring
     change.

Changes in v6:
  1. Add "qcom,pmi632-vib" as a standalone compatible string.

Changes in v5:
  1. Drop "qcom,spmi-vib-gen2" generic compatible string as requested
     and use device specific compatible strings only.

Changes in v4:
  1. Update to use the combination of the HW type and register offset
     as the constant match data, the register base address defined in
     'reg' property will be added when accessing SPMI registers using
     regmap APIs.
  2. Remove 'qcom,spmi-vib-gen1' generic compatible string.

Changes in v3:
  1. Refactor the driver to support different type of the vibrators with
    better flexibility by introducing the HW type with corresponding
    register fields definitions.
  2. Add 'qcom,spmi-vib-gen1' and 'qcom,spmi-vib-gen2' compatible
    strings, and add PMI632, PM7250B, PM7325B, PM7550BA as compatbile as
    spmi-vib-gen2.

Changes in v2:
  Remove the "pm7550ba-vib" compatible string as it's compatible with pm7325b.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Fenglin Wu (3):
      input: pm8xxx-vibrator: refactor to support new SPMI vibrator
      dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
      input: pm8xxx-vibrator: add new SPMI vibrator support

 .../devicetree/bindings/input/qcom,pm8xxx-vib.yaml | 16 +++-
 drivers/input/misc/pm8xxx-vibrator.c               | 87 ++++++++++++++++------
 2 files changed, 78 insertions(+), 25 deletions(-)
---
base-commit: 650cda2ce25f08e8fae391b3ba6be27e7296c6a5
change-id: 20240328-pm8xxx-vibrator-new-design-e5811ad59e8a

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>



