Return-Path: <linux-kernel+bounces-111391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14264886BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E6D1C20850
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650A3FBA3;
	Fri, 22 Mar 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYyI2Nba"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EE3F9FD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108701; cv=none; b=qWle0f8HHXjzepc/dF0izdlShXm4gyKsprFJBefJgjpehQOYa/6jjpyD7v7ICSEL0LfEynXFI9Wa00i2gn5Qg78ZKNaufqfs6TLgP8xvEa9s4hx/N67CdVzPrigX9SFEZPylHbCKsCuVN3Nnr2CqkFr3dtrkcbTWJLSlXIc9jFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108701; c=relaxed/simple;
	bh=rUfaXAOeL+5U2/ybOBW/sEHVze6zYt5hNl7ZTJEp/GI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HD591YnM9i78AVbPvX52ggDSxRGV9az1/GU4Cyf+V6ZKi19gbr1NFyaPVnha78nLd8RgtwQ/3xjU19ZB0sj/fBokeBR6Buh/xiOPT/6pCDZ+5AM2i24YOG4Yhl28OwJvFqcSLjP8sDmdxZlEwMEjAVZsPyOtRfMeJvpwcL6Dato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYyI2Nba; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so26194501fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711108697; x=1711713497; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPV5NG3qIVRm59STf4IgUCUuMGOo2OT7pMBanQA+htw=;
        b=sYyI2NbaRWkit6qLcNqorcBT77ma+jHUjTj/+QvjYoZHugsNhtmcXC8SbBV7e44Kgi
         StnDTd9cluuqIhxrW0ShN5LHdk6dC8SjsNvOjPUTRtScSaofo5VqFmCkOgkfokwVmIUW
         p8ENVEer7Nnt7D560wbS+bhUt9BwizcROlBcyv9rRSJHMKCgTNJyemomk/xwkDC5LNai
         gwnolLaB0G5wDqniqmQMx+CABpk14vVoViupfBZBx1vag7nsq/RhqPpEWmU0tVU/CqaU
         i9AchAx6nDINbO7St76uNWepcVfctz6nFlPkz5hfYQjm9Ofbg5TyMAEg3II9pUV+STdb
         YIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711108697; x=1711713497;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPV5NG3qIVRm59STf4IgUCUuMGOo2OT7pMBanQA+htw=;
        b=Lc47a/BZFhaiYJzTMc3kPVtnZ1hL2jCCS62bj/sE7NMl11PltVPDYU25emerA+AX/o
         AYa7EZYGVC3jFP/zqyqo2+qxJAbJ7oLfivXbT/haen3u3DbKSl50eBjTaVlCEHEzGyt2
         qTQTq5dJ96U67AVCnvgRXu5ympF2noWe78XqgVWOgwQc7j9HwryQyK5aev9HzO8olRd/
         bQuIfLROWFSdckuZuxqYh7sq3o+kzbFjRCRglqmNkLvYO6MbrPdS8Dg9iU7FYJaq9fFG
         4hsw3zp3IDun9kvsxWH5Ko94e9PrtnZEEJ10G301BLAND27XsZ1SW3f611eGZgY9iNL5
         fHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMGDPODkAO7rBXJMg3R1g4LyKNCEWGK+bmgp5OMQoQylCY0R+SVQgPG5+5+Hb6f+PgGvDTrsyHHGJUgEb5jiMYq/ak7w68DqRP8DVc
X-Gm-Message-State: AOJu0YyZKJHCVng4mbgd1VVBXktIThTWSe69Ri6OWR2Jow6LCC45ixui
	Qgw28YCvEQFg9uvM3uU5Hi9w8RARbZ9T0/Ei0YUgycnQat3ddLWyL9bTylPGD4egqS+K+bTzgOJ
	R
X-Google-Smtp-Source: AGHT+IHdlpfs1QVcAXn9/An7CN50e8pE0rm/gdopZxqK1sglXhPKe2A/jEHyR/sRuAAN3VtfNzO6Yw==
X-Received: by 2002:a2e:9053:0:b0:2d2:4f81:4dcd with SMTP id n19-20020a2e9053000000b002d24f814dcdmr1709472ljg.21.1711108697525;
        Fri, 22 Mar 2024 04:58:17 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d7-20020a2e8907000000b002d10daeb6dasm307430lji.126.2024.03.22.04.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:58:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8250: fix description of the
 Type-C signals
Date: Fri, 22 Mar 2024 13:58:15 +0200
Message-Id: <20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdy/WUC/x2MSQqAMAwAvyI5G4ipG35FPJQaNQcXWhGl+HeLx
 2GYiRDEqwTosgheLg26bwmKPAO32G0W1DExMHFJhhnP5xCHk94Y1pYrQmNc2VgylqoaUnZ4SfZ
 f9sP7fiYMI4xiAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rUfaXAOeL+5U2/ybOBW/sEHVze6zYt5hNl7ZTJEp/GI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl/XJY+5m1urB5EqXXy3/JguPVROfb/jPJI4Cci
 6nEuNwyRWmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZf1yWAAKCRCLPIo+Aiko
 1esvB/4n6bJHiJ0d94eC60Yi5ipvLVQovTb7BxABF+BOrbW+SCwkFGCJM7RXBgeESXMl+ydNQQV
 m/pq3EdAJ7swk4Tsxq9dOUhyZ3+5HYHO/7lh99zqvXmAPidm96955XHdP5rDHchSG5JAdWWKa57
 a97LP0u72ogF372ZZDdJyWE1pvl/a4SyJPgLOH2tVIsn6z6+Bz2hECkQpg+MLEeH7R30lgG4hC+
 FCCjpO6fi0MwtwgFCrI839HPqFpNwdA48p92gJifKdmpKZ95ablF1zSx7YfKCTICMzHiVLYPoQD
 WGKW7b3+BUhK4AwHWGO7R9H4ECCtQtPA1xiHQwxT2eZqEWLy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rename the HS link between usb-c-connector and the DWC3 USB controller.
Add missing graph connection between the QMP PHY and DWC3 USB
controller.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      arm64: dts: qcom: sm8250: describe HS signals properly
      arm64: dts: qcom: sm8250: add a link between DWC3 and QMP PHY

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |  8 ++++----
 .../boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  |  8 ++++----
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 24 ++++++++++++++++++++--
 3 files changed, 30 insertions(+), 10 deletions(-)
---
base-commit: 226d3c72fcde130a99d760895ebdd20e78e02cb5
change-id: 20240322-typec-fix-sm8250-33c47a03a056

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


