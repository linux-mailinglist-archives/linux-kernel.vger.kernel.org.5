Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810A77A6B6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHMOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:12:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B36127;
        Sun, 13 Aug 2023 07:12:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6877eb31261so2342127b3a.1;
        Sun, 13 Aug 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691935933; x=1692540733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=manx55rXTBvaqxGz9G2eNlyGDJ5fD2gP+HFfKEjL4GU=;
        b=bitAK+HSSOXWRE4iF+rMlqah7ETrsE6uR3wghz9wsQSQ/EOGv9l35XkZuvMf6UGAns
         DB9JFmzhv589h6bWiW4qwEb2Exy3JkhIJQn6apJ6xRYuKMQR1k2RW7ZeV8PChT9WjnNp
         CXcoKdHM6qqlz3c+o4//hhn5sOaDb3n3B7KjFxE0tGje0V20kMDnS77F5f1/86m3/NOc
         rzni6RgzlBHdcHEOTFqibCDdmg5g7yJkbIlJleEPC3brIvlOHsqevknZuQV8iBjY2XTG
         4d56VHip7cwQxxuoUEhYqIBOX34zoIw679bTmI5PsVI9P0Zqrr04Mw/+S4+kuPFOPmuP
         XbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935933; x=1692540733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=manx55rXTBvaqxGz9G2eNlyGDJ5fD2gP+HFfKEjL4GU=;
        b=hwGz9JqHWQeG7dtS60VeMTArudZLp7iXejg6PMoyVe4+NOnQi5SckpgP6ojMaP9wxR
         P3ip/EbQqhBNqmgSnGF0ZzOwo54XQxoAmHPBuvRNa7GJDo+HuIyvCG+VaK5t1aKvWBJi
         0eYkkOvBIKDk6H2fEG/LxMlZcW7KyhsdAX4r9o6ar9bjOGHCwYt9J6SvOIyZ0fhK9Ms8
         nfUuujFKQMPvGv7oaHyGWwp3FzbtDfWEaQVfsUmhADNo5JicITQcQOSSn3nQ0JMkqPhQ
         CBlignOV3wXjR/+KtyOhu3JsXprnWxoypJBnxfvnEx04vAjhfP7AzkmDD08piKvwyV+R
         HVHg==
X-Gm-Message-State: AOJu0YwpQ3V193gl2llBO0z2VvKZksLekHJPFygK20o/YImPgqQyoYDf
        dze/dfjzKqhTFynpP2HEJIQ=
X-Google-Smtp-Source: AGHT+IEP9tRi8H6+FA02DYYEt3B73lTRYOFjQ4Vk/kD67vg/+ol7wC/NDcGgH/2MA/Q6VTx1cH1Dgg==
X-Received: by 2002:a05:6a20:1606:b0:13e:6447:ce45 with SMTP id l6-20020a056a20160600b0013e6447ce45mr7520681pzj.43.1691935932865;
        Sun, 13 Aug 2023 07:12:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1022:f538:d00a:1992:423:e24e])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b00687494a59bfsm6269649pfn.61.2023.08.13.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:12:12 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative 
Date:   Sun, 13 Aug 2023 19:42:07 +0530
Message-Id: <20230813141207.150336-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In struct mpc512x_psc_spi, the variable 'irq' is declared as an unsigned int.
The comparison of variable 'irq'  with signed int operand is incorrect. Also,
the return value from the call to platform_get_irq(pdev,0) is int and it is 
assigned to an unsigned int variable 'irq', thus redeclaring the type of 
variable 'irq' to signed int.

This fixes warning such as:
drivers/spi/spi-mpc512x-psc.c:493:5-13: 
WARNING: Unsigned expression compared with zero: mps -> irq < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit message

---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 99aeef28a..5cecca1be 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -53,7 +53,7 @@ struct mpc512x_psc_spi {
 	int type;
 	void __iomem *psc;
 	struct mpc512x_psc_fifo __iomem *fifo;
-	unsigned int irq;
+	int irq;
 	u8 bits_per_word;
 	u32 mclk_rate;
 
-- 
2.25.1

