Return-Path: <linux-kernel+bounces-114564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962B888B14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDFC1F275C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F94297D76;
	Sun, 24 Mar 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PklAE7Wh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF61FD5C5;
	Sun, 24 Mar 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322210; cv=none; b=BqA3D+neBAdwfvvfusYy32E77TUopnTv6vSnJ53EkGWcqdS9cfZ6+e2y71taDJ/rTmcdj8Qe9lR8gWvGscqwVj3/6HrlJfwF7ixFdyjzhrVdrBDu6hwZ54Ko1sUTd4sQ2NfM+zpAIt6H0U6iGr5kNCnVxuALRc9JjB53WZRP9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322210; c=relaxed/simple;
	bh=ZuBDzA0LJ2LWcinmQ68PW2D0/5IeWTgCwZspXksVE5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgYx+kAqjYjeKreLZKeyUYBu42fs/pBfTMRLg3OSKM5Ulfr9XTm88kngK6c48FpvSg2DGhjPEOJuLweRU0eai8GyJwBfYFcH7yJeMkuyDDyMpX11pD0VRiSS490JfyfliGZaZjQxGMyys5YhxdYquPvJX3yMAlX+cHeI35mT1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PklAE7Wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779C8C433F1;
	Sun, 24 Mar 2024 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322209;
	bh=ZuBDzA0LJ2LWcinmQ68PW2D0/5IeWTgCwZspXksVE5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PklAE7WhwOnlvpxRAui5Ra2sVnsZ9OBwKy/bASknWv+LP6uPB05+IM11Oes8jYwUN
	 FP6wjRlBZ6SfUFCNV3uRduQgKvV6kg1UPJ9szqDcpZtCt/qrym8ZIx8MLKXNOH8g6D
	 brx1cYM/YwqgWftGCiiULYyrecSk9UGv8U6pxsd9e3s2nmK6IZnAFUVrUC2e4qrCTw
	 Wy/yS3mnKdTaeXCVaRY3ifJrutlAja3zrgcCVp8nx6vNT9HvLT8KQL1+chAw7gK6WR
	 HnjxBFyzbrfwsgIe9n07W5gOmaeU7EplZJchUQzggdIV0IZ4SyxAyTh+nxFRVBTDNn
	 VG2UNyERShDxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 289/451] ASoC: meson: aiu: fix function pointer type mismatch
Date: Sun, 24 Mar 2024 19:09:25 -0400
Message-ID: <20240324231207.1351418-290-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 98ac85a00f31d2e9d5452b825a9ed0153d934043 ]

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

sound/soc/meson/aiu.c:243:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  243 |                                        (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Link: https://msgid.link/r/20240213215807.3326688-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/aiu.c | 19 ++++---------------
 sound/soc/meson/aiu.h |  1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 88e611e64d14f..077b9c0b6c4ca 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -218,11 +218,12 @@ static const char * const aiu_spdif_ids[] = {
 static int aiu_clk_get(struct device *dev)
 {
 	struct aiu *aiu = dev_get_drvdata(dev);
+	struct clk *pclk;
 	int ret;
 
-	aiu->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(aiu->pclk))
-		return dev_err_probe(dev, PTR_ERR(aiu->pclk), "Can't get the aiu pclk\n");
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "Can't get the aiu pclk\n");
 
 	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
 	if (IS_ERR(aiu->spdif_mclk))
@@ -239,18 +240,6 @@ static int aiu_clk_get(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
 
-	ret = clk_prepare_enable(aiu->pclk);
-	if (ret) {
-		dev_err(dev, "peripheral clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       aiu->pclk);
-	if (ret)
-		dev_err(dev, "failed to add reset action on pclk");
-
 	return ret;
 }
 
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 393b6c2307e49..0f94c8bf60818 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -33,7 +33,6 @@ struct aiu_platform_data {
 };
 
 struct aiu {
-	struct clk *pclk;
 	struct clk *spdif_mclk;
 	struct aiu_interface i2s;
 	struct aiu_interface spdif;
-- 
2.43.0


