Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DC7A53C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjIRUS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjIRUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:18:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99E115
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso3855e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695068327; x=1695673127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkkuj5E4x1e6TpkXqhUiBmxr9QkX14PDo84XKtGvNno=;
        b=ALreQFON1ZyxVPrJtG+ADSKUyWCJuHAtFFPIB1YyZ2J3cSqAMr7l1D6YW0WolnFJdJ
         ydaRpRtX40gYxRRGiECs0f1w2IP7fqQb7B1Al35xIQRk5+5fvWLVLYdNBJvkMUAc1iu4
         9cW1q7K4obVhgYA9iEAC+XiO3H4BbE/liTKirm4Pa2i7zZ7IN0lpX0/Cz8hp3Uk2/ewF
         OL+Z/HtODL8IwI1Zzv2QWIHgDyGRAj+XLgA73ppa3bh+ryRodeT7EWFdHRO6+ynrCw2X
         Avf0IpLe9/uDYeuhenjWcQanYQ3XFAI8k/nnZPJ6UR9+bWQomEQjYP/KqP5Fstx8idzK
         ZYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068327; x=1695673127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkkuj5E4x1e6TpkXqhUiBmxr9QkX14PDo84XKtGvNno=;
        b=Jv6M4hne6Oi48HE19jpvMMcQ2qGPS3SWaTTWcU+BhEq6GaDJteDztIIRSf07vqwNvY
         bIj+JvsR0ijWKOTydKxaRr+IuuwLnAru12bxWjR3vMJB280UsMvQxKOnt1wINhxmE81E
         9KbfMd7R7u2n1q2c7a/brd/7i7d5yQxt/CXJGzkSqg9/aIkX0gI0hXlCot9DcqRrdymw
         mh9jykrjQmhxtwSHw7NVoFMwIyV+QbE2M6q0NLMii77YZ4hQMsjFf6o+clQbC1FUfsUT
         zA9G2vUvQajwBBjM2S8uuhashrOcz9l3B2Qo0dJFdTpVQOPeFpqclnVSkqMxc0wGwqqW
         tn+w==
X-Gm-Message-State: AOJu0YyVOu5JnOb47NIMhveakzf5Zd2J+tZ9jfllBDrQVT6wrrT/ReBT
        QdLJkW/AYjksZXYeW5mhSNZgLw==
X-Google-Smtp-Source: AGHT+IFPfXjLQWY+XTrivjGyq5y6EUdbaEOdn9f05wDcTfA1C8e0Gf41avxSx5fLPuTL4g/18veJ1w==
X-Received: by 2002:a05:600c:4fd6:b0:3fe:ef25:8b86 with SMTP id o22-20020a05600c4fd600b003feef258b86mr22708wmq.4.1695068326889;
        Mon, 18 Sep 2023 13:18:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:2d2b:53ca:9e7d:d91b])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d4d44000000b00317e77106dbsm13372719wru.48.2023.09.18.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:18:43 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: document mmu_notifier_invalidate_range_start_nonblock()
Date:   Mon, 18 Sep 2023 22:18:32 +0200
Message-ID: <20230918201832.265108-1-jannh@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document what mmu_notifier_invalidate_range_start_nonblock() is for.
Also add a __must_check annotation to signal that callers must bail out if
a notifier vetoes the operation.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/mmu_notifier.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 6e3c857606f1..f349e08a9dfe 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -459,7 +459,14 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
-static inline int
+/*
+ * This version of mmu_notifier_invalidate_range_start() avoids blocking, but it
+ * can return an error if a notifier can't proceed without blocking, in which
+ * case you're not allowed to modify PTEs in the specified range.
+ *
+ * This is mainly intended for OOM handling.
+ */
+static inline int __must_check
 mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 {
 	int ret = 0;

base-commit: 6704c78e2963a5682b4ac3c0e609d36f2405cf17
-- 
2.42.0.459.ge4e396fd5e-goog

