Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5D78BD20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjH2DFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjH2DFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:05:02 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FEC1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:04:33 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-799761430c2so1415144241.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693278272; x=1693883072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lI8M8ZRptwkAjGBaYfIMQ3H4xC/5cD7g/wcdXEPGuCc=;
        b=Cu6WsiPFMLf6j21mZ5bpWDD2HLENVemFQb6I7fYF67iDV1qjfEhKcHatMfXUGGo5+O
         wgvcuQdyIaUux+zYGiN1Af2/pqFrE5IStznVq0XAjJWnQJjz8aM+N6V1PcSo0sLg/cq2
         qcQQYea1AnSJvvrLen2UB04SBogiUEpssKvSn+ysZ2Xk5mVrgTbSCI0jKnAn/Ag6io2a
         nNsnaFKWJMxzFH9z6uBK8Hq2TKYS4zVtCzHoCRp4dPg34v9mgOmo9DR0VK/7N/bgnV6x
         NHxNfRY0GC8A1sdL4s1jHVkNzu2Ro0ESl5gGIGs+NAhAUY5AFLx/N1NUzx9GVIv6cxh9
         VZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693278272; x=1693883072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lI8M8ZRptwkAjGBaYfIMQ3H4xC/5cD7g/wcdXEPGuCc=;
        b=fcIYK0Z28BG8J2RWCuyjJn/+4UiEOKLq7gqWuyY39n0lZinzSnr+0+5BNlP2A8WPjT
         dAFLZDJLGr23pkEYAKMX5Jv6YcYddn47CeOED8yzooN4Q23SEpTg/m9TYYORJZAHxf62
         3ZJ5EstaqYgZTV0dU5RFr0YZ4B3G7TMHfjg70FNb4DIH1Ri5wwkZODpdmeL8TbTn7Y08
         AwuWHg+8n8eHA7e9Sr7rfyKkHG5EoOjA4sX+UIsu0uNa0j09UymBOLCyV3Hvj3G2ByoD
         mb7Yd9zLbRsTncyKeB53R1AA/e1TEAGEe36iq5dU3cdhdvfEyyLCuulGJIym4aZDOyoD
         BFZw==
X-Gm-Message-State: AOJu0YzePQLI6u6MLB81wjwDQw6Eg+st8VNT99Q9y5qg1C9wvJVnuC4S
        PHTsdWpXYi48do4kS4LowhmF4A==
X-Google-Smtp-Source: AGHT+IHTF28IGaor49YyZHwAHBaCrtuW6UPntdJJCZGsWCp51X0FCGXipOKB1pqaAGCySQBfHCODCw==
X-Received: by 2002:a67:ef8f:0:b0:44e:94b3:9253 with SMTP id r15-20020a67ef8f000000b0044e94b39253mr12974923vsp.12.1693278272265;
        Mon, 28 Aug 2023 20:04:32 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a1a1700b00263e4dc33aasm10355488pjk.11.2023.08.28.20.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 20:04:31 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/fair: Make update_entity_lag() static
Date:   Tue, 29 Aug 2023 11:03:25 +0800
Message-Id: <20230829030325.69128-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function update_entity_lag() is only used inside file fair.c.
Make it static.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 911d0063763c..8dbff6e7ad4f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -699,7 +699,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 lag, limit;
 
-- 
2.39.2

