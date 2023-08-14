Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710FB77BE69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjHNQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHNQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93EC5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so6178372a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031981; x=1692636781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E1H+tqjrcltsTk51oasBteSCGLkUFt3kqgkC3BldPg=;
        b=HKu+RXf1ENQEa7J1URcaC67AosvdRfHWnB15LuzNToTXrldDJ68D+QyZ382t8NrYPy
         KAFR7bps4P4eH0r3BhTHppP8/fzfBCUqfictk5DghqeWKlpmODP9XPcEQO2rC4oHlwgo
         goeQ1ne9HCMq8I9J1KoTh9jTuKghNB/LouzTwwjVouhJn/Q4TDmCK3+/XfzxyvYEACAn
         VqW4AUMVjA3lq5evD1aV9EhQwnZ1NTA8TMSAOOTvVNeDsxhQMf1NdGe9H+7/1uPkUQBf
         FyEwTdScSqQSyFimoe7EYin2QuSOvO6S+8k2hEJ5toGVl5V6XtuafygY13jz/u6WhbVm
         BqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031981; x=1692636781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E1H+tqjrcltsTk51oasBteSCGLkUFt3kqgkC3BldPg=;
        b=Om6UxGPU89dNdpNm2K8+ptRNwvS/rVDLQANRgb27muaHMbVJ0P1Lty54W5i65XTGMx
         QEnmJ8f7qM7bSBxkLh4FwTXU95F1AJlToC3PpPyubYRguLLOlI5+Ck3OE/FFXewrxp4A
         aZhGqCQWgnJs6w00hXRGVatr7IfaX7J3869nBFI+jbKK7Hi8Y5YAg+MYO5Chvh0oCiHU
         HIq+rpZaxCqF14zYNmKBSFcJLpsoFc0dj1qCUQnwBMSi9eWkdFb8zHT6ZgroygPO2j0Z
         CTZw3xcrp540A5kr7Uo0ZUVczYqu/PLfJbjgXXedePFaUuC6mtf6JK3eOsNo6pjEpVEb
         +Olw==
X-Gm-Message-State: AOJu0Yw6C0zAZ+GEmMvs/6+gIJQXxZOEkYDetxNlAJJReECnNkoGdL0L
        8AEoc8WeDs8G7a8GSiPttRvflQ==
X-Google-Smtp-Source: AGHT+IH/lS7Ba4JudTW2rUwEudhzZroTmR3YctyFysG1niYinNxUjhXTTIymKvofDu3JLb7THaUPow==
X-Received: by 2002:aa7:d64a:0:b0:523:3fa1:6a34 with SMTP id v10-20020aa7d64a000000b005233fa16a34mr6965299edr.4.1692031981191;
        Mon, 14 Aug 2023 09:53:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:32 +0100
Message-Id: <20230814165252.93422-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a970f1741cc6..6bfe02ab169a 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -125,7 +125,6 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
@@ -142,8 +141,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 		return -EINVAL;
 	sid->value_offset = cfg->value_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sid->base = devm_ioremap_resource(dev, res);
+	sid->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-- 
2.25.1

