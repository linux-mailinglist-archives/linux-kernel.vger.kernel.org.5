Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681F776812
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHITMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjHITL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D62123;
        Wed,  9 Aug 2023 12:11:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317715ec496so182176f8f.3;
        Wed, 09 Aug 2023 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608314; x=1692213114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xhlXRebsXbSxUbfqBN5lh6qztABqKEYUhQQm4iljog=;
        b=PmobMLJmic2QNvJGOsFjS1ZoKyARB2rmxdOBbA/jcYani3BMlpHyyS40EBRIG1+qH1
         ifJ2Lt5yd9bdh/D9332e0pcTKXFZ7aGc+46JPe7lY26+Fyx1VFQ31iA16tNCOurWt+qj
         KY5JiTaUK/S3CiLzFSWEnStmXXnOc0nEpULsxPFZ6yFSMOjBZCTwgahHkW6WABAhTYq7
         ZE4rV/ibz80hSo/S105RniIxz8jglyQ41IJR3L/+nezLwYH75LQh/hzE6UD+q1dogYOW
         ww6vtNs8rBNT3FmtCH5qNn78RCKdiz/H7cEBm/RWerEPYVufZKrTDrIqPCMk+vSO0V3H
         WYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608314; x=1692213114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xhlXRebsXbSxUbfqBN5lh6qztABqKEYUhQQm4iljog=;
        b=OQPwaHr6n3uBIZXU/4YomZwyG0sLzKgloGg5eCI12Xxh/tfMgAhdf19kJR/DrQOZUS
         4fwSJk7xRVxIzFt/0PRBOnGjgKVxcyHguE4wpJqi37QhSYWpiqrgsrLr0T1KUt36he9f
         sb56IPYH/1fcqoiN/daAXDon7po3RbHY1q+qEQrXxH1WhKlzzVqkG5tKEhvpx3oQpNuT
         kCQGac21Bl5MuDF7B69b96Qx+mW71AHz/YpazFuWEGUPO4n0nlFb/WoSvZ8KG8wODeEQ
         99wrPnbWfxRifhRN/zRXw5B7ZiD/rel4y+6nEm0ZVMYZNPusepkIxSelX8yUIZsDXfgJ
         3JgQ==
X-Gm-Message-State: AOJu0YzBPVeTjoKfrZ0C16vKNJKS06ZzlolGI6qJ4tRAAHMuYzvQmIVV
        paAIkVLH8FRqfEfR5/ORvtM=
X-Google-Smtp-Source: AGHT+IHnI+4DFUYb8EuXDW27ZHSVy6EfJigcOUl3TOA1HtfSnE7P1VdGU/pFaIddS3Yz7WVT21xyog==
X-Received: by 2002:a05:6000:1b0a:b0:313:f9a0:c530 with SMTP id f10-20020a0560001b0a00b00313f9a0c530mr215855wrz.52.1691608314065;
        Wed, 09 Aug 2023 12:11:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:53 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v7 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Wed,  9 Aug 2023 21:11:34 +0200
Message-Id: <2c69e918cb6dfab663bb62952c554b6b72f58390.1691607526.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1691607526.git.mehdi.djait.k@gmail.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid error returns on a failure to match and instead just warn with
assumption that we have a correct dt-binding telling us that
some new device with a different ID is backwards compatible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v7:
v6:
v5:
v4:
- no changes

v3:
- changed from 'unsupported' to 'unknown'
- removed the opening bracket

v2:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index ff8aa7b9568e..494e81ba1da9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1036,10 +1036,8 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
-		dev_err(dev, "unsupported device 0x%x\n", chip_id);
-		return -EINVAL;
-	}
+	if (chip_id != KX022A_ID)
+		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-- 
2.30.2

