Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498E7773F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHJJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjHJJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:13:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0826B1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:13:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so834738a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658783; x=1692263583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DsFloMzJs2US5nqq3Dm/hbtJoJsMF3TU/damdp25rB8=;
        b=XOJKpRvZI3v3V/Mbdox2G3i0ZbQGR48Q2kNTQmiZaw2Jovhll60xFcV+qPgQ0hW08I
         IkK1MN+Y0gxQ4IvQeEUTEgn/Rpe+Iv2TCK7IrMcmAzI/GClLQCB1a1JCH943QMetJDBL
         1LN5HHx7Dk3c/ZTFZM5sWpqnS6T31Rx26KKgxUZ07k5TiiuP6CI2N8u4XTMgsWjZMSyE
         xxhhBpy3gb5Ev6Y3GwQG85O3H80FthqIFyQGSoFN8/t2BAYqRpBSmLoi1KBt6yU6xPuD
         Jiy1jYQu2YwG6RdloDcv/Xgeq0TJgqzeqwFYPHIQa/Fb0kD5ShgSYEg3psL88BcwEOu1
         YHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658783; x=1692263583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsFloMzJs2US5nqq3Dm/hbtJoJsMF3TU/damdp25rB8=;
        b=cGExfgwffNmLp/qcHQbLipL+vT6sw6MqI4wH13JFL8vec+TlfIjgDY6szZzt8hskWy
         i2RZUz1LaCGRCXuaHJzJiTE96uNL5QhDmjtmuxXKL2mn9e6VV87MmOgkMBUwr4gq5RcQ
         VquhLIZ4lW9RAH+HYKuUB3/k42IUULGG46qrJvpiq5EC812wdnnGrMT6ZYFrfC846cJv
         7Xl3IpLxRb46jwuwhyoB/k8ez///p4ALlMbyRoKFN1eow/ddwV7p+ugfeLxTGKY41jDE
         Ng/kUrhChXrR6K5pJZTHs016HR53BW9X4r+u8iKm65xAluiMRV2qzdtvPXzTHIXHXwIf
         2M4w==
X-Gm-Message-State: AOJu0Yx8i8gqKkfGPqjTxFHO/XG8NNlcvYdFO653VQYblOzPXDbC9+a1
        YpRV/hqCPW4LR7m8rWHS4VOl8g==
X-Google-Smtp-Source: AGHT+IEa6KKr+/bSPOZouZ3sU3rt+HBxNvlOcZ1OJqVlIYzX20Mdf86a7uDAa/gjcnzZuOXhMlJwpA==
X-Received: by 2002:aa7:c3d3:0:b0:523:1e0a:e12e with SMTP id l19-20020aa7c3d3000000b005231e0ae12emr1535085edr.23.1691658782605;
        Thu, 10 Aug 2023 02:13:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id l15-20020a056402124f00b005227ead61d0sm529559edw.83.2023.08.10.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:13:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:13:00 +0200
Message-Id: <20230810091300.70197-1-krzysztof.kozlowski@linaro.org>
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

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  hi6220_reset.c:166:9: error: cast to smaller integer type 'enum hi6220_reset_ctrl_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/hisilicon/hi6220_reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 8d1fce18ded7..5c3267acd2b1 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -163,7 +163,7 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	type = (enum hi6220_reset_ctrl_type)of_device_get_match_data(dev);
+	type = (uintptr_t)of_device_get_match_data(dev);
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
-- 
2.34.1

