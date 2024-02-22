Return-Path: <linux-kernel+bounces-76831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1885FD42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49533B28B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2815530F;
	Thu, 22 Feb 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVzLKgME"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F42154C15
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617324; cv=none; b=ozDsg4cov27XxapeGWX6q+39rPXfIKxGqtOZ5gQtY7brYELsJsv0br9aypDpvV0evCY4/VBuEKx5ISEcgqcedpTVWq2Qn4j+dK1KWijSsfcg3VaczSJvKxYoae0mjoMMXErku/Oa4hRVLVxxd+R9Hq4csc2pj/h6VIDDLnGtpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617324; c=relaxed/simple;
	bh=juqBTEKPT37KdVrE5NS/VLPd1q4zL9O2Ncx/5a0Zm7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JM8JcrtUU72aMOEGvPKhZ//0QU8aIc9sro0R12aWvlH8YUfvsfIStWz33TzS6MEJijK/qzdu+Af340LorFiq3NRdSNssIopSGWUA+wtXNiD3PdmD9eOAd0rMffLzd9xBPkmcSQFEeJrzhZD5+vxhD2EXGJ4h9z1XGWj/aB10WFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVzLKgME; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565468bec51so1051722a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708617321; x=1709222121; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMinW4dJsDafnRq5GEE/p/11l4kkoSDLdjvo8D26CuM=;
        b=bVzLKgMEP1zJmCaBRqwnoKYyFD8lBsJSrOb3K1J9vtdzKwdiF/pz/9G1HbNFbxxrQn
         5i3cdI2cxvKUG2SjCv2AEFLwfHiLXh7cjnZ3HQhlU8cYkfkRn45xPWM8ouV9j1hKTvxj
         VZh277Kz4a1a14qc0Gm38kz6sUnFDGGU2TCWhkJzyZgIK7SAddwmSEIipRPz0xnD0cZ9
         mKbZX3vFghZznbIpZcx8dPbpYxQSaJoLj6/jzkgKxViJ67X25XTDr6qRllidT8SDKbXh
         vuH96JTUcl8xWUJB+xL7xmGhcwqyMMFEYy3cUiwqTlkNVwW4lvBTahKNXHZ4ko82FtIS
         JnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617321; x=1709222121;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMinW4dJsDafnRq5GEE/p/11l4kkoSDLdjvo8D26CuM=;
        b=iXXN94xLODSKfeIEwJT/lDYVYPNApm1iHBCjGD/i5s1kKuJt2koAmYYlUGVJfwiHqu
         2iNNCyx1krFzHitBi4Ah5I4WUal8C3xN89UB39HOslMeuU1309bG/yD73KmGdfooTtdX
         sbWLDiuu4kqrVhOx3c5Ibq7a/HKifzTkjVfjjpNPT97BtuJk/BP3ATQGV+U8EgW6O27t
         UcKGUBwRXxvBSp4g4s+vpqaQnZe+2zQ+bmkmTtf9qsNWZqySCdtHeu20t97HnULGTglS
         I9y0sjeayMOq2Vp4FzgfMPZp2E5rxBzSPGL16h6I4c898hqjpyn62LMM9yUKHfIjdCMx
         C9PA==
X-Forwarded-Encrypted: i=1; AJvYcCVFwzzaIH7pAc9Ie9Ixnt49q46OoRPLAO4fy0fnw8ZeZwTIa5kKzUn5wWl9e9/RpXA11pPFndkjRt+5v29DBzGKeRUEjfap1W1BFHPh
X-Gm-Message-State: AOJu0Yxl7U86b1cg/2iL7MsmyupTJFAo5cx/0tLpbvowgae06LPAfq8k
	5WNoVtm3A9yhTZ4RQ6ruC5rii27zUJVioUzp7hI5LRtTTnKSo+N+G2/qvczfOrI=
