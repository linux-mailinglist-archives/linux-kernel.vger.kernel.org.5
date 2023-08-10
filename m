Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5510C777521
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjHJJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjHJJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:58:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54400270A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1078231f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661512; x=1692266312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5W5BwA5ems5Xa0NhS4gDL/rwiqkgh7KLUrr8yr7fBbY=;
        b=rr2hi8z+103UkejPFtAtNm6HpMpOXEXFcpwcSUzMxZsGlWYRqsj/IX6H+rShmsg7hN
         IIv3VSs9kSfb4xsqgF1XGibsqqf8tjJxxtgGe3TGPTFCiCV2YKC/wKQM90OSeHl3EVqK
         Uv0dlR6QZu1alB61xpBqeDR+ylkERjTrr7x1GeL1tTKNB/XnKtNnsijdet94CiDHa4fp
         jTOdLnA2JbC6rnfLiD1CTthl9t2XTYSIcGu9JoyYY07wlB2F4Z5+RPFlX8gkilRmuf6q
         7C0dfKsC2FUK1P9xr70NLnyOMuqXHlCcTh3lTwTlluluoM/eB5Re0Hsb2a+bb34EuhjR
         18Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661512; x=1692266312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W5BwA5ems5Xa0NhS4gDL/rwiqkgh7KLUrr8yr7fBbY=;
        b=VE9/zT7sJxNqDgntQWPsaohjHomOJkTFrKu/pymTn1mM6LZlIUyxHKqHk+TLPbIODH
         ABX7mnAIKhM74ymKrVUP8tjx5yzv7K7zW5ZcGwPby3r2sSLD/T+9CldHK3T7wdQJKfTy
         2XqXFLOskqBXMd6TcnjxTKxFbgPnMZFh83SaGG1WwVQKmdeg7lda8ZZc7mInXyYF+usD
         9FLILQikx8SXugnZV3DkjPImG2I9MeeEYNyD4IahZUsGduebO0wuBpNmDaBVWh40+JzS
         3npV9fo6SIWqRB/0VIllUvpmxBKQqEvJjJBp5qVcl449Fd9p8SSpqx8L/7Cs6q0aKuEL
         +9qQ==
X-Gm-Message-State: AOJu0Ywqv0KZpa7QMDMY5jW31EnrboWq+rVnwT1kmG0LxjSVPtG0dHwI
        VjuWqy1tb5viIgwkYINl1Xj7Eg==
X-Google-Smtp-Source: AGHT+IGKK0F0MRbbkAuFb8wrCFC9fp/6jl3NafUdjMs0srGMlY8+KQjkyDbaXcRl2iCDJvdIMNcnvQ==
X-Received: by 2002:a5d:658f:0:b0:313:f38d:555f with SMTP id q15-20020a5d658f000000b00313f38d555fmr1093373wru.24.1691661511801;
        Thu, 10 Aug 2023 02:58:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b0031437ec7ec1sm1633117wrq.2.2023.08.10.02.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mux: adgs1408: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:22 +0200
Message-Id: <20230810095822.123181-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

'chip_id' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  adgs1408.c:62:12: error: cast to smaller integer type 'enum adgs1408_chip_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mux/adgs1408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 22ed051eb1a4..29836062152c 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -59,7 +59,7 @@ static int adgs1408_probe(struct spi_device *spi)
 	s32 idle_state;
 	int ret;
 
-	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
+	chip_id = (uintptr_t)device_get_match_data(dev);
 	if (!chip_id)
 		chip_id = spi_get_device_id(spi)->driver_data;
 
-- 
2.34.1

