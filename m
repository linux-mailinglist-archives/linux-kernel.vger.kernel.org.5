Return-Path: <linux-kernel+bounces-125592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE6892927
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F1B1C21265
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8259455;
	Sat, 30 Mar 2024 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNXtpUBL"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547579C8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711771174; cv=none; b=sLZRJD1iHGJBXmJ2esbFPN3RTxQT4jn2ahn6RtiJzdiIjac5eefgGMBqPDnKOs/mN+oDJsEki/Encg2WBxA6gl84rKWjTdEnmJ0gGvp6kUfe5CIHf3aRNS9JJHWBQT6jiMBtZLEsORDp9jjCiqAtimAvaMFKpNq/WvdwcQDHHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711771174; c=relaxed/simple;
	bh=HVQQ/1Sqaeom6RrFBW54Crl9fEDAeeQFXdkKvNlg5mU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qLb58tWTbpTV5nAVHMPFAre1AmaS7Ijtltr4kUWQm3tGiIRbe0TaAqL2kbi76bCmsgHSgLKnlyWOBvf+Jbn3kqMMK+BxmV5sU55sPwpqX2MHAWAQZnarD5fdGZfaapjNvj3vl1py09aVUiJabl6nc5JpZJ23zAG0IiKZTuw3adA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNXtpUBL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515b69e8f38so2616621e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711771170; x=1712375970; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/KyYTez7Ham6RArqjYsAGdRx6I3CfaIBG2n577n7v0=;
        b=QNXtpUBLHZugTJXF79Q12RS1j/sw9g89w9NaxBbzlJXt4lL4qprmSGzD4bMqIpG6FR
         4XaGOlmjw+HMF153uu6Fl2M8R4J/IQGkLUleFaKykIThHHVcB2yC99mq0C0m9iyMtsvU
         3fmFLmpD22myrTBf7xe08XCyGP3Vm/vJsPkTHCFVktR1DAP3DD8Ll5kgDh+TirQHwBFt
         itugFTRVpVHr4kUgxIs9n7j+d6DiWn4ChJYUK4cum2ozfqSsjLmfP3BGnOoqkUAUGYMk
         ct2u1+pwIK3BbRCeSiB0kC1AJ3gTPsOlZYcqHyLkhLOJ5tNmJwWJ8wOVAqK6wnTKtoUj
         9daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711771170; x=1712375970;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/KyYTez7Ham6RArqjYsAGdRx6I3CfaIBG2n577n7v0=;
        b=HIF90423vQEdu0QFKvz0ZXFUTqY6o1UHmSGmyhsbMIej0/3e/1XyT0CiaFYLp3MsJ0
         CApUPEUMbcr0PTsDgl+kDy6QFRQoFaHcPnpZizkTturwLDR+fELfxr++O5qa0dDVzd1q
         cb/EbNbFrWj18Ey7HrKV4uD1t0i1MUl6UNt6ellBwcZaROgZywx7oMK8qHz8n0K9eBoV
         LMbMy3CCA15WlUnQRoQqilZlgqMPyim7MAhAWbh8Kq3Ybo7u6mI+cjBwm+K1gNnW2FVP
         8L1fvIBJzU1I7y9gacgvGL0/QoYaxUg2+cuWWPwEh48L/JPEz/08qpWkXETSoedtCxLq
         U/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOm8hWtQrb4xbkBvodua8nQZ3uVVfaer4K2vT+MlXr8vm7zmF1rCStvIqC/gWkUip8CxegPqlAoHUOFk+fn1zr+swvsefcB0Jswk0O
X-Gm-Message-State: AOJu0YwU7zFvLXjvkrsukcRtSluoCqy+3fb7ACUco44DCeYLuoseCV4z
	6OB3jEH/fIVuey7WPaj8p8ouvgAZRSMgNK1Y+MKjYC27QpJSR0w0FvbWmxBTZRU=
X-Google-Smtp-Source: AGHT+IGQmXGXUknN+Wj2FG7n6iWPBgprhcqnpU4Z7Jb+uCSYuzieUgOOjoMlqaa84Q2JHfEIdl2+hw==
X-Received: by 2002:a05:6512:1307:b0:513:4f60:82c4 with SMTP id x7-20020a056512130700b005134f6082c4mr2915403lfu.3.1711771170376;
        Fri, 29 Mar 2024 20:59:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id br2-20020a056512400200b00515d1393f3csm423957lfb.104.2024.03.29.20.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 20:59:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/3] drm/panel: add support for LG SW43408 panel
Date: Sat, 30 Mar 2024 05:59:27 +0200
Message-Id: <20240330-lg-sw43408-panel-v1-0-f5580fc9f2da@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+OB2YC/x3MTQqAIBBA4avIrBvwF6KrRAurqQbERKEC6e5Jy
 2/xXoVCmanAICpkurjwGRtUJ2A5fNwJeW0GLbWVxkgMO5bbGit7TD5SwNk5vVmlFmcIWpYybfz
 8y3F63w9k14blYgAAAA==
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=HVQQ/1Sqaeom6RrFBW54Crl9fEDAeeQFXdkKvNlg5mU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmB44hgrh2oy+/fGY8pSaDoMtDIh0OTOsGKIq/J
 gzwpsBOeeqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgeOIQAKCRCLPIo+Aiko
 1dxCB/4unCfNUOHubbbTywYo1qg6QGSV/hNj4aNbERch4zIqmSeAdnCJ+jhqqI8JVTf9p/K8eGy
 Imft1WGaRzBE4/Mz6X7eYHg0bAnxSKiTcJ/fWjgXUelBwcBhujJdnV/QwD1/31TJwKPTZ8ndtas
 xFvdOUxYLfRSiLCVBha6RHugPSV6jGnORHIa/75nDD0QeieoGUG1hNHNLI27t967xu+PabyHw1N
 dF0xhIyiw7lH3v+3kRnAOUfXusPAFWH6I7KiaUnVfUiI2FV1mAIBVQe3sIepOOqkLjfQUNqQIKz
 Q45lS/fx23lgfYel7BCBih5vpKbUipfx78y05cbBmelONARu
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The LG SW43408 panel is used on Google Pixel3 devices. For a long time
we could not submit the driver, as the panel was not coming up from the
reset. The panel seems to be picky about some of the delays during init
and it also uses non-standard payload for MIPI_DSI_COMPRESSION_MODE.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (1):
      drm/mipi-dsi: add mipi_dsi_compression_mode_raw()

Sumit Semwal (2):
      dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
      drm: panel: Add LG sw43408 panel driver

 .../bindings/display/panel/lg,sw43408.yaml         |  37 +++
 MAINTAINERS                                        |   8 +
 drivers/gpu/drm/drm_mipi_dsi.c                     |  34 ++-
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43408.c           | 322 +++++++++++++++++++++
 include/drm/drm_mipi_dsi.h                         |   1 +
 7 files changed, 406 insertions(+), 8 deletions(-)
---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20240330-lg-sw43408-panel-b552f411c53e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


