Return-Path: <linux-kernel+bounces-79614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280428624B3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59ED01C21B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1E4C62A;
	Sat, 24 Feb 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5AWNTxo"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D7481DD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775158; cv=none; b=MGuQQDQR1t2DRE3G9f0SeQ5f9tpSTJZV7+rURIUnCiS+lNg7dwePnF9l5h+ZhLX5yHbbaUV1XrxS6yJ0/+pH4Ykj3yMyNKLf6aOfkPxq/bizJNjJ9cpAmaT9K6wwFkHKGkxcVLIqOF5gRblcdL00y8actKlYjGbO37UOOGLpF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775158; c=relaxed/simple;
	bh=LM+xTq6J4+xN/3hkhq0Y8g9M/pd/4r9GnJzSkbJ03lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q43u2acp0GBPWYU+fXoFAOc+eUkmdReU3uttBTN9Y6f6vpGIxt3dux35dYEEHCAmTst4vkNfmSEC65bMqL5ScSF4ol3h2gXMfAnYXjvu1kwlrIHpOJQh/Yslbp2uMwZ6sLWuOZ4Rs/zlMKZQNlQFq1KQHTDO4UUAcjwYzvaYA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5AWNTxo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so151274566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775155; x=1709379955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y492RWEJd5wja5KAvcbQOaDOMx8y5RKUhmHOdEQLHO0=;
        b=J5AWNTxop2RDkptAX2nvIAIuSz+2DOVXOtSreC06ZCmveGDTJDipw+U9NzBTkKxTnM
         WV35HPtCe/w093DGNEJKg22URcSJ875p+iaY61DeDJfyvpyPP+WSDqnFvBZi8r2lX/Pq
         2EqSkZCJjdpv2g9IpTSZ20A3gxsmWdsdJdLbTHW1vbJkWvUsyFuhwbxRy09jBYhmkaG/
         YvlWZoqRcoQnEUMxV4VEiXrIi0u7lyi2txaWn87xHmdG+3r/JtTq8znan1OXpjbujVTW
         /stZ1s/LbhPGQ4AEzsz7GA9Ej9P7b7arj7wVZqwH+eOxelzJYC058FpzGHmBn2T+I9sP
         PkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775155; x=1709379955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y492RWEJd5wja5KAvcbQOaDOMx8y5RKUhmHOdEQLHO0=;
        b=w6yNN25q9ZwaNMl4J2RMokB0zv9aIZgMJT2Tl/dPecQZ8fxIuckPlBT9W9/tUHf4jW
         pUlX3oKAFKmX2R0uSmJB162qNA7ntUp8Xv7bscYJovA1jhHmCmWjnav7nv1WkAiwrh6A
         n/6eLENtcm5HuLG+eBGLXIOg5bz1nd+2X26hYWI1xu06Jb4k/0dkxXNoBYVR0BTIHMLM
         BQLnrmgYjxwjvkt0F91aVB0Qd3tlMxuo9vpNfYFjpS4vrCZpgjub30gfYHnx7IQxKiNe
         Tfkki6omvFdVbSloaZksMZjZTa6vCR4HhbusLYMqbLd4kGE9tnyKAUi2A6h+oUHUszru
         hDKg==
X-Gm-Message-State: AOJu0YxCHoSm0lzsqkAKcBiIaqw9pVw2v9Aqwzl9yHU2dLSwwyWKIIyG
	Swzs/uTX34sCfzsPUYCFJxeKlWEb9cu9kvSmbIDjHNxKVbhytZzpVcAbD0JtfeI=
X-Google-Smtp-Source: AGHT+IEvsWSLpUvE2emfWWoeL244tfryAtqxA1MiHgED0xCYxfcys/V2Z8HsAz2sONw5a5j85EI3Ng==
X-Received: by 2002:a17:906:c448:b0:a3e:9e4d:dafb with SMTP id ck8-20020a170906c44800b00a3e9e4ddafbmr1336122ejb.29.1708775155042;
        Sat, 24 Feb 2024 03:45:55 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:54 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/11] nvmem: core: Print error on wrong bits DT property
Date: Sat, 24 Feb 2024 11:45:16 +0000
Message-Id: <20240224114516.86365-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=uroTY94WYSRKwirx4GTT/pxJsWbg17Tq/2L7JU2HVts=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbM9vgaNdhVQEZmZBLe9WFY1YItaepN6vO/N t1fl0xkOKiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWzAAKCRB6of1ZxzRV N21CCACZw7dzFNz2c+Re7cGe52bU1nOZIU1SflLg8Nayn7PrEGrDbAhu5rvye+voYX/rxJ53GV3 VcGABSvqlIh/vAYBlmCAJGFGmR+7eZsj7GTmzREqhNFX3/Sa0dYavhxqwV7PCuIS7f3kXzHmTQB SsK6F9l739Ev+3AYMjz0WdemRzIL7rKA8uABZLQFGweCG19Ugy2JNper9Sv0128qunofkyjPmXQ x+I+zEb7dX1o6umTUV8pOtsl0v96d3hmnInsLc15nL6KuVPfZD0Zxmljp0MVNKggmkY3MrxuBue XogfKiIuhwL/vLLaNNfV4X3ahVjqhM0d8xNcuN4aaD0wGi/K
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Markus Schneider-Pargmann <msp@baylibre.com>

The algorithms in nvmem core are built with the constraint that
bit_offset < 8. If bit_offset is greater the results are wrong. Print an
error if the devicetree 'bits' property is outside of the valid range
and abort parsing.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 980123fb4dde..a9832b5a608e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -806,6 +806,11 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		if (addr && len == (2 * sizeof(u32))) {
 			info.bit_offset = be32_to_cpup(addr++);
 			info.nbits = be32_to_cpup(addr);
+			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
+				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
 		}
 
 		info.np = of_node_get(child);
-- 
2.25.1


