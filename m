Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9B7ED9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjKPCnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344517AbjKPCnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:43:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93752199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:43:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso229139a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700102624; x=1700707424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6qfrVn0277bDMh3KhTRXLaLEzam5I22VMt+zO4G1cM=;
        b=Tby07y+6loHpFn3GK7zo2tIOIt5SuhFCe2zZz+grYyW7Y0tnWiG2OIpBecvO2Fh9RI
         XGMBm8nBq/I5E8p+umMuvibFpOhKn9LWAc7MEfDWROqTxf848rsKvgQVaoweeORtlYNk
         MH02Knl/+NYPEaFBzEvb/d9uLwrukaoQtYMw/gO2JuCGbzAeWqPv7/fweQB3Yi+qrYa9
         ikIPN8faAt7caQGC9IupSQ7rujOV5Jz9KvTljN8f8GLO/r03tFRxzOfKQCn3CBuD0V91
         HTWTdHZfeYQhMDtxs6ZquXj/mTYk3nDhBLyaPuAy7Fx2RO0ZWmnNX8uDGsUcMMPNIRRg
         pZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700102624; x=1700707424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i6qfrVn0277bDMh3KhTRXLaLEzam5I22VMt+zO4G1cM=;
        b=gBXeThGw1o/x6Gka1H5tyW+hjO830Zp2QpDBz+RE/H+uaqbaTX+M/1xDSDMMw/uitK
         E0GuzHrMmegxXJOA5g60Q59QD/FBMi0jAPPwNfUINBtfGm6Eoo6H+96q31U8NCslq+TS
         KsSAXTlF07DveBOyPzZ/rSIKew6L7MuG0pgnT1ZmwnUO7ml7YkwX7VOoEiCEqK+rGgqZ
         35XLNpy1OHJR/i5Cs14KzzHLwxltLC2vd5VB9DqhZMJmHde25AshQRXTYxVp4tVvj8Ez
         2kpXdo0l2BOc1TaQWu44s8pQ5stNapKbPqJyLSsNZYHG6L0NrHnaO95F7vR9Dhc69wBu
         qK2g==
X-Gm-Message-State: AOJu0YwmlsRUujgNdpiXzojWc74xyg+Kie9hOhjQoyS43AUUoRlySAX1
        fHUat2mmxWVK9VVkqqsXvxg=
X-Google-Smtp-Source: AGHT+IG2GkCzFqshPEQzqo2Np/ULMdeZyvTsdASC3HcD+LCRU2bZ7D2D6cFw0I99XSk2bP4lPmfNVg==
X-Received: by 2002:a17:90b:4ac4:b0:280:729d:98ec with SMTP id mh4-20020a17090b4ac400b00280729d98ecmr16831708pjb.47.1700102623916;
        Wed, 15 Nov 2023 18:43:43 -0800 (PST)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0a8200b002810810cc80sm589666pjw.37.2023.11.15.18.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:43:43 -0800 (PST)
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
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] mtd: spi-nor: Stop reporting warning message when soft reset is not suported
Date:   Thu, 16 Nov 2023 10:43:38 +0800
Message-Id: <20231116024338.337304-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116024338.337304-1-acelan.kao@canonical.com>
References: <20231116024338.337304-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

When the software reset command isn't supported, we now stop reporting
the warning message to avoid unnecessary warnings and potential confusion.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
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
index 87cb2047df80..96a207751cf2 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3237,7 +3237,8 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		if (ret != -EOPNOTSUPP)
+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
-- 
2.34.1

