Return-Path: <linux-kernel+bounces-78043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670AA860E55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992D61C2135B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877145CDF5;
	Fri, 23 Feb 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVazC6xJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2235C91E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681249; cv=none; b=QtGRLp01p9BJsBL9b22Qxu4T0QlKv9GQ0OTFxdDolOPG2XW65Jm9jzD5RALnUzgWXm3I7FnJNXojyBBLGuqHc2UTWCOiNF5qkBlaLz6u5zhVDMbIeqv7rW2UM+njKQyImrpIfvtYYR7ceoW7JWUwoXYjuwO65fxtVE0rLQ+LGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681249; c=relaxed/simple;
	bh=rAZRRa29e7xVYk8Hc95CB+iUlw9D84lT7pBp2nK1EwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sZe1dMAafu1O1+n7OS+n5qsKQMPmFhr00H2rDQWuapcMIQCCZN7yA7hBdkUdLV21zzrvKkeHCU2DRstl4325uYogjnZP1TwyYKHM0JEMHXMTWsKYFutygy3MOQbyuurs8CpJDiBB8wIfRY7rDM83kTRelcL9EReWJGF6HfIJ76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVazC6xJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41294021cd8so918085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708681246; x=1709286046; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sClHUEJjf2CmNxz7CFNtdXtyCHWqVxiZ5wHj9LbF+v0=;
        b=vVazC6xJNXY34o/6DEjjJLQ4bGnRcVls8AwL3GGHuTsPtQMfHCLZO70YmeWCBj+JQT
         lLR9M0WNI0CkXxu6T+jFQS1EERdesAjFDHy/oR7JkakiZeUP3/TaLwzz0NYPSlqNaJeQ
         UdhEmQgmEqiuis1dLJAhMTX/U1LaNV1CBclJeHrSVTQmDkTV6wQj4TIs6d4YNFLhZCpM
         q2cUac4oBwnqLDdNe9sdQP54ChZvWRY6igr6lOww3Qsgdec9HbMtDG6ZFpTQR80qj0HT
         5Oq0h3T/6JCK7XPa5JkWUH8xxhBiWkMb1ydX6HRfDOVaQT6Ub4iv6pJQsWvYt/uM6zkb
         TImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681246; x=1709286046;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sClHUEJjf2CmNxz7CFNtdXtyCHWqVxiZ5wHj9LbF+v0=;
        b=IrL6/xwR2XTIdlGmdJhzvwtHVc5E3zd3W21SQs5WK8zZABvdMiMM1s2Ru/pRrTTzQV
         bsqdQ/kOwRdJVnWvBvPVbEyiIBP90geT+C+S+GMUk8gJWoSLRQ2lxv9EyoohyM/FsQma
         o0PvC50ncj+wUifAEjEqpoY55Qbd6BklhYcGzDxH+OggiQyPNNDKmAE6FqTq33BS8UBt
         Xb4SwGCUuIacixIQAWbaS2S/YjYvnHnYok4akQHeX7llMlTBVN/xmGQJZs8M9NNrvXQv
         Z2rm7VFAvQnMoVvec4mPTKKosRGlscGzjp9WY2U9VbjUoPc1l7R+3ZJHyq8W7904JSgu
         As/A==
X-Forwarded-Encrypted: i=1; AJvYcCVAaQpyw+fOq3wKLGS3cCWx1Bk0OxCJJTxQbRo1agqkEXYxjJ3F0eO3g+kVDH+AONnHPwX9c8EPGvnDCDIuDIHuOXMe6bLqFvgzuCfs
X-Gm-Message-State: AOJu0YyDi6ihMZsDnPm2axldfZaXNECDw/wzCT4ZeY8ekmYUWgpmeiag
	1oOZ+qMxoant1sqt35OY5uzFPRfJMBx8ipLyI58ZE6Ob1uHBVjOSI454Yj2CUkQ=
X-Google-Smtp-Source: AGHT+IEjHAxBxVh5OtjxN2vdFCneVCDEeOmLFcQppDjrnwdgtaLb9VFSu0mgNJ/TFI9Q41H4TYKdiA==
X-Received: by 2002:a05:600c:5117:b0:412:96e2:96aa with SMTP id o23-20020a05600c511700b0041296e296aamr194323wms.28.1708681246371;
        Fri, 23 Feb 2024 01:40:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b004129228da2dsm1676084wmq.31.2024.02.23.01.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:40:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 23 Feb 2024 10:40:40 +0100
Subject: [PATCH] usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-topic-sm8550-upstream-ucsi-no-pdos-v1-1-8900ad510944@linaro.org>
X-B4-Tracking: v=1; b=H4sIABdo2GUC/x3NQQqDMBBA0avIrB1IpzVoryJdhGRSZ2ESMloK4
 t0NLt/m/wOUq7DCuzug8k9Ucmp49B34xaUvo4RmIEMvQ/TELRfxqOs4DAb3oltlt+LuVTBlLCE
 rWorBBWunOBlooVI5yv+ezJ/zvABx+dvKdAAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rAZRRa29e7xVYk8Hc95CB+iUlw9D84lT7pBp2nK1EwU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl2GgdjlLJk4bh0zWaDYCcISwdOQmXeslMUStbkNsY
 ndCVxl6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZdhoHQAKCRB33NvayMhJ0SVsEA
 DDl13NERujQDeoEBdaWpzFTUuOBR6UZhyBlRfdJ6lGVF7r0EUs0b5/KjVyShkVAVcA4liqGODKA+kU
 Kd/6VAUN+nZKU8mqBuwdBqUSrQmmYJR8VVRYG7rtjjjh6/c9XcU2C+2Kd4a2lLnhW0wvkv2dsz39Xp
 YbOJ53ky+sZwGk92lFkDBAIiSx1GJ/IwIZ6myDkBa5pzB8huVte71/4SEJTVUzuZ939eH4v9yHY0XU
 g74E4GMTQiR16vZgZbMgVfG/hM3pi4J7FA86F2UaGofoIRe/FasEhdMdijxAP3uwHqLOf3Rem209E8
 +lwM/HzDmYXb2VOW3NPPnzieEkTOiIYXxquZ1nrY5sKLylqaPWbTapz8wLB/q2CKZ2r3GKlldtTHjo
 pt65I9G1+0eNWNJuloRhGfe5QavHa9yZZI3O9eTmSaMYeBmyrrm+aIsf3YlAYOjKDulr9QgDqil1FN
 pEGeslk+P+uLBy3jjlSw6mKQ7k0epUCXxwK/MX8VbAJ77EUjmMNJCqQcMswyETNOAtqBG5w+OdYpYz
 uOK94ueF4Ro+2Kvb7DYw0yrzbf+UPi3Rx9GzN+nT0BimpL9iToRz8Q/APPlT4Oc2bHgN51q8dr7R1o
 iuunGkz8tVTQy2JRRXyjwd5BV50Gb24zsUxQY6w6SZgM0HSi7TIYimPeQ0MA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

On SM8550 and SM8650 Qualcomm platforms a call to UCSI_GET_PDOS for
non-PD partners will cause a firmware crash with no
easy way to recover from it.

Add UCSI_NO_PARTNER_PDOS quirk for those platform until we find
a way to properly handle the crash.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 0bd3f6dee678..932e7bf69447 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -302,6 +302,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{}
 };
 

---
base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
change-id: 20240223-topic-sm8550-upstream-ucsi-no-pdos-62fdad669f90

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


