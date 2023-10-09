Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70E7BE725
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377836AbjJIQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376910AbjJIQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:57:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A321FA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:57:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso34270685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870673; x=1697475473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2D+qd1LEt3eJ/8XHGRVqxXgOIKNs9E3/VA/WHhSU4M=;
        b=MPD6ZLz3Oygw97Ahyj3zMbBaAvQcaeBhP4L0iVE53kYmz51MUTV7Z40oQDqXtj5PKX
         /YxCDgtUIoCEgUlOCwFDcZGzuBLalKfv4dyWpAVMJZXoNjjgk9/2/66L92j6R7Wtdnkn
         //uFE74D9h9n4/EbntkNepOWScQwhUcgxNLA5fBb3G8kSogc7z9KkXMAFq/LTR3EejoJ
         J4q0afWgH6VWW4GBiOkkiLZQcSKDer3mrri4QkeYhMDa4h3AVX3KGTQGnanAAq57cjlu
         vAE+7pNAI15CDWdLJrORbaEayWTDDtxKWzmXptNhwhasP8z238s4gcx37w1NHq7U6WYV
         RMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870673; x=1697475473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2D+qd1LEt3eJ/8XHGRVqxXgOIKNs9E3/VA/WHhSU4M=;
        b=eqHWmU0CDTdPDYJc+WJBMHyYqHVjhYaIgvU+tREIep9DYVh64uerw7NLtNxgz5sKmZ
         J2KYUPzPyAxl1Ya9dYdBGGUHfaeAVS6RCvPooOJcS2p0UNonN365Mv7Iy9PecpUxs/DC
         yhSRNqSy3WExFpRX8utZnIHavrCKh7MSeoZl/X+RTxG6wu+q9ZMXNLTGj1GeYY/6T4XL
         kt8JraKEKEik2YGhAICvh3N3vkQSc2T6v1IN8KbSnEZn3AmW8FXkNhi8HJXw7bin0R2c
         fVRbXgJ7WYkdaDS0ppWRv1h4MGoUobalxIgURPZgaofBumpHj9KqSqDh1mojyR3/NHPk
         +1Hw==
X-Gm-Message-State: AOJu0YwAIWqyc0m0DRnSK+9igc1BZLSmJUI8WbEL8kxG/DTZvQuBZOdq
        KQd/5RdNowWaX5YqEPO8kQyALA==
X-Google-Smtp-Source: AGHT+IElXmP4SCjtxv9ewcCHPAkm9pRR5k2/mRyhENiprO5xOyrGrQtF+ixAcWjFdyzzy5QLvmmn1g==
X-Received: by 2002:a05:6000:1092:b0:320:968:f3b0 with SMTP id y18-20020a056000109200b003200968f3b0mr8718653wrw.35.1696870673079;
        Mon, 09 Oct 2023 09:57:53 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:57:52 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drivers/counter: add local variable for newly allocated attribute_group**
Date:   Mon,  9 Oct 2023 18:57:37 +0200
Message-Id: <20231009165741.746184-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the compiler to keep the pointer in a register and
prepares for making the struct field "const".

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/counter/counter-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 42c523343d32..47e1e2c61cf0 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -1122,6 +1122,7 @@ int counter_sysfs_add(struct counter_device *const counter)
 	struct counter_attribute_group *cattr_groups;
 	size_t i, j;
 	int err;
+	const struct attribute_group **dev_groups;
 	struct attribute_group *groups;
 	struct counter_attribute *p;
 
@@ -1141,9 +1142,9 @@ int counter_sysfs_add(struct counter_device *const counter)
 		return err;
 
 	/* Allocate attribute group pointers for association with device */
-	dev->groups = devm_kcalloc(dev, num_groups + 1, sizeof(*dev->groups),
+	dev->groups = dev_groups = devm_kcalloc(dev, num_groups + 1, sizeof(*dev_groups),
 				   GFP_KERNEL);
-	if (!dev->groups)
+	if (!dev_groups)
 		return -ENOMEM;
 
 	/* Allocate space for attribute groups */
@@ -1169,7 +1170,7 @@ int counter_sysfs_add(struct counter_device *const counter)
 			groups[i].attrs[j++] = &p->dev_attr.attr;
 
 		/* Associate attribute group */
-		dev->groups[i] = &groups[i];
+		dev_groups[i] = &groups[i];
 	}
 
 	return 0;
-- 
2.39.2

