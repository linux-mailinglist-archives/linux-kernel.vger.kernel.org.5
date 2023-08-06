Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8737713FC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHFIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHFIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:37:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF311D;
        Sun,  6 Aug 2023 01:37:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2682b4ca7b7so1886187a91.3;
        Sun, 06 Aug 2023 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691311060; x=1691915860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/VsbE0slEMRhZ8TGMIdWLlmOlT7Ip9MoAgWWsTSAm8=;
        b=KzgTJejuxzMjf7uHhJZ1yYeDin/Jxg2lr0jvwD1a2ZB0FOHX1cWxEidzAj2xBDkv1A
         6RZGS47QIYBBfFWTWHCIJAccg2aNjxoSrEz7VGUNQWOIYeD1GtiwBFC7ZOjw0Tt/eLis
         dSVrChsTtepG4sT13WoxwAq2bULnjIeo93EZmwLYOTO7EevsicYjme9BfsYwxKPmCzTW
         sxopvfmh3WgJjbierzs+xoEm0BzzA8X/+Lq4ConhV6PqcM+67bwrwn2ZPatD02udTbqW
         0oBWwcW3wBlkmBSNRmpFiciBUThVlLiUlvHvfRRK6/8NsW1aW/Bt/TdXcvmGZFqg65+w
         H5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691311060; x=1691915860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/VsbE0slEMRhZ8TGMIdWLlmOlT7Ip9MoAgWWsTSAm8=;
        b=XyZpBqUfY8/iiq+74TwoR61kj0Yyi4B/AFIeQkkaPt3mBb+XLUZtKPR3QKrVOAR978
         9WuV2kS84PLT/Pz51pzTt4vR71CeYedeaLpvLCrOPblcaQ3fY6xASf71e/9B7dTiiWs7
         xrYuf5PZ9THld5CXdLrqXQ7uZbAYa3LCiPP8pCiBG7kp7PGlM7uAJLxQGRrR7tEQBAbh
         qI90PEYtE9t3AR69SMoe+eJAZLYfCsiW0JQPpj+Nh6+g3n1R1bikzFyFtlyepWUIK2l1
         7XIRmgcOnjUXVzBeo6WPzQbClqJyztAD9mYLMkkKJCNLftsVoF5qgG+bhd8M/1d0ztPL
         yuUQ==
X-Gm-Message-State: AOJu0Yym9bdRozU2rjOhHb3h2IRItVZ3aqVgD/FWlf0I+j1w+qQyvZ7a
        NmoSm2M4vdQXi/AxOs+68pc=
X-Google-Smtp-Source: AGHT+IG7mAl6KpNhqZSM2ZAq57uyOgALa53jlvIRprYxgC5XwMf2mDueVaeumtqB2y4Dp2eKUnCFQQ==
X-Received: by 2002:a17:90a:f287:b0:268:5558:de4c with SMTP id fs7-20020a17090af28700b002685558de4cmr4980313pjb.38.1691311059896;
        Sun, 06 Aug 2023 01:37:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1028:5dc5:7c0a:52e1:6b87:38ef])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a64c400b0026307fa0442sm6580403pjm.49.2023.08.06.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 01:37:39 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v3] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative 
Date:   Sun,  6 Aug 2023 14:07:33 +0530
Message-Id: <20230806083734.7685-1-coolrrsh@gmail.com>
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

