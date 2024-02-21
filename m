Return-Path: <linux-kernel+bounces-74911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A885DFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB50B2875DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B37FBD3;
	Wed, 21 Feb 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sF0jUMJ/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82647F7EA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526338; cv=none; b=phd+sB28Bwf93s5GRq/BlZwdQuP2uuu3Ov3jx8Knm+lIPDC7DqDR0o8MmF727TLZ+yKTHeccLZa06IZAB4HqDiMySmvW8ylopSyCRllBdsN2+lcD9fQabl3JnUFeKDzkt4pFNYReq2j7cLqvamXDS8LR9kYPR2VEYXlOtwdjh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526338; c=relaxed/simple;
	bh=q4atgorVyarvUtiSOp6Dkx/P5tSPZXkAjKk4CWmyCaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TWPoP4y2c2/Ml5nZdxlKY+pcabJVSAW5faqwwlOLKL3y3T++p185vjFoRIwElniOW5T7VfkBkUNdmv1QEG/9IWggVxWTTJfz04UVInltC5XK4E4wNWg9EWz7ABwbWZdbrkRXIUBxYZQ/mvlyqpvvFeDvpFQzaINFXsymVaYDBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sF0jUMJ/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ee69976c9so347601366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708526335; x=1709131135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVpjBrfZDLz5cq2FcVPX67ljd8ZHs+O+QU1skwOj/LM=;
        b=sF0jUMJ/ks68HKZmRehWewlq4U+7tl7NBlgg94buMdybg1+U8KoNh85MEkesdyZMfP
         4Sra3fUYiFwjqgN7GyNDOjD/JUEh1itnpS1tv/i8rWDTcylW/WgZ8TvuM4DkvmN7BDV3
         qYjehY49/jo7rBZGpfCvT4udKCxh1imJ2NGdvfV3GYXNJDtGTTaU26O436F5/wIfvj1n
         PMC4jYuOzI9HWCZRKdWsI8AYgphjcQJt5S7EM8TI5pNlxCrFImNJUlvpsC3Be+ZHU3Tm
         s4kPWy368L8hhI7foZlB1egLP6AQU8p1cmGosjP0DewcaddJATeazSinh46CtM20t3pd
         12fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526335; x=1709131135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVpjBrfZDLz5cq2FcVPX67ljd8ZHs+O+QU1skwOj/LM=;
        b=GODQGcgL04D/DsGMVoVdQ6xcXBxRSP7AkX0X3sEoccbDuCIcaRPJZOUffGzEreoS/X
         2QkfAjgWH137AyA65j9tRAU+1u7N5QgvVpi1mp6bFpIrbS702o77zp7st04dCVX1/b+Y
         xMpr2Fa9c66JhWunHgdls9iP4LxEiINaWQvSFwvvHUD2H4lfbs+hsx4nHWAZGs1J17Ca
         x6YZDuY85LbIh3Q4t+EAHCsJGffwWYDA9oHJYVFfmszMc1tIqEWenxQrRvA2Tc9odTJH
         yIGNNV4WYjqp7hfZbOIf1hsVIN5JFpvg3/QMndjgsZ2H97BlhFCBVjLJDuDJvtYyhHaR
         uobw==
X-Forwarded-Encrypted: i=1; AJvYcCWSFTno+NZp9F18h4zhbpKMeTJHFf1Oekz8uxx4+1yuInVuo1MzjNcRyjA5DkQZ//ZjioHAVsl1dz3gpqxtNcxFz11oAAul4Peze8Ro
X-Gm-Message-State: AOJu0Yx2IQMcynl8lZRwAXYD9godcYYtRWGTP+7wxihG4Q7J7MllK8rJ
	jbRMQ0CGp6YiQ+cL8HWxJI+3p27zfs1Ygjr60Wd7ugC4n6oCoJdDZfHE07HsV+Y=
