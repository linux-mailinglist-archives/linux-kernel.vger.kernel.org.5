Return-Path: <linux-kernel+bounces-52631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C4849AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5BC1F23066
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3951CAB0;
	Mon,  5 Feb 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2hw3NKa"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6F1BDC4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137122; cv=none; b=bHeib2faQDrDHMkzTLQfBXl2uvTrsWx7ZP9Pe+NeWGVeJYFb+CslpZQEkcWSGry+ko7hX2yGUFpx0MWENmmeI9XrcaHJGjNLNz5SXQQZqVaaZ3uHn+uG9VQYWiQ34YEhKK6EwuAoC+z+4Ajm5Xnsg6i3cmogr1S+A2SvO5vQ8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137122; c=relaxed/simple;
	bh=5qYcJnFoULZlrS/gcnahlbnYI2pJkSgG/5PVWkskUyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpGxy6OCyKGil6GvkQAJfOZCfEMOL7HoimPbi4I8wYzWWlpZWiUiYNZ5LU4glbRzp4g+Thz/KfpflBKrOypxNw4hjWk8AYz/IiALwJsh4fLawxi6g0/fyR6Exx4q1KS5iISwu4MzS0wsciJrsPm05Syz0HaLzFkL3/yGGAQbFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P2hw3NKa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso33499405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137118; x=1707741918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzNCPI2uV4bVb56xzb5sANMJH8iS3z8IvBbUnLuAoXM=;
        b=P2hw3NKaq1enQGTKx8Xp+y30R59TcYUEwyrPNzmf60qNSrTMdh+Q6lgIARgMvxEwLn
         bI3DH/Zon1z4peFqvManSVrxvR/0N3XtUGQqw1zpcq8aei/VgBIcVXPa5jpEqrB5Gnex
         xpvB4CrtiI2ipHwPj3YqaVMO6AwtKH3LBlXY4DKeQRkUEdrP7vFJZa7RJlttrmtjHPLT
         YcGrIzBbpJJy7jDSa27omu69jSBuFZqjfgWY2aI1uWtkKtOStrVu0IKSttiwzFF+gUQw
         wBcQfd2nivcjWgpPe8JtbF/TOlX2yiBSJzWFq9mgxzzU1XbpALTgG8MtsFP9NZOLLV/r
         ghoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137118; x=1707741918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzNCPI2uV4bVb56xzb5sANMJH8iS3z8IvBbUnLuAoXM=;
        b=WCUg+FWoZuHkgUx3YxyR3jrS6xSrWsQ+SyysdqHyFImLrlJgsj4XemofO+XZvMOMIG
         45OjEyMOlSo5rjkSjLNelO4ygRoGvW4SsS3Q1++2608Gmnm6SNuMqeJdr2tXqoJ2B4Ew
         Xdltw1caFfQyCsBKUnxV/25ZEleA63VP71QyRSgnfWGeMRXUfsNAzSwIP36YOukw07l8
         DQXDAK+cHG2SdZvXSow/dhSgyNq3tSEFobnEQ+UEC364mDBlfWt3sJ1eVcFxtkbUanHj
         00lzfkK3WQtAGeYva6stcBKyeqrii4uQrnbQ3+YcP6nEdvWWad0xwfy3JNEDbkdZG87f
         93jA==
X-Gm-Message-State: AOJu0YxT2DUOrtKpBATQmdm0/W5FPh0mGcwL9kRFmOW10ScdvGD3SRkM
	5gFpvQuHIpdpzCri/CirjwqW3FfUzayUbd/0pqCmWTPFnC2KLD6SfUy3DFz7pmI=
X-Google-Smtp-Source: AGHT+IFm8XMhSyOEj6JXeYBZfyH+577pYvFMCZlW+Kw7nOs1uHReXIMhb9GkUoJmry5cYkJROtgeKA==
X-Received: by 2002:a5d:6481:0:b0:33b:1b0b:9354 with SMTP id o1-20020a5d6481000000b0033b1b0b9354mr8296412wri.51.1707137118681;
        Mon, 05 Feb 2024 04:45:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMNK1VDiEGqIAVNlJNMn+ZqV2UzxR+ZQy6PWi6/43efDeJOBNTObVEo1aWIqyi9Q2D3zrFK2uBuiC+kjoOMlWV8H6hFlFvBP6dnJmmkdiaojv1Ms9KR4sIp9xVR1Jg3+EpVR5ZulJUzrHeGoPBoPJQzlc7APQSdiPTy+WS1EkrHwkhLHmvUcasJMnakugFnt5ecVtBolqGBLuzMBIrmNxK91bzMWhX6CHRFyendF7RIEtH12rlYrgowJnLxYD955Pe2G6tzj2wH9FPT/BmD9dBD67Liy4u9JwFRfL/nDdHA7rxOgDtNzg0T7FS+/JTv6LoxCmYqSZm3BkxEapuwlE+CA+5tB87be+Av+GYBR+jWVinHLYtyL2NqyAZ0BvfCVa4FiihxgeVdQpPS3UZjjevD3B9mrOqL6t/A3nzgl0NjJwozlkShAjyHyLyZtc0qwrObZTSJ7LEUsejK5PVghUWfP3q6+6IuJfkCHfl7XUZAzypgZKwbUQ/zKuaUw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:18 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 02/16] spi: s3c64xx: explicitly include <linux/bits.h>
Date: Mon,  5 Feb 2024 12:44:59 +0000
Message-ID: <20240205124513.447875-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses GENMASK() but does not include <linux/bits.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 1224e29572f6 ("spi: s3c64xx: Fix large transfers with DMA")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c1cbc4780a3b..2b5bb7604526 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-- 
2.43.0.594.gd9cf4e227d-goog


