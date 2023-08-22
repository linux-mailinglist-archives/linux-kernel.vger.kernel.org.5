Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71120784B17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjHVUGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHVUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:06:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E32E4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3159d5e409dso3765422f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692734797; x=1693339597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W80DDZNGe/khXLl1P1oJD7Ws9Jxxl4GH65wXpEW+I0=;
        b=gTgztgGy9pUJimfjEmJCOR3TUuzn1C7SM2NY3p8LtYt+KnIKh7AehQAxjyi1MRdSjz
         2AEHZASUrXMVYy/hNBrWxRbJAGj7ohemsnfX0vU/OpVAqh5yOkalG/UdFSt6wdmExEEH
         XRI1kWt/3AAuv/C4MeeYaRbCKA/H4tOAConUOH7Dqm00vFbLtO0RR0QdL9IwwE26+FsW
         W1aD1CqZ1keskTyVKWz2NVsA+nxFO2rIPiUU3Gb0iZ4sTkiWtlVEhORtsT7mJ7IKLPBP
         5BNkyDnFKgT4ELI56wGD7x1wWGwO68Ow5qS1xDO0HJ1k0y0+Dg1EmTSGmHjZ2uHL9c39
         Y4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734797; x=1693339597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W80DDZNGe/khXLl1P1oJD7Ws9Jxxl4GH65wXpEW+I0=;
        b=hoHfIGYHFH+SJoR9NI02FJSuHDeuge/K6iK0BDvRhf777SzhkqvD/tqiiie1QQ3EqG
         7FH2kIK9yXtTYdNxzuHbI4yC3QcaTecoUkuK9lacKzSg2cHJOpgEPDNo8tBHFMXZ3aVU
         KOK0l3wPFgbizr9yJ/8dgNxBEWpXCStPY5uD36YSaApsCMQSyI6or8FqVnQ+Lf0TV6PO
         MS4Ue9JmVecXgZrOBp1YFqeLAraZajO/LzNmxyNMfB43AGQoEwIcMfAhgHQoaFLGCxa7
         bE0hjGt0JzVe3iLuPrGVJ5+mV3F9EvSe03QpVRfPURNl25w8BDTkHHl4A76/C1kb4u9H
         xpvQ==
X-Gm-Message-State: AOJu0YyUIT+24hE6TVKrbbVb2WgGdDall4kG08scesvWc5kQp13QbsCW
        Mjob1eDOyBWlRJvZbpWno446Ew==
X-Google-Smtp-Source: AGHT+IFBYUFGxtIAxAk2uSJPPGQrrPrF9Iw6Oo1/N2yschbv9Ni528UmOdOalKcEfFMz8WMOqf1ujg==
X-Received: by 2002:adf:de07:0:b0:319:6b56:94d9 with SMTP id b7-20020adfde07000000b003196b5694d9mr11658665wrm.2.1692734796970;
        Tue, 22 Aug 2023 13:06:36 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y12-20020adfee0c000000b0031aeca90e1fsm12873690wrn.70.2023.08.22.13.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:06:36 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 6/9] media: qcom: camss: Fix missing vfe_lite clocks check
Date:   Tue, 22 Aug 2023 21:06:23 +0100
Message-ID: <20230822200626.1931129-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_clock doesn't account for vfe_lite which means that vfe_lite will
never get validated by this routine. Add the clock name to the expected set
to remediate.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 938f373bcd1fd..b021f81cef123 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -535,7 +535,8 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 		struct camss_clock *clock = &vfe->clock[i];
 
 		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1")) {
+		    !strcmp(clock->name, "vfe1") ||
+		    !strcmp(clock->name, "vfe_lite")) {
 			u64 min_rate = 0;
 			unsigned long rate;
 
-- 
2.41.0

