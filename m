Return-Path: <linux-kernel+bounces-73163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF985BE76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4156FB266F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D36BB34;
	Tue, 20 Feb 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOiowJOV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11ED6A8A5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438573; cv=none; b=gAXcRkhEGmNExdFAIOkwIbP8Vm9CIjDqPF8GFA0ixULhaEJuE9Ta+kJ5/825+sHWnTnLXyUeNS5b7P+tTOanDD+cpGVYldX7Wa5Db9+hU1uCJxWXi7PbFMhRUdtKVH3I6GzzgybMhfymhw//4dSaF3MUcFT96zx0uuJFLmOxbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438573; c=relaxed/simple;
	bh=+c+uzrOpdn07JJ5Qe8bduej7vzyjISIkL3aTdvUotpw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e8TamknnMGb+SdaIisRIgWfsVj4jZLQw7IZOIOtKWdfUjEGtDj3Qw+samF2z0SSQdTwRqmGqAC4EH85CRoNtrUO9rNg3pku8fK39m+QxOHP4gb2WfPMELwjceIry+3wee+PIrQuQwwe6AB5V+t5TADicbN1Gm33uN6Bs+CpLagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fOiowJOV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b25893c9so2665229e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438570; x=1709043370; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2Td2TNrjEN7a0rVuoz6czqXirIflgboIWJrSXb6sbE=;
        b=fOiowJOVruGnsYExPlbEH018KYE+iLXNVpBGU9rnrpq63g2eGCneg9h34SEC3tUGlv
         F6JXmK1WltPdPoelu5nVlRowO7wszJK+EqE2tU/eX9V+ucZQF116H85ArsTZ7gcQjhGL
         B5iXsdcq9sD6Jals0JWhacXIslJxWsyT+fDCdmcOOveWJOsx9tp2otrZDKyHKtTG2/Mz
         5KQu1YtBn/Tb8WsS2xL/VumI2AJAsEUDTXk1nY7jSmcR+LtBhAfoyS3byZMyAtmMppDo
         gK3pNwWskEtH0rBLK67ez1sKjwUpabrBBQ9vbCCQStHRFnWKwobrJ/sz7PvujSm7Ow4y
         pyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438570; x=1709043370;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2Td2TNrjEN7a0rVuoz6czqXirIflgboIWJrSXb6sbE=;
        b=aquFRh5rKYkhJJps8nuhbGqPMF6r6cLLghtfJbtQmu73uTtAa5Nd287CEo6UJxLveq
         Q2Qi/HzCNY99vMuAHW/NIJ7a2pPaurTb/c38veek1lMuSCAlnu0NTKmEQEmgfjMs7K2D
         zPkEV6H2MdU8E6swwRR4gepOjY6F+dny/bOUrmee25IOQ+/LxrjWOQzjLsrTVf9loVEU
         CdKarvowPcv/Mn37KuDMpd+wmUyN/f9fsyMFVzXmTIGnnIwvL4HGCEneqcn6NqypMXHX
         GIE4NQm7Gc9RiK1AbMjJwncf/kPFBTbekRv8qSvnM8VMxLt4RiA2pvv3a6yxUIzznnxN
         VNjw==
X-Forwarded-Encrypted: i=1; AJvYcCXaK7ejbKGyMhQIEZDlR/zd3t//eGR5t7LBJdGrywEFM4vGC1XB7mg5cWQGwLW1+DTOB0xjHLLS4HWXgC8A4YEnyaybxsLabxz63Smz
X-Gm-Message-State: AOJu0Yw6lr366itFSyHa38gxCbv21CNzPOJ4FJnaGfE5X+kaE24+jerr
	nTNNIzcNe3DdLViKgGrpNCZnRr612/nrtvLqZ7n9hMU3TdfYqnoPTWYTyUsVTyM=
X-Google-Smtp-Source: AGHT+IFOSEeoJnbaHyMnGgA+ZXg4/jNIvZL9WnPF804ful9dH+0xLvjUzFdtefQJ5iv8rXCafIUGDQ==
X-Received: by 2002:ac2:4d84:0:b0:512:adba:2d9d with SMTP id g4-20020ac24d84000000b00512adba2d9dmr5632265lfe.14.1708438570171;
        Tue, 20 Feb 2024 06:16:10 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a3de4c7bf00sm3998534ejj.79.2024.02.20.06.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:16:09 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/4] drm/msm: Add display support for X1E80100
