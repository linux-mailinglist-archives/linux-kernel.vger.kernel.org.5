Return-Path: <linux-kernel+bounces-112807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0792C887E64
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847422815BA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E77D534;
	Sun, 24 Mar 2024 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfI71te/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBEC2FD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306240; cv=none; b=bmYRnszwaEWOmXUjxINva2Rx66lMyG+qfBY8MIcx1iUg6M7nyRDf8pfpDjnlIRfQYRBsNJLeG4MbiXLQ+Jlk93IvDg/5VG33G0C0fCwyJHrEUeK8M6MXkGj/U+L+Njql5pOqGaIi3Kd6aJDYyV3h2JKNDSsNoY+dxowAB9tmAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306240; c=relaxed/simple;
	bh=O0xVY+gl/fPHcB6WhFKWsogdWZR6lFHePZT39lrEaZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A2rKLbeHgYFlB3cfxe3yP3vdYfYBdF6rDJQFIlsT2m+nj7CqxI8eNWSSOxs/Wtqe34u5jAfW669/m9Nxuqqy+lQ2UTuaTIjpuPd4qDZed5M94++dld94QWPbEselRsiHnHvqm30lHlnVtUvaE588bS11pV8aO8C1lF674Y5YWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfI71te/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4715991c32so423244066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711306237; x=1711911037; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh7WIPngChgpb6/wT2qnSquscN8CZ3uMdGD+jaJxYv8=;
        b=LfI71te/lri8tXBfg3FoFdN2qhR2tcloWhWukiXBsS6Odqk2kdmaluKFNsbr/CKBez
         LqeNqxdAB/2TJLKJvcLZUKOr5Uu0HTz6bl2IWb/IDjeHa71HR7Evd1TPGdC4G0Au3VOR
         gQd22VXXlrRA24oQx2nneysc7RgWtHZe/XJzXaWA268j9bMbHyWeuV+e2Rn+GcAOh20W
         QhHIkCj8vsB43eGofApyaDcLngK+ug8z2H2hxBnTvoqySBSyEBvmnK1hkKCmOOCoJk48
         NJGHcje7if2LddZm1D6ex8tk6YAayyWG7+qKAhCEvUrIIL8XY2g8iq7XBE8aFhU6gVWJ
         mV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711306237; x=1711911037;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh7WIPngChgpb6/wT2qnSquscN8CZ3uMdGD+jaJxYv8=;
        b=ogb2dT0O4xfgCu1B6t1/c41zgp6ftR9VQ77KLXIk145/K20asmnQfAeuKiXtSARGXG
         Dl9lk0eUDhakrMca3yz1gAYoO4ur8/x6l+hN8EDorMiXHa4y/921VJsVTiQskceiQAvE
         zgi/X6fSHEsDFDPUmNinCJ2wqYp4Z59cJBUMlWuDs1+mFNEqjF1f8rSG/J8au9H291rT
         dqnBPKlkK3LFXZBaCiZC60S5roa7OxxKTavGfumE07lmRy+josvLVWd+pT2/Jq445XPj
         ltJnH9pdmOrvfLa0ShNTgOyWC7+SiV6YkeliqemS/oLM/qWN3CyL4RK0lYujUagWTGHy
         aC6g==
X-Forwarded-Encrypted: i=1; AJvYcCWLX+8TnU48t+MdmXFxvFA4pbpB5TeWRqbeb/dTq5EeKD2KU54vR812vvtztnTioQwwsIGSzrndlgI+YpKVWgPM1kPmtAblsw1/QbYP
X-Gm-Message-State: AOJu0YwTrf7S01KkebMfI130zX4b+8jF/cABPAtTEa9ryuzfNpk7pHWs
	JyPyOEwNtGmoMa/gRcIQF2iDNSDLgdeLkbAj6p5gLyJ0MK3I6k9YWPTMXcKNVJE=
X-Google-Smtp-Source: AGHT+IE7YzZVq4H0/yCqXg4Z63bK4KbtfqOS7Jf4EbizVXqQY6dIiXsth6aZPv2MfP3+lLsWDN16ZQ==
X-Received: by 2002:a17:906:1796:b0:a47:3b6a:a29b with SMTP id t22-20020a170906179600b00a473b6aa29bmr3095023eje.13.1711306236616;
        Sun, 24 Mar 2024 11:50:36 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id kn5-20020a170906aa4500b00a46524d06afsm2188136ejb.8.2024.03.24.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:50:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RESEND v5 0/2] phy: qcom: edp: Allow eDP/DP configuring via
 set_mode op
