Return-Path: <linux-kernel+bounces-68610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC3857D22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565A22880C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DF1292E5;
	Fri, 16 Feb 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcF3oW5E"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32177F25
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088554; cv=none; b=dwQcU8ow6WJkI/5vdpKfaaH2M8O2UYPe9HlRQLNxg7cvtBfcVJogYn0oOT0PCL+iLVsSnGXgvBdRwvyp9uowV/ITpURVS9nptr5lx3JGMK+hOen7jxFSHjwYzHWmtcQpWVNKiWMQsAwDm5fd1YNn0no5M/VoDjnReVVjnAztrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088554; c=relaxed/simple;
	bh=ymGKj7gvKTmsiEBKEFvNUrhHmeS3+tvQXhuPlfQonQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pfGRkba/5z86TIkbdcvxESiCDUw8LA8Sm5AU9Z1L6XRcLxNq4L0eb+WwzB1n+uzhmvPyWsCUkfOtVvORt3HxysG7uk4EKGxnnRGNekzhZXoDwicGHDjhxUi+/0YnsZAys3AwjHJEBA+XNU5Ax6OU8QAKS0P+n7Wt0YZgZtEg/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcF3oW5E; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5116ec49365so867131e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708088550; x=1708693350; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WogvKBnTSfqlenahj/21fSgTDCDEh9d69i3ysSWZV/k=;
        b=WcF3oW5ES5jdz9fvp40u/0xq2RTnWK9fCzQhVTI4u7AJnOlCj5Bz9horsNiHYahpGW
         ncjaLPRocKEkWJhDgPHGwsncwZbttA3Lyr4e8NrDa49aXPfia3fPWAnycFcNx+6Tl/xg
         tRucFeUlDxuljDZ664XP4lp9c6YJyWJmVE8YTX0MvdC5YpcVTccp45n5TbUqOSCzmWht
         x5UqZAzInRwmGucYMQ7bvo3SO54XDb7rnUKwtpTignoEHFCdyRH2BQYOIrJjYcM3QRSl
         wi4VftVRDyYs+af1hFON4cIXSZi90eycMpJGqlrii+q2mSy+xu63gjQGv/NDG9bYZuiA
         s9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088550; x=1708693350;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WogvKBnTSfqlenahj/21fSgTDCDEh9d69i3ysSWZV/k=;
        b=iID/qQhPGoCpwH2nlrJgydMhN06IUmybdJdYPR+4bAF4xKaCXh5Bw5iKnVy3meuB7i
         Nht0Jz05G9IsV7f6u9lsaTcOfIhS+DEsw6MZQUBrYgqRu6i+JA7ogiZHqQvIiPIokICz
         IQknI3nAm46hmo7gjfK86bZ+GexEYR7odQi+enPoHLdORYe0YwX8H4CjjD8SalN1XsUg
         drCND2buSINKWJSPim8gZGjjADhgP6jfgzwqczv5o34ihozO5MCr3t2ZO+xQYR6PB2/T
         ZLdxP59cNoe0bbOlR+RxXGAeT4QB8q8RIfuC78hIlshL6iz4sdycU2WMGcp2XADSolnG
         iI5g==
X-Forwarded-Encrypted: i=1; AJvYcCXgPmaLfXpPxO0yhVZPTSPcTcFzK/WeNO/uUu2ciSjqzZ0tgePiaHNMsmHyBtmVhDRh7Ul1gSsJ6tx6OACpqJ0GjBSLgml6yd/jN4tE
X-Gm-Message-State: AOJu0YzqUl5Jcbge+Gukn+inlInbl88G3GG86vQ2GdhzLF15u1uT5iO0
	dRqwRkJY+gr+My9RAY3XA+a8iSVeFy/PF8Q+naDR1irMflXocHg6n4+djK6JXX4=
X-Google-Smtp-Source: AGHT+IGw/AlDiLLA+RB7XpLCrxWnOc5MjQI5KGh9YGBH3DXlLo5thFcDGBTSJAq1FNpVLXuadpNpBA==
X-Received: by 2002:a19:7707:0:b0:511:3283:e3af with SMTP id s7-20020a197707000000b005113283e3afmr3385555lfc.27.1708088550281;
        Fri, 16 Feb 2024 05:02:30 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lg20-20020a170906f89400b00a3da60acdd3sm1317105ejb.27.2024.02.16.05.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:02:29 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/2] phy: qcom: edp: Allow eDP/DP configuring via
 set_mode op
Date: Fri, 16 Feb 2024 15:02:17 +0200
Message-Id: <20240216-x1e80100-phy-edp-compatible-refactor-v4-0-c07fd1a52186@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlcz2UC/5XOwQrCMAwG4FeRno20ibWbJ99DPNQucwVdRyfDM
 fbuRkFQvOjxT8L3Z1I958i92i4mlXmIfUythPVyoULj2xNDrCQr1EgGTQk3w4U2WkPXjMBVByF
 dOn+NxzND5tqHa8pQOCIO3oVQeSVUJ5t4e9bsD5Kb2MvZ+GwdzGP6Z8FgQENdsnPOYmmp2p1j6
 3NapXxSj4YB31TEH1UU1R+tKzYByZb1l0ovda0N/voricrO1CRksGQ/1Hme7zmOjrSFAQAA
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ymGKj7gvKTmsiEBKEFvNUrhHmeS3+tvQXhuPlfQonQ4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlz1zcfuzNAkEVglQWrxL9kzvWKVd0FwHcrgncB
 nypshDoGfKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc9c3AAKCRAbX0TJAJUV
 ViX2D/4y4X7nqbgO6z9vuSlCELC/e5oKyj/bPJ3rRs0trPeeqYK/vMj2KRBZCD72m8e5Owf9gJm
 +cuOTIgAtN/rtcctYamzdF6zakdqBkilNAp8nw1Bz9Qa27CTkRo/7qJgK/hvQ79N4rD7mJlY1yV
 Q3v1P5sRZoDWHiVKvWjOwrYqjQJM6bKfHfIavSmahchJxOSuud5FW1YSU1+hfl47/6yjV1yJkuy
 sNJcHtBB3OvMrNtcW++vsjW3eFAjNvm9nMJcdhRMIbY/mBtJEZFm/rqCFoZn74C3rNnu1j6NKDp
 RvyzAQ9iqZCDpjtPFp+4SR5T42C89a/hpg2b+Mx5q44IaOt2zm+tND9ppfZmwvrL9bm6xwImUJC
 b8Z7836woAQvsdIegYTdU6Q6zPptyNZGzXqRBXUAO2GrlpJUIrzzv8VOSNFxKEHBynWOnQYrJVF
 bzFSfi1Ch/60DlC5mkYoKZAkKoS/XX419qipWAOpmwOYC+8/HMZYiuBqNH2uBekwtW4QGDNFfBh
 OkJ4T7KRBTeCjw9Zo1qMqVzLoE0nKq2JJMq0l629tTFYLbld6F3ifL1yH32XIgqImyWcFml97ok
 SNYD9p0Y/xXQdNvncon4kWJjKkYYsT5s1vJFD3k3gXdVyIdmButDLchmid1Aw9RJKbUwGuKyPie
 zEiIsG8kh0/SbBA==
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
base-commit: 225cd66584b578351668a2a6f6c723819ab8921d
change-id: 20231219-x1e80100-phy-edp-compatible-refactor-8733eca7ccda

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