Date: Tue, 20 Feb 2024 16:15:55 +0200
Message-Id: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABu01GUC/23OQQrCMBAF0KtI1kZmJqlGV95DXEzS1AZKKokWR
 Xp3025U6vJ/mPfnJbJPwWdxWL1E8kPIoY8l6PVKuJbjxctQlywISCEBygd6Awgg65CvHT8l660
 irQEsN6KcWc5e2sTRteUw3ruulNfkm/CYd07nktuQb316zrMDTu20oAFpv1wYUIKEeu+toUrXD
 Ry7EDn1mz5dxKQN9BEI9R+BiuAaqCwbs9OVWgjqW9j+EVQRyFh0SrEz7veHcRzfR6jImUoBAAA
 =
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=+c+uzrOpdn07JJ5Qe8bduej7vzyjISIkL3aTdvUotpw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1LQfBxdTi1BQQL3lITfc+y4flWf8plONsFo12
 F9XUKyW1C6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdS0HwAKCRAbX0TJAJUV
 Vqp0D/9uvgP2TpKhX1DILfvHjT1/h9BUJZzL3agXqXe9hYJsQr69ug+Gg6jMEqFxME4TD5G2mZt
 pWIVdvWGoPuZkbDEyzdGVmbyr1tiF/TTi6YxZN3e50YVXl4fLf2yxlvT1JGX2yGZhI3CLpDTRf5
 xq9wnCjOKShAJ3KqqIH3+OPjK/CBw8FgS2cVZ/72DHFSsYzEkwxjBdVXkEaDDm9G/WvG1ulDzjM
 0M3KglSxfZJKHeq4v2CulS2Ew4i8fmudQ0L3caC1EjvRU+siOAR9iKxklE/hQ2VP2ITRdeIJugX
 n0kAem3egHPqld4kTmEb/Zfk08taiU6QfwgmrPsBo6FfV/wv/NU2lJSErTyJXExNOCSk3XAfOKm
 vBs+IBJZzXN23h95AM3TelwGAG/RuD3TbuUS+cFpRQI5NAOMM6fY7A7R7LYz3i284GjyTozvFSE
 UqWF5G+dGKvhgl1XsBuWxAgDG81Spodqm6QpviJmt8qX5EUIu+m6P87HZE80k7bknHDhyelDHnu
 QZUzEqak2Jek1i9Sq4qmvlYZThIE7BJNvfQDSSM/FI47PxOtaZMNEFf5W2VYszRKnsWhf/eWZCr
 ohujJ9mVU6SdaZSZyYepV4R2jrxlTrlEsQLYLa5oCZpWpCt3fvKWSDie0DpyFsggYkneZMkmS96
 vjcrEqyVtvEVcrw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds support for display for X1E80100.
The support for embedded DisplayPort on this platform will not
be enabled using the connetor type from driver match data,
but through some 'is-edp' property via DT. This subsequent work
will be part of a separate patchset.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- Dropped all references to clocks IDs from MDSS schema, along with all
  headers includes, and replaced with bogus phandles, all to avoid
  dependecies.
- Added Krzysztof's R-b tag to DPU schema patch.
- Link to v3: https://lore.kernel.org/r/20240216-x1e80100-display-v3-0-28b1c33ac8c0@linaro.org

Changes in v3:
- Added Dmitry's R-b tag to the mdss patch
- Swapped order of first two patches, as suggested by Rob
- Added "additionalProperties: true" to all pattern properties in MDSS
  schema
- Link to v2: https://lore.kernel.org/r/20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org

Changes in v2:
- Dropped the 4th patch:
  "drm/msm/dp: Try looking for link-frequencies into the port@0's endpoint first"
- Fixed the qcom,x1e80100-mdss schema by including some missing headers
  in the example
- Added TODO comment for reg_bus_bw
- Switched to SDMA features mask
- Added Krzysztof's R-b tag to mdss schema patch
- Added Dmitry's R-b tag to the dpu patch
- Link to v1: https://lore.kernel.org/r/20240129-x1e80100-display-v1-0-0d9eb8254df0@linaro.org

---
Abel Vesa (4):
      dt-bindings: display/msm: Document the DPU for X1E80100
      dt-bindings: display/msm: Document MDSS on X1E80100
      drm/msm: mdss: Add X1E80100 support
      drm/msm/dpu: Add X1E80100 support

 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   4 +-
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 251 ++++++++++++
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   | 449 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  13 +
 7 files changed, 720 insertions(+), 1 deletion(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20231201-x1e80100-display-a46324400baf

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


