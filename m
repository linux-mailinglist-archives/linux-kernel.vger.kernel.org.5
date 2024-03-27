Return-Path: <linux-kernel+bounces-120376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCED88D666
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5F11C235A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A152C1AE;
	Wed, 27 Mar 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDis3yhQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083F2557E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521126; cv=none; b=Z/I7JXYVSnAFECOb4fv/YkiAhfVg+CiYg+eDKnZNRCCNALYjsVIYxGsuMP2nvezMqMgOe8z9mxzE7hz+1E/JuB0xwtkrkZqEDnSXwBVoiOlwWaHeHwjTqwu7vLt7ARgRGkZZ0oHVFqozBQoKY8DIL2wm53BFWY3ibFQLwoS+U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521126; c=relaxed/simple;
	bh=4Ya6dMmudtxYNTl823jMJouUofxDkL1bOiUAsKX9Kv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuAdt0RqA3e6lac3aJd5lfLWvtBfs1UAi27OnTUptTQYCBqtAEM8dyOoiK47CbGBNtv7zTqgSqVpd68UxO46JQ4/FJLbXySI9sa3bErHWtGYSBGDcauueLNySLoMqR6lMvHtWDFyGcXfyNFDFJrB+0tD5ekQwaiPErUQvWf7oMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDis3yhQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4149319511fso2421675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521124; x=1712125924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXMHtvsJsvcQqDicqUMe4VBvDRS5p7vk0mv1oCDMNgk=;
        b=IDis3yhQh9Q9ydmY40DZQSuKNlfNMwEngv3ZlQZI/Byxjnoabum8kj5wdvfy55NbVs
         V1zajgqdL7K87U0Wa+uaxBzYll6bSCm13Jni1413AO7g5MmMmLtvzZm0/y/L0MLe0lt5
         lXK71UrPMA+jPUWXwS21F8jt+YWnMdLpFddYNmiAgcf8rZyoLLybZGUF/vRBUXtJ9msu
         YMfhAvcGVTsXqkwBhMb5N7Avpnrf29/IJ+B5Eh+/QLMvRLVBJ28oN4CdP0AtLzoVMlHU
         Dz6pslRe+prgJdZnZ4HpYVh9RQ9vDWaRc6rSzqkjreUfOwRkVnS7MhcJkgvUn4sXZX92
         TMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521124; x=1712125924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXMHtvsJsvcQqDicqUMe4VBvDRS5p7vk0mv1oCDMNgk=;
        b=ESlb5kLQJWfmM9KnChrOBMhgkjrznjPoBw9GawmJN/ZBOhEJTRgBRSJKS+1/YgS2vK
         ee1Vq3o9BOqcL1HxPTMmaTE1cFu5ncH4eOTcP9ZPY1ro3HWATG8w8SqUrv2OI3VD1ee6
         7OHrN7EDKoldNh9pATHPGq55OwLiEXP0nAFL1GKHRebn1r/8uchWnMh6UGN7ypv0+Ouq
         clqa4FB3cjv8DVPpbXjwFWFAQKQ3ZhYn3nN9DfmvkwEjZNZ97l12wwr8d+nz8EOcfTt0
         1iiw1FgnWD3lgMgYAKV/3hioYomoQN9g3ztOXcU9fHbGO5MezleT20bUyvwC25IdiALm
         PGLw==
X-Forwarded-Encrypted: i=1; AJvYcCXRGilwqvJ7uougdb39/tpHdbgM+bd22ZT/pzhNGCJwMXlCnMCfXQU+V+QcGNZ0ceRt9gjAtqV5Knj/GFJFzv7oTNN52K9aFYRa+IsZ
X-Gm-Message-State: AOJu0YyzXLN5Y6iQoN0f1W63mWHaKSh4whCQLUyWe0fowj9KA6kPAffZ
	gV7CVDiOs/3V1LR95qDGxWGk2TkOFyeQNJOHdFFm1ms0krlC5zKiXRmB3f7Q
X-Google-Smtp-Source: AGHT+IFpCD7tboYvNfb4MrBj3TBy+dSMMfHPuYZxT4EyTeiUHVl1fmgymSFndJwB+olMdfitoepI6Q==
X-Received: by 2002:a05:600c:3c99:b0:414:61d9:d1f5 with SMTP id bg25-20020a05600c3c9900b0041461d9d1f5mr3067760wmb.10.1711521123637;
        Tue, 26 Mar 2024 23:32:03 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004148d7b889asm1121360wmf.8.2024.03.26.23.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:32:03 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: pi433: Make use of spi mode macro instead of magic number.
Date: Wed, 27 Mar 2024 08:31:56 +0200
Message-Id: <20240327063156.96307-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327063156.96307-1-ikobh7@gmail.com>
References: <20240327063156.96307-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SPI_MODE_0 to setup spi mode.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index ec9f07a4f769..8c513ac62156 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1164,7 +1164,7 @@ static int pi433_probe(struct spi_device *spi)
 	struct dentry		*entry;
 
 	/* setup spi parameters */
-	spi->mode = 0x00;
+	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
 	/*
 	 * spi->max_speed_hz = 10000000;
-- 
2.34.1


