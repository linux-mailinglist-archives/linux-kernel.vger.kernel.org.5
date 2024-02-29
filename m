Return-Path: <linux-kernel+bounces-86725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F186C9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FD3B23BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2A7E113;
	Thu, 29 Feb 2024 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMQYZ8qj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960E7E0E7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212034; cv=none; b=pbVlu6BYvqRlJN+4/RmcBCJr8Zal9H7DpDHHiBwM2aH9OJ1E3nxSdLSsim7gFtV+ssaFF0NEJq+lTSpsZxKbIVKZHgf5/GTQRLuPDvipD8GORn9kCO5dKZRw/tPuYQy+6vSfKNlzmAefxx/6dFbiaXNyYj3JW96D9Re6miwA0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212034; c=relaxed/simple;
	bh=aqZRgp2yiWRPmMT6L1mHmGD73EcopqhjHSAXgidIbgk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jrm7XUyGqZQbNJ7wYko4H0MDQvlkB6M6BVZGnpRCH/7V9fE3vnZbmnt5WXB04lS1+sxMnwty7xBVSqZTSXEcyTLPVZtNbZ3TE4Dm1xLhGY2LHRsPXoS95MOSBMHAq47oxWNabzFGsw1WXdO9fLgdAvPbQWZ/W4Y64nmN656DTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMQYZ8qj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512e4f4e463so756458e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709212031; x=1709816831; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpJyTXc1Ywh+o/rrJ2pOXjJ2ggpkjWz2aQ0FDxBOhIY=;
        b=eMQYZ8qjJTl9QE9rOAbVUlR7Uc5m+sKBLLSbt7ThOnS+kG7bwcCTnSW7XVuv9Y353R
         Oh8KTlRfHygakuX3ChnHD2KLNAwK6aZrukK8EHDVEhAV8fHVIp/B9I9OeFJXyCDCZmMW
         NH57bbArFCg6TJq3hh8K7NSlnAzbG+jmIxbddH3SdecVQyIsZgy4EvhxJ7Qs3nLsXpwN
         ykBmd4ykIfIaWDZ81ssk3c5Kdtcp4PPK7kviwsVtM2VDPQ1rv61sqfkMkwZCm6AG0Xg7
         UQkqfbY9F6wqHDqKjLslDMDQbAZvX2jCd/DZP7OWyBAWRXZFCwySoGSuhlnrqFJbw9DE
         vMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212031; x=1709816831;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpJyTXc1Ywh+o/rrJ2pOXjJ2ggpkjWz2aQ0FDxBOhIY=;
        b=Y/7ul750dJcLebAlnLD+X/KZ1rK/9Do73UvQnuDvUUHVdqHe+KM9BtugbCbH3lMAXG
         auwMIGBwJ0llCYAzfZb+lg0UfbSS2o90JN0viyDX09oaulzfZEMZC+64NkWwk9la5GiB
         bBBn3b1C6+x0KzvtLWvKoRsSiEppVj0w9sD3hjI9xf0Np7ownXXg0+MNhfUG8nKnnHf6
         JDf7VCro942Mec/FbnkwzADlDbj0J3AclZOmdmzwFpLl/5OV0uDcVX08NRNgIuVs7vpO
         5xNZED4kGR0FqWfMsRrUbCklhK1bnms8OcTe/YpvN9Lfae0e7Im66bZJHaaMSUDYZLwJ
         eKEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXy7esp7/b/s4fXhe/B6NMGhv5IXMAgEsd+s1jBL/KbhyUJl56lw8ZMpBkdatRderysifylQ5uermDsSGpGgxxk0c1rtf304/Qy+b6
X-Gm-Message-State: AOJu0YyxksGFy42nRl73NqjTXMw+tdQOFKX5bE7EC2f5soEA7dE5uBb7
	S9ZiXTIx5U66geqa52bI0DfBZWqQxaOtxlQzeGPF4yXlCK+s5Pvq16nLNB7IHZU=
X-Google-Smtp-Source: AGHT+IFTxPsS0B7q7kKEpGoSR07lplEbqHtwyaT9O3CctzbYkluJr32N4q6Bwnf9qN9P4GECQcJESQ==
X-Received: by 2002:a05:6512:138d:b0:513:2ba9:4b14 with SMTP id fc13-20020a056512138d00b005132ba94b14mr536713lfb.46.1709212031012;
        Thu, 29 Feb 2024 05:07:11 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b00412a38e732csm2071473wmq.35.2024.02.29.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:07:10 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
