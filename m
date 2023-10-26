Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3D7D82CC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbjJZMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:38:05 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01489193
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:38:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-586a5d76413so392263eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698323882; x=1698928682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQqMrZDq+OCCC7E+rUSLhgCSlCp+SRTlpWYY64uyomU=;
        b=JrTeY1yOuZa7bNWUiaVa7Th71xUw3OJWNy9XLlqaiuCFo+bmq27A/WB7C7W6q8bLsY
         tiIHvCrBaGwKs7z4pSmdecw1yKH6GrSnJw/Jyb8vff1MXVxAbeziTh9h8g42eJ6jQytn
         W4thcownCOqObZYu+p6GgtAn7QAQX/oJ3hy7lfBXHLrgJyS7t8tyag8uYr6n0+wVcH2z
         1bjhz2QQJ2qME+7gzKuNje4MCUGn72iZuvU4nrniHJ2Pi1yt7YfLOp7ZpqZFzieB9BHw
         Gr4xJ3DLSFxDtPjuSqwOeYeePDFEBT/ykXGfoe1txBV5DA6uQbOIMk+/iyKmwWM8zSLh
         0BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323882; x=1698928682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQqMrZDq+OCCC7E+rUSLhgCSlCp+SRTlpWYY64uyomU=;
        b=cGF+T0+XdJtJJYYsYJD24NnKeO257cc6138fjlQQtFSONfCeOvNtrq+flDKaZ9O0Gu
         4pYzLMgkda27svsVLeMYAMSd6c9tBN+9+Phcq6tZZdjQu4I03msnCDU74Z1wDY286yKi
         YTCmA+ehDAXFCTqTK0ZD0J2wq/hL+lHIzuL/y6eoAbRAm1SrFke9bgEUbiF6B5bMI7Xb
         jbz7XOSf6JtC+MOsEX7etd6ib1jIDjdkXqDN7ACofj3oIgg//ydMXBA7B11dhzv9SPxv
         bjwd7k0TZZIx0EqJm1YxLTWxcutHHSqni6guk9yGw8dU94kCBzQEzEzJ3YpNSf56Zut3
         4v2A==
X-Gm-Message-State: AOJu0YySCYvVTWaE8e6Lgq9SvjCI9h5UrrsKkEA9XFzqv+zhbMVmB2tz
        V7/L5t8uVcif3xZAJTGMM2A=
X-Google-Smtp-Source: AGHT+IGvSqGHx22WraCmrfuVm1PHF2GnlMekMr+QaJzRW++2LrRxNblNzHLOt0zLttrhTsn5uczqBQ==
X-Received: by 2002:a05:6359:4296:b0:168:d346:ce5e with SMTP id kp22-20020a056359429600b00168d346ce5emr13381970rwb.8.1698323882032;
        Thu, 26 Oct 2023 05:38:02 -0700 (PDT)
Received: from localhost.lan ([2a01:111:f100:6000::4134:a26f])
        by smtp.gmail.com with ESMTPSA id u13-20020a65670d000000b0056c2f1a2f6bsm9035103pgf.41.2023.10.26.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:38:01 -0700 (PDT)
From:   Peng Liang <tcx4c70@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tcx4c70@gmail.com
Subject: [PATCH] sched/fair: remove 2 early returns
Date:   Thu, 26 Oct 2023 20:37:20 +0800
Message-ID: <20231026123721.957154-1-tcx4c70@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 5e963f2bd465 ("sched/fair: Commit to EEVDF"), the 2 early
returns in entity_tick can be removed safely.

Signed-off-by: Peng Liang <tcx4c70@gmail.com>
---
 kernel/sched/fair.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df348aa55d3c..74f72a01aad4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5322,16 +5322,8 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 * queued ticks are scheduled to match the slice, so don't bother
 	 * validating it and just reschedule.
 	 */
-	if (queued) {
+	if (queued)
 		resched_curr(rq_of(cfs_rq));
-		return;
-	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
 #endif
 }
 
-- 
2.41.0