Date: Sun, 24 Mar 2024 20:50:16 +0200
Message-Id: <20240324-x1e80100-phy-edp-compatible-refactor-v5-0-a0db5f3150bc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=O0xVY+gl/fPHcB6WhFKWsogdWZR6lFHePZT39lrEaZQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmAHXupd+aX9jJ71rkl3EKxdf9VYRDpb/da92OQ
 qn8lHUFCE2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgB17gAKCRAbX0TJAJUV
 VrvREACwrHiaD6PwIQtmnkqeVgB4JTXBJY1d3DFw4JlKGgOPs1vt4XIrCdM6vXnftUL4GSfCLwc
 muGOAhE7nPqs2eI7WGJvCUT0tu/4zmPTMm4BFJumTjPIRPLd83wRv38r/YdInH0RLvdwQpHezMB
 7xPkkn0yoj5BBa05aGQH96uSDpvfpk1dcI4kQ0TkUSKzm/SvqdNN/uVEq4utV9aOWTxQCZX3dE7
 j3T0GrGAI0CvsW6NC6nWYHfXa/6jgmo5Ex7EWNnqLM3umPS0mYweBQCz69lcWFzUhw/wFIWN3eL
 c+NBUX5hb0Tstet0/pXnRm2Rad9qAhJwE0sNRgnxf+AfrGDoiIJys0t2DKFiLmW/miG2imbv6nb
 pBRTZk2i4fYlmhj8TghwGDM1D9XYi3OwkmWtwqsRu8e1fbn1zAOgBYPZb9ah5sAve3njTpFOPTs
 skefZtRU5xXqPelVXOi05FjngLy8PsdG1Ef33nVAAjhSWiSiBNGTeL1olN2AD60iAlmektibpwo
 UZu1w09t6jF6t4BE6zyiwpz/fRA2aBeqQ6tLHTPIbNq9LWEoXw5PrCOEa2Jcnxjdvs4AvvrqkI1
 +yqljOqtyH6L60/WHeqCyTSgy9HwvHkRuNafIAdlC4y3yw3J0b8VQz9GHDZQltUxF82J6+bYUk0
 QxfmgqD8Yw/exMg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Until now, all platform that supported both eDP and DP had different
compatibles for each mode. Using different compatibles for basically
the same IP block but for a different configuration is bad way all
around. There is a new compute platform from Qualcomm that supports
both eDP and DP with the same PHY. So instead of following the old
method, we should allow the submode to be configured via set_mode from
the controller driver.

The controller part will follow after we conclude the PHY part first.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v5:
- Dropped the unnecessary ternary operator.
- Link to v4: https://lore.kernel.org/r/20240216-x1e80100-phy-edp-compatible-refactor-v4-0-c07fd1a52186@linaro.org

Changes in v4:
- Added todo comment about setting the value of cfg8 based on swing
  pre-emph availability, like Konrad suggested
- Fixed the condition in qcom_edp_phy_power_on, reported by Dmitry
- Link to v3: https://lore.kernel.org/r/20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org

Changes in v3:
- Dropped needs_swing_pre_emph_cfg as we store the table instead
- Picking the table based on is_edp instead of overriding.
- Link to v2: https://lore.kernel.org/r/20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org

Changes in v2:
- Dropped the dedicated xlate function and added set_mode op instead
- Dropped the eDP PHY type and mode addition
- Added the DP PHY submodes (eDP and DP)
- Removed the device match data storing from the container struct
- Link to v1: https://lore.kernel.org/r/20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org

Initial attepmpt was here:
https://lore.kernel.org/all/20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org/
Compared to that version, this one uses the phy-cells method and drops
the X1E80100 support. The X1E80100 support will be a separate patchset.

---
Abel Vesa (2):
      phy: Add Embedded DisplayPort and DisplayPort submodes
      phy: qcom: edp: Add set_mode op for configuring eDP/DP submode

 drivers/phy/qualcomm/phy-qcom-edp.c | 76 +++++++++++++++++++++++++++----------
 include/linux/phy/phy-dp.h          |  3 ++
 2 files changed, 59 insertions(+), 20 deletions(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20231219-x1e80100-phy-edp-compatible-refactor-8733eca7ccda

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


