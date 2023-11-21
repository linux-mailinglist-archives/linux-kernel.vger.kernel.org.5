Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17E7F25C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKUGb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUGb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:31:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F773E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:31:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c2139492d9so1829601a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700548289; x=1701153089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id8ujeGpIkTWnBgsbrdjWqBN1vyTocw7BJ8Bs4CExAE=;
        b=iGsC9TOiz+JS6ON5xJ5Fq6d0daSnIWtBi1Gg2QBxtU21+kMTf6SDj8JJsOFb/34Uoa
         vzwK3Gv0Ic1ZX9VP67RMJXSqIgV6Hf6Bw0NYcRu1hdyHYe/xCtUI2wgsdmev9mg/NOjM
         Of2P1a8UQsmxqO0XGl0ZqxGgzmf0F6QfGyT51uiQMSs7YvIaqzukKkt9bzGqlYw9+MwL
         qVJ2dJUZ76/fiEA2GJ+W3WSs9dKDMdPoeKMdr0CPr2J7+scZalVKmY4Lm42WOW2gyp+i
         jeEyocybcR620u5p1SzVNp0bUG07YgyrFxPovgwxdw4Xpgw7p/F7Gx7L+TveAlWGg3V/
         wlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700548289; x=1701153089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id8ujeGpIkTWnBgsbrdjWqBN1vyTocw7BJ8Bs4CExAE=;
        b=FWZseEJHnwuwYfBkNdvXOxscCgfD4v2d6TqpJeBPU1gtXV5MUJkoHrvQcTqrP+2vm/
         NwLyEZwwtOltBI1pO3oXPcZ0dVoaRhK71V5gUuF/d9SvmwEDyIGtEMSefXWairBMOwIW
         RfS1D2KBoSz6EKJ4hn9+svIdZDRPtq4037MWXu9GNZqxtw42qag1sECOJgchig79P01s
         lqEBC6bBLMkkLyyPUdQtxDlXBnm6LgA/sYtoA2K/2kDhp46q1uvbHn4RrP7egfVqF+07
         Dsq5l+Dk2tT9KeP3SZvj7PR+X/Q3irvLlYk61C5CjF9sivL3JmMaY4hAi5NgngoMm1bL
         2NBg==
X-Gm-Message-State: AOJu0YzTEfjMlqiQqSrjfiYyDdTj9bJ0NcKpVA44u6wT/KzzsgpZ/XrA
        LZvt5I5X029bnsog/3oK682zqI+dqscJ4X0xNxaiNw==
X-Google-Smtp-Source: AGHT+IGaL/ZBmNB4muHdNpaLOjY2/y5nWcYnCFXfIwuPy+jxxgaoeX0bqx5IKCWaJevo0BKKWLn/dg==
X-Received: by 2002:a17:90b:3e85:b0:27d:882f:e6c5 with SMTP id rj5-20020a17090b3e8500b0027d882fe6c5mr7905600pjb.9.1700548288861;
        Mon, 20 Nov 2023 22:31:28 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090a8c9300b00280070a2613sm8334414pjo.51.2023.11.20.22.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 22:31:28 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        wuqiang.matt@bytedance.com
Subject: [PATCH v2] lib: objpool: fix head overrun on big.LITTLE system
Date:   Tue, 21 Nov 2023 14:31:12 +0800
Message-Id: <20231121063112.541940-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120141824.86bda7ae184baf331e3175d9@kernel.org>
References: <20231120141824.86bda7ae184baf331e3175d9@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objpool overrun stress with test_objpool on OrangePi5+ SBC triggered the
following kernel warnings:

    WARNING: CPU: 6 PID: 3115 at lib/objpool.c:168 objpool_push+0xc0/0x100

This message is from objpool.c:168:

    WARN_ON_ONCE(tail - head > pool->nr_objs);

