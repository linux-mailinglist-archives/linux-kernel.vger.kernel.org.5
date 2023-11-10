Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75C7E819F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjKJSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjKJS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:28:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE62D41324
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:52:46 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so201476b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699635166; x=1700239966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxqRDZ+ztZSd9qnawgjaQAg5ACh45Q6dnAez8SycqZU=;
        b=nAzPVWGhBTJKVemy7yzWl4jGVHQT2WWCcTbrSF29/tkQQzNQrnIsG9bh8GQWOHRzJP
         2H9Lch+J3DiuErMV5yr9uoxcc8I/B59y8X4Z56m7EaShkT5M3kFYdt501DTHLndiu1Jz
         Rspd2U5wBsOiXCKC+y71bwDevMatO2tiDcFMbG9+I8H6eqHV0GayZLsO8FxuVcoKZ4ok
         rcRF5nh3hvu52wM52xZW9cP42C2r5xJuwfIuypqPx+9oxgDMwJKYr0yNCMDwV7/ZFdKl
         0tpFcVs+0g+o4iq0OwPFf3tYBrW5Bxc6LO9mJ1opcMljLq+xzYZn4FRlmx0+zdexfORv
         L1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635166; x=1700239966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxqRDZ+ztZSd9qnawgjaQAg5ACh45Q6dnAez8SycqZU=;
        b=NFibCZXUPBl0BrrHP2FETRdc4bpZ6qTGWx+pFWeROvYXSUt2ZuwQFhqptXTQde9Lmv
         R7pecOw6wnpT5TlVJBUe2HwOXxqGoVDqIC7537ztZQtQSVqOB8V2sN4V7u5wUVtiWM8O
         RKu0lwc4J8tlHBBQYaS1iQc5eepyAgOEjtn9j0isX69dhZf2lA1E9e6enUsUbmStAXtD
         BNQdBMsBCVi5AmZs3PmEC358OwXWSVm0EAlhTCShzEVl7IGn9EaMsca8mK7EArFGQItl
         QYoVYtKi6tcogfpGpZAdRWfF20OU3AORCaxLg1qeWgTwWGleDBCFL4yqIWqqEIORedYD
         andg==
X-Gm-Message-State: AOJu0Yzga2o7gcYOs6NUWR5t00wIE2d8Nm1mlICMvvp6eTd/mtxFBBFB
        5epxdfbPDMJCCv5+ou+LN80=
X-Google-Smtp-Source: AGHT+IEGxk/jLqGJA0yS3ZeTi81R4xE2ZufSKB2Rtpbbh9NrGc0xsWCOW69zHXopVbKhjoSWZEwD/w==
X-Received: by 2002:a05:6a21:329b:b0:133:6e3d:68cd with SMTP id yt27-20020a056a21329b00b001336e3d68cdmr10384496pzb.3.1699635166235;
        Fri, 10 Nov 2023 08:52:46 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id ka19-20020a056a00939300b006905f6bfc37sm12797665pfb.31.2023.11.10.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 08:52:45 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] platform/chrome: sensorhub: Fix typos
Date:   Sat, 11 Nov 2023 00:52:39 +0800
Message-Id: <20231110165239.1559109-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZU3GbHTA3x19h2Zi@google.com>
References: <ZU3GbHTA3x19h2Zi@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'preceeds' with 'precedes' in the comment.
Replace 'porod' with 'period' in the comment.
Replace 'noone' with 'no one' in the comment.
Replace 'lantency' with 'latency' in the comment.
Replace 'kifo' with 'kfifo' in the comment.
Replace 'change' with 'chance' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
v1 -> v2:
 * Separate patch series into two patches.

 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 71948dade0e2..9e17f7483ca0 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
  * @sensorhub: Sensor Hub object
  * @on: true when events are requested.
  *
- * To be called before sleeping or when noone is listening.
+ * To be called before sleeping or when no one is listening.
  * Return: 0 on success, or an error when we can not communicate with the EC.
  *
  */
@@ -175,8 +175,8 @@ static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
  *
  * While a and b are recorded at accurate times (due to the EC real time
  * nature); c is pretty untrustworthy, even though it's recorded the
- * first thing in ec_irq_handler(). There is a very good change we'll get
- * added lantency due to:
+ * first thing in ec_irq_handler(). There is a very good chance we'll get
+ * added latency due to:
  *   other irqs
  *   ddrfreq
  *   cpuidle
@@ -511,7 +511,7 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
  *                                 ringbuffer.
  *
  * This is the new spreading code, assumes every sample's timestamp
- * preceeds the sample. Run if tight_timestamps == true.
+ * precedes the sample. Run if tight_timestamps == true.
  *
  * Sometimes the EC receives only one interrupt (hence timestamp) for
  * a batch of samples. Only the first sample will have the correct
@@ -595,7 +595,7 @@ cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
 			} else {
 				/*
 				 * Push first sample in the batch to the,
-				 * kifo, it's guaranteed to be correct, the
+				 * kfifo, it's guaranteed to be correct, the
 				 * rest will follow later on.
 				 */
 				sample_idx = 1;
@@ -701,7 +701,7 @@ cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
  *           last_out -->
  *
  *
- * We spread time for the samples using perod p = (current - TS1)/4.
+ * We spread time for the samples using period p = (current - TS1)/4.
  * between TS1 and TS2: [TS1+p/4, TS1+2p/4, TS1+3p/4, current_timestamp].
  *
  */
-- 
2.25.1

