Return-Path: <linux-kernel+bounces-138299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A10F89EF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1496F284E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757E156861;
	Wed, 10 Apr 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G03OLYCa"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8744D59F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743571; cv=none; b=Gjk57GTHjZ8Q7vFCLrYDn0xSw0jhlt4S9w6OzdbSIeqRd3fPEEzbDQpgrfAPq6LSuiWxHmQAtEZ2xMymAVeKRvAUqWrRhL8kXJTCyEzpFAEXD/j+FGA3ZH1+eNB8kasErb9D9rwia1mVp+DzjBSpHcBP1HIajbZinJqNQqHW6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743571; c=relaxed/simple;
	bh=j7jhjPXzHWwRadactMkVoJM5y4LJns+b5jjXbm6w+Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gQe6hpgYrxHoMoSO1f+3o7/gc2TnzQ7Qc61XHZXhwsY3Y1wmgS20xZQnUlV4bqaca1RACyNMXhJeQtkcvhEqDPlBEVYl9vZC7Q0Q2xqqIQwX3NXqjMU3SyBff9H98n0vJ8oWeEbhMeGu7TZIOS0QfVo/Kv5GsW7TJi/CNDPt0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G03OLYCa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a5ef566c7aso100896a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712743569; x=1713348369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1LpKFL+yI+IpX+c47vgJ/x998fTDNJ7BUtB4SB1yXE=;
        b=G03OLYCabSasZG4X0lQPnSwxyswsZ5dXyZ1vMfV2pfL64kL2NSTIHSIcBW3nEXK69W
         edCg2jhxwSwDUYpmW03kpPh6lUkH+mlBYTVi4BnAcOoSXJgTR/9sIeIG2EOybpFvXapM
         UkTE+DUXtWQAE14Ov4oKzLmhn1NbM58cRqn8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712743569; x=1713348369;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1LpKFL+yI+IpX+c47vgJ/x998fTDNJ7BUtB4SB1yXE=;
        b=QfMDF+DC1mIuuRiTgYChvegg+WCWxqQYT76UangaeCjq8cCXqhLNp4Kna6flA+dGTo
         j8nVDnEHQ1qOsIXY15q3sDnjFV075q7rQNTLprn5NwAQw1a+kQMm+j4aHiYpId+MW8Vb
         Vs5TFUk0CLry5faIQrgalmK81xzQbTN1h/ZmhwOEv1LxHrsrSGAJ10eGpTLwC0dwHcLL
         M+KAwwpaTS3CEqVkfSvuqh8wcGxIjE87dK7U3CZr6vk2cIfZ+QCQNJyP5GLHjlTFPqGL
         VR7NgsAOtsOAnPWXvgx3ZsSjs6+jthfoM0p5HlX9MMsDYgoMOrcV1/LwgX121xhXBtSj
         qY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVUII9sx3LBYW7yMH9hGSRiZJ1zoVdHqSXjQo3i10Z3EMfm7DBghmx++u/30bfOl/mKao703yvgtzVN+xrRI4jVZwjhE4Va1IEqvLX
X-Gm-Message-State: AOJu0YxY8Jay/I2Zi+qi+gfTB9330H14+N1J+rSYlRueA91V8KV01AmK
	u1Kkba8IKGAyyRbtyf/MkMwPgWEv3blYAL8R4u3E0+vtDvrit1y1IxYd/TZbJw==
X-Google-Smtp-Source: AGHT+IEgWW/yvuflbCPPd3wcdtqJfAQHQgU5ksKHqoN0JvvBwSkc10gWcYuN/ly4S2nYghQ9sKh4yg==
X-Received: by 2002:a17:90a:e514:b0:2a2:672f:ef66 with SMTP id t20-20020a17090ae51400b002a2672fef66mr1861559pjy.7.1712743569253;
        Wed, 10 Apr 2024 03:06:09 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090a740b00b002a4ce78e3e8sm1014434pjg.35.2024.04.10.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 03:06:08 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 10:06:04 +0000
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Add coeff for
 mt8192
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-lvts_thermal-v1-1-ee50b29c1756@chromium.org>
X-B4-Tracking: v=1; b=H4sIAItkFmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0MD3ZyykuL4kozUotzEHF3jFGMzUwsT88TktDQloJaCotS0zAqwcdG
 xtbUAtac9M14AAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

In order for lvts_raw_to_temp to function properly on mt8192,
temperature coefficients for mt8192 need to be added.

Fixes: 288732242db4 ("thermal/drivers/mediatek/lvts_thermal: Add mt8192 support")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a6..6d226c3e135ca 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,6 +80,8 @@
 #define LVTS_SENSOR_MAX				4
 #define LVTS_GOLDEN_TEMP_MAX		62
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
+#define LVTS_COEFF_A_MT8192			-250460
+#define LVTS_COEFF_B_MT8192			250460
 #define LVTS_COEFF_A_MT8195			-250460
 #define LVTS_COEFF_B_MT8195			250460
 #define LVTS_COEFF_A_MT7988			-204650
@@ -1530,11 +1532,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8192,
+	.temp_offset	= LVTS_COEFF_B_MT8192,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8192,
+	.temp_offset	= LVTS_COEFF_B_MT8192,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {

---
base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
change-id: 20240410-lvts_thermal-3d365847acff

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


