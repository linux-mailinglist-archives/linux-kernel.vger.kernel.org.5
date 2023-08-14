Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6277BE79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjHNQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjHNQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:54:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4710CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so7484582e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032036; x=1692636836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++XkycmXXP25RSGckkmcwf1QKwi7KQ7LDbgEwWwhLO8=;
        b=bPduDkOPT2prTF9APnhmn6V9hOyX7uAyvqYqhp9lWdyhDjF9xJpOmmF23ceHnXJezR
         jAJ0bWcsnqGSH4Hev2heS7qlyiUSTMwp0plvxOttjKoB38eq0brP/ex4ISkhvxSrW8tL
         awdu5j+GqBrk4WXv1bWQa/uYnRw4BUTe4iERGHHIKmv/KPYgwO1t0TajsFgaxSIcyYlh
         mG7j91tWBiPV6Qn3PuoAcJwScCPa3d2Z56W4t01fdXR/vPt5PnWZMtcmOAq3a6tmgMTv
         88plPlMPBrb8dhWpsl+5TwSsGBaot+CgV4MXtMKyt9Y/WafTWx1Awpryh3/CXJNQxqlG
         EJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032036; x=1692636836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++XkycmXXP25RSGckkmcwf1QKwi7KQ7LDbgEwWwhLO8=;
        b=RiDVKByiZDMG9k4/Rs8aOB2F+m7yjrvTbbMcMgQJptc7r7K6Pte0LL4xgMuzh6t05B
         jS9NRCkk2AA5gE93aeGW1KBK7OeTGPTl5RWMG06n20SsXof4DdC7/7An2UApQYDv4Fka
         6qPUR3zGdA32oeKK5dCTmHR6PI/FnhYlFDHWGyfQrYDpsUrXbr6QDMI6quQhHYu8uEex
         5ugvFaaFPEwXlT+wDqkaTez4TtR0AQy6Hp2pTt5SYQkjH9wG/dpV1+4njg3eyu/TNTlX
         y353ZnaTvDDP3Vk4DUW1VirHeniT+jNbt7CmJyZNBu676EqwF8F83BfNohNIVeokdeWX
         l6lg==
X-Gm-Message-State: AOJu0YyHBoH+cxtq1k+UpfRaqIlaMYBgCjajRjHVJKi18bzvj0giDI0U
        +x9Wi7MkfvNLHnLlJVa2CNM+Cizgh+T0X9HFMfQ=
X-Google-Smtp-Source: AGHT+IFhDOF//485w/wj0uSk+zlWcOW4MNcstc2Muwm1qXZR8r8cKiGJYU9NklTVzgHIFQSpNBEBRg==
X-Received: by 2002:ac2:4ec3:0:b0:4fb:8de9:ac0e with SMTP id p3-20020ac24ec3000000b004fb8de9ac0emr6039976lfr.1.1692032036173;
        Mon, 14 Aug 2023 09:53:56 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 19/22] nvmem: core: Create all cells before adding the nvmem device
Date:   Mon, 14 Aug 2023 17:52:49 +0100
Message-Id: <20230814165252.93422-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Let's pack all the cells creation in one place, so they are all created
before we add the nvmem device.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2251103b2c5f..bc7ea001a446 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -997,17 +997,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-
-	rval = device_add(&nvmem->dev);
+	rval = nvmem_add_cells_from_fixed_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_fixed_layout(nvmem);
+	rval = nvmem_add_cells_from_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_layout(nvmem);
+	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
+
+	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_remove_cells;
 
-- 
2.25.1

