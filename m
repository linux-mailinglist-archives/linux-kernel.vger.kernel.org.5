Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B63784B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHVUGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjHVUGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:06:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13122CEF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1617318f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692734794; x=1693339594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X48QdO7ZGmP4DgIzy4AepzJ0PTfhLqJqNGkl4UYymyI=;
        b=BUJ1MI41qACsWQ/vLK7pgu/2HJjCWyekOC5Y8gXK+ebDGE4B0VUbu/J84uQoiYFAU+
         NeK0t3bOziD8KiBUgmP5+TLQ2Yf7KH7bRGMVvqyPR2NUhYoCnwPBmSA0wFXoZ/j6euPd
         7s5PZyZ5AlDxecHQxqtQ1+gPFbf6XUFTtSlokxi1gc+JYxC1ZLQnjNvI6MvV1iNKuf2W
         qL8N6LQRVtkvTmc68WxNzEd7mqeibAY6OfUUD+DZMtlYLnDV4mjzohWSIkx6VdQVNBGf
         sQLyPABmIgc+Lpl8TTYcPd1GhtA//l7picoSgpWeCDl4j4coUaI04lB//H5AgNgf0oaj
         WSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734794; x=1693339594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X48QdO7ZGmP4DgIzy4AepzJ0PTfhLqJqNGkl4UYymyI=;
        b=VUB40UbjYP2tCKeNUf5D13exsi6xVRuKjBr+60dkKuO6tTsuRRxuKL5QhcrQPaFjtu
         Bcmv4ay6krlyDMDMusQ9hv+60xsiSWnuEF5VL6UUt9lqxLWmGBLKouBwkIYo5tWvnh7h
         vGAkPPdtnVIdm8XI2m4NMVfFXCyCdvek3sh8Wt5HZb7kEkLyt4DtDh6UJRUt8an+MPfk
         TYwCtyqHgY1EfWcqmjhI1vb9lvy/RWIM2VsfavTiv6xHDVCdy5JwpK7FL0vPjah7YJO/
         MHutBnlIUcPdhOrgwkk/uNwRA91HNEsaxFYsSEweHwvAOV6l8aHXiBSVjxbGTd4CJdkE
         BZ/Q==
X-Gm-Message-State: AOJu0Yy0vpTkj0eRpbQBG4k9FoupH8bZEWs3Q9gfZb7lFZvc39Wz15xv
        yPCgPFZe5otuMH4xPUvLFF8GUw==
X-Google-Smtp-Source: AGHT+IF+bofEoyb8KWplasp+JLd1ZKK7rGpWfmHgkQb/utt0re9fXPVXIBLEocPKvn55p+73ba8T1A==
X-Received: by 2002:a5d:55c3:0:b0:319:7a9f:c63 with SMTP id i3-20020a5d55c3000000b003197a9f0c63mr7672656wrw.50.1692734794667;
        Tue, 22 Aug 2023 13:06:34 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y12-20020adfee0c000000b0031aeca90e1fsm12873690wrn.70.2023.08.22.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:06:34 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 4/9] media: qcom: camss: Fix VFE-17x vfe_disable_output()
Date:   Tue, 22 Aug 2023 21:06:21 +0100
Message-ID: <20230822200626.1931129-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

