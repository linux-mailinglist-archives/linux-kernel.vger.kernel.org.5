Return-Path: <linux-kernel+bounces-121738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D688ED24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11B11C30012
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595914EC53;
	Wed, 27 Mar 2024 17:46:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2014E2E7;
	Wed, 27 Mar 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561604; cv=none; b=iD7lO/4fZTk2FLpw4NuMYuzIlIDaqcx257gokphfgb5zycvd2wpqtj1a8xQ73RNSLPcHe8gNhTDKuiusBYeg0yfojEAGY/TAXWkleekA0UsupW0AVE1ZT26Tdy94lzO4J4dtCb8bKPICvl2A7np8/yc4GOgfFJmBIyqOrWx9iUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561604; c=relaxed/simple;
	bh=XN3G2xFD1jz0E5RTJppOWDoQwF4H3/52tfM/dRti1vE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMFAXXbtmdGQS3YaUzX1aJlkQ24ISaE3GvOT2j+ix1DVIpupybjeJ7a2Zh2UouRGTTA+laZFezSJFPlB9KK/NLcQFPZ3d7YaIig0c+Hn+JyfAWDXiY1iSErzmXAvbFbcvPJ80WPXRd9fNHGs3YXah4P8puFz67AWF5OLxVBzMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2692CC433F1;
	Wed, 27 Mar 2024 17:46:41 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] watchdog: mtx-1: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:46:38 +0100
Message-Id: <20240327174638.519445-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/watchdog/mtx-1_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 152e41ecbb14..06756135033d 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -236,7 +236,6 @@ static struct platform_driver mtx1_wdt_driver = {
 	.probe = mtx1_wdt_probe,
 	.remove_new = mtx1_wdt_remove,
 	.driver.name = "mtx1-wdt",
-	.driver.owner = THIS_MODULE,
 };
 
 module_platform_driver(mtx1_wdt_driver);
-- 
2.34.1


