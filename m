Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22177282A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjHGOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:49:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D910CB;
        Mon,  7 Aug 2023 07:49:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-687087d8ddaso4437087b3a.1;
        Mon, 07 Aug 2023 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419794; x=1692024594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=manx55rXTBvaqxGz9G2eNlyGDJ5fD2gP+HFfKEjL4GU=;
        b=sWF0QXNHlaTAVhPmuX6j4ld3K60S6RM56ZBwkgf0Fy933B/1Z1E3ZQAAEnx4cPlkRr
         yeHpVQUWywjzavhwxDy5QkepIkD4gI7T3wGCWGGGh8241VuUM5tLeJ+ZvLm8Xf5zuMJp
         lAn/7oQE7BoPEnms3qqyL9qzLro3+rDBQVUf1FJHFSymrsFnL+29t3JhPLuID/INgaOX
         mZh3Bih+q7vrCr2wf2/XqVg2T/yFo2WSVQt5umEk1SgDH0kXb0xxwGLjBEM1YQLHMxuY
         4jEWkXh+i9NV8oFrSYmDC5zghdVw3JLWktCIohzg3opgqHRwFjMgyMAcTRNbpRTRAlW/
         HJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419794; x=1692024594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=manx55rXTBvaqxGz9G2eNlyGDJ5fD2gP+HFfKEjL4GU=;
        b=jTxmkUZm0cGQNZnqPS9Qi2Pp0TLNcDvmb55j5WxFCsCTGH3kiv3md1yIerqlTK0eFc
         lSVa92W239f9i/DmXlmSBxasY8pAJFHOA96GHGt2MKC2WKRJcIZQZThduaSrQ7ap8cVj
         ulc+CPdQRdblCQ82kFWCc/tjTUhyu32camuY9NB9VzoeYP092Gx7F1HJwE9gB429wnpN
         g6l74Z66QlL1xQUVGtVCcAyx1azT6pxEOYEZrY9MHgLR0g+YFeiRyg6u2Bsk0DsiUxM6
         po8smFQSL3OwNRLTCc4+4/FKPifNOSfxQOnFaCmQ04Glq0v1g/x5HY+pZ0yYQUHszQ0l
         t2RQ==
X-Gm-Message-State: AOJu0Ywyp6OvINRH78m3zXTZWUoukeGxhjocCcDWrU+5CMkXoA/jlpJW
        OCplN9q2FlUr2EcCD7Aw5MA=
X-Google-Smtp-Source: AGHT+IHSF2LjhCwFeQ9exe3vk3rKcmGFd9zuiy0O5vO0KOXNIP4cDVzDNZUx2ai2UjTwQ9bvQVghPg==
X-Received: by 2002:a05:6a20:258b:b0:13e:e3aa:d871 with SMTP id k11-20020a056a20258b00b0013ee3aad871mr12459029pzd.53.1691419793906;
        Mon, 07 Aug 2023 07:49:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1035:32cd:7d2b:8acf:815f:3f79])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b006826df9e286sm6417461pfh.143.2023.08.07.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:49:50 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative 
Date:   Mon,  7 Aug 2023 20:19:41 +0530
Message-Id: <20230807144942.30317-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