X-Google-Smtp-Source: AGHT+IEuzPA3K/ZazkFQtxH9mWz+hr8FA93pKgsIx7V2K8w6Js0xonvb0OCNabHBJGhBQINfXiiDkA==
X-Received: by 2002:aa7:c894:0:b0:565:42a4:82ff with SMTP id p20-20020aa7c894000000b0056542a482ffmr1647181eds.0.1708617320831;
        Thu, 22 Feb 2024 07:55:20 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id v7-20020aa7dbc7000000b00564e489ce9asm1924247edt.12.2024.02.22.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:55:20 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/3] drm/msm/dp: Rework the eDP/DP modes and add support
 for X1E80100
Date: Thu, 22 Feb 2024 17:55:05 +0200
Message-Id: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlu12UC/42NTQqDMBCFryKzbspM/MF21XsUF+k41QFJSlJEE
 e/e6Am6e9/j8b0NkkSVBPdigyizJg0+g70UwKPzgxjtM4NFW5Klm1lIWiRE02v6TG41Ud6OvyE
 aDt7LmYS4aeqqZSclZNMnb3Q5X55d5lFTnq3n6UxHe/grtJb+8s9k0LQNo5C8+lr4Mal3MVxDH
 KDb9/0H4oWfNtcAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=juqBTEKPT37KdVrE5NS/VLPd1q4zL9O2Ncx/5a0Zm7s=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl125e/3jKv8cpJxPBa5OyNhYESc9csBvD30KPX
 LeQwemNzTOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdduXgAKCRAbX0TJAJUV
 VgrkD/4qMcYnUDnFjZ0IzRmXQx3RcQfnNwEw/8a2Eo/xjIx1UbNjdBRmCRQFARmuOc+twM0A7fw
 PpHVq42snH6xCtvedA45PvCOxiGWeBXpCv02OhD+xGJsPR506up+y5XUzEubE9Fq6jgo/6kj7Sk
 OtvBZEk+L1K21WnLnta6ui3mOAn68tcYDjmuNNhu30U6PQcdb+EVdFeuYvtNBuvpLjU1OjE+LwH
 jpJv5E6Z1brDToNJidHikj5pdSRobkxe1SK3HpMXJhNYX5mlB/7oB0ZDGUod0IhE78veoy2+lZg
 XrxmZjra22Lto2k+6LWh8RoJcFvMOcA6dM3sd6gAlvy8/MFQzQUOPskcHdQm5AG2m0iFs6LWQsm
 fSRbHhTqQvQDzc2LeuGVzZL1NK/3mnFNPTdoVRYbwBN+hQgoifkgBXu8oozR765hF8aQwGfPe6c
 7f9Tu9DFBUwHBLE4531pwGhMKCLRO6OhSZVJCVAnlgpJ+YBC4T1kCJTjg3CxsR3Rxu6My2OxLZY
 olz3BzRZ6WO+yKSpm/G/sHGjKb5WnyEUbwLSW+rCgkaHQeHfQCcWfwtSGA48C1sVQ566YpeC2jE
 lEKuSf3OQCJblgu/M5EF5gXOXBA9KmHawJgckjAbz8140w+obveO/eNH4YqivZJ/gjf5uGIHbmC
 5FLKPqLKEtWX8+g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Since this new platform supports both DP and eDP, it's the perfect time
to drop the dual compatible (eDP and DP) and figure out a different way
to specify the mode. After some off-list discussion, one suggested way
was to add a 'is-edp' property to the controller node and call
phy_set_mode to let the PHY know which mode it should configure itself.

The PHY counterpart patchset is here:
https://lore.kernel.org/all/20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
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
Abel Vesa (3):
      dt-bindings: display: msm: dp-controller: document X1E80100 compatible
      drm/msm/dp: Add support for setting the eDP mode from devicetree
      drm/msm/dp: Add support for the X1E80100

 .../bindings/display/msm/dp-controller.yaml        |  6 +++++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 11 +++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c                | 26 +++++++++++++++++++---
 4 files changed, 41 insertions(+), 3 deletions(-)
---
base-commit: 4893c639cc3659cefaa675bf1e59f4e7571afb5c
change-id: 20231219-x1e80100-display-refactor-connector-e1c66548cae3

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


