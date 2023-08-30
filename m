Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6378DF73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjH3TKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245453AbjH3PQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:16:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94BE8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso3231067f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693408584; x=1694013384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/8j8dFWn4s/DJNCKaCJuJGk5oWKKJv4/UvwcNEFGrs=;
        b=qpkwBkQ3VyojMZYvkSJLkM5q6ej6Rm+sDrrv+6MaXQ9Zlm/K3pdlPzFCDz29iKncaY
         RM7EyZ8trn1bVUDCA1335SugdWSUIyISzC54eUFJmIfm3uSTmTH3nBLmkx1ZWECmd/BY
         G6V9TnUOkDLaJ0c6+F0UDUXmOTL9Abrnf3EBNWyr0phBfou9hJQctdI2MBnrAbCLeJyr
         LNgJFKSg1XpcF31G1nj9wvQBIvZKs8GOApX2fnM/MAjvNnLYGmsAHTaOpilsBsCh6KD4
         07moVWVCmvnreX8JBaU+/tvet0gLfhrlT5TAP1Kq/Z3O0B3+msPIaEhTqi3F8CcLLSxv
         tTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408584; x=1694013384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/8j8dFWn4s/DJNCKaCJuJGk5oWKKJv4/UvwcNEFGrs=;
        b=ChVVWDs7C2BuC3Bbvdc57D4a8TvCya/K64jllLkytCA92rQkoJiSET6sX72Yn7WUyv
         5+cy3oBlpcoDYVyz+Zy+JQRjfCLsmzqA8B1WJjvTQgB9eYOJXDVKI6KknGO4lzgGFL+M
         5EU2U0BP/VzzNWviMp8mBog9tBich9PE4qh/ifikMAz0r0X9uu/AXQereiEAWNNg2IYh
         9SdkRstBJ2XZ57I7OvQ4r6UW1lldvp4uAfQijUBT2L1wQZPhszZlvLYck9oXmAzQVB8r
         fusPFDrb1rb9/QQSs8sDx+KVURBXD4mi4OVaURI9ocW3tBk16ekUmm+sVWYYqGimQUs3
         IJMg==
X-Gm-Message-State: AOJu0YzFxWkMJj5VzurYOaqHkl4Ehr67T9O7pXLi94bU58ImwGrWk7/E
        FwuzkkpqbG6E3q68+QVBndBmpg==
X-Google-Smtp-Source: AGHT+IEXmtGoZReYyF800HatJ95OPCGdEjoJ2blpLdJZ/AsPzPDgYIujuHZyamPuVoaTQIobAYwcfA==
X-Received: by 2002:a05:6000:1188:b0:319:72f8:7244 with SMTP id g8-20020a056000118800b0031972f87244mr2241616wrx.45.1693408584096;
        Wed, 30 Aug 2023 08:16:24 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0030fd03e3d25sm16989961wru.75.2023.08.30.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 05/10] media: qcom: camss: Fix VFE-17x vfe_disable_output()
Date:   Wed, 30 Aug 2023 16:16:10 +0100
Message-ID: <20230830151615.3012325-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
References: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two problems with the current vfe_disable_output() routine.

Firstly we rightly use a spinlock to protect output->gen2.active_num
everywhere except for in the IDLE timeout path of vfe_disable_output().
Even if that is not racy "in practice" somehow it is by happenstance not
by design.

Secondly we do not get consistent behaviour from this routine. On
sc8280xp 50% of the time I get "VFE idle timeout - resetting". In this
case the subsequent capture will succeed. The other 50% of the time, we
don't hit the idle timeout, never do the VFE reset and subsequent
captures stall indefinitely.

Rewrite the vfe_disable_output() routine to

- Quiesce write masters with vfe_wm_stop()
- Set active_num = 0

remembering to hold the spinlock when we do so followed by

- Reset the VFE

Testing on sc8280xp and sdm845 shows this to be a valid fix.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 02494c89da91c..168baaa80d4e6 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2020-2021 Linaro Ltd.
  */
 
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -494,35 +493,20 @@ static int vfe_enable_output(struct vfe_line *line)
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
 	unsigned long flags;
 	unsigned int i;
-	bool done;
-	int timeout = 0;
-
-	do {
-		spin_lock_irqsave(&vfe->output_lock, flags);
-		done = !output->gen2.active_num;
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-		usleep_range(10000, 20000);
-
-		if (timeout++ == 100) {
-			dev_err(vfe->camss->dev, "VFE idle timeout - resetting\n");
-			vfe_reset(vfe);
-			output->gen2.active_num = 0;
-			return 0;
-		}
-	} while (!done);
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 	for (i = 0; i < output->wm_num; i++)
 		vfe_wm_stop(vfe, output->wm_idx[i]);
+	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
-	return 0;
+	vfe_reset(vfe);
 }
 
 /*
-- 
2.41.0

