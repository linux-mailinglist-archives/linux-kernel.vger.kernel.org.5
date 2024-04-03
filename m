Return-Path: <linux-kernel+bounces-129308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F402E896903
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F639B2C47B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BD1332B3;
	Wed,  3 Apr 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWrRnUv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508B13329B;
	Wed,  3 Apr 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131918; cv=none; b=TjgzEulotaOgTrXX5jeQ+nN321nImyoN7ffmUSTcraBCfE6sn07m4KoRGA2udEwTFxhThHpu49upJhkrGNpKtbMBbu+gEom9oCGGrt7RtX+1C3DFrsU28hwvw78WDYNdGi2WUoBdj2863ax1aEFbrLQgCYD35UiJ7fMtXiOY1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131918; c=relaxed/simple;
	bh=eTAXLTfSMqPzmGg1LsuyAG1Zp31dv3Dky44SOxHYxuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvz0JBAf2Uo0koZcHoKM74VyVdZFIb408kxpe9ooDm/G4d+umxuMJxdgYohIxSVimq6AYqov/0hGecGOsvQwFeQpW8jxqjy8KEGaSF37WeXH7ELre6JdT5+O+QGF8SA9aga6vq8G+UybWHEz+nN18G5/wVPAo39YDciWkZaWkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWrRnUv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0ADC433C7;
	Wed,  3 Apr 2024 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131918;
	bh=eTAXLTfSMqPzmGg1LsuyAG1Zp31dv3Dky44SOxHYxuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWrRnUv4lYXxKle69MNfRfBQK7ESJOlsoX3+1O6jaAa58kXkx/76YpEzDKxB4A0Kp
	 HYpcT/Kz5LFT66zC94llHyVuTtej8K5hH8XeTdVyHAhvHCAydmsJRkTVMZpmKNQAGp
	 ayrMPDNVedGE1y5Bs39aIdNRSYstABuoExbqWsoiVBOxvFLHgKuFAdOwbpRWgeHtt5
	 mLfyGf3RfYEvyUmLaYJM0ly9RhDoMwCSyJW3C60zerG9frwgZ6tHYBM3JbDcue/FsO
	 wgC4Flt/z8UE7l/iJBMLwf+swLeJIPB8K90gVjaJ8Ex9yFl265ysKntswFJjsdEzK7
	 XhXWqQlQ65q6g==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karel Balej <balejk@matfyz.cz>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-input@vger.kernel.org
Subject: [PATCH 29/34] Input: imagis - remove incorrect ifdef checks
Date: Wed,  3 Apr 2024 10:06:47 +0200
Message-Id: <20240403080702.3509288-30-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_OF is disabled, three variables become unused:

drivers/input/touchscreen/imagis.c:391:39: error: unused variable 'imagis_3032c_data' [-Werror,-Wunused-const-variable]
drivers/input/touchscreen/imagis.c:399:39: error: unused variable 'imagis_3038b_data' [-Werror,-Wunused-const-variable]
drivers/input/touchscreen/imagis.c:407:39: error: unused variable 'imagis_3038c_data' [-Werror,-Wunused-const-variable]

There is no real point in building this driver without CONFIG_OF,
so just remove the #ifdef checks and just always build this to avoids
the warnings.

Fixes: 10ad7d7a428f ("input/touchscreen: imagis: Add support for Imagis IST3038B")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/imagis.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 074dd6c342ec..d09b10f77a19 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -411,7 +411,6 @@ static const struct imagis_properties imagis_3038c_data = {
 	.whoami_val = IST3038C_WHOAMI,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
 	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
 	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
@@ -419,13 +418,12 @@ static const struct of_device_id imagis_of_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imagis_of_match);
-#endif
 
 static struct i2c_driver imagis_ts_driver = {
 	.driver = {
 		.name = "imagis-touchscreen",
 		.pm = pm_sleep_ptr(&imagis_pm_ops),
-		.of_match_table = of_match_ptr(imagis_of_match),
+		.of_match_table = imagis_of_match,
 	},
 	.probe = imagis_probe,
 };
-- 
2.39.2


