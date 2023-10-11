Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0957C4D20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjJKI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjJKI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:28:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD398
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:28:07 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3ae65e8eb45so4543306b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697012886; x=1697617686; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzwy8dVzFkqBpnclcii55xn3E3Sc8bsV1BMoAlSfZ1w=;
        b=OGSDDFr9Su1LsRcBNglx47LCri9qfjvIoTltpmcJ7wYFl2GcdYp0baT8iQlb7Qn2AC
         PPxKyUv/j+9v23w19jJztopO0Tiwy5ZUTTQ4HriNyTzX7x2UMuRTq4uSqfOGJsD8zzFj
         4jnoQPVmZsaxF8ZjQxN6ORYBVCyA3f6ENgTpsF097Nq54KFtpvwaaZejsqoa/WQTXoo/
         cntM3R/HCJ1am2nP/SjJs5qxFNj7OnLZEP43uBmMHLE0LWCYecul3A4CUE/U0KOZk7L0
         FLXZR5znY+56KivEuVYefaC4xCQ1WPkdMTDjzWmivXC5pZe3XUG5k+Mom4QWxB227C6z
         JUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012886; x=1697617686;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wzwy8dVzFkqBpnclcii55xn3E3Sc8bsV1BMoAlSfZ1w=;
        b=uVgSfm36p/JNS+oxCwgUoKGtam1nT2dlY3IChQ+mGIAnc/9syTGZu1Pc2xdJpQMbSa
         VgKfPgIZ2MaO4ikQG6QFomzgLizqcW6pgrqK4ZnI7COtkR1tiwkE2D6WAmOndnOAPOda
         htV/eli6xLydBtywnKmhJNnaRgd+DxThDolzE5h4Vu7ZwMkA/GZ6XQ2gqBCCJH0kuWWY
         A9KJGC/TPMiCGR5PPYAi9czqOYR4pAL1NxeoZgO9QtxIQRbZ5juYe832pB/oB8TReeU/
         34RsDDLbwRpKJ+Rw5Q6d88souh6ema/4nggyBrpRmrd0qtrrheJui6anNh+puLcpZfLW
         je1g==
X-Gm-Message-State: AOJu0YxCNYzbSxFQWAfxDh89CVS+y34LzyAoRFECdt+NhNt/zJpSMzAo
        5JvProO+dTg+M5kknpVrZBo=
X-Google-Smtp-Source: AGHT+IGpRm1Kztit0KLsvMRyjNSBxupAdNhYfo8BW0PR5C86g9tMdIhxP4hkjgF77FFnccx64GSeJw==
X-Received: by 2002:a05:6358:70c:b0:142:d71b:59ce with SMTP id e12-20020a056358070c00b00142d71b59cemr23075111rwj.26.1697012886601;
        Wed, 11 Oct 2023 01:28:06 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b006862b2a6b0dsm9866888pfa.15.2023.10.11.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:28:06 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com
Subject: [PATCH v2] workqueue: Use the kmem_cache_free() instead of kfree() to release pwq
Date:   Wed, 11 Oct 2023 16:27:59 +0800
Message-Id: <20231011082759.8570-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kfree() be used for pwq objects allocated with
kmem_cache_alloc() in alloc_and_link_pwqs(), this isn't wrong.
but usually, use "trace_kmem_cache_alloc/trace_kmem_cache_free"
to track memory allocation and free. this commit therefore use
kmem_cache_free() instead of kfree() in alloc_and_link_pwqs()
and also consistent with release of the pwq in rcu_free_pwq().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ebe24a5e1435..6f74cab2bd5a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4610,8 +4610,12 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 
 enomem:
 	if (wq->cpu_pwq) {
-		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(wq->cpu_pwq, cpu));
+		for_each_possible_cpu(cpu) {
+			struct pool_workqueue *pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
+
+			if (pwq)
+				kmem_cache_free(pwq_cache, pwq);
+		}
 		free_percpu(wq->cpu_pwq);
 		wq->cpu_pwq = NULL;
 	}
-- 
2.17.1

