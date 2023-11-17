Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D517EED0B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjKQIBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjKQIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:01:31 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7662D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:01:27 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2cf67be2so881204a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700208087; x=1700812887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FD1T5/Vwe2w6D1RvspPERaCOb/Tcilq1ukgsM1ozSQ8=;
        b=O09pMfK6gB7mnHSUqgY6jZRzemLI9nwsff25ZJLbZwPoyIpxOq/PplcmQRAgUfk8Xa
         vmoluHz3vHAyhbcdylcXbkM3y9uakfIP4dI4htyTEA7i2IHVrhoU0i7Nyd7rhxok0KOy
         F3o+Tim6nJWKt8lV1Dv/WhjWvRYiKHqYbch5ZOmi7VXCEeGTqOGQ+63ey9gPfQJ1n5MP
         6cDq3jWok8fKDSPfXVbjsNM5sEpdsaCHFJify35i6/Pi32wrgcTlWQvsNixNHnOxi5r9
         MriDGnH7K59oHLgbb1H3B0C1KRBnCo61JJwYMyZI23CPGKgWwvP/Sq34LzbkicIjAI5f
         QimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700208087; x=1700812887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FD1T5/Vwe2w6D1RvspPERaCOb/Tcilq1ukgsM1ozSQ8=;
        b=pQF1r67ZX4jB5Qlbe0WkWpwB9G8bWyuuRibpeUtPqpy3x99BsIDYsEcIwgKz2AfTzw
         oBcAT7Fi1ZMqLYx0jfbFrrNQVLugH3F8hz6PPtH+gfqSIiambv4vlgLclg6r5UMezQib
         bOz6AM+0R8kdfHQsaR+Scv2X9SPQfQ5J0RtDsNWTCujyzB9D46aUwZqQoDDONHbYgXbM
         CiJeOOwARcQ1e+MWScZQmtg7Z3FAri09/+J0N31fK7Ifnq7phyOfgnHu5c0JS31X09DW
         fY/D8Lc5YFwvzTHzxk1lzgLn1cwKMkXXEyy0T7oCDnqwXh50fKedHjb8K0VN6yN/mCaZ
         8wuA==
X-Gm-Message-State: AOJu0YzXujw6yuvLI2IAkR3+c8b10sSjzyo79AU/7fNr37GqkOiO3/1Q
        gQ01paafUuLTSk1SHq5Ta5U=
X-Google-Smtp-Source: AGHT+IEfcVDwF5UBVACewMd0qOxufqPaEG6V38epjOrdzKvbslrWCgRP/U44uZ7Xsr/3RRxaDRfZ4A==
X-Received: by 2002:a05:6870:670e:b0:1ef:cedd:5c32 with SMTP id gb14-20020a056870670e00b001efcedd5c32mr23630637oab.3.1700208087098;
        Fri, 17 Nov 2023 00:01:27 -0800 (PST)
Received: from rin-ThinkPad-L390.. ([2401:e180:88b2:6c98:99a1:b0b3:129f:54b8])
        by smtp.gmail.com with ESMTPSA id p11-20020a056a000a0b00b0068fb8e18971sm885567pfh.130.2023.11.17.00.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:01:26 -0800 (PST)
From:   Yiwei Lin <s921975628@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, wuyun.abel@bytedance.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975627@gmail.com,
        Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH] sched/fair: Update min_vruntime for reweight_entity() correctly
Date:   Fri, 17 Nov 2023 16:01:06 +0800
Message-Id: <20231117080106.12890-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since reweight_entity() may have chance to change the weight of
cfs_rq->curr entity, we should also update_min_vruntime() if
this is the case

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07f555857..6fb89f4a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (!curr) {
-			/*
-			 * The entity's vruntime has been adjusted, so let's check
-			 * whether the rq-wide min_vruntime needs updated too. Since
-			 * the calculations above require stable min_vruntime rather
-			 * than up-to-date one, we do the update at the end of the
-			 * reweight process.
-			 */
+		if (!curr)
 			__enqueue_entity(cfs_rq, se);
-			update_min_vruntime(cfs_rq);
-		}
+
+		/*
+		 * The entity's vruntime has been adjusted, so let's check
+		 * whether the rq-wide min_vruntime needs updated too. Since
+		 * the calculations above require stable min_vruntime rather
+		 * than up-to-date one, we do the update at the end of the
+		 * reweight process.
+		 */
+		update_min_vruntime(cfs_rq);
 	}
 }
 
-- 
2.34.1

