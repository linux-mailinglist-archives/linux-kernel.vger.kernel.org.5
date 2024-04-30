Return-Path: <linux-kernel+bounces-163579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875AF8B6D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84DA1C2241F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E63129A9A;
	Tue, 30 Apr 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrIhI0ya"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46D1292D5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466986; cv=none; b=LbkFq9gEV4fMvddnmyeyH0UbjmFihev354sHjqmckHVvHq3H70OjPcMzuZSR06920T5igFkpUWdFtFCIUksveVJ3iYZ6JU2U0W5sTJCeYFeVXRZPfNj7qpBuUGwIJO2ZmXJcZAt7Fkphqsq/7ZspxUi+sGiVqLjKfMEH+KaAcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466986; c=relaxed/simple;
	bh=iTTcOcD771YN8JNfEpuxId3bgcgO2vzqLzc+ZGJPvxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIv3d/XNB25K5Vi5JzDbyz27CqcZXgi2fujE117vCIohkAmMMPYDARY/T80cDrC6FonwfKmxVQNpz6/WcrwaR0fBR9BFLBZXs+9vNh0x6J4A2uChH1SIfPmHXRv7ok1W91XHXccmP4AT8S5vo/sz/vaysTez6yOM5qgW4ew8k5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrIhI0ya; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso38598375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466983; x=1715071783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQtvZgZdjrAiP1VwfMjLFwF/VqcDbqbHsdx/0g1EU3A=;
        b=FrIhI0yalPNOWHzfDXxZpZ3I6LDYPE28FISXEhVeZfWgqH8jXlrneJljqMw5PqP0f0
         Vg1h5YmDD3VJWuaWbI65yeAUbUMAZ7KScUQ7tVsIDXLCcoUVxoVAgcfVqS0GJ4iVbU5g
         Z4WL5L/nitzGyCmrmcxg9+stAR/L8uF7dvrRvNPTSS9r7N8WjxWPIcEe9maLdSJlsksL
         0rGJhaFnlDvm6zl0ZgQER8ps8NqZvqXDC9m0kIgI9dPO3kkrB63zX5abk0E4yB/jO6z5
         pPYpszO46QxzxSWeom4i/tc4NndWlFO2x/Lw/CNZLuagyLk5mWZyTrk4aud/OEiKsWqJ
         u4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466983; x=1715071783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQtvZgZdjrAiP1VwfMjLFwF/VqcDbqbHsdx/0g1EU3A=;
        b=KUxVvtXbCc87HcqV7z69KVt/E6yssKmvOeYUBv476fCM70LROU9LpxjXnjMLxha8Jr
         orSPw3iyDq3SZhPM/1HvjwYQMuR/rdT6c+5XKqMasmRDQgjL+pdAPKg9bV+xdoaSh7qN
         mBkVrzdoYBz/VXZN4RQ55cpvsIwE+XAgElPeZWYQeUPewM8rtiOsA42bDIz/cz7wB6vp
         RSwJ+ygv1VWS7XzYVJaOMpuPCBSBxk3X96sGCutTtDV4Y0wOoGhEy7ruHuf0XOr16Do7
         +bBNQuTokOLBHf99FdTsHAqyMsHRYCz8GSk/87roNXsRjgXVk1rUv2uPE0BsmPTrdi6t
         dUNg==
X-Gm-Message-State: AOJu0YxwxM8d9PEgk4Bdl2ozukAJbyd9kw8Uduvev1LNxBcw9bw9+Jbj
	CgWD3Czw1k38EkTbw6D7i/QuiYtRXJOuil/GzGd07XTn5gTyZ2FXqZ9ipe0aTzjFl/OQKU8MF64
	h
X-Google-Smtp-Source: AGHT+IG1waQTdP8QRJxY3frmq93vrpTwT2iyBt1AFBov0/wQGIj49sFX8WRmkKgz4P/RPW9aohvbHA==
X-Received: by 2002:a05:600c:384d:b0:41b:b013:a2d8 with SMTP id s13-20020a05600c384d00b0041bb013a2d8mr7447197wmr.10.1714466983168;
        Tue, 30 Apr 2024 01:49:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:42 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/11] nvmem: sprd: fix module autoloading
Date: Tue, 30 Apr 2024 09:49:15 +0100
Message-Id: <20240430084921.33387-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=QhEcs1bTND8e51eJbbSp5m8YG46XrvtfgXxNw6FjZnk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCMcwWp4Cozw67o7qIX+vcwDW8DGLIttBLi1 u5OprvH7QqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjAAKCRB6of1ZxzRV N2BlB/0YTHmw6rw5ko2fPcjViI7IXOaaTllJET+kY7eIrmzFEoNLjqP53iP8qxRxOlBzeDaCCjT l2ykePbqMsABxQz0T+c6qv+NwlrNU01fVfB3y2KamMv8WnAqttD+14Q6IA+NQjHu8exqtZeRnEB CTIaOzz7dfmt8OMQWmpdWzE6WazSP68Y29j1qP4AvYPU3rqhUnftlkqpX5Pn4huEMFcDM/YyDBl xfZ1E0kE9hY+2NT7RP9qiGlvGgzJLzkc7/W5Xg/IjyfBpneVz10S9V8z6ihIhY8QCs0ZfnbgcFQ zQKAqrUxb/9XHxWYdrmMUqvf+hAfhO876v82eBK+wqR3ukRF
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index bb3105f3291f..1a7e4e5d8b86 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -426,6 +426,7 @@ static const struct of_device_id sprd_efuse_of_match[] = {
 	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sprd_efuse_of_match);
 
 static struct platform_driver sprd_efuse_driver = {
 	.probe = sprd_efuse_probe,
-- 
2.25.1


