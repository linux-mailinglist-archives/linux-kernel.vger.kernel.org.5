Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E069790B68
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjICJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:51:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF9F1;
        Sun,  3 Sep 2023 02:51:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0a4333e03so1934585ad.0;
        Sun, 03 Sep 2023 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693734667; x=1694339467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8FXjdDVO9yS7Gvo/LvVBPcgy31BVypQ/0qEk2ktmX8=;
        b=MPcp2kSZuDinWjxYIQ309QGvhjSSWQ2TGDwWyFDfqzpgBI/blFkY5I+E+1VYJR+wAX
         UXxnscTxHHAttDW0Yx7t8A9wVCMMz+NXF7y+c3iFFORDt9ZwEqlPpIzsK9vzuNUHOfKC
         2wWr+y8dp6jgRDZg36GMIiSB43Ni4Qpusoh2O4+j1HLdC7nDc43daZ1xSq0Z47RpdmuM
         eixPyEO9UMgeyC3TxpJr0UdP4230XLNegPaE2hdMA8Foxl2O2vaWupBq8XLIQzOGYCIB
         pAuT+lWeePqHIUFuFfFkMkHNazRR6igHAYNPXAy7ZtC7h4ei1ehz2KQpsTILH64vPKVB
         gvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693734667; x=1694339467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8FXjdDVO9yS7Gvo/LvVBPcgy31BVypQ/0qEk2ktmX8=;
        b=VvLs6pnEU6o66pXWsETSAmQjL/PMdZsYqdH6AQ8MyTnQiezy0Ppyc2gFwYH/6FKLZA
         olNVtfA/6UNj/BDyPmH37btyjpH6CZeaXJP1h0BXgGdcRhzxeABBphC2IIuAIXaTbkTz
         oGMgGdjnDO+uTBSW4iR38zAeD/CQhJ4Knlp+WlLqyRnLrqNU2Qavano9Maw4PZXYeAZJ
         zxcyZ4RxnW980Fh3OpBauJH3TgmQ7ba3dQ03sIlG9zIVoNQRcz8OLxK+plafT/CTa8qO
         hAcLqn52UiE5GUQ64tYoRj8OWbdNF4qIUg74/3wdzEoUXScEm1eM22Urlcr0yaf29t03
         bVng==
X-Gm-Message-State: AOJu0Yxzor82Hl99mLTtUEk4WYi9xjhjtvjo1cWtfz/gTJw9Q97Pqb42
        YhbEsX6833/F/Gd1WG3SGLxHWMQTdDfqVg==
X-Google-Smtp-Source: AGHT+IFN9+sx646tl37aTaBaSI7gBk72g024qTzkkcg/lU+pc/I/5jpRDPMI5BE8VY5roiJ21d9tWw==
X-Received: by 2002:a05:6a20:442a:b0:13e:1d49:723c with SMTP id ce42-20020a056a20442a00b0013e1d49723cmr10323540pzb.2.1693734667488;
        Sun, 03 Sep 2023 02:51:07 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id x14-20020a63aa4e000000b0056c5454105csm5550873pgo.93.2023.09.03.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 02:51:07 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] md/raid5: eliminate if-statements in cmp_stripe()
Date:   Sun,  3 Sep 2023 17:50:59 +0800
Message-Id: <20230903095059.2683850-1-visitorckw@gmail.com>
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

Replace the conditional statements in the cmp_stripe() function with a
branchless version to improve code readability and potentially enhance
performance. The new code calculates the result using a subtraction of
comparison results, making it more concise and avoiding conditional
branches. This change does not alter the functionality of the code.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/md/raid5.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4cb9c608ee19..b14d7ba38f0f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1035,11 +1035,7 @@ static int cmp_stripe(void *priv, const struct list_head *a,
 				struct r5pending_data, sibling);
 	const struct r5pending_data *db = list_entry(b,
 				struct r5pending_data, sibling);
-	if (da->sector > db->sector)
-		return 1;
-	if (da->sector < db->sector)
-		return -1;
-	return 0;
+	return (da->sector > db->sector) - (da->sector < db->sector);
 }
 
 static void dispatch_defer_bios(struct r5conf *conf, int target,
-- 
2.25.1

