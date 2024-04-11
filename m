Return-Path: <linux-kernel+bounces-140089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C08A0B59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247F51C20F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC23147C7C;
	Thu, 11 Apr 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+NCAXOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75B14659B;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824327; cv=none; b=bcTcnJKYgLQyTskouniwa8AO+69QG+WbRDEQImsE9Oji1pgn/sgkm9JnesIu7bVpY0vWgpMmSEsmEMnKck1g8gmgAY8fGFUr1hDfuIeVp31WIi2Ud7i9Fwd7WOGybqpeYtt1IpyZ3xkEHATOHmwwt0CsDwTCDoXA6o/buQ804HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824327; c=relaxed/simple;
	bh=kNslZwOV3XuxhTTrri2kOLx2C0i3TRLUbLC5t/3fJag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iuL7G7SzVSGhAF4bbO/O2mNBcNn3YZsVeb7diWHqLGIjxeqvTVi+74+CjLLkJKpkmWD2+cIRLOXVGdYaObUxg3L/NNKSIDopinGhKie5je4OgAQmWZVsdpY8YwsryU4ouMD1qf7+blw0wzldkuOmLOatQl9hMrcuTgSS/cpEPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+NCAXOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81ECC433C7;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824326;
	bh=kNslZwOV3XuxhTTrri2kOLx2C0i3TRLUbLC5t/3fJag=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=p+NCAXOP316q4cZnQ43z3YfBXFQlRyK9k6P9OSMK1p+cMZXIwx20fgss11dRcCxKm
	 xtCIkPxy2dqRRj+WYb0cf3PSiDbcBln71q+Kz6shKQGV2w7lXo1ruNVdacQrnw1h/k
	 r8Vs1cq4ddmvDz87ISTtK9GsyXjfMc01XKEhns8jlt8jvOanIsyLpZK9MHSnoiBvD2
	 j472vfDNnmSVY0Pb6gHYfaHx83EIH5xxKiMF1B/r8XRHlI5NeNYuayNAfJwJ5OrA/C
	 qmktfYU00aVVGFRrUy5MPqakZQf5h/ZWqpEBNDtv1a3lhk71z1ItZY//SxdkT4b7A2
	 +YKXCiEqqxt9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB36BCD1284;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH v9 0/4] Add support for vibrator in multiple PMICs
Date: Thu, 11 Apr 2024 16:30:56 +0800
Message-Id: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGfF2YC/33NwRKCIBDG8VdxOLcNohZ26j0aD4Cr7kE0KKJxe
 PfI7h3/38z+dmMeHaFnl2JjDgN5WmyO9lAwMyk7IlCfmwkual4JCessY4wQSDv1WBxYfEGPnkY
 L2MiyVH3TolQsA6vDgeKO37rcE/l88d5/Bfldf2zNy39skMDhNAgtNa90bc7X+5MMWXM0y8y6l
 NIHkF7MX8YAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712824325; l=2742;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=kNslZwOV3XuxhTTrri2kOLx2C0i3TRLUbLC5t/3fJag=;
 b=2dQIoJ04TjfpOwLWNiOsikzGaOEQ5hG77y2zor95vsY7p9XzVxjbJPcNm4Ra1XQS1kZXv/SNz
 4EXJpCJmibpB8kSgsbJIy0E7DUe5l5ZCwA/YHuvocG6QglstEknmiN3
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
Fenglin Wu (4):
      input: pm8xxx-vibrator: correct VIB_MAX_LEVELS calculation
      input: pm8xxx-vibrator: refactor to support new SPMI vibrator
      dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
      input: pm8xxx-vibrator: add new SPMI vibrator support

 .../devicetree/bindings/input/qcom,pm8xxx-vib.yaml | 16 +++-
 drivers/input/misc/pm8xxx-vibrator.c               | 92 ++++++++++++++++------
 2 files changed, 82 insertions(+), 26 deletions(-)
---
base-commit: 650cda2ce25f08e8fae391b3ba6be27e7296c6a5
change-id: 20240328-pm8xxx-vibrator-new-design-e5811ad59e8a

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>



