Return-Path: <linux-kernel+bounces-163581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B988B6D50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727EC283F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB313AD2F;
	Tue, 30 Apr 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ix2hw3dQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCD12C534
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466991; cv=none; b=BdnVT48TjZdKov7ARr8GQlRyHJWW2GJ/C3ynZjZk5xHbCnfxZeqBF3ePeMVlt6m+Sqzs1dUn/fQX2Qt3d2ejwweZul+q7VKmfeJQzSqCIA3q78mlJ4xRx8B0BOeCDCJ9Tw1TjEnOVo4EZO8a5zc7BhxX5PVuPCyb8Ziva28GxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466991; c=relaxed/simple;
	bh=/0mOQX9z4RM8MzW8+jhlHbyoqWmRQOcez9LVcdlJ/bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoVtzOnK/+I2ZLF0XH3cD1otc3uE+D0N/XJzv431YOyw6f1CMaA34b3wvtXoMqQB/rJYcJ3wsis106Zep+BSPyN5J73W5fK7Z4f++5TVXz68sZuYdXJ91BwxoJKYwa8dvhfB4HYbXdCp/lDW9Wgh2p1Y0uNvIVUnjE/8z+GTpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ix2hw3dQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41adf155cffso40023965e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466988; x=1715071788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geXfuNKOZIVHM39x/POn6vwf0rlhafOMzFww1pqak90=;
        b=ix2hw3dQTLUClqhCpPSvH4Wrv0lEmG10zKALNl8Qu9ebeO1qM6UOa1+h99IbwXTv6H
         8KuDPTSXINIgUOlqrlQJKG+zCQ5qa3O0z5tqZyYRjaa2iq8M0FIcD5Te4b5knpeXA+Gz
         ZhaUdwr4o57iOdT1o79CB05YB21NlLt0cSdy24pAxONr0043FxCso6ue/NP4FxnwtiAw
         GUxlxguD1kVbjgzbGhk6aLmO2F62XZ+YwCy1bOv2jkOj1vnghWFVg7Li1BIqjRXaMH5s
         2DafM58q4JgDd1lYD+TvLkg/BNNOOiXJ93bddui4MtCLZESZr5v32wCdoB9ifFEzcTpf
         Ew/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466988; x=1715071788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geXfuNKOZIVHM39x/POn6vwf0rlhafOMzFww1pqak90=;
        b=EreWrkEUcg5gLbEX/hr4hUaD4QfIrxWA87vwyOZRROr8ktoka+0eYKDDlZxPaalO5d
         DcKOPXiL/n+18TqargDIo+hjY/C9XUIQT2p7EsME8LDPeZQ0pLk4RKH4cYJW8wh7m8Ix
         vFicpdt1b91Sm7PrZucwRqnsZcGZcAfync7Rcv5SzAlNBceoMGouXDTQarIUFpXGIbaA
         lBV0JYfI9WZyvgTP4H0t5v6U47/VU3pAezBqU2+RBI+zqPeEumGCqmrNrCoXciCmtYAE
         hk86Ex+wkH9eQuUG0QYWXGTN8gHspM4Ivava97EjbcsoDCy0DGY5Xad5AdGZBd5YhNH/
         iQjw==
X-Gm-Message-State: AOJu0Ywy6jUZMwG64h8LGSb9ercm4QnzO9EgE4CFr977zQCe2VxM6flg
	FndvT6FTsRTHkFszZEM69IG+yvMVQWCwIOvls6/hmQTvNQa8VPrFBcQ0ox20sDiAGxo+Bnwcpl4
	R
X-Google-Smtp-Source: AGHT+IFOJHPFC6k/gpAMDykQQrnWyuZuIpWTcAe2KAsu7+3/RCR3TQlEF2KxlI0pQSJ/CcxasomL2A==
X-Received: by 2002:a05:600c:4587:b0:41c:15d:98ac with SMTP id r7-20020a05600c458700b0041c015d98acmr5658873wmo.11.1714466987794;
        Tue, 30 Apr 2024 01:49:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:46 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/11] nvmem: lpc18xx_eeprom: Convert to platform remove callback returning void
Date: Tue, 30 Apr 2024 09:49:17 +0100
Message-Id: <20240430084921.33387-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ajCEvWwfTwYfcnm7t2NUL1o4f/llfr7RXl6U2Xe6fUs=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCN63e/MA0eRRnbkRDSvWQD0YeWOM0UlD4Wn EEigitKErqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjQAKCRB6of1ZxzRV NxRtB/4pl6pZnzIRi3xX9fm/+Haqa92QLwexDSEB5mbXDx9soSakRf7AROoEzpSlaQlwdggHrcK qc/HIQeNyJxig1c/VulTjHGitHsqL7oIeFSf0qyTw/vXOj83KHbn1sNiL7SOEn/Qm3Ho2obk9wj PDihJwkJcmkeDIC0kdakvycs5wzN74JhY5YByCOw0rvZ9wPtP+ga9067xlzdP8Zw8bY5vKJn5er ASkV6uz4JRSxPVPh9Bbu6XUf9KuEHBFEHoOfa48SJJ2Dx+aHW2Cy4EsI6JQSB/HZHjD3nGdofkn 2191hK6QFDlbW3NU68LL+PKEp3BKnzMxMmu/XKWqC4J9WauT
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/lpc18xx_eeprom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index a0275b29afd5..a73acc7377d2 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -249,13 +249,11 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lpc18xx_eeprom_remove(struct platform_device *pdev)
+static void lpc18xx_eeprom_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(eeprom->clk);
-
-	return 0;
 }
 
 static const struct of_device_id lpc18xx_eeprom_of_match[] = {
@@ -266,7 +264,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_eeprom_of_match);
 
 static struct platform_driver lpc18xx_eeprom_driver = {
 	.probe = lpc18xx_eeprom_probe,
-	.remove = lpc18xx_eeprom_remove,
+	.remove_new = lpc18xx_eeprom_remove,
 	.driver = {
 		.name = "lpc18xx-eeprom",
 		.of_match_table = lpc18xx_eeprom_of_match,
-- 
2.25.1


