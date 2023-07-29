Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F57767D33
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjG2Ijk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjG2Ij2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434E448A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690619921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8rIpeBRze9Zu+72Qm9sEpSig7svqTG6Kuh9DJYcSFE=;
        b=OB6KvnTc7VsgJS22BjKYm+UVkvttOWJ2rQK5E2YAImOg3rDP/O9BRvu72t0venSXo84uHk
        /aF0Mmtc0RRaPD6eCP+bIgQgwADcUo8xH4eM3c3P666M+gcLNxgtlint4nzXZ4dwhq165y
        C/cDRbbd7v9xoGNWbjlH/Z/XH8WpGkM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-N9FgJUSPP0qhLCobfTOKaw-1; Sat, 29 Jul 2023 04:38:39 -0400
X-MC-Unique: N9FgJUSPP0qhLCobfTOKaw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a5ab57036fso5783864b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690619918; x=1691224718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8rIpeBRze9Zu+72Qm9sEpSig7svqTG6Kuh9DJYcSFE=;
        b=Y2rW7570eu3xyqX0qbBsXULwQ//cV6VY8BZbL7DSV3n+DzBzibBDDQ99waRk5Zbp34
         qrtAdKbJtVcPp122XIeoCsCG03yDnH6rD6Y5DT9XiCbj0h5yClFfQSw3l7OeHiAF9jYt
         ywsR22NQurLhSkRIp0a8a2fCHWOCrV0re5Xt/v660XAp9zG8eYGelxmrs2hZw8+r1Iep
         CucJX+Ncj3AGLE2+e5WLTpHChDSEJowJ0gF8OxkWnelQNS6Roe1FLxwGsqb23Em70U0g
         Ju9XBqFvBBZoIfhZRlgma4r/BQ7M9Z7pHTtZG8kXQLkwnmU4bDka1It+jBau77sl13rD
         XoNA==
X-Gm-Message-State: ABy/qLYe2AKavotAAGzJOJWpoayvk8xq2YB/3V1qYQUq7Kv7nGz18mdW
        FQbKf+GH0QBSPfj8zL1PUuelPDhsJlMGGURIpQNVhLiuEM4Clj1lGaGPHEHL8/BQGg/xxU4imcm
        0ZDvIRJpQp5Hw7mNNs5VcVuVY
X-Received: by 2002:a05:6808:1509:b0:3a3:6382:b67d with SMTP id u9-20020a056808150900b003a36382b67dmr5871263oiw.41.1690619918506;
        Sat, 29 Jul 2023 01:38:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE72np9M7VBc9ea9R1wrVx2dR1OmQ/wiPBtvU58KUGekGEzrx+xog2FSog4LO47TmsFk4c88A==
X-Received: by 2002:a05:6808:1509:b0:3a3:6382:b67d with SMTP id u9-20020a056808150900b003a36382b67dmr5871253oiw.41.1690619918256;
        Sat, 29 Jul 2023 01:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:93ca:d713:4eb3:968e:3b54])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003a3f922207asm2467184oib.1.2023.07.29.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 01:38:37 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH 3/4] memcontrol: apply new local_schedule_work_on() interface
Date:   Sat, 29 Jul 2023 05:37:34 -0300
Message-ID: <20230729083737.38699-5-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230729083737.38699-2-leobras@redhat.com>
References: <20230729083737.38699-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the new local_*lock_n*() and local_schedule_work_on() interface
to improve performance & latency on PREEMTP_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_*lock*() by local_lock_n*(), and replace schedule_work_on() by
local_schedule_work_on().

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..6d4fa48d75e3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2277,7 +2277,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 	WRITE_ONCE(stock->cached, NULL);
 }
 
-static void drain_local_stock(struct work_struct *dummy)
+static void _drain_local_stock(int cpu)
 {
 	struct memcg_stock_pcp *stock;
 	struct obj_cgroup *old = NULL;
@@ -2288,18 +2288,23 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave_n(&memcg_stock.stock_lock, flags, cpu);
 
-	stock = this_cpu_ptr(&memcg_stock);
+	stock = per_cpu_ptr(&memcg_stock, cpu);
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore_n(&memcg_stock.stock_lock, flags, cpu);
 	if (old)
 		obj_cgroup_put(old);
 }
 
+static void drain_local_stock(struct work_struct *w)
+{
+	_drain_local_stock((int)w->data.counter);
+}
+
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
@@ -2365,9 +2370,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		if (flush &&
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
-				drain_local_stock(&stock->work);
+				_drain_local_stock(cpu);
 			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &stock->work);
+				local_queue_work_on(cpu, system_wq, &stock->work);
 		}
 	}
 	migrate_enable();
-- 
2.41.0

