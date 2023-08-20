Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EDD781D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjHTJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHTJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:26:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB24206
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 02:21:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so486899566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692523302; x=1693128102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9OULWVa+9T7e9o5P1jtC577YEjNpAm+SlBh32Oe6Yg=;
        b=eDVqdKJpbJD7MuQny9+PhQ5TFBxVSIo3XbudQeaIjzBlui+3e/vbqjkeOpOrn0zhMH
         6T7c9bZzLd9TkiJN0kUB3yH0OwgAkPkfT66CuwyqMEOXu5s5ej7Onmmi7eSPmIOIljwf
         clo+s7h4M9mgy18apQBtXpEn34uDj9l8+h7YMwSU6OV0nhcHn+p904R10gWX2RBVEkV2
         uRk4yGtdwCY6frKfaPAep8zXa5w9BYDveiwec2tqchY3Uzr7C8zuSaYZBLl6C3e3jBMh
         SUK0Z0XOPhjqX/fmA2QTrlXGC6hqsYkFYod6mBqxsX60y9HWb0rJ9nsd4jjuIU3xraJo
         Uekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692523302; x=1693128102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9OULWVa+9T7e9o5P1jtC577YEjNpAm+SlBh32Oe6Yg=;
        b=PNP6TNz+nAP2Eeq4TnFig9ChrYfWq7M/8c0VjG7Q+ntRLM/9eCC6Q8UYDzhvwLD3QM
         6WHPAr9yHQCHGYX5u+q7SjIwWl1qLfq44XZl6Ptq99L21i0++nZp/auCS1GEoHOB1mh0
         ES8be/uvR5Rbv/lCMcsyQckUaQS6M1bvUWd/Xss54yUVEPzEzaq31vyColqdf+qacrvU
         E0hKyfnbrOowQ12TtnL9AZ/iHTckSHoMsQ4WWDONInjPrdf3Ebd5VJ7Ft6XZC1icwkEC
         n39DNPMvVBUhbNgNkLGu6phvuMXxUIROvKI+QffN6LU5wV4q0os8qO04cxzUNgki//YI
         72JA==
X-Gm-Message-State: AOJu0YwY4TnokKXawHvIiUZAh32vszhXjg8ocOXEfedTdlcilv3VQJ+Q
        Ivxcs9vVERVHrjPP9NWuhllEig==
X-Google-Smtp-Source: AGHT+IHkeRUpC5ZDCIVCrdslgCCGuB/IQ0zwX54Vc5/y9+nsHHaU5zB3arEBOBCtnfhpKTUPxcz3Jg==
X-Received: by 2002:a17:907:6d09:b0:98d:ebb7:a8b0 with SMTP id sa9-20020a1709076d0900b0098debb7a8b0mr4282297ejc.14.1692523301871;
        Sun, 20 Aug 2023 02:21:41 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906705000b0099bd6026f45sm4320132ejj.198.2023.08.20.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 02:21:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2] nvme: host: hwmon: constify pointers to hwmon_channel_info
Date:   Sun, 20 Aug 2023 11:21:39 +0200
Message-Id: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---

Changes since v1:
1. Correct whitespace (Christoph)
2. Add tags
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 316f3e4ca7cc..8df73a0b3980 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -187,7 +187,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
-- 
2.34.1

