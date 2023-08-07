Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501077282C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjHGOuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:49:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27610CC;
        Mon,  7 Aug 2023 07:49:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686ba97e4feso4401371b3a.0;
        Mon, 07 Aug 2023 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419798; x=1692024598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVJ1NMXrZLpfm1TC5o9BlBqLzQ7UhV92PKS85S8rFNs=;
        b=Sroup4QU3HZ7LerI3fPwMoENwg0kBChAlLlahHdIe5ucOHVSbEpVo+ZcfpOC86jqnL
         41WK8xWU6Sb4NixCabglANoa8//xn/56r6m1jWsHNhEug7rzGL+rW/dsZsVn5ob4YH+R
         L3i91RmJmpV9CNCnrppAQS3BsumCDChhd4De712R5yR2/KV7DhkKQaWz+QlGHJWXs2Yw
         WFm+A2/3VqAJSkdS1khuK74NF4YQ9YZbGj9BJO2IcwUYwUJAMF4OZw5+HBoNvMuvyAwC
         QfIcb3XiJ4U6EX3u5KEvgf9i7ypvt8VVsT3JiGYJMHS4NjPOn1CeK/HOCn15tsACs+3a
         q/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419798; x=1692024598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVJ1NMXrZLpfm1TC5o9BlBqLzQ7UhV92PKS85S8rFNs=;
        b=GSBfv9jHyn99LBIKKKmyh3LGR1DqOtiLEAWGcNnTwdBoXpYB/4f5p3yaBupAaKTlLA
         bL8hUspCzltdw/ebmrpZ40c1VHSgtwUpl4/Dvz3NAFb2+xDF5bL4LXZ3tEobKKBebmko
         wCT5YN9a2KNLfuLvsWXjTd13cFeCPFGURnwR8U1pASL0cFIsfN4ORDu3rbHXNpID407g
         wPjUxuT30BgYP3EY3B1WeCbWNdZjZczImL/lYF/yQoJghMCDbPv+yWPUcZGD5+CzfkBH
         GdZnBlxKji86badXKzRWtvFZ9PnOb50AcucFGNE0SgjgG51GzKmy5J2DR3n7K8fdqAAB
         K6vQ==
X-Gm-Message-State: AOJu0YxEcVFGf0yzVRpXIwnxn2XtbJhesq3FW6rNyKCx8TAVEXgDp7T0
        SlBSZNUVEOJKswUrERT6vig=
X-Google-Smtp-Source: AGHT+IFxCA9Hh9AGaKvSkXYR503KWYhOuOlfrvrHCVIxaYrFzl1ziRZ0VuWFV8rpmy8d+cxHJY21ag==
X-Received: by 2002:a05:6a20:549f:b0:12f:bc36:4c67 with SMTP id i31-20020a056a20549f00b0012fbc364c67mr12099566pzk.61.1691419798413;
        Mon, 07 Aug 2023 07:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1035:32cd:7d2b:8acf:815f:3f79])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b006826df9e286sm6417461pfh.143.2023.08.07.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:49:56 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative 
Date:   Mon,  7 Aug 2023 20:19:42 +0530
Message-Id: <20230807144942.30317-2-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807144942.30317-1-coolrrsh@gmail.com>
References: <20230807144942.30317-1-coolrrsh@gmail.com>
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

In struct mpc52xx_psc_spi, the variable 'irq' is declared as an unsigned int.
The comparison of variable 'irq'  with signed int operand is incorrect. Also,
the return value from the call to platform_get_irq(pdev,0) is int and it is 
assigned to an unsigned int variable 'irq', thus redeclaring the type of
variable 'irq' to signed int.

This fixes warning such as:
drivers/spi/spi-mpc52xx-psc.c:332:5-13:
WARNING: Unsigned expression compared with zero: mps -> irq < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit message 

---
 drivers/spi/spi-mpc52xx-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 9a1a080fb..795c08594 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -29,7 +29,7 @@ struct mpc52xx_psc_spi {
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
 	struct mpc52xx_psc_fifo __iomem *fifo;
-	unsigned int irq;
+	int irq;
 	u8 bits_per_word;
 
 	struct completion done;
-- 
2.25.1

