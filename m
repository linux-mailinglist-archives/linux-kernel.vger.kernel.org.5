Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA7E7942CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbjIFSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIFSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:09:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476B7CE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:09:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso777065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694023788; x=1694628588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ60R3rHW7RtCo/8VNaTl4hpFxxt5nZxG1tJ6/+yqfY=;
        b=mYSBO9Gyi+XIhlh03NXl4t4gMDxP84oFLJWwtaLxcqrPQ9zhnS+VKSwZGUFjWNESd1
         pMYKwV7v+L/3xO3WrSkS6Rnq5Odwz1aqSo2NFFT7W8i18/ZXxq6cLNRo9kcXlZvPkOlL
         ZMI2/aDP3+DR7wx8HsMgxFCF+47GR4sADyO2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023788; x=1694628588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ60R3rHW7RtCo/8VNaTl4hpFxxt5nZxG1tJ6/+yqfY=;
        b=VJMP2j2Yt+pWK+juSMhuGttru/3gm28syEiPRHrZbLA9y7KiCGJrBfZuTu4iz0ZRjm
         zV7hDZaGmEojM5shwkq5LlS4XXCiv7xGkKP2npiyPKAeVdAtdcTSSR6YpiVdnkJ8lGeH
         jfxL2MvfpUvMPQIvWEeNnUGNCxFYPCXHlSl/N7RokF8gQ+UKfoQMyPS5kf/6oXAtu5OB
         w5IxRzE6U1H7L/9QT0M5KaIA51VVTOBi+V+z+O6qQiMtQjWREhSTSWlDIS1PvwGlyFRW
         G+aG9VqOjUkuqP5yT7KylVSdnaKIKCKsp1LVy/DZh1yjIFiCfRThEnXFdyvX1uAfcjRk
         ++BA==
X-Gm-Message-State: AOJu0YzY6AicaBlJYvrv7H5J+oNrtMGMxLrYXjciLsU4FKrsp6suodPP
        QnVW3gnPO/Nl52Ghpv733gGi6A==
X-Google-Smtp-Source: AGHT+IFTy5AW0hEg/3ypp2wUfruRPqHHSv6/9h119PwBpNp6mPHXIi/XqQfMzExiQ7wVnyux07tFkA==
X-Received: by 2002:a17:903:24c:b0:1bc:2d43:c747 with SMTP id j12-20020a170903024c00b001bc2d43c747mr20299220plh.38.1694023787823;
        Wed, 06 Sep 2023 11:09:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:a404:ed4a:5a1e:3b4a])
        by smtp.gmail.com with ESMTPSA id ix5-20020a170902f80500b001bc675068e2sm11363996plb.111.2023.09.06.11.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:09:47 -0700 (PDT)
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
Subject: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
Date:   Wed,  6 Sep 2023 11:09:41 -0700
Message-ID: <20230906180944.2197111-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906180944.2197111-1-swboyd@chromium.org>
References: <20230906180944.2197111-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This is sufficiently busy so I didn't add any tags from previous round.

 drivers/platform/x86/intel_scu_ipc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 6851d10d6582..b2a2de22b8ff 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -232,18 +232,21 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
 	unsigned long end = jiffies + IPC_TIMEOUT;
+	u32 status;
 
 	do {
-		u32 status;
-
 		status = ipc_read_status(scu);
 		if (!(status & IPC_STATUS_BUSY))
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+			goto not_busy;
 
 		usleep_range(50, 100);
 	} while (time_before(jiffies, end));
 
-	return -ETIMEDOUT;
+	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY)
+		return -ETIMEDOUT;
+not_busy:
+	return (status & IPC_STATUS_ERR) ? -EIO : 0;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
-- 
https://chromeos.dev

