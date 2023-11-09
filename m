Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F47E71C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjKISy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKISy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:54:58 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F23C13
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:54:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so288014b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556096; x=1700160896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOp+xpHlmwwJHpuAsntREKGWWkLs/V8YPmUbdNBBy0c=;
        b=fB6A8KUBkT3NPcrLeZkwztwcU9nMqgap2PNJgV9JTkqPKouNwkWQk4ycVOSqHdRFdg
         VodBkRQlmAdEKl7BDW0gtSVIiDo/2sFNiOpxavgg/YIk6aJbX5puqwBawctrOcQT4nAz
         cZ1CVR5dM4C0QNyFpyQ4AH2tn2qQKmukE6AsfaU8LLg1wW5tXXORNwNIqp0UrRyJEAOW
         7+hd2oO9Yxx66FUVKToJw7rMvFyfBhaP/c1bvmgmEaQy6Kr0mxrLVv9OJvTBMahnragA
         jjWsxyEJPh9M2zzvMhhUfpOwGGnVysNjrMSN5FiXl+vWfDxSL7xEEhpfLIQHbGDiZGdy
         6LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556096; x=1700160896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOp+xpHlmwwJHpuAsntREKGWWkLs/V8YPmUbdNBBy0c=;
        b=N1KJz7iyufQESVLaIzrfW2fs8yJmn50mV/V5RRD6MKwLqAXhFu+hl2Q7i9UbZ+Hznw
         Wo7W/vXax2xrH8abpisG0l6NLf6veBbuptcva6vj7z6w/L3vvUm4zNtCWlzJm3czpEBt
         RCLN220ljfw0IKXui3i7wkckZhIO8fsORXbSzihie1KFPqYN70oD30h6aWLSw3R3II0v
         3s7mnYszlLi9G2CGmoROQe3YCJqrfuX/nsAv6BEcr4PZJ1L0TfV5tCIgT/UaPKmI4ZJW
         5hwGroFdXwagnGcbNlRYEvwAVrMa9N7zzvbpU/xZjWh3I8rsk8Xp84bLUSg6cHjYzlnK
         0m6Q==
X-Gm-Message-State: AOJu0Yw5T3o8gJyvDn0ydADVNEyanZ/3vTvNyDp3hOHgYfYNEwrd0i4H
        P0YJYYkYWvURin28LQ6cCOw=
X-Google-Smtp-Source: AGHT+IE+IJZS1sqYktLsiPaL1df4ka4ANEDD9qXqEAzn3MA5xqXj0C0RPxKP+lsVDxfLH5oDuT8zSg==
X-Received: by 2002:a05:6a20:4304:b0:16e:26fd:7c02 with SMTP id h4-20020a056a20430400b0016e26fd7c02mr6287408pzk.2.1699556096014;
        Thu, 09 Nov 2023 10:54:56 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:54:55 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/7] platform/chrome: Fix typo 'preceeds' in comment
Date:   Fri, 10 Nov 2023 02:54:33 +0800
Message-Id: <20231109185439.1535962-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'preceeds' with 'precedes' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 71948dade0e2..568bbb64a389 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -511,7 +511,7 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
  *                                 ringbuffer.
  *
  * This is the new spreading code, assumes every sample's timestamp
- * preceeds the sample. Run if tight_timestamps == true.
+ * precedes the sample. Run if tight_timestamps == true.
  *
  * Sometimes the EC receives only one interrupt (hence timestamp) for
  * a batch of samples. Only the first sample will have the correct
-- 
2.25.1

