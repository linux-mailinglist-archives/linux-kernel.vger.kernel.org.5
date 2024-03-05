Return-Path: <linux-kernel+bounces-92509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7976D87215F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194E91F22340
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AC98664C;
	Tue,  5 Mar 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA3uTBDR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6168662A;
	Tue,  5 Mar 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648480; cv=none; b=IyohiVyw81sAo9HUnd7hN2XZb6QepgH4v5WDnJZVrU/lM/9WcMqMGSu/VkOxJ+cai0WStIYfWaRaNqmQDpAJpTQ3IaBqvQNC4OZgBqKZXLjxFZ9F4qh2DRW2BMU6NKeUf7S+nF5+K2ehfFcwEZDCi+ITKnXaw/Gd5mq4qR2HAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648480; c=relaxed/simple;
	bh=4wsJ1D/gACw9m0Q0mBOCLnDEJZilKXztwEPm8R1Dap4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlwpfNwnlfC6JGpWPozjBt0zqr5dkb/KvVQPDSTg88YU3goiZ6PtDyRhbovZRVfBxUKtwNbygQUI3mY0fsivlb6clesIfDnZkwTVozsVSICbJ5MGDIpqennHviWCUCGpWdAqtwGlXs+ylu/Ixd00nekWlrKIj1n7LrJDiGKgfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA3uTBDR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so111068966b.0;
        Tue, 05 Mar 2024 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709648477; x=1710253277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4wSy7E3YJQQeA67cWPwwJxebVYn1l0HIVjiXiLQflo=;
        b=hA3uTBDR1ksY8Ege0wfgq7r1biweRyaGcq2wgpNuA/wJ2h8Gjk83WUMMBOKyh3pysO
         5Thw9Twq+4/Bo2dp0XE3mnbPdAL9bQuro53SEFhWOpwFPW+2hHM/TtgsW2U/kQBZM3pw
         sYdhsJPuwTTm3YmIkQ7voHUr+OypJk6tSw8ON9Kw+Wazm8sOqko59oDRHj7hSQKESeKi
         8nW2VRRQErADN7lfVbz62Ufc+bSkBGGqSOchLP2gTCJbk3Nj3wkjbzLJkCIMQEhl9k3k
         WEEkFcjjt22MdA3ueV1Qdp92ItunJgVhY+vDJMz4yLdDyAXHpKDvEdRH4XIF/fh9rDLX
         acZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648477; x=1710253277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4wSy7E3YJQQeA67cWPwwJxebVYn1l0HIVjiXiLQflo=;
        b=XKjRffFC11HN+HgNrTGfsmx8Vtn+Zd8TPHWNOd6Tn9+bjd/WSEg9dgxtoPv2He2r0N
         BJDpr5Ku2Q6ED4oxLF/tfI5rPL51VwLVUN91caSJtAQoH27RgN9PJO3nEPhFkOWRfAqi
         v/gqmzOcoJNlQrxWgGcc01guEsoUbbq5zao9cWyIIYsare3prMlMO/9DAQcKrrB6+Kxi
         YI4f3o8ZuI5lsAwA1SCxgFr70A/AdbAXlV4UHZoRAdEAfUpeenyStO+iEpapNYGOcvlt
         /ME9c28n+Lcsapp9AJt8H/CzNLZ7Bpk2CaA1ZD/dHIE53A9+bt9C35gRp4WbMXHBQvZG
         mEHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/rOl8vNBpf11TWiVjepoiGsvp02Aom4F4YqqgFFuLvT0WbQ4f0S8pv+Pklcqrcz6lcyDqv/E+m10okvrvLcTBDHowECMHRSygcFR5yCxyC9ZN6S8lMczmUTI+JJ7ctoObsq46hx0nJXV/sIPf92TyJvA5L1PTXe5fduNP9jyHq4uq8Q==
X-Gm-Message-State: AOJu0Yx0OA9+BjK2Qn8yBK8mYSbXt+WVCyV36FcrVMR2oINt+oDmCoSh
	HbK0SZzzdohK8K6S0utk7ofG6ip4buJkNyy0uROzvACRRRFF5UT4
X-Google-Smtp-Source: AGHT+IFUK19xyeHDaX7M9KvSwKFpva6VNgisudcPFsUdhCKxLODsoNp+jjPI+KJMcT6WSAhre3/T/A==
X-Received: by 2002:a17:906:4ecb:b0:a44:cd5f:9762 with SMTP id i11-20020a1709064ecb00b00a44cd5f9762mr6552774ejv.54.1709648476389;
        Tue, 05 Mar 2024 06:21:16 -0800 (PST)
Received: from fedora.. (d-zg1-234.globalnet.hr. [213.149.36.248])
        by smtp.googlemail.com with ESMTPSA id k13-20020a1709067acd00b00a44f3fb4f07sm3597969ejo.191.2024.03.05.06.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 06:21:15 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v3] net: phy: qca807x: fix compilation when CONFIG_GPIOLIB is not set
Date: Tue,  5 Mar 2024 15:20:33 +0100
Message-ID: <20240305142113.795005-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel bot has discovered that if CONFIG_GPIOLIB is not set compilation
will fail.

Upon investigation the issue is that qca807x_gpio() is guarded by a
preprocessor check but then it is called under
if (IS_ENABLED(CONFIG_GPIOLIB)) in the probe call so the compiler will
error out since qca807x_gpio() has not been declared if CONFIG_GPIOLIB has
not been set.

Fixes: d1cb613efbd3 ("net: phy: qcom: add support for QCA807x PHY Family")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403031332.IGAbZzwq-lkp@intel.com/
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Target net-next tree
Changes in v2:
* Reduce the code indent level

 drivers/net/phy/qcom/qca807x.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 780c28e2e4aa..672c6929119a 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -732,24 +732,24 @@ static int qca807x_probe(struct phy_device *phydev)
 	priv->dac_disable_bias_current_tweak = of_property_read_bool(node,
 								     "qcom,dac-disable-bias-current-tweak");
 
-	if (IS_ENABLED(CONFIG_GPIOLIB)) {
-		/* Make sure we don't have mixed leds node and gpio-controller
-		 * to prevent registering leds and having gpio-controller usage
-		 * conflicting with them.
-		 */
-		if (of_find_property(node, "leds", NULL) &&
-		    of_find_property(node, "gpio-controller", NULL)) {
-			phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
-			return -EINVAL;
-		}
+#if IS_ENABLED(CONFIG_GPIOLIB)
+	/* Make sure we don't have mixed leds node and gpio-controller
+	 * to prevent registering leds and having gpio-controller usage
+	 * conflicting with them.
+	 */
+	if (of_find_property(node, "leds", NULL) &&
+	    of_find_property(node, "gpio-controller", NULL)) {
+		phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
+		return -EINVAL;
+	}
 
-		/* Do not register a GPIO controller unless flagged for it */
-		if (of_property_read_bool(node, "gpio-controller")) {
-			ret = qca807x_gpio(phydev);
-			if (ret)
-				return ret;
-		}
+	/* Do not register a GPIO controller unless flagged for it */
+	if (of_property_read_bool(node, "gpio-controller")) {
+		ret = qca807x_gpio(phydev);
+		if (ret)
+			return ret;
 	}
+#endif
 
 	/* Attach SFP bus on combo port*/
 	if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
-- 
2.44.0


