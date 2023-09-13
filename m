Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0A79F3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjIMV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:27:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B661724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:27 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-577dad08512so695452a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694640447; x=1695245247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOiFJlPGyJUavNNVJMIMcGzvlYAGe09SF66xWdVaxyU=;
        b=aP1CrSMPFY/9BpGHOgfmmkbW0TKI9OKa0TkBfI4Q6dG7IY75LrR1u7SseAg0gt5zaY
         YZhHEEZRwh0ykb9Bcx+/aHeT2UNCT64SnjpbzVzNVD2hopL543cXm4yOjppFRsEKGok5
         Z/10+RP7OdA67IIdWydENjNRC6wJ8ap9/JL5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640447; x=1695245247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOiFJlPGyJUavNNVJMIMcGzvlYAGe09SF66xWdVaxyU=;
        b=KiOTj4jqq6Iupsf2O53IYhab68xDWNUVaWebBtRAOW54rIryAoJfYiBPGDV0dA8aZ0
         1V0HshVrr5yxEjZnSiO8iAqgJwvyKxIaDb2tJaaupNyeAyzQsYDQJY2JMUzTXagAiQ/8
         D2zTL2XWNMpenlOlnvWIMIoKKZIenqcCXGy+sZlwDy1tnzRJbwfhdpYgxVnFC2Mfb1DW
         mA+zUwtenBTEIDG1LnL1zR9cWw5FUiUK7jkl+stlkDh+KpLWg/UGJ7d0Jn+zpMHqI3Ka
         fySNsws1fCmKDuz54tnF/YN3QiN9iY/rsoDcbuo5/1KB8TqJ0waR+oqUbqZDd951KnQC
         KTtw==
X-Gm-Message-State: AOJu0YyQKAF61QNAN2lY/NtFIegbUjbtOnivrZa26SiuYSDtswOR9e9V
        xXJdR7Qi5Ba8+VBxd+somsyTpg==
X-Google-Smtp-Source: AGHT+IGyULUVZNu+bUP/MqMEKr8RaVU+CWUNozYQ8it166LT6PCoR6pmCH6eo+YA6LRjoue3V82dXQ==
X-Received: by 2002:a17:90b:30c2:b0:26f:392f:f901 with SMTP id hi2-20020a17090b30c200b0026f392ff901mr5552309pjb.14.1694640447120;
        Wed, 13 Sep 2023 14:27:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:ae97:c6dc:1d98:494f])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090ad80a00b0025bdc3454c6sm1923976pjv.8.2023.09.13.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:27:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v4 1/4] platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
Date:   Wed, 13 Sep 2023 14:27:19 -0700
Message-ID: <20230913212723.3055315-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230913212723.3055315-1-swboyd@chromium.org>
References: <20230913212723.3055315-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for the polling loop in busy_loop() to get scheduled away
for a long time.

  status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
  <long time scheduled away>
  if (!(status & IPC_STATUS_BUSY))

If this happens, then the status bit could change while the task is
scheduled away and this function would never read the status again after
timing out. Instead, the function will return -ETIMEDOUT when it's
possible that scheduling didn't work out and the status bit was cleared.
Bit polling code should always check the bit being polled one more time
after the timeout in case this happens.

Fix this by reading the status once more after the while loop breaks.
The readl_poll_timeout() macro implements all of this, and it is
shorter, so use that macro here to consolidate code and fix this.

There were some concerns with using readl_poll_timeout() because it uses
timekeeping, and timekeeping isn't running early on or during the late
stages of system suspend or early stages of system resume, but an audit
of the code concluded that this code isn't called during those times so
it is safe to use the macro.

Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 6851d10d6582..4c774ee8bb1b 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -231,19 +232,15 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 /* Wait till scu status is busy */
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
-	unsigned long end = jiffies + IPC_TIMEOUT;
+	u8 status;
+	int err;
 
-	do {
-		u32 status;
+	err = readx_poll_timeout(ipc_read_status, scu, status, !(status & IPC_STATUS_BUSY),
+				 100, jiffies_to_usecs(IPC_TIMEOUT));
+	if (err)
+		return err;
 
-		status = ipc_read_status(scu);
-		if (!(status & IPC_STATUS_BUSY))
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
-
-		usleep_range(50, 100);
-	} while (time_before(jiffies, end));
-
-	return -ETIMEDOUT;
+	return (status & IPC_STATUS_ERR) ? -EIO : 0;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
-- 
https://chromeos.dev

