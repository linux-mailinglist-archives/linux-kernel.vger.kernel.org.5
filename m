Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE979BF55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbjIKVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244217AbjIKTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:39:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE51B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:39:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26d50a832a9so3339579a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694461182; x=1695065982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdCNmE4TQzaUVGYBpjExxVlAWo5NcVTWN45t1mLK2Kw=;
        b=ogpttftmeuGXskkeyI7t4md+uLYnvUs0J/Pn3eJnYCUi/XytZcLFKUOVj3ijBzWBnO
         lJlDS1XHOVyvuJSBwO2U8D49Cx1zJ3IJSWBDxs2I/hGrWFvW1G+Q7AhJEaqoDt5mG7Fs
         QoHCsnruJJxVE7zckenLWst++1VoWlgJV8HGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461182; x=1695065982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdCNmE4TQzaUVGYBpjExxVlAWo5NcVTWN45t1mLK2Kw=;
        b=mdiuWQd2Gx2fGkCLJWgejcILGgqE/f+T9lU5iFm/VPhfCq2hYoaf8oubywFkzyrF16
         2dP784ZoQRAbYPbkfBh2eBkMvQ+WzNh5Ra/csoQUIEqlHDSbKKSpxh7lFHF/eOyIKE6v
         T+6o7g7pMUW4sJVLlW2KCrUtT0ugd4GPhv34F4V38b+EMhVlMm1HH+zqI1Z0Pt502lZp
         o1VPDrXW+bHPYVH74PpX2D35E2AB0HAANIIEBt0NCp5eeemTtp8Dos3/VKuMLsZeu1I4
         lfC0AnKvDHWzKIZzA3gaGo0BsGoVziy0eRcxsYWEXNhhQTOdldK+IQ8NJ42Td93TU3S1
         ZTPg==
X-Gm-Message-State: AOJu0YyWWjhI3s2oqjoSb4cy4Ty9RkQCFo6MbIKAIirWHMx5eYFysd8x
        V3aeY9dAXI5PHN/Gw5yxh/VU6g==
X-Google-Smtp-Source: AGHT+IGGvlqWnCd6FgKie+c4RBzySbl2Wtfy49TuNcsKhZkbb20DCZlYeRe7ju+YlMJNU0euA/ADjA==
X-Received: by 2002:a17:90a:c246:b0:263:ebab:a152 with SMTP id d6-20020a17090ac24600b00263ebaba152mr8240717pjx.19.1694461181946;
        Mon, 11 Sep 2023 12:39:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d487:5e33:6656:3711])
        by smtp.gmail.com with ESMTPSA id fu8-20020a17090ad18800b00262e485156esm7736543pjb.57.2023.09.11.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:39:41 -0700 (PDT)
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
Subject: [PATCH v3 1/4] platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
Date:   Mon, 11 Sep 2023 12:39:33 -0700
Message-ID: <20230911193937.302552-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230911193937.302552-1-swboyd@chromium.org>
References: <20230911193937.302552-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
The read_poll_timeout() macro implements all of this, and it is
shorter, so use that macro here to consolidate code and fix this.

There were some concerns with using read_poll_timeout() because it uses
timekeeping, and timekeeping isn't running early on or during the late
stages of system suspend or early stages of system resume, but an audit
of the code concluded that this code isn't called during those times so
it is safe to use the macro.

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
+	u8 status;
+	int err;
 
-	do {
-		u32 status;
+	err = read_poll_timeout(ipc_read_status, status, !(status & IPC_STATUS_BUSY),
+				100, jiffies_to_usecs(IPC_TIMEOUT), false, scu);
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