X-Google-Smtp-Source: AGHT+IH3nTACWpA78HizfHb+QZrj8kkswkekwHjT/yU8q6sleBVZr4oVFwhVL7AXZx1gELCaRLokwg==
X-Received: by 2002:a17:906:7f84:b0:a3e:b7b5:a64e with SMTP id f4-20020a1709067f8400b00a3eb7b5a64emr4693686ejr.20.1708526335019;
        Wed, 21 Feb 2024 06:38:55 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id wp12-20020a170907060c00b00a3eb953335esm2653970ejb.44.2024.02.21.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:38:54 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/4] arm64: dts: qcom: x1e80100: Add support for eUSB2
 repeaters
Date: Wed, 21 Feb 2024 16:38:30 +0200
Message-Id: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOYK1mUC/22NQQ6CMBAAv2J6ds3uIkI8+Q/DoS0LNMHWtEgwh
 L9biUePM8lkVpUkOknqelhVlNklF3wGPh6UHbTvBVybWTFyQYwEC0mNhAjtlCA9DBcXBLSV5bJ
 jQV2pnBqdBEzU3g459q9xzPIZpXPL/ro3mQeXphDf+3qmr/1diP9fZgICy7Ux57YiLOU2Oq9jO
 IXYq2bbtg+oHHutzgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=q4atgorVyarvUtiSOp6Dkx/P5tSPZXkAjKk4CWmyCaw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1grzV02Xl5xbRYiP7XMlIVQG91w9EaJLHjw6y
 cgl4RmwfpKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdYK8wAKCRAbX0TJAJUV
 Vo4qEACObTtQpjCuBVnsEVxDBLprIFYJpidJBKvGYjQNOJB2n0kayuY7VGu79F9J+HdgqW4/1Ku
 nX4gjbXDOVsWE2xAqFwdaKFmuozvG2ZF/XOdlopuJTY4tTbnkgDVy2FCIZSPYS2HRt6Fthwr+R9
 7uup9bT8vidkG8U3N05uztYwz0kgai4wFbczRd3wXJ3zmMaaltgl2ASJP66O0tcaaWM4uc/TXh/
 eJGfIszBj6cQTgvrl9HDIxFhFfV8ekFyUrZYpk8SMbI/G+thAjzxDdi3MejH9XKGNJhy0w9rciK
 FqskZIYL6MCGlUtxCb6Raf9mxTFjbzINT+bOvwV0Ek4owazW2i0eEPYB+PpULtxOvpEdAssNnIf
 BQS+TNzAOd7dysSuWfVMM03BASNcElDK2S1xnDPmsB7YkoWSYVR/W7HEQVen2nsIy5c0WuHigmk
 lbj7zGwe+GaIAThSWeKJOA87IPRRvy0vYUSiUBCSRAZLtX3pijqpiUU1JhN37u1JjQlNpusJIQ4
 I9L550o57YlrkumpjCGLmhN++aXyuwy418FQLaqjqZN41CoTH+lYXZrIvjMAEGL/37EQIhC8DNa
 WCy+cjkwyeC6kHWt02cqUm2tid7GZ7dST5PHhTzNWlBO6N03IkXwro5imR0K2M2TUUSFtzgkJT9
 j1CgZKsXDUMcJDQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The X1E80100 platform comes with a v7 SPMI arbiter, which means it
implements two separate buses. The boards using this platform come with
3 instances of SMB2360 PMIC which implement a eUSB2 repeater.

This patchset relies on the support added by this patchset:
https://lore.kernel.org/all/20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Changes in v2:
- Reworked the whole SPMI DT node layout
- Added the SPMI DT node
- Added patches for each board (QCP and CRD) that adds the repeater
  nodes
- Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-smb2360-v1-1-c28bb4d7105e@linaro.org

---
Abel Vesa (4):
      arm64: dts: qcom: x1e80100: Add SPMI support
      arm64: dts: qcom: Add SMB2360 pmic dtsi
      arm64: dts: qcom: x1e80100-crd: Add repeater nodes
      arm64: dts: qcom: x1e80100-qcp: Add repeater nodes

 arch/arm64/boot/dts/qcom/smb2360.dtsi     | 51 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 22 +++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 22 +++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 42 +++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
---
base-commit: 4893c639cc3659cefaa675bf1e59f4e7571afb5c
change-id: 20231201-x1e80100-dts-smb2360-0c7c25f2e0a7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


