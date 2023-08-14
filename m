Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7A77BE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjHNQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHNQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7411E7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fea0640d88so6581475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692030566; x=1692635366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CilnvTYr96ahQ3O2WrOgBxIJx4YDnh0XI4B0xmqb0M=;
        b=K3tfo/pRi0hQAQaOE5/zas7ptBfHYn16dneCzYANrATrmd3cGIQCdpXrOSTG7KmZ0W
         TREFgrM33FiAO9NawMoyEQPXfIrpXtWmy1S2UkQpjLruNNOQZMCNcnZcE43w2x0gQ1F7
         PwHBa1x8W/wHh8Mclgn8dxWfDBHDyXvzNIdmhydpliJl+L+T/kkzvE1aWvxsCFKs+f19
         kXxHbRMC8pILpeMi3haQMoCmGZTY/RR8BvW94n69Pv3FSWxwn3broP1bIJX7PyuMoHq4
         LPCIW/J04ZkRRczjawHFJnvixsSAUBGQowv/xwk1Ysr5hjVYH+DQl+nF1EfHngThbg0R
         oh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030566; x=1692635366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CilnvTYr96ahQ3O2WrOgBxIJx4YDnh0XI4B0xmqb0M=;
        b=HNxNdB6UKrNBttJKjHwGaWICB6ntrcw/BRAJTnJbsWp3nB1/PUoxlUXyWZuff/nba2
         UHNX2iu0+MMdCObtV4UiHk6si1ESAqP10fNEOFy12mujuyn05grFphAR351fG0oTMXsk
         8cszhBVtoUpvgvZH3cr2eyhBK864H/M6b7hsGMthUHVUlLFqziTP7T7djymCuqjN2kim
         xpyk4awT5SK25r3OT688Kx4VRzF6X/1jXBQBjg5kFG5eU7zk5VdFQDwchA5WgNqdA8pk
         gC+YO5kyF8ZzcVLRYtXnQ2IedwMS9NU876xgKeIbEjMtDRSlOSAqJE0kZsyde0HIdMfn
         h6eQ==
X-Gm-Message-State: AOJu0Yy9vq2k9+NEVbx7ytJ0ZSzl9xwf6CpEskoIBziuoHrEVu9kM5eR
        d/OBGo9ntVkn0OH3y2t3fqC6tg==
X-Google-Smtp-Source: AGHT+IEVRfTa9DMGNwpE9nPby1QLZhfKTJZIH+YKW3oHOD/I3sg191THtlrKM2s/wSAsQb5bpSxyug==
X-Received: by 2002:a7b:c3d8:0:b0:3fe:22a9:907 with SMTP id t24-20020a7bc3d8000000b003fe22a90907mr7548285wmj.20.1692030566183;
        Mon, 14 Aug 2023 09:29:26 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fc16ee2864sm14743475wme.48.2023.08.14.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:29:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/14] media: qcom: camss: Add support for setting CSIPHY clock name csiphyX
Date:   Mon, 14 Aug 2023 17:29:06 +0100
Message-ID: <20230814162907.3878421-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
References: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