The overrun test case is to validate the case that pre-allocated objects
are insufficient: 8 objects are pre-allocated for each node and consumer
thread per node tries to grab 16 objects in a row. The testing system is
OrangePI 5+, with RK3588, a big.LITTLE SOC with 4x A76 and 4x A55. When
disabling either all 4 big or 4 little cores, the overrun tests run well,
and once with big and little cores mixed together, the overrun test would
always cause an overrun loop. It's likely the memory timing differences
of big and little cores cause this trouble. Here are the debugging data
of objpool_try_get_slot after try_cmpxchg_release:

    objpool_pop: cpu: 4/0 0:0 head: 278/279 tail:278 last:276/278

The local copies of 'head' and 'last' were 278 and 276, and reloading of
'slot->head' and 'slot->last' got 279 and 278. After try_cmpxchg_release
'slot->head' became 'head + 1', which is correct. But what's wrong here
is the stale value of 'last', and that stale value of 'last' finally led
the overrun of 'head'.

Memory updating of 'last' and 'head' are performed in push() and pop()
independently, which could be the culprit leading this out of order
visibility of 'last' and 'head'. So for objpool_try_get_slot(), it's
not enough only checking the condition of 'head != slot', the implicit
condition 'last - head <= nr_objs' must also be explicitly asserted to
guarantee 'last' is always behind 'head' before the object retrieving.

This patch will check and try reloading of 'head' and 'last' to ensure
'last' is behind 'head' at the time of object retrieving. Performance
testings show the average impact is about 0.1% for X86_64 and 1.12% for
ARM64. Here are the results:

    OS: Debian 10 X86_64, Linux 6.6rc
    HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
                      1T         2T         4T         8T        16T
    native:     49543304   99277826  199017659  399070324  795185848
    objpool:    29909085   59865637  119692073  239750369  478005250
    objpool+:   29879313   59230743  119609856  239067773  478509029
                     32T        48T        64T        96T       128T
    native:   1596927073 2390099988 2929397330 3183875848 3257546602
    objpool:   957553042 1435814086 1680872925 2043126796 2165424198
    objpool+:  956476281 1434491297 1666055740 2041556569 2157415622

    OS: Debian 11 AARCH64, Linux 6.6rc
    HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
                      1T         2T         4T         8T        16T
    native:     30890508   60399915  123111980  242257008  494002946
    objpool:    14742531   28883047   57739948  115886644  232455421
    objpool+:   14107220   29032998   57286084  113730493  232232850
                     24T        32T        48T        64T        96T
    native:    746406039 1000174750 1493236240 1998318364 2942911180
    objpool:   349164852  467284332  702296756  934459713 1387898285
    objpool+:  348388180  462750976  696606096  927865887 1368402195

Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")

v1 -> v2:
    - Title updated since it's a common issue of objpool for big.LITTLE
      systems, verified on Rockchip RK3588 and Amlogic A311D
    - Fixes tag added, as reminded by Masami Hiramatsu

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/objpool.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/objpool.c b/lib/objpool.c
index 1ab49b897b2e..e8c9a30e485f 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -199,6 +199,23 @@ static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
 	while (head != READ_ONCE(slot->last)) {
 		void *obj;
 
+		/*
+		 * data visibility of 'last' and 'head' could be out of
+		 * order since memory updating of 'last' and 'head' are
+		 * performed in push() and pop() independently
+		 *
+		 * before any retrieving attempts, pop() must guarantee
+		 * 'last' is behind 'head', that is to say, there must
+		 * be available objects in slot, which could be ensured
+		 * by condition 'last != head && last - head <= nr_objs'
+		 * that is equivalent to 'last - head - 1 < nr_objs' as
+		 * 'last' and 'head' are both unsigned int32
+		 */
+		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
+			head = READ_ONCE(slot->head);
+			continue;
+		}
+
 		/* obj must be retrieved before moving forward head */
 		obj = READ_ONCE(slot->entries[head & slot->mask]);
 
-- 
2.40.1

