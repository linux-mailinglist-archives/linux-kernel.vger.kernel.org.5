Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE477FCF51
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377015AbjK2GnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbjK2GnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:43:10 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54671170B;
        Tue, 28 Nov 2023 22:43:17 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e330033fso3894750b6e.3;
        Tue, 28 Nov 2023 22:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701240196; x=1701844996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6qfrVn0277bDMh3KhTRXLaLEzam5I22VMt+zO4G1cM=;
        b=kZqsuYJhpnRSk4CaACBSG0acrUy/5+TsxuD2SDSCkjWnrUUabRJ4FzepB4aKzNsNRZ
         zIPMHRtbVNjr0sfzdhGYanpUgb5XD0DejB2Zn/gsESJUk9TU9tQzV7m6FVziQPpVgzNW
         USSzCTmbWjG83bt16S+yJ0o2/WlQf3/3bdFF/0CRgrTavUtMY8Z+bSECA2t70emTlUle
         f7VOSGv1LyI9/cdXOrccNYWfToIs9we/NEk6rRwZ2WJZ3popU7ziWrW3cQhbCT9TxfMd
         DkJG+/pFAl7TFC9UOFhJhA27tfbDY0m5voLPPQpQbinQ7miji54cciIFRCL2vGzr5Y0n
         jS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701240196; x=1701844996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i6qfrVn0277bDMh3KhTRXLaLEzam5I22VMt+zO4G1cM=;
        b=tmKQfyfnnsEAOLnyDjRUQmDL5r7ZzsjTkVUzEGAyQsmUhQm9uaIoGpFft+wJhpFc2e
         MlY+zVtT8/z8OF4hur3pWWLhIrzeUJZgx4RS/8y/tOkPKaf7qAFoNptAJ9RD9p4uILp8
         f7DHv6MD0wGEsoawYG8rks6Y/6s7txbyoY7SGxWIMTr3SV/lus5kfn/oYAjD4LAdPmUL
         VFBV3FtxYQC1xIqhDZE6VF6aJq3yL+hvfozn1VnzivPt8t2qS0WmT3UN8dSGpHl28c6t
         3ZJ950LRGuSG98mPD0Hwt2mb7X3uOCr11m+VxQ/eobd2Qr4KU7550CFvd6KvbKLxilSy
         JxcA==
X-Gm-Message-State: AOJu0Yzy/eqedp0ZmlaMnaJDCwPGLmFS4Mp2wVJl5EmDuMKgWTRaNMoN
        bFe1G75Crt0zhz8hzjbgy84=
X-Google-Smtp-Source: AGHT+IEaYdguNW0MvrtGlevAV1RSYiqQFJXUoenv/xvsoqABBLuNLSdryk2roXcEnPubcmjtlLFCzg==
X-Received: by 2002:a05:6808:23c9:b0:3b5:ae0d:b208 with SMTP id bq9-20020a05680823c900b003b5ae0db208mr25801175oib.6.1701240196530;
        Tue, 28 Nov 2023 22:43:16 -0800 (PST)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b006cb638ba1aasm9877362pff.49.2023.11.28.22.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:43:16 -0800 (PST)
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
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when soft reset is not suported
Date:   Wed, 29 Nov 2023 14:43:11 +0800
Message-Id: <20231129064311.272422-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
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

