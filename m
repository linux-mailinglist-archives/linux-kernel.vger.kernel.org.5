Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E217853A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjHWJPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjHWJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:11:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FC273A;
        Wed, 23 Aug 2023 02:03:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3197808bb08so4866485f8f.2;
        Wed, 23 Aug 2023 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692781407; x=1693386207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YO/WOkrwEXYf9n89IX0yKt/64CcuxWDD6IgoTDcbvZU=;
        b=b3TPtVV9WYnVP0xc3bm0CU3iTUNE4KW7L5RqP4CYb5zhdjsYLySfJvr/0KwkB9mt9R
         u79Kz+ubf5bdQ2me/46UEEBotz2scDU0bLBG4ELIVxSq3r3vKn2vnYTbu5tormD6pZLt
         N38g6lBYPIF3IfnO8fl6Rrrk/YiJdtwfEHCI5y8R47dh0L5sgVGvDJ8ueYVedGFqkaNn
         DiE7kklDPD9+G6eh61kcIc8lOKG0Pw6CYwek8Qzl9TGkw2QyYyUDU9zyo/fFufH/qEpl
         F4zfzPYmgDR/UaEJggDUoRTtG6R9JrjyohrkbEOe0GUKS6hpr9eXV/6lET+8MTaG9Pm8
         F6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781407; x=1693386207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YO/WOkrwEXYf9n89IX0yKt/64CcuxWDD6IgoTDcbvZU=;
        b=RCNOcndVrDHUD7fvJDzItHFHQJZ4JmguNYDcadrZwddJDe/Kku8AzPJdJ8NrPcFzV6
         +etfbl3UUkWYoGNK/D9JElzLpwUQAZ+39KlZLKPB+4qmrZCYNKIz530WbjDgKYacn/w2
         KX5veM91w5HAqBAzO+R+lrGUOSb0BfYLvtFOrmacy8X8AXszQowyyXdAc2BtzVRCTaRs
         vm7jDsGAuwzgP/k7zYyySoAoEmEUImPNEZuQXz0Kn59OuBDcTmocXX0VFHj6Flj7WBxx
         hk+dLoQmF+rOguBOwOdHT5+W8jRJy2p+W86AaAfMA9HHwzXaeYZQjMJfNdHnEDwCpbKt
         jVig==
X-Gm-Message-State: AOJu0YyXacbGJ3LfnOzCFjz5A/uftQQgEpdorDzQmzzi0no8nQalwJuk
        QAYWDWnsTFF6DV4nTu3Hu0//yDQEOaySUQ==
X-Google-Smtp-Source: AGHT+IFIdpNbTfUs35kdTucR7rl6DKkzbkWnSECKpU83/iZ4E/M4zKtWK+korKF4tt75GGbwFpXXPA==
X-Received: by 2002:a5d:4f0f:0:b0:319:89ce:da0b with SMTP id c15-20020a5d4f0f000000b0031989ceda0bmr8759387wru.68.1692781407079;
        Wed, 23 Aug 2023 02:03:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003197b85bad2sm18292924wru.79.2023.08.23.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:03:25 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd: Fix spelling mistake "throtting" -> "throttling"
Date:   Wed, 23 Aug 2023 10:03:23 +0100
Message-Id: <20230823090323.184121-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in variable throtting_events, rename
it to throttling_events.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 704a2b577a0e..fbcff154b1d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2313,7 +2313,7 @@ static const struct throttling_logging_label {
 static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 {
 	int ret;
-	int throttler_idx, throtting_events = 0, buf_idx = 0;
+	int throttler_idx, throttling_events = 0, buf_idx = 0;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t throttler_status;
 	char log_buf[256];
@@ -2328,11 +2328,11 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 	for (throttler_idx = 0; throttler_idx < ARRAY_SIZE(logging_label);
 	     throttler_idx++) {
 		if (throttler_status & logging_label[throttler_idx].feature_mask) {
-			throtting_events++;
+			throttling_events++;
 			buf_idx += snprintf(log_buf + buf_idx,
 					    sizeof(log_buf) - buf_idx,
 					    "%s%s",
-					    throtting_events > 1 ? " and " : "",
+					    throttling_events > 1 ? " and " : "",
 					    logging_label[throttler_idx].label);
 			if (buf_idx >= sizeof(log_buf)) {
 				dev_err(adev->dev, "buffer overflow!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index cc3169400c9b..bed5a9df1c06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1674,7 +1674,7 @@ static const struct throttling_logging_label {
 static void aldebaran_log_thermal_throttling_event(struct smu_context *smu)
 {
 	int ret;
-	int throttler_idx, throtting_events = 0, buf_idx = 0;
+	int throttler_idx, throttling_events = 0, buf_idx = 0;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t throttler_status;
 	char log_buf[256];
@@ -1689,11 +1689,11 @@ static void aldebaran_log_thermal_throttling_event(struct smu_context *smu)
 	for (throttler_idx = 0; throttler_idx < ARRAY_SIZE(logging_label);
 	     throttler_idx++) {
 		if (throttler_status & logging_label[throttler_idx].feature_mask) {
-			throtting_events++;
+			throttling_events++;
 			buf_idx += snprintf(log_buf + buf_idx,
 					    sizeof(log_buf) - buf_idx,
 					    "%s%s",
-					    throtting_events > 1 ? " and " : "",
+					    throttling_events > 1 ? " and " : "",
 					    logging_label[throttler_idx].label);
 			if (buf_idx >= sizeof(log_buf)) {
 				dev_err(adev->dev, "buffer overflow!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d3b578e6bc2a..fa4ad08099ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1888,7 +1888,7 @@ static const char *const throttling_logging_label[] = {
 
 static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
 {
-	int throttler_idx, throtting_events = 0, buf_idx = 0;
+	int throttler_idx, throttling_events = 0, buf_idx = 0;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t throttler_status;
 	char log_buf[256];
@@ -1902,10 +1902,10 @@ static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
 	     throttler_idx < ARRAY_SIZE(throttling_logging_label);
 	     throttler_idx++) {
 		if (throttler_status & (1U << throttler_idx)) {
-			throtting_events++;
+			throttling_events++;
 			buf_idx += snprintf(
 				log_buf + buf_idx, sizeof(log_buf) - buf_idx,
-				"%s%s", throtting_events > 1 ? " and " : "",
+				"%s%s", throttling_events > 1 ? " and " : "",
 				throttling_logging_label[throttler_idx]);
 			if (buf_idx >= sizeof(log_buf)) {
 				dev_err(adev->dev, "buffer overflow!\n");
-- 
2.39.2

