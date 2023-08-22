Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE07846C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbjHVQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjHVQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:16:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C922CFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fee51329feso20143945e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692720995; x=1693325795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ2VKKNJcWBxsnE8fA4GSZFE3NOH8fxJi08OtAhPrEw=;
        b=tIDClvU//nBPMTdJlHk2CT/TMWkfyIhLDPLu4+5XBURuc6RdJ/SkzIMx3jZpdSK14l
         FptSX8duiC0WMwYg0mNlnmvYTEAM49cafgMwNq9teJr5rNHYBTriqsRtjlOieLZq+NU5
         MIhjZjg+oanc59XzBCaL0xbYKg+T9IJY0Vy1lBA4zIF6d190bqsy/N3KGr+CUlkOJ9dk
         GuGRA7khNsV/kgLjw8Ba3FcP9Jq/zk+VME+L33vDKcMza7WyDas2Ha8igxAHBwt04XmY
         oPOMzArb0uZok9P8jp9O7ehgdT5Z7/UoQqDe7YvcjJXhYRRqpp/wA5B4lGvbI44krfcp
         sbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720995; x=1693325795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJ2VKKNJcWBxsnE8fA4GSZFE3NOH8fxJi08OtAhPrEw=;
        b=XUucDiquqZQF4bERlf4UdYwrqUS3CYKKR5eVTncPGdFBPC6yoNNtA/sn0kktBIkAsz
         8x52re22bm114uIRy38T98P4CVKRNKE3mrD5eL5YXxKoFCcBI7DETIRiiQh/UyenM4Sh
         2+3CCFz87OJDFmcNWjtrsZUO5yNicej9VT5jgLjjA6cTug7qt1wPVa5l/Om/ZQ3rGTXh
         0Mohye7sfBnE0pCb7IqcgzlGOV3NqZg6Q2JKTqSB8Wt4O3251360fHcElnSutxHiV2cF
         9CS7aDoR6WJ3KOQPIdParLT0qhUdfxYMr1BhfrG2B+TYATq46KzZlAuecZA4MBzD6eZi
         kN0A==
X-Gm-Message-State: AOJu0YwGyLlZY6+qyS5LksWjwRp2PNNNLF8G1SXVXw09+/V96UjSUjQG
        +sKMamowX50Q4Z1WI3GtHeZkBQ==
X-Google-Smtp-Source: AGHT+IF0P/tGXfuORLiqfSIShYCcmVarjae6QmfjI8GMSwjt1V0vb+MYVmQcn/8l1H099oZIh40PiA==
X-Received: by 2002:a1c:6a16:0:b0:3fe:1c10:8d04 with SMTP id f22-20020a1c6a16000000b003fe1c108d04mr7447740wmc.19.1692720995134;
        Tue, 22 Aug 2023 09:16:35 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm16516130wmj.33.2023.08.22.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:16:34 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v1 5/9] media: qcom: camss: Fix VFE-480 vfe_disable_output()
Date:   Tue, 22 Aug 2023 17:16:16 +0100
Message-ID: <20230822161620.1915110-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfe-480 is copied from vfe-17x and has the same racy idle timeout bug as in
17x.

Fix the vfe_disable_output() logic to no longer be racy and to conform
to the 17x way of quiescing and then resetting the VFE.

Fixes: 4edc8eae715c ("media: camss: Add initial support for VFE hardware version Titan 480")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-480.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index f70aad2e8c237..a64d660abc538 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -334,28 +334,15 @@ static int vfe_disable_output(struct vfe_line *line)
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

