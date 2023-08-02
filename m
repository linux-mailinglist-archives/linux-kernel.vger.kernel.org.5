Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADB76D656
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjHBSAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjHBSAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:00:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522AD448B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:59:03 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-564656d952aso3808a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690999138; x=1691603938;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J1wRxvwIBG6whrhBQqY3j42uJNiPMlVZKztMAOT2qV0=;
        b=QGUrIT89MvYS3t/BjCmVvSURD+MbqebJGtc3cCwz8zJN5xreAULo9hPxkBuDJTlREo
         Iv1et5XsMrpwC92xhQTbDswjowkDR822RrJZWcJaEMTKj+YSgL+gT5PWAtkeW70uIZM9
         NvmTY5E7sAEr94iOp23I87Fpb60kpow/fwNdC1beZrLqSfH4pBdvAETp/2InSsUZRcaV
         nyFuua1NT/VJ205mGgHCPrQD/vmuJkTHI9h7wvFAWyTl24eNyr98twK8K2ywXjMEKyze
         Ra07W7/nade914hbMyfmF9EhZT5ijKu0V06TMhKSj++vO1UjREsYg7Wm6PMT+8oWpVs0
         v97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999138; x=1691603938;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1wRxvwIBG6whrhBQqY3j42uJNiPMlVZKztMAOT2qV0=;
        b=HkMJgIurJfwiZ6cVqlFwdXxRHz67/6eOYhgs29+SJ5kSp+dhBkH4Wc7+Vv09LlNLz4
         Ug0Td2aPw0OTho2jx6uEJ6RYG6LoYDUaMvKNoNpDX0S9fGx7ChDiNA7L95Junwjy6BvR
         iwNqKTkCk7EGXzRSqh32OOqcN8fqGNErTgs5F8pRDNYDBgDVXqIaL590+M3W9DPPscKJ
         7rSDNlpYZoysB0mmCcT+1yhQlmNcm2ZxhOKEoixwBtR3k02C9gsYdkmiJi69lXPJTlNX
         1axgUrhdeUw3+sc8VzxdD+9f92VbldRTHoMsyGCTIeKRQlaErN8ua+Mv+Wv6qp/ekhVq
         Nu5Q==
X-Gm-Message-State: ABy/qLa3ZjERk5NwUDFt0GYMgqrOTYGfS3SXRUtFlJR/0WJQPmbwedSl
        j6KxXEJ1M5ZqNiBCxvpZEuWxl9ld6ZHgG0c=
X-Google-Smtp-Source: APBJJlGBxnUJKAwPN2SkouJDIO/T7ZOjzXPDlTrpZnzACU8F/JTOH7Q9WY1CCvSB96tNZldsP+lPhdnEANtOQbk=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a63:745e:0:b0:563:dd4c:7779 with SMTP id
 e30-20020a63745e000000b00563dd4c7779mr104804pgn.12.1690999138281; Wed, 02 Aug
 2023 10:58:58 -0700 (PDT)
Date:   Wed,  2 Aug 2023 17:58:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid>
Subject: [PATCH] platform/chrome: cros_ec_lpc: Remove EC panic shutdown timeout
From:   Rob Barnes <robbarnes@google.com>
To:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dtor@chromium.org
Cc:     Rob Barnes <robbarnes@google.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 1 second timeout applied to hw_protection_shutdown after an
EC panic. On some platforms this 1 second timeout is insufficient to
allow the filesystem to fully sync. Independently the EC will force a
full system reset after a short period. So this backup timeout is
unnecessary.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---

 drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 500a61b093e47..356572452898d 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -327,8 +327,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
-		/* Begin orderly shutdown. Force shutdown after 1 second. */
-		hw_protection_shutdown("CrOS EC Panic", 1000);
+		/* Begin orderly shutdown. EC will force reset after a short period. */
+		hw_protection_shutdown("CrOS EC Panic", -1);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
-- 
2.41.0.585.gd2178a4bd4-goog

