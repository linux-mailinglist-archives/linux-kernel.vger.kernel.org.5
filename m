Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317F7846C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbjHVQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbjHVQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:16:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A565CF0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4213738f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692720993; x=1693325793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X48QdO7ZGmP4DgIzy4AepzJ0PTfhLqJqNGkl4UYymyI=;
        b=gYyBA5s0dymZ6dhLnxYaGLZWFiorzQMmIfddojMH5qoC9CBVbRdCcDmIiww0HORiik
         wZK+2IzBc2mCkj8606O2kct0ENdqY8kbBAZeOHUxKzmyqY55xy9pwI59fXCxtzwH8pMd
         ivsQuoIbf+b+pgcPwUvvNe0QaKfyz3PBokE2hn2PjpvIHNAaDnorwdnccqX6AJZputdF
         8Ae0a0L0/fAoK4THeFHyTK3HQcUcZClKAt9G0SwntUy+mkKlbwAL67gzWk0eXJTJ0kEw
         KhKAO98A605I+p4J8jlPQObuwwPjs/etlq3Sy2QuCAkdS0mNWQNXexfB51ulTK88SX5r
         tkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720993; x=1693325793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X48QdO7ZGmP4DgIzy4AepzJ0PTfhLqJqNGkl4UYymyI=;
        b=FIxKNjSAz2oH42BRkBtomXLmNJv25yy4ppGFnyWZp+REm/1bGsacUs+4o2BEvIEgMo
         d91HPp0tCXVlBTKVxRgAwGB4gjcLU8GC4HRRO0jL2mjIInU5sYm87M3nPrtf6UWcLn3G
         Nl59SkMO2Y8K01PplohhYd1n6s24DUAGZXSrPw3yhw/22B9yRrCmuaFb7v19ZgXvZbOx
         CyfMpSjk7/mxKRgDMrPV82ZqT8eAz8l3MDXX23xYEajVgR/u1LRre+cbN+SwZ+DsPg6J
         4UjGCAF7EwfENcnrqNFVHAoF53Kypj/WZkgZUCkWFp8PSXXzWL3U9xMT6gqQXFZ4vTwj
         hzcQ==
X-Gm-Message-State: AOJu0YxLCszPHf21dmEQhOHKAD4MH3tEKcxU1gkFeFvfzvlM6ERhzDdE
        eRMpX0EhgeRL96byblNr1fuz3g==
X-Google-Smtp-Source: AGHT+IGIMDF8lppDQgxjPIAKW1ri+H7YPka52vp9cQO/xOhvri9kKzihS3t11gTZtEk1pR3zIU0FZg==
X-Received: by 2002:a5d:6a07:0:b0:314:415:cbf5 with SMTP id m7-20020a5d6a07000000b003140415cbf5mr7817538wru.51.1692720992993;
        Tue, 22 Aug 2023 09:16:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm16516130wmj.33.2023.08.22.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:16:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v1 4/9] media: qcom: camss: Fix VFE-17x vfe_disable_output()
Date:   Tue, 22 Aug 2023 17:16:15 +0100
Message-ID: <20230822161620.1915110-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

