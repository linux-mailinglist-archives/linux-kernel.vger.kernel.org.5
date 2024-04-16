Return-Path: <linux-kernel+bounces-146130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225ED8A612A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A1A282618
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF6208A4;
	Tue, 16 Apr 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm3C/JfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF415AF6;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235481; cv=none; b=cXjXmKNzXNWL2C2yN9FImQGlmeW1yiieY+2d+ENm1AascL5zUFGtN4TbmJXhwhDz9U7MneXYx8nFa72OVSQCWPJd8DWM9e1UdfmWFj27J0hZedbAXcdoShxkFL/QH1wA0LLMguMUjHucG26hrM69BaK1Rp08IP1jtpB384afiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235481; c=relaxed/simple;
	bh=RreoZmN1edYuN7I01FSs8Hp2zCBxe6Smv38jWjREaV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GHKyux0rDMjw1And5Yf/Fo7+SGKuDtM87wmGdAQjBqyB/cqeDWXIzxd5CNnRKAoqRLPb+l04b153qPBpZp0i47Yj6qnRO8k0r0d0ogTqJDWqKsqcNk5xOptr7YN3RlA0Spqxwo9x7F92VzO7kFzHzCbdr72dLIWgTaORlcKaztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm3C/JfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E2AC3277B;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713235481;
	bh=RreoZmN1edYuN7I01FSs8Hp2zCBxe6Smv38jWjREaV4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rm3C/JfVwCIVWivUx4yxMlC6uOMTC2OeE2EVRqfYHDhHIovoKZXCBHgwftMNJnQNF
	 taiLt3jaMeiu8YwjV369J5c+AhDaqmcd8bgMFsdS5CFjEuxBSkytL51hYqRaTVw8+y
	 Hj7h+rVz7hr9i9ts4Y9EHYP7HD1pgveoMMZYS7E56swILBOICm4XPVXv7HzqHiN+yg
	 TjP9hVRrdoQZDmU32zPK8jVzEptecdeRUfpJrDd3/NsXxhkRTBXbEbUGbg5cjF2m9b
	 otXanmd8u894Nl7fGuAkY/G+xAlvtTHKhfa+gPTkLhMlWlWDV0FdElQUoAlwwubcXJ
	 9GiOvB3A18Oyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34373C4345F;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH v11 0/3] Add support for vibrator in multiple PMICs
Date: Tue, 16 Apr 2024 10:44:31 +0800
Message-Id: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/mHWYC/33NzW7CMBAE4FdBPuNq1/lh01PfA/VgOxvYA06ww
 aRCefcaeqFCynFGmm/uKnEUTupzc1eRsyQZQwmI243yRxsOrKUvhTJgaqgM6elE8zzrLC7ayxh
 14JvuOckhaG4I0fZNx2RVAabIg8xPff9d8lFSWfw8zzI92j+2BlxjM2nQ7WAcOahc7Xdf56t4C
 f7Djyf1gHP3guE61hVs54am9a4zztA7hvCqmVUNoXDAHmyPVUVt+59bluUXEFqF1WMBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713235479; l=3163;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=RreoZmN1edYuN7I01FSs8Hp2zCBxe6Smv38jWjREaV4=;
 b=r23ue46tPssBOUx14QG0XF32Hf9unfHC7pg1hOPjY7KUqpeHsmHFbrdyn64EKSa9ssVbFo4wV
 JE9r7L1hkutBzK6sMG3eioWiNOxlFthbORu0oyiuvW4ly2jwHDnPXrs
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

Changes in v11:
  1. Drop the 1st patch since it has been applied
  2. Update to address review comments
     Link to v10: https://lore.kernel.org/r/20240412-pm8xxx-vibrator-new-design-v10-0-0ec0ad133866@quicinc.com

Changes in v10:
  1. Add Fixes tag
  2. Update SSBI vibrator to use DT 'reg' value
  3. Add drv_in_step flag for programming vibrator level in steps
     Link to v9: https://lore.kernel.org/r/20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com

Changes in v9:
  1. Add a preceding change to correct VIB_MAX_LEVELS calculation
  2. Address review comments from Konrad
     Link to v8: https://lore.kernel.org/r/20240401-pm8xxx-vibrator-new-design-v8-0-6f2b8b03b4c7@quicinc.com

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
 drivers/input/misc/pm8xxx-vibrator.c               | 93 ++++++++++++++++------
 2 files changed, 80 insertions(+), 29 deletions(-)
---
base-commit: 48c0687a322d54ac7e7a685c0b6db78d78f593af
change-id: 20240328-pm8xxx-vibrator-new-design-e5811ad59e8a

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>



