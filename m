Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441A7B025D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjI0LEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjI0LEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:04:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F5E193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:04:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c44c0f9138so79238665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812646; x=1696417446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Olui9SEAYGZ/qLdWlOCc/Jx3V7KvjrAKjWFcO+OQFo=;
        b=X1qikUUuvIVGQNWH1ne6FBTiJjHtCofgUHqv95pEoDIK6yD49dc9ZjH6CtSd8BW8kK
         f9OIPiRmIC+1SDu8xPTMQ8iFLYtuOILuv3BUL1ogQgY7lgqto6aFewz09sAOmVL0/0AA
         raEbhjE6cA5s50j3RaajiAor1r9x5M/2h3IyXQgytYbSQI1XfgzR87FznqsMLZCrVw9t
         01NV4OcWSm/yNKLJecM1A/YeMKSAoSnJ4sGWv96h6X9Wug9xwAup2739zNExg2FnDkbh
         jsOebyVEHnngPQStwxeueaVUf2bRx3RrVOhvU5ZJ1xlq5Q2/JQRJiE7YjIYoQIyf5KBi
         CpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812646; x=1696417446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Olui9SEAYGZ/qLdWlOCc/Jx3V7KvjrAKjWFcO+OQFo=;
        b=aabkqQ3wu0TS0kenrmGrVqRaMFvWDnyE5iy40SoFg5jvZS5AG0y3AfZSXpJJkXwtgf
         DpmH2OEJRNfCkP/ytbsKUFoJoU3VRXBSTaCY6Cr6Y+p3QV3Xxeti9NAp09yC1GPQn7yf
         6IkA3pbvMCz7IRknYAeNddyNSU4Mbjq92gHyxvt/KrVLhDqEl090twEYi2ttgBnDUMHC
         HaHqQnce0mRnQcNrlAyNC/kdOhP3rlui4bYs3yg/xA/n1cFfU4+8Czrf+jChmHvZjBI1
         7htDib7A6jitUjqtIJfEt+93AGh55N71E1ZZvg9Q+Fs0XLidP/208qCfQFSfw8HyhAgm
         I+Lw==
X-Gm-Message-State: AOJu0YyssjiUfqDTv6y3Fp3ZbG3bIHnmkCFZGg3NGShu7dyewBpRGPnV
        0Bcw94gWJI/i2dBNUCB/Le7mJQ==
X-Google-Smtp-Source: AGHT+IFxzrWNLufY50IyW3bEWJWsf1QdJoE3jrrMDzWOS4nFSr+1s4uQ8C8I1SJ4clQWRwKWHf4H+w==
X-Received: by 2002:a17:902:7d96:b0:1c5:bc83:556b with SMTP id a22-20020a1709027d9600b001c5bc83556bmr1203539plm.52.1695812646068;
        Wed, 27 Sep 2023 04:04:06 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001b9d335223csm8845093plb.26.2023.09.27.04.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:04:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: debugfs: Fix warning with W=1 builds
Date:   Wed, 27 Sep 2023 16:33:56 +0530
Message-Id: <d1f97b7149af693b2ff7cfe0126eaf774d967f32.1695812634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <0484680a9c7bb66cf1fb583a5178e753dd763afd.1695812634.git.viresh.kumar@linaro.org>
References: <0484680a9c7bb66cf1fb583a5178e753dd763afd.1695812634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently get the following warning:

debugfs.c: In function ‘opp_debug_create_one’:
debugfs.c:63:42: warning: ‘%.1d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
   snprintf(name, sizeof(name), "icc-path-%.1d", i);
                                          ^~~~
debugfs.c:63:32: note: directive argument in the range [0, 2147483647]
   snprintf(name, sizeof(name), "icc-path-%.1d", i);
                                ^~~~~~~~~~~~~~~
debugfs.c:63:3: note: ‘snprintf’ output between 11 and 20 bytes into a destination of size 11
   snprintf(name, sizeof(name), "icc-path-%.1d", i);

Fix it by increasing size of the `name` array.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 17543c0aa5b6..ec030b19164a 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -56,7 +56,7 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
 				struct dentry *pdentry)
 {
 	struct dentry *d;
-	char name[11];
+	char name[20];
 	int i;
 
 	for (i = 0; i < opp_table->path_count; i++) {
-- 
2.31.1.272.g89b43f80a514

