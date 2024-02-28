Return-Path: <linux-kernel+bounces-85531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B6886B722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42491286060
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D701240866;
	Wed, 28 Feb 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="xnM34M7c"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66540860
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144882; cv=none; b=OWm71h//6HcjL5R7PsuJqeCK6SRQQgZ/VVzZQexTgrFuXqO4HnigHb4Ul6qcYo/KrXtUj3Fyft3WHB23qDa7xu6SrnGKk0WLsnpq/Gmfj2MVOX0h2Tg9OJATwqAHmRNQh2H4vOawSm521xuXc/7C3cl9zqIUJ0Gjbb7ONB4L+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144882; c=relaxed/simple;
	bh=k4xyia0piuIcKuFqrg4Vvg1MChuit3EZ7ASf2pglsMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvIf/6Nmr2z254PkjuI6BgS2EjNWEETDN/OBD/qXyTIHdM0aoH8J+jUKNu+mKNSZURQDQGoCOq7XJ7z2G5RtdJKFJhzvDM7YTRFnsCzzwhJslN+uFSwJbVVY84ccHvVYKVKtg24iUszxP0qeaKJlIC09agcS5latVSX7KySyL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com; spf=none smtp.mailfrom=hefring.com; dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b=xnM34M7c; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed0710c74so83982276.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1709144878; x=1709749678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EF1KPzXNNkHhE7yYlv+hV5FrLPYFNCzXyE0ge4E72Xc=;
        b=xnM34M7cCjaHquzBGHYfE/gb6Zi719cfhzCqjktyCvCcdKHeQVQJdZXfRRaTSAXILF
         /SKByzv5s5E5/xhLiUNRqjceyUwGSaxsb0IlfxHCfPXkyqjP9dBTgvZs10XxLjvw4Kh1
         ljWVTGEZKJAGjOFYty7jscH7p9Dojk/SosUjD1owQ9qHlquXazMf1bWEMAn/PT6KciEP
         o0Skd2unAC7+05nVXyj3Dk44L5ti54dtGLTsOjxHH29FotSPb3rqznup0ZAFLpp2wrJR
         ECQn/65BeKjl1/3IsbUzxCyx9PTN1eD4BBzX5qqDTNYiIo/Wzt9hP56yK9BpNZ/JVovH
         Hidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144878; x=1709749678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF1KPzXNNkHhE7yYlv+hV5FrLPYFNCzXyE0ge4E72Xc=;
        b=b/76RgqD2C2/Mpm8fM6sW+xaIFb3LlhPgd7y3a9L2BowdMoJgmMXxYMOjERueTIR3E
         bDaxozDeNFk35ST7Wa55rvgqyf/hykSNv/ZNai9HfVLENlue66PXLlfeM8LCWlfxYJSG
         RDF5JpL6ZSGtJsfTGXgFoRVBxRzST5Z2ZupIuQ3MLi+okfGWZFIH+uWxymObbgf7NEze
         fDGrPuprQLuHEFTx+Ww9E9uFPq0SqzireA+bCzUgkd4SmhQJk9M3VqO0LdEsSxOjfo4D
         Cgwu16M2FUwNGvii8GmhsiQAyfpHiILDbDIxJmyZyY/qLK662QbWrofS6A5YUNapMPbG
         KzyA==
X-Gm-Message-State: AOJu0YxAG9lCH4itf1Rnt95LnP+vbVGS6MQywqEWe1Qb1p9VrEjirZYg
	k1rj+o//i9Vl3eUIXY1FTzSIvzCwfQSKcDc6tYJVL3+cnC82uMaA6BJkOgQxLkHoge90SpVeciU
	u
X-Google-Smtp-Source: AGHT+IGGIUcPNLaPDD97/JSUYoRXanewPna4Nbjsv7a0TEzYLDOhtOT2egjmszbqhcM+oGhhhvzNHQ==
X-Received: by 2002:a05:6902:136e:b0:dc5:f51e:6a60 with SMTP id bt14-20020a056902136e00b00dc5f51e6a60mr22948ybb.6.1709144878346;
        Wed, 28 Feb 2024 10:27:58 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id x4-20020ac87a84000000b0042e390c9804sm8355qtr.6.2024.02.28.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:27:57 -0800 (PST)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@st.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] watchdog: stm32_iwdg: initialize default timeout
Date: Wed, 28 Feb 2024 13:27:23 -0500
Message-ID: <20240228182723.12855-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver never sets a default timeout value, therefore it is
initialized to zero. When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is
enabled, the watchdog is started during probe. The kernel is supposed to
automatically ping the watchdog from this point until userspace takes
over, but this does not happen if the configured timeout is zero. A zero
timeout causes watchdog_need_worker() to return false, so the heartbeat
worker does not run and the system therefore resets soon after the
driver is probed.

This patch fixes this by setting an arbitrary non-zero default timeout.
The default could be read from the hardware instead, but I didn't see
any reason to add this complexity.

This has been tested on an STM32F746.

Fixes: 85fdc63fe256 ("drivers: watchdog: stm32_iwdg: set WDOG_HW_RUNNING at probe")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/watchdog/stm32_iwdg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index d9fd50df9802..5404e0387620 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -20,6 +20,8 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
+#define DEFAULT_TIMEOUT 10
+
 /* IWDG registers */
 #define IWDG_KR		0x00 /* Key register */
 #define IWDG_PR		0x04 /* Prescaler Register */
@@ -248,6 +250,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->parent = dev;
 	wdd->info = &stm32_iwdg_info;
 	wdd->ops = &stm32_iwdg_ops;
+	wdd->timeout = DEFAULT_TIMEOUT;
 	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
-- 
2.43.0


