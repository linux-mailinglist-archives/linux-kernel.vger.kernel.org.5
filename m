Return-Path: <linux-kernel+bounces-121880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087488EEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104CC1F2EB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE251152180;
	Wed, 27 Mar 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz3fHk96"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB21509AE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566616; cv=none; b=JBf74F4mT7LBz+cuEm3brqEH6bOQOgjJZZKX3RTe3K5DTA1iYKBzwDR7DUkCqAHxEqg5z+5Hgsl91V+XniwyHboJheF5jYdSmgbkPL7Ugu8FfL7x5rsRJRRiaIpAetyoLc1uIZwSQv472LDvSmPvmSMW6Fi8cHqzYviZkmkhL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566616; c=relaxed/simple;
	bh=2ZKwNze6O6FHYLv0ZmDp5vBMzHN4+fjn61h42zC6U0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCdcZTneqMFCji23ZCD60gL8vssVJfpA4VDOp3Oy7dT7D9Fv2dvT1IrDXM0HS3NUi9QpehZfN0nj4KJjVxwHL6s6lfCXbWegVnaqAgYW5oD42JHbEQBE8Ym2B9Rn8rrVdV/iXJCOjWxgA2Swt5DSt8IvsvQog8EnAG9ucAfeK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz3fHk96; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-696315c9da5so1277346d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566614; x=1712171414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2mei3j/lcrSSTisR+Uqzrn/InZyJ99Sff97ygb+XVk=;
        b=Xz3fHk96bZxyMAT7iBYRvgZSve/pjKRvNqOenJO90WBv9AB79m3L0FDtM2ypWbgUrh
         KNW1JTs17qJj4Hp9wBADLcedAe1PwgqQPgHBEM74zBMXlTwZ65Q2WVG/8ZKnRdLAoRSx
         5D0sjsents1LvQu04mBQX+iCLKQIbg+qAtiuugP9sHQsQLgc56LSZW2sua+TcAu6Vcx1
         apgV/nQH23UJra+zxaMhU0uFxNEFMH5sSE7wU2sHt9MxlHL5ODF8Q67iNa7iBHOZUQJb
         PBA+TAgVcVYhL5Nj+A7yBB3E6gVO6Kgr9ULSGNjhKzKdeHehdtPnNe6zdhAK3zQnyTTj
         vUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566614; x=1712171414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2mei3j/lcrSSTisR+Uqzrn/InZyJ99Sff97ygb+XVk=;
        b=GbJ6QcIJO0JYMOMbW0r8qt/Bxvfoll4OGgSBmekCOk0LJReK2jdR0DCEIF11TJ9TOh
         eJUwdhT0mblEiiSH6tMio9QE8wGKkhOQn+SpUY3Mu+KVhfEZI1938QQlJYonh282G/wZ
         1QxpOoM8PpCGU5CSE0vO6F9iQgfdyXNjqyluUd9iUD6GXrjHSVfoixIq/heDdaxKeGXE
         aaGMdffYGo7c+v8gNdCeg1NHzaaGX4ThFJTtosIt2hqs0pHN/SbujGN0m6O8a2b18ahG
         z0kTZpJLJ9o+00q5odh2bnkh+cnVbhJzvAkK0CNdOABijkse7xTV/ZoQ4yK8UD5AXhSD
         1jig==
X-Forwarded-Encrypted: i=1; AJvYcCURLXOr0ocGi6aFCDZEsomEMn3PcPBnHbVREJP6oh4GgFQdYci7w11WbVrlE97wVerg+ANOVa3LNn3rdxMFn3VAIf4FECDEhHXj19DO
X-Gm-Message-State: AOJu0Yx+KJjMmXEjLkuSbgI1X1iWaBA4vFGJO4UITYWOuGbcM6Yayqq+
	vuPXNZo9iKELtQOkmEEUcv/xBxh/nZpo+66+KYUp87kdDfm3QV87OryURiQJ
X-Google-Smtp-Source: AGHT+IE7DncV9RK/Fz3ApyzCE9YenBkZ2tRm5kS5LFTI0MF4BpFfqfBtyqdxgHF+2EsItosROiEsuA==
X-Received: by 2002:a05:6214:5287:b0:696:77a8:9135 with SMTP id kj7-20020a056214528700b0069677a89135mr515196qvb.32.1711566613832;
        Wed, 27 Mar 2024 12:10:13 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id 10-20020a05621420ea00b00696a1f5dd18sm1784789qvk.116.2024.03.27.12.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:10:13 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: pi433: Use headers in appropriate files.
Date: Wed, 27 Mar 2024 21:10:02 +0200
Message-Id: <20240327191004.619748-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327191004.619748-1-ikobh7@gmail.com>
References: <20240327191004.619748-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure rf69.c directly includes rf69_enum.h.
Move rf69_registers.h from header to the relevant source file.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
v2->v3:
        Restore Reviewed-by tag.

 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.c     | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 81de98c0245a..0c12b31c4642 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -45,6 +45,7 @@
 
 #include "pi433_if.h"
 #include "rf69.h"
+#include "rf69_registers.h"
 
 #define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 5a1c362badb6..bf802f097310 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -11,6 +11,7 @@
 #include <linux/units.h>
 
 #include "rf69.h"
+#include "rf69_enum.h"
 #include "rf69_registers.h"
 
 #define F_OSC (32 * HZ_PER_MHZ)
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 76f0f9896a52..dd6fa8af9b9c 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -9,7 +9,6 @@
 #define RF69_H
 
 #include "rf69_enum.h"
-#include "rf69_registers.h"
 
 #define FIFO_SIZE	66		/* bytes */
 
-- 
2.34.1


