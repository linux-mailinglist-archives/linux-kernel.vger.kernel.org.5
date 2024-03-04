Return-Path: <linux-kernel+bounces-91171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEBF870A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7FB283E37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D179946;
	Mon,  4 Mar 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YULSnw4R"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6878B6C;
	Mon,  4 Mar 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580171; cv=none; b=r3cYc8MeNo69IbMdy0Ya4RhXgDryi9+FFYqzkLm0VG3hCNR8AfNl6dBGb9RE4ADTQWqzU13CLwHulri/wdtjyeaa6h2+el0gVLAVgRLvHAIxa6AhQNqJg8kGTJFa7CMhiBEwCpLCF47w/Xk+Z4gQ0E5jxP81r227bubwyFqrvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580171; c=relaxed/simple;
	bh=v7NsgE12NIO1n40LrcHtFd5wa2hSC9XVumdH3Bq/4Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFABminu31mBdejMYfY280J78uEsTc0onBvRCkPpsq2Bl3E5g7zo9CNhLZ9TKhET1nj2t0TVXJz1k2vEgPx9oCuT9YVybBZOPSoLPGPCQabyguxDyspPw6uKUUP/mnvitO/EbQvXx/1pkp99bIWdWw7YXYiSkTED1AYRhtu91Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YULSnw4R; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450bedffdfso218312166b.3;
        Mon, 04 Mar 2024 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580168; x=1710184968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSgRd3+kEex/VGylgSWmd7x56h+mIL9y73UIdt/cAHo=;
        b=YULSnw4RRZGb4oBaLeNvcrrXn415HOTdXXp7oC3GKy6u2eWPpK44rPODBcyuseAhUg
         16tXD7/3a4AgE1EUekUEmDBDjuiddSWOYk/d3y0McX9ot7J8qQ9rJ1nNeeSJ6NQrpV0i
         i/t+M1NjQImeZv0cWVLSfVwrFTPXjptN6AyArtoVViZoV6X/uke7mCoFKOQcrNVOjJdj
         V84iD8b0CtfddZcWs8WFXgSzgkdZgz5QWWXCRYOg0B1TQYrk2kbjQ+vbmg0yn4OXvKGZ
         ZuBAIVz5xeOhgEq59oSYz+Auq9fjUgEs50tYF1VAnEeQ7/pSSzyWb4eWvpmFSaDOy39y
         3oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580168; x=1710184968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSgRd3+kEex/VGylgSWmd7x56h+mIL9y73UIdt/cAHo=;
        b=EfgEisQhljq4jF80uImeFG+E8C58jaT6uvZSLUwQdZ9pnJUAeMHC4DtwxlgSDE1k55
         cPcS4iLVRosqNMq62//ZItyZFtIEbZ2qXTSnBUS2bRPhmWcDH1gP+ytqE66T+a/GGV5r
         7xnnKmd2aWRfp8adf7f3i53sXatRq5nv3+MZ7jDexY0y9uRyUxDGdxYP1Mx/6M2jnG5y
         CZqdSqHvDbbKGA5K3rc9BG5GZfG33uq/KXAIbmvQ0s/uoePkSamopDouz7DqTw8ZWS/4
         GR28t4xQGXn51acxi4XS56qcFVdkHwYussFpZAMS7xKuCVbLuXVAimEFrby/IyGbKUWi
         k4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUJr7i1J4kwrONp8qsliOhZoRM6e9IZ+2KmRJXqS2p2hVzho9te5McOze4WV0BqdfAtn/wRDaabJwfqcdwm5BmC3O0hVskZL8cQxCXRP/+YeuKXexw/f+LErlt4ciu+Y0xZwnfQNb4z8Mlb1Tvhd0Rnnf9d5eE9DvArJfFoFXZaMpvWgA==
X-Gm-Message-State: AOJu0YylWvSP7On80g1Gl6Xp7Z7sxsrgSVDCIiTiRJcCSNyj1WQcwhQM
	TpusPhUZiupv9Qrf1mTQaOKyk0u9F130OgzARroESgJ/8b8VGjye
X-Google-Smtp-Source: AGHT+IEMeWdaCa2Icccuwu+EQtJbWZHKRLaAfV37YsxF3ct+Lxhr4SAeYUBJ4ZKngg9+daMZa8+YmQ==
X-Received: by 2002:a17:906:c49:b0:a3f:173a:224c with SMTP id t9-20020a1709060c4900b00a3f173a224cmr6063996ejf.51.1709580167640;
        Mon, 04 Mar 2024 11:22:47 -0800 (PST)
Received: from fedora.. (cpe-94-253-164-177.zg.cable.xnet.hr. [94.253.164.177])
        by smtp.googlemail.com with ESMTPSA id f8-20020a17090660c800b00a45a09e7e23sm26320ejk.136.2024.03.04.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:22:47 -0800 (PST)
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
Subject: [PATCH net] net: phy: qca807x: fix compilation when CONFIG_GPIOLIB is not set
Date: Mon,  4 Mar 2024 20:21:36 +0100
Message-ID: <20240304192244.2924407-1-robimarko@gmail.com>
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
 drivers/net/phy/qcom/qca807x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 780c28e2e4aa..62c01076b506 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -732,7 +732,7 @@ static int qca807x_probe(struct phy_device *phydev)
 	priv->dac_disable_bias_current_tweak = of_property_read_bool(node,
 								     "qcom,dac-disable-bias-current-tweak");
 
-	if (IS_ENABLED(CONFIG_GPIOLIB)) {
+#if IS_ENABLED(CONFIG_GPIOLIB)
 		/* Make sure we don't have mixed leds node and gpio-controller
 		 * to prevent registering leds and having gpio-controller usage
 		 * conflicting with them.
@@ -749,7 +749,7 @@ static int qca807x_probe(struct phy_device *phydev)
 			if (ret)
 				return ret;
 		}
-	}
+#endif
 
 	/* Attach SFP bus on combo port*/
 	if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
-- 
2.44.0


