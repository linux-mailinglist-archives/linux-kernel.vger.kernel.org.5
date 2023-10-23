Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4806D7D32F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjJWLZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjJWLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:25:05 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1CDB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:25:03 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5842c251d7cso1516894eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698060302; x=1698665102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2192OsjXmgrld0RFvNELnPp3O3hEpjh1EJLRBwaLwjg=;
        b=aEmrYdKmYJ5Gd/MO4IJE4sGEP48zfF+hPRpu9ZXzTzX2Wk5Q5S5X3dT+05vjCMdV2E
         QmYf2QJIdrvHLpI442ERjDKidOjxYWY3IS9d0QYzlghSuCofMq230eSRprA0yW115xRO
         a3zjQNCUUesJ+ImFcvSyjUz8in4bUqrIQRCC7JeyvodWbkLvdkDjAjBpm8UF008QiJNv
         4ii93PqqL8C8ZM8pol/GNNqltTA7toe6Ng8TccIyx+UMVvkeb2d2AgqMFb3cLItWMv5j
         dNdg1FTJVCWZGPZKNVK5QJbKgLXtKgplGQXMja7hq5pz68jrVNwJw7OPVqtm/90iEiH7
         K1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698060302; x=1698665102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2192OsjXmgrld0RFvNELnPp3O3hEpjh1EJLRBwaLwjg=;
        b=QihG8gLfRzsJinaIIIUmmhibnDaBAShU/ismhN1KcqXb73gMXIBEPOXc2ZvKlnqBWN
         dqf9feu1117Jh8L/3ahWdw4aBc772PZT225vdbWMp1dejrEVWzXmCqhfsr5TYsr7XQ9S
         M6ubAs+fHWb5x0OTafdUMMHPp0o0NORvIFIPWN2GTRXvVhxee7HlEY643DRaSCAVAlo2
         CWlOUu6yn2fTUtmVIPbcJyG4kuUOAY05NeJJ08rlrObJent2QxqA5yspiXN4uPWq6Bhe
         3radN36ugcNuIxC+3KdMTBEEDMayLy9y3ZDj/2YNaWVBhfD0nRRhSaOp76MCanBzty35
         vPEQ==
X-Gm-Message-State: AOJu0YxFFbskgSzje85dzAJD2Tvp241Ij4QDnjA6crUG02T8U6U2WC3/
        SVeET7MaiDE1VgdA8hc4IUn1Lg==
X-Google-Smtp-Source: AGHT+IHa3uVm9uNk9uUTpXnzauQE78s8dd1IL3sNWjOcLV+AY4KgKWIXNfymZ+W3xhqQWh/kmVQ+cw==
X-Received: by 2002:a05:6359:6c11:b0:168:e697:ce0d with SMTP id tc17-20020a0563596c1100b00168e697ce0dmr916303rwb.31.1698060302535;
        Mon, 23 Oct 2023 04:25:02 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id s10-20020a65644a000000b005781e026905sm4823298pgv.56.2023.10.23.04.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:25:01 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Date:   Mon, 23 Oct 2023 19:24:52 +0800
Message-Id: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objpool_push can only happen on local cpu node, so only the local
cpu can touch slot->tail and slot->last, which ensures the correctness
of using cmpxchg without lock prefix (using try_cmpxchg_local instead
of try_cmpxchg_acquire).

Testing with IACA found the lock version of pop/push pair costs 16.46
cycles and local-push version costs 15.63 cycles. Kretprobe throughput
is improved to 1.019 times of the lock version for x86_64 systems.

OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s

                 1T         2T         4T         8T        16T
  lock:    29909085   59865637  119692073  239750369  478005250
  local:   30297523   60532376  121147338  242598499  484620355
                32T        48T        64T        96T       128T
  lock:   957553042 1435814086 1680872925 2043126796 2165424198
  local:  968526317 1454991286 1861053557 2059530343 2171732306

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 lib/objpool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/objpool.c b/lib/objpool.c
index ce0087f64400..a032701beccb 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -166,7 +166,7 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
 		head = READ_ONCE(slot->head);
 		/* fault caught: something must be wrong */
 		WARN_ON_ONCE(tail - head > pool->nr_objs);
-	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
+	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
 
 	/* now the tail position is reserved for the given obj */
 	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
-- 
2.40.1

