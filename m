Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D477BCC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjHNPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjHNPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:13:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B71B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:13:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so40825865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025983; x=1692630783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CilnvTYr96ahQ3O2WrOgBxIJx4YDnh0XI4B0xmqb0M=;
        b=BFvmf1AHI5Aq8gzxukHQqOLdavI/MlU/TWd29OnFQgc7zEfL5xyaQ22w5xrfdPTlGZ
         DplE5xmYHqAXMIPzS60HIAHJtiQVW2eGv/9EZHqwHpscHdcYx82K+YbyxzEPNKW0qSOk
         WBA9qQNuzVkeBEWHyS2fwlyNjPWMVkc7M8owuLhLMXp/4BW+V3245BVWp0H+pvgoq0Yo
         awgWb5Ej+ZtE2eJELwELhS2IPUh6sSPQu6kh36mRMm9D8irwkIbF8b8d7gO1jUx3trdV
         K1zDTnkqt/RoxJeQntrRkj+IT8o7A8g27skabyDv3rZig7GczqFy9pEvicwDtATIrEMb
         y2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025983; x=1692630783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CilnvTYr96ahQ3O2WrOgBxIJx4YDnh0XI4B0xmqb0M=;
        b=IZMcuxgLdi5rZBn3s47a6UrVLksLho96xJLJo213SyyUkFiyPuervjkrZtAgA5e3bT
         9LZGiAW3fXds4wwXmDpceGmDZKibAFsKXv1YOzgVDDMiJGpAhMAG9a+xN4ddumBXPAsU
         Ga2zW+07s+ft6seWVaVqK/JAluz+AnqOclfNDyDqOtaLRH/Bi7BTZBw7feDTkWSY7nHr
         ABPjk5EGUYqmfQhUMfhwRtkd1aoY5iTk2yvvCw1JUcsV2h8WeW0n68W97UdlP7fkBhT/
         XWll348rswdsHLAqv2oUNcOoYIrgQJCXrY9tlYhnpggMLLaBz2qrQEjCKjZmEflP4D6t
         nhew==
X-Gm-Message-State: AOJu0YydxZWHQTKFgXz6hYunTUVeSw4f7wJssJ6Qvu9lJI4G3jA0k5Cr
        W5q8ppypLyn0qojBUpdsHVgraw==
X-Google-Smtp-Source: AGHT+IGRs50M0vPLfuQzjUUguCsbH9hS+8qdTzuOGeZllLUzfNeRYgMsdcliQzEV40UAzc8haxOEkg==
X-Received: by 2002:a1c:750f:0:b0:3fe:2624:484e with SMTP id o15-20020a1c750f000000b003fe2624484emr7929347wmc.38.1692025983526;
        Mon, 14 Aug 2023 08:13:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:13:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 13/13] media: qcom: camss: Add support for setting CSIPHY clock name csiphyX
Date:   Mon, 14 Aug 2023 16:12:43 +0100
Message-ID: <20230814151243.3801456-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

