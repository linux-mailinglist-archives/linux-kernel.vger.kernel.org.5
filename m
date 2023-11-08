Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B014C7E52CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbjKHJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjKHJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:43:11 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AAF1721
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:43:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507973f3b65so9031553e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699436587; x=1700041387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTdWMQca1C4HNDwcm5hUdGGDITp+wUmav3/Udbm5/KI=;
        b=baufa41l/Pt1on8j1Tc/00RzQI/eRO0C+4gPThuhIpF46VwC0R7lZUCR6UmYjbtS9i
         pt1XvlYu8uTjJ/Njjk7YeHg1BCNzLTVKL3jsgum/7E5Ch6hzF6opsRo28GcC4qWqR2yt
         hqUmdV5jv4ZDQHvD6nDyUEz6zjAnZLp7FBnWSWdTNxuWBln5r1YvwqApYx3ngOu4QWAk
         lo3wJHDJ9aq0TMo36E2icvQLkMzHyLO4QmwxOQNBwYwJ6r7uBBAKWCd4s4oODaD98gmV
         gsEX/b9dPYLIYX1rBSZry5014OFgnJYsVnwCs7c6ZDWIy86oQHHYqaespZ7QwS6iUuDz
         ud8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699436587; x=1700041387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTdWMQca1C4HNDwcm5hUdGGDITp+wUmav3/Udbm5/KI=;
        b=kLboErhdHVWs7pzQR/zcAqU6EYEQShbeW+j19RCfOy+EsGnN3Lo3txuSo05SDrrEjy
         z66FMDY4F6KP7tELqNRO4aaC0QhjFYzEAq8cH1C/5P2dJRUbwD98f7IXYdf28k58Qz+A
         Rzr0EldSrOds4ckpRuR2kr/n8VTpjV7Gl428iMm28JWuIUk/hzrkxfPEpY2Q6pii97tg
         9HF+2RWP8SMVQKjj5U8ELI+tV85ZH/Y7QpicTKH8a9BL1wjNkFWnVFH+kRW4zTi+1Rrt
         ETZc7yEwbdtsqSLIu+Idy6MtbYG30bHiPHdVMlCpNbGOeQt0PnMgO5r1k7OuPdAUBaQO
         i2uw==
X-Gm-Message-State: AOJu0Yzq3QqVQPMDjsDA4JnSzAWbl4KvCdshf3QdmDA14Joi61Nz1RBj
        lCw8//APSIc3CG/jdR9mkZ87xpA2DtnzFvMUMdMgDg==
X-Google-Smtp-Source: AGHT+IGN2eNKB4yscUruMipZNeY2T5Lza6kfYIJcO34HkG89KBnnQO6rwioTsWDSLIeoKAO8YxOUNQ==
X-Received: by 2002:a05:6512:6d3:b0:4f3:9136:9cd0 with SMTP id u19-20020a05651206d300b004f391369cd0mr967668lff.44.1699436586681;
        Wed, 08 Nov 2023 01:43:06 -0800 (PST)
Received: from localhost ([195.13.248.78])
        by smtp.gmail.com with ESMTPSA id x14-20020ac259ce000000b005091492ac3fsm621470lfn.175.2023.11.08.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 01:43:05 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] mtd: spi-nor: Stop reporting warning message when soft reset is not suported
Date:   Wed,  8 Nov 2023 17:43:03 +0800
Message-Id: <20231108094303.46303-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108094303.46303-1-acelan.kao@canonical.com>
References: <20231108094303.46303-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

When the software reset command isn't supported, we now stop reporting
the warning message to avoid unnecessary warnings and potential confusion.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

---
v2. only lower the priority for the not supported failure
v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only
v4. move the version information below the '---' line
v5. remove dev_warn if soft reset operation is not supported
---
 drivers/mtd/spi-nor/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..75bac1418045 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3252,7 +3252,8 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		if (ret != -EOPNOTSUPP)
+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
-- 
2.34.1

