Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54278E43D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjHaBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbjHaBOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:14:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BD4CE6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:14:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdbf10333bso2080935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693444448; x=1694049248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi6iDn2wgjxe+kNysUVpTjdo2oBFvbwTmlzECQzPgK4=;
        b=SSBvqxLqzTclllT8Qi74+ZrY7KHUP0okB5bi8PZDIi49wbN8LGeqCPEy0i9ObHyr16
         BwRjeWZLDCASnZQ/8KV6lOCL51Fv1aJkE6JALvWqe2zcoGFmyooezpqqpgO7hU1BWSD2
         uYnxsA44DiM+46/hYDCZ6kzDRVAp5e35f2d/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693444448; x=1694049248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yi6iDn2wgjxe+kNysUVpTjdo2oBFvbwTmlzECQzPgK4=;
        b=kYm1pV6ycs4yVc3Wg9yH5PA21c2aTYXhcnHRV/QY159Bi6NDJbqp0n+K+v81a8Khs0
         stFMvn2u6Cvha6mzPn9nTVrN8EWh4RbviB2pC89HHE2EToZ2w0OH58vnv9JGVu0DBcsj
         oSsDaqF1FZC3CfsXI7BN3IwhuS4WwPeIyVzgikpZdC5tUhUxqatX55S2uoUIlz65DrvA
         sBvjJcsAA1E11QtH709FNwelEw8Co7mvfML6n0KbSCoSsNHJbRFTRGWtT7l4hrvR+HDp
         tGPn+bQuHmOFJMWtrTPBE2hFTPJGoPUVioZ73N7BZJpv6SG5oevmOiGzmX5/vTHupS+c
         iuyg==
X-Gm-Message-State: AOJu0YwMPD+vIrBx5YXK89xCdf0FPu9FddkqHU3SgdVJi4oE6mkCQolA
        UGiZkyglZ0mzA7zPO7tqJ5lCDrOLvznsFHW93/g=
X-Google-Smtp-Source: AGHT+IHew80vJT+8xJZut5mz37IpFi9RdN3+DaIDAboblAp+7f8qYSDoSaiqwxvec94o5LPnr5OQKA==
X-Received: by 2002:a17:902:8e89:b0:1c0:b7f4:5b86 with SMTP id bg9-20020a1709028e8900b001c0b7f45b86mr3639342plb.65.1693444448598;
        Wed, 30 Aug 2023 18:14:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:248f:d364:b451:2bc0])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001bbb7af4963sm132604plb.68.2023.08.30.18.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 18:14:08 -0700 (PDT)
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
Subject: [PATCH 1/3] platform/x86: intel_scu_ipc: Check status after timeouts in busy_loop()
Date:   Wed, 30 Aug 2023 18:14:01 -0700
Message-ID: <20230831011405.3246849-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831011405.3246849-1-swboyd@chromium.org>
References: <20230831011405.3246849-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for the polling loop in busy_loop() to get scheduled away
for a long time.

  status = ipc_read_status(scu);
  <long time scheduled away>
  if (!(status & IPC_STATUS_BUSY))

If this happens, then the status bit could change and this function
would never test it again after checking the jiffies against the timeout
limit. Polling code should check the condition one more time after the
timeout in case this happens.

The read_poll_timeout() helper implements this logic, and is shorter, so
simply use that helper here.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 6851d10d6582..5a37becc65aa 100644
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
-
-	do {
-		u32 status;
-
-		status = ipc_read_status(scu);
-		if (!(status & IPC_STATUS_BUSY))
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+	u8 status;
+	int err;
 
-		usleep_range(50, 100);
-	} while (time_before(jiffies, end));
+	err = read_poll_timeout(ipc_read_status, status, !(status & IPC_STATUS_BUSY),
+				100, jiffies_to_usecs(IPC_TIMEOUT), false, scu);
+	if (err)
+		return err;
 
-	return -ETIMEDOUT;
+	return (status & IPC_STATUS_ERR) ? -EIO : 0;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
-- 
https://chromeos.dev