Date: Thu, 29 Feb 2024 14:07:00 +0100
Message-Id: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSB4GUC/x2NQQrCMBAAv1L27EKSWrA+wAdIb+KhjavdQ5olm
 0pK6d8NMqe5zOyglJgUrs0Oib6sHJcq9tSAn8flQ8iv6uCMOxvnesxR2KOGS+kMrqI50RhQ5g1
 9DFPEvAl5DGvB1k6dq9jW91B7kujN5f96wP02wPM4fuclkP+AAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aqZRgp2yiWRPmMT6L1mHmGD73EcopqhjHSAXgidIbgk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl4IF64Q3vQhe8Ed4JVg0rO8vaK7Imt55fyQPjvmDn
 /qxcxw+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZeCBegAKCRB33NvayMhJ0TqvD/
 9Pe1QxNJeonARwUNIv58+ZC9X0zLMPhhsW3n0g0YX64trQSgJfo1ipVCBFz3B6QRoQ7d79Zy6vr8Jo
 p3h5KqBdtD8iXEg4RjDyFG4tEZ1/yfEfPpvNHOdXL1rvzswSBelfQAtUymOLpu4wAde4d0CoNBzAtN
 wfBqrc+pgorJ9ZkQODfyH6PFEcCqYHiYi7wtr9UTupQDmQevpxezlRqgXjThLR5Wkh32vYAL6UaoZS
 oFe/4EUWdE39zYj/S5C82ovTahV20EoKKAFjW4FyZuElpIph06rPM0LqZZamwrcdvHQG8PgWMqv+Zt
 MRmv9WYWWUeXqunK4cbjd0tuK6RrcyZnB9FVoOZh1pw/h2I0ER0R3087l10FeJNCbg25IjAb6LKJ+E
 +Ylm6LwXJUWTgNYCjy4yLWxMM2tz7FgBL+4btv+2JV0ZxaxuDqud9PeiEQkG4rn5R8gKkefuLukLKq
 J1wDXNfJ7yDNDfS7Zp7kkBCruGQ06Th35oUOBsQ3XRJ2sH944iPQg/Id4PKHEMkFa/8k7sLqlZefhv
 0YxdgyR/n1TNnE2uEgzfiZ1LGDy1u4PM863oq1ZvKZff4UTRCXoZcwrnz0e0wxkkdegvNWNZVa5jCm
 AioPNYeKX4y2iIt9SQU2D/sr9fbiuuyfkR5tX4sja42vc26AccpjVDvtMO9g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Register a typec mux in order to change the PHY mode on the Type-C
mux events depending on the mode and the svid when in Altmode setup.

The DisplayPort phy should be left enabled if is still powered on
by the DRM DisplayPort controller, so bail out until the DisplayPort
PHY is not powered off.

The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
will be set in between of USB-Only, Combo and DisplayPort Only so
this will leave enough time to the DRM DisplayPort controller to
turn of the DisplayPort PHY.

The patchset also includes bindings changes and DT changes.

This has been successfully tested on an SM8550 board, but the
Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPort,
PD USB Hubs and PD Altmode Dongles to make sure the switch works
as expected.

The DisplayPort 4 lanes setup can be check with:
$ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debug
	name = msm_dp
	drm_dp_link
		rate = 540000
		num_lanes = 4
..

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (7):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add mode-switch
      phy: qcom: qmp-combo: store DP phy power state
      phy: qcom: qmp-combo: introduce QPHY_MODE
      phy: qcom: qmp-combo: register a typec mux to change the QPHY_MODE
      arm64: dts: qcom-sm8550: allow 4 lanes for DisplayPort and enable QMP PHY mode-switch
      arm64: dts: qcom-sm8650: allow 4 lanes for DisplayPort and enable QMP PHY mode-switch
      arm64: dts: qcom-mode-switch: allow 4 lanes for DisplayPort and enable QMP PHY mode-switch

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   5 +
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   6 +-
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   3 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   3 +-
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 168 +++++++++++++++++++--
 6 files changed, 173 insertions(+), 15 deletions(-)
---
base-commit: b321c0e8ca754d8cd9f23ceba958e3ea93c6519e
change-id: 20240229-topic-sm8x50-upstream-phy-combo-typec-mux-31b5252513c9

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


