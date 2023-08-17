Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7B177F963
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352104AbjHQOiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352067AbjHQOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A92D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3110ab7110aso7031798f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283111; x=1692887911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CilnvTYr96ahQ3O2WrOgBxIJx4YDnh0XI4B0xmqb0M=;
        b=YwTeQTNLM9eIWy12X5K0elLIAsH1jrFwere4LkOVehwSBrbX1XJFXLm0wZ1huOMlcb
         uYfW7SewcC3PRa0bHyVusBnwdi/KaTsaGMOMOb7bWRQiHlAVgOsFbsFokAbJUyHHutKG
         t/u6ZAqctzypvbIUGzT9a+qNjkPNFGiU8HYNMRP4rG9a5ZEeZJcL3rRjPDvNSAB1toTH
         70c0jmDU+8VXtv9LLRlh01FURuoxKwZQwC5UC7y8GZJ7OaRRXSZcLajOgI1hXtqJMzEI
         FUHcfMBp+XO7/awzpWQGryX3dQfLZF8le+HHkiH8IHxaGwVGVoowAoSxFw5zIXU7t+iT
         glUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283111; x=1692887911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CilnvTYr96ahQ3O2WrOgBxIJx4YDnh0XI4B0xmqb0M=;
        b=JgDmloVtg33qh+blelobQeI+fa6gKRP7n5Um3jscNOaNJz7SubTJdne+EgU38ZyY/4
         X8q/m0dy22Aq5nr14h8fVfcFdUm7BY95Tzv1g+I6HGeAScZYDf/NkxalZuWTWr5wSCpn
         PtFq+QNjyL3xVMJB+Gkj1WlVtDkP77PYQpuaRs0HBJmqwUWwV6rP+34mLPNIJe6q8t/8
         900BjJlTJs9/w7THS5KxK7RoiocdgMYJvCwh26XMgn2TJb476BoE+yTIgitcDUMeb6Wj
         lE0I5n5ZoPdFQJgZ2WgDd+uI/UjrDzpl0Uevy2ZRp5+vr94hU4BMoczQ7qOQ6pWvp9IK
         FFNQ==
X-Gm-Message-State: AOJu0YzpBtnHcddLmjHNnHqBoV72uRybdXusEba+4tHAFL70RAvgDt0J
        /gABD2AhRxBp9vyeU1YqYNPvMQ==
X-Google-Smtp-Source: AGHT+IEao7YnjHg3coPXwWG667W6QdSpnb6X8GoTtuIqq6drB5OqPJwYRIplZY8lboMZR68QteUrdw==
X-Received: by 2002:a5d:4641:0:b0:317:d048:8d87 with SMTP id j1-20020a5d4641000000b00317d0488d87mr3847749wrs.61.1692283110826;
        Thu, 17 Aug 2023 07:38:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:30 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] media: qcom: camss: Add support for setting CSIPHY clock name csiphyX
Date:   Thu, 17 Aug 2023 15:38:11 +0100
Message-ID: <20230817143812.677554-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
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

Several of our upstream and soon-to-be upstream SoC CAMSS dtsi declare
csiphyX as opposed to the older clock name csiX_phy.

For newer SoCs csiphyX turns out to be a clock you really need to set.

On sc8280xp for example we will encounter difficult to track down and
root-cause RX CRC errors without setting the csiX_phy clock. On sdm845 and
sm8250 we declare the csiXphy clock but seem to get away with not setting
it.

The right approach here is to set the clock when it is declared. If a SoC
doesn't require or a SoC driver implementer doesn't think we need, then the
clock ought to simply be omitted from the clock list.

Include csiphyX in the set of permissible strings which will subsequently
lead to the csiphyX clock being set during csiphy_set_clock_rates() phase.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csiphy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index baf78c525fbfc..d9c751f457703 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -687,6 +687,10 @@ int msm_csiphy_subdev_init(struct camss *camss,
 				if (csiphy->rate_set[i])
 					break;
 			}
+
+			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name, "csiphy%d", k);
+			if (csiphy->rate_set[i])
+				break;
 		}
 	}
 
-- 
2.41.0

