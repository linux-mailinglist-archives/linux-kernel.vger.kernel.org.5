Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81407E71CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbjKISz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbjKISzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:55:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A33C25
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:55:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc41afd376so1916465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556115; x=1700160915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg9I4ZaIj7Cn80AZ+YJatc/DGTkLCa1gLvsiD/shfvU=;
        b=j7E0SD9NUFsG+ThDAFM8nNNmuKrjPg0mEol3O7rWtFPbE36Lup82K4EdI1/J4MX0li
         UrdjxuLdN9thCQoSrGQegzpM7kRKPUY2i/XT5GyqvRZQCuCKlS4tpEn32F1ZkrWFgZ96
         hj3GJ9QeaxKQ8mgFYGcWLLnAAtu5uJBMpvgl7AtwzvhVrvM0ZpdqfOTIVz2c9DLv7LTB
         0L/5+chsV/yfoq0h5vOWzFDLYDLsoxIxYso2Oiy5w9Kv0qsP2cG4tjHT8BpDDuirdudt
         v9tikniwSjrncY9OdTUsoDvE6F+CfCZoTjVqoju5U4jgH4XwZUJpaZ+I7bbm3O9ZkqMb
         GZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556115; x=1700160915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg9I4ZaIj7Cn80AZ+YJatc/DGTkLCa1gLvsiD/shfvU=;
        b=CNk7BHcWJUngnDXYox6JX2hPEXG3HRrG4ahY2tg5uSOUEX/9F8vLp+Axe7ilALLgZM
         KQ7UIu9AaA2S5sLuQKGXHu0ZTekfiue2Nj/gNj50OTvQ1wd8ULIBLbE/XaApvI0hTmq+
         Mbr8P4ucYaaKXo3tEPW4zlgpt5ruFt6+IYhwDiQY19wGdKJaDDeSj5bxFROz8Zd/N3nB
         j3HjM9R5bp5NGmKyREtKXINRCAOp5AtfI9jTDf9KXGwEv3HfHL18ZcS5Be4YidhPq4P1
         U2b8+UXjTgGbJbfXvbnv4ylZiG9rOyDfQ7UQk0xfk3A5Yv2ewJ2ZjFOYcBrZERWKf8VZ
         TeKg==
X-Gm-Message-State: AOJu0YyejQjG9Xc2GGicbO59hivLOdtLJcCsXGR8cJ29pdUpI3KJMn2C
        Tpg84fjfVew/nrRaW/Yhug9QzIaO4uc=
X-Google-Smtp-Source: AGHT+IEtW1oaVYd/An5rg2FaDM6Q0s0wAl5Pr2VY0eMfJkPWNQqJ1LUHlgMkwIfQk4Ow5hwMKO0bCg==
X-Received: by 2002:a17:902:ce8c:b0:1cc:3e45:ac1e with SMTP id f12-20020a170902ce8c00b001cc3e45ac1emr6334586plg.6.1699556115257;
        Thu, 09 Nov 2023 10:55:15 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:55:14 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 6/7] platform/chrome: Fix typo 'change' in comment
Date:   Fri, 10 Nov 2023 02:54:38 +0800
Message-Id: <20231109185439.1535962-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'change' with 'chance' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 6c2aa2651e5f..9e17f7483ca0 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -175,7 +175,7 @@ static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
  *
  * While a and b are recorded at accurate times (due to the EC real time
  * nature); c is pretty untrustworthy, even though it's recorded the
- * first thing in ec_irq_handler(). There is a very good change we'll get
+ * first thing in ec_irq_handler(). There is a very good chance we'll get
  * added latency due to:
  *   other irqs
  *   ddrfreq
-- 
2.25.1

