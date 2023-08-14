Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564A77BB11
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjHNOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjHNOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:10:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF296E4A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso40546025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692022217; x=1692627017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X48QdO7ZGmP4DgIzy4AepzJ0PTfhLqJqNGkl4UYymyI=;
        b=SRtcXOVMzOKjZZZnzVrv+gd+fAPJ7NRNwpxrdhNIf94diXTSpYs9f3N0HqaGcjQxxB
         LTnaQRRsOKC7fb9SHQMUExlLaq8AFSs/ZaJ378O+r7sPcFgs93jd1gcWP9ZGQ0Ux6Q8U
         tborBXwxc2LnNxlrvqAtUCQa0DP78qTaN8p/qUHdpQQMGjgQCDnsjE3K+TugQszON2os
         yB13jc6NGBe7GvL86sMjpLz2UVlAbvA4pQmCwfcU4CQdFZ6OjF6ixt2viCdm9BF5IKNg
         XwcM5gp8R3M38VyWHNeO+AgAe7FidzfYrKRPI45+GdFbzEHMWYorragp+AlOdJSPPuXE
         erjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692022217; x=1692627017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X48QdO7ZGmP4DgIzy4AepzJ0PTfhLqJqNGkl4UYymyI=;
        b=DIJmoAtMMXf4y4d89VA3a851y2L3FdjdD9vdVHNd+0VLoJKWBsh37x7Eea/VmTEBXn
         mKHh2/MvnPSAs1L5BsyEpX/4t2MnTrScO6c5Hk+x8a3RoFhJQeK0hxLxIwJCKJOcERj5
         4Q94DBDTYz1LiIOjAJdwrbPKRu23f5i6/RR21F8f0vzOJwGq7/tn3b1AnptBw9zVYEir
         gcjwdGaTGFIwxpzBj5VcbPQaEAvnzOcdhAQxg7UIag5wUtkaPwyzZFBos7KtBegQikd4
         He/NWoitbG7rGIKCteW6uZtcC+casy14elMf3HzuhT4xICovBqgsO7qPWqbGzQAZVf0+
         tcIw==
X-Gm-Message-State: AOJu0YxPxLUiaVyfbT6+uCP6w9dZGm5bRphjMFn0wlxayD+V31e2QTCg
        oE0s1nmBL5IwzvjhQ5OvKM7gxw==
X-Google-Smtp-Source: AGHT+IHWYycbiR8omN3ul/lzSMiBGmAKop5QLk3DyoWb+BMbeNAQkuOT1rypmRR10kszRc1c9SopAQ==
X-Received: by 2002:a7b:cd19:0:b0:3fe:9a6:f44 with SMTP id f25-20020a7bcd19000000b003fe09a60f44mr7948223wmj.32.1692022216972;
        Mon, 14 Aug 2023 07:10:16 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm17232749wmc.24.2023.08.14.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:10:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v0 4/9] media: qcom: camss: Fix VFE-17x vfe_disable_output()
Date:   Mon, 14 Aug 2023 15:10:02 +0100
Message-ID: <20230814141007.3721197-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
References: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../media/platform/qcom/camss/camss-vfe-170.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 02494c89da91c..ae9137633c301 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -500,28 +500,15 @@ static int vfe_disable_output(struct vfe_line *line)
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
 
+	vfe_reset(vfe);
+
 	return 0;
 }
 
-- 
2.41.0

