Return-Path: <linux-kernel+bounces-112811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C2887E75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A6E281615
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FAFDDA6;
	Sun, 24 Mar 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1mzKRM+"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A59D51D
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306633; cv=none; b=W+Y/PbSnumNzPI88OYSADzYadV08te7U/5UykhnpsSQPFtfD0apfXuJDRb0uh2Kngw5z4OdJzxyA8mh44YqTBnuc0IXwIP0L9lGx6TIpTpo/CmA6BRoAAY1e3V9raWYRcNOgP1uOztf3aHs81BBkiPhiZY8rNT0j/b7cU6NSLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306633; c=relaxed/simple;
	bh=oMPQR/xSsCiEnea50bPdQBfX/S0LEOHiccm2F6hjWeA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DqhjaTEJO0uPzQcsqFgSc2LZiGe0c8UnmbXcuC22Kew02SJEQmKNyUMxc6LkpgsDphfRBnkLRVeg9JwedQq/jLFX6LX6kNUtHR4KlkMbGQ8eT1d8S3yGt/aHrQOvPYR4qOvHDdIbS+IDEVrVOmASCSsGopVFmJ/97tfRXdPdGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1mzKRM+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51381021af1so5631031e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711306630; x=1711911430; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8EKsV+yihlR6CzqwroFmnT9wtLXmcrhrPbnC7zLk2c=;
        b=L1mzKRM+4rMC2dO9rBTItiAyIsrUaxRiMThQSj/H9lz26UX1q4bqZf6qmVCnejdNzd
         nWo6qQTH3LwKI+DCdZZAp4TBSJwYzrd0nfnXLNFo2wp3Wpnwy57VEtw40qAHbvNIeH3r
         9DsxrYFAIuXr/7pTJDVNM5+8EuIXnG0oh7IfmTTiXIPKRUAoK1u25Sm6L1KNUdhWDvdx
         TERY0RWLxbRj3dLqM1blV3QVCsfWVXYxQunKjpasXw8Bcp05LMPp4l+1Ayp0rcU4M6kz
         uR7cNpJKRwI4iAnCy1LXE1PGSE63r1pxM5U43AENoF4zCLRpz+7Z3PYbcsMQdlU2LCBY
         4H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711306630; x=1711911430;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8EKsV+yihlR6CzqwroFmnT9wtLXmcrhrPbnC7zLk2c=;
        b=uHLxl0r6/uIvWv/XpCLrl4uOUwWqqz6N2iZtpAfPlbjGG1mWrKJmfpvwzPX5o735y+
         e9atYzgMFXSeMoxIWqoSHxECOwO5hcXSwud+kkaqmAh4zJWjrVIBKQy43ib842dnr4vY
         Ac6YMsjIJeT9MjcgoHe46JY5CtEOa6EwdWDXLHRyNcwjkxvspiwPmSWfZE40u2I2l+wj
         ybMa4lxYkiMLpKgVzFa8i1A+ReX2Da/+V9+HgIcalCMS90//lCx7WmdYB0lBAaFU5jO6
         wBLrFi1/srsKfqmqf8ESJGi9WHmbfaVfIYGrIMtsuiLMjzauHTLMsed7fDd8vrCV1txb
         oucQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw91DKqN6V0xYrM5rzYdlM8To0DZiV8pwYObFKnpBbCznB/EgiMyWjd1Pq4OKQU+9RNmvyV2RUzs5z1qazo0DnT0K/lFmVlo75G7Q3
X-Gm-Message-State: AOJu0YzGNA7IZMC5DPJ6BlHDMAVA+4pjCR1yVHHVosGtuXZuh9p0bGU5
	YfRVOXd1ZxR37v0ILQfzPwRRtfz3S5U7d6RNlnA4Px4u/ug4KDPtBKLsyWLDh/uQrP7jJLJkal/
	D
X-Google-Smtp-Source: AGHT+IH2KHBBOkQYLt8KmkDQpzHDjSFYkXQ0RrpfLOMZ+n+CDoSZn6CkN/xUvljvXZTQc2SKZiVisg==
X-Received: by 2002:ac2:4648:0:b0:513:7e83:b3f2 with SMTP id s8-20020ac24648000000b005137e83b3f2mr3924620lfo.45.1711306629505;
        Sun, 24 Mar 2024 11:57:09 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709060d9300b00a45c9945251sm2194008eji.192.2024.03.24.11.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:57:09 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/2] drm/msm/dp: Rework the eDP/DP modes and add support
 for X1E80100
Date: Sun, 24 Mar 2024 20:56:50 +0200
Message-Id: <20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJ3AGYC/43QwWrDMAwG4FcpPs/Dkt0s6WnvUXpwZKU1FLvYI
 zSEvHuVXLqxS276hfh+0Kwql8hVnQ6zKjzGGnOS4D4Oim4+XVnHIFmhQQsInX4CtwaM0SHWx91
 PuvDg6ScXTTkl3iYGapqja8mzVSI95CY+t5bzRfItVjmbttIR1u3qO4MIu/wRtNFtQ4aB+3Bk+
 r7H5Ev+zOWq1oIRf6O4D0VB++Cg+woDse//ofaN2r2oFdQP4Ag7P8hT/qDLsrwA7wPZ6IEBAAA
 =
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=oMPQR/xSsCiEnea50bPdQBfX/S0LEOHiccm2F6hjWeA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmAHd4lgu2vfGbLvStLsNULe27rIa9BA4g7Xdio
 tjyiTt5mviJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgB3eAAKCRAbX0TJAJUV
 Vte3EADN9Ft9g125gXKPgtlGKbDrMlRtX+co+XctSgpggauUDYyIaT+mHbnRoXN1i4TgyNYMnOp
 qZoKBJU04N6wh8PnEBISjNU2igSxkl6pMG9wYwHA5YVrHdkKvIsSXDD1G5o6Kltxtoiw5UDvdvI
 BO6kOWuyCMpfGlXRtKALj9BClWGWlYkE+bVW8rQJV8+lBaKhNQCKcUySEAmQ6WXsoSUZHaYoKIc
 1OXf1RUaU0Oo2U4olAiasUKpHwmj5bi26v51o9w1YTXf3kvgjIXN8DY4g4NAvmjoEVadE5VfRAt
 jCxQFZK/cvePxHCvfMto0I9LIJqiWVHy6BoqQ4VS5H7hM+kJszdjDsMzADh7HV4vKuXS1B/SXaH
 7nuSkyOYKlmV6+6vH3MOdg26HNc7+1vNdvhdIWfxZd+141X6rlCD8N5LmNdt1aZfgv/gbshipmR
 S6daXCU/g2VbQJL7YRuVYFHpo36VtTZIDB2xuuDMmzNKgYgWuj9HKEHMamQlgRRaieqOYxcbU7R
 7IwGWkQjEbdsTGHweGWNgr2L4D40Qreth9SMUbuCy/MmzH4o4bN4OBgSN/tN0yHagTTT5pgvrPb
 NSTj46q0EU/d4AvjI4U7SP+SdlxGs6cH3flD1RUP0SCtSVrRD2O175ip8+mFcXnQUKf4AxU7JvQ
 b7mFfwR2RSMz3qg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Since this new platform supports both DP and eDP, it's the perfect time
to drop the dual compatible (eDP and DP) and figure out a different way
to specify the mode. After some off-list discussion, one suggested way
was to add a 'is-edp' property to the controller node, but that approach
has been dropped due to bindings concerns. So now we lookup the panel
node in DT and based on it's presence we can safely say if it is eDP or not.

The PHY counterpart patchset is here:
https://lore.kernel.org/all/20240324-x1e80100-phy-edp-compatible-refactor-v5-0-a0db5f3150bc@linaro.org

This patchset cannot be applied without the one mentioned above because
it relies on PHY_SUBMODE_EDP and PHY_SUBMODE_DP.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- Reworked the dp_display_get_connector_type to be more readable, like
  Bjorn suggested.
- Dropped the unrelated change w.r.t. dp_aux_get call, reported by
  Dmitry.
- Re-worded the commit message for the first patch, to align with
  Dmitry's suggestion.
- Added Dmitry's R-b tag to the X1E80100 specific patch
- Link to v3: https://lore.kernel.org/r/20240322-x1e80100-display-refactor-connector-v3-0-af14c29af665@linaro.org

Changes in v3:
- Dropped the bindings patch as this new solution doesn't involve
  bindings update.
- Dropped R-b tags as this has been entirely reworked
- Reworked to lookup the panel node in DT and set the is_edp and
  connector type based on panel node presence
- Link to v2: https://lore.kernel.org/r/20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org

Changes in v2:
- Added Dmitry's R-b tag to both driver patches
- Dropped the if statement around assigning the is_edp in
  dp_display_probe, and fixed said assignment by using the connector
  type from match data instead.
- Moved the qcom,x1e80100-dp compatible where it belongs
- Re-worded the bindings commit message to follow Bjorn's suggestion
- Dropped the RFC tag as the approach doesn't seem to be questioned
  anymore 
- Link to v1: https://lore.kernel.org/r/20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org

---
Abel Vesa (2):
      drm/msm/dp: Add support for determining the eDP/DP mode from DT
      drm/msm/dp: Add support for the X1E80100

 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)
---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20231219-x1e80100-display-refactor-connector-e1c66548cae3

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


