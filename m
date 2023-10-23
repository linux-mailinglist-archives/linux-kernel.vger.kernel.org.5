Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5521F7D32B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjJWLXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjJWLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:23:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242210CA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:22:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b5354da665so1502884a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698060176; x=1698664976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dRh+rfLET0p9qdBskbivIY2crf8jG9hQg8expagdDw=;
        b=MaK8FcAllO/jg62yqYX8ZrcpoNfIqqVR7TLf6DvhPwEhNf4Az9KHRjIipfXQ/Yg3QA
         a0L4PmuqwNL5NECFfO6FwB1NQE/nR5ybTtGaECzPunY3kIv+LuFWeUfP68gkTHDol1MP
         fqxRLBbXKQwR0Id2k0m76EkCgEdvVHZ8mLu4/LLhAKgxLx9+UXt/THte1NJ3IAeIXiaC
         YYN3enYtspXyHKvHi8gnI/TEtDHKwEWVSwG52zskDmzS76GVfsKdJNvnLSPSZpGCFNtN
         67YI76QhTfbmQyqAaIiov13gJbeallJWDrmYiLc/kPu9DU+tsyoFl+HVuTxxffhMVVu/
         uzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698060176; x=1698664976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dRh+rfLET0p9qdBskbivIY2crf8jG9hQg8expagdDw=;
        b=lM589BOlOsF03pg9Xj/pjI/t5edHyfHpgY7VIcRK6g/TZLqVAijt6U0aYKWAzfqe2O
         GQ/78N9bbTeYZl7wIXrnp1Jj2TgUnFLVThH62y8FsHMrrO87tzMRKOkLy1CIgLG+KoU1
         B5wk3jh1ZMerA6V9Remf6OEw5+dOZ0vVkwGY8NqiyVxx7T31u6t4aWQpqv2g+vZ5RDcc
         GH916Ui+ES8xWdVFtU6/eGc9yYC4GyJacqgJL3CXdfGeAdlbKwWok8y9HCwaoWhy20ax
         mhg+H6A7U7tJouelTt4xtqdYLpgyqVPek6eh9nK2DvouSSDgri8Nda53ks9nBdNg+ngO
         1W6g==
X-Gm-Message-State: AOJu0YzYJBRC7AGJ6SvTvBRrmVpsGtVY2Ss9A3r63fP6O/0eRCX5hs4C
        U4dK0HozIvPXQGSG2vOdEMgeVA==
X-Google-Smtp-Source: AGHT+IFUPprF8WH63BfMN6S8KFDiIXR8rDvOjQKwgDG5gvFN95DflbmCkixx4JnRCYSUzW8xwHd9NA==
X-Received: by 2002:a17:90b:1490:b0:27c:edd5:6137 with SMTP id js16-20020a17090b149000b0027cedd56137mr6387590pjb.25.1698060176247;
        Mon, 23 Oct 2023 04:22:56 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b0026b3a86b0d5sm6048439pje.33.2023.10.23.04.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:22:55 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v1] kprobes: unused header files removed
Date:   Mon, 23 Oct 2023 19:22:45 +0800
Message-Id: <20231023112245.6112-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kernel test robot reported, lib/test_objpool.c (trace:probes/for-next)
has linux/version.h included, but version.h is not used at all. Then more
unused headers are found in test_objpool.c and rethook.c, and all of them
should be removed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310191512.vvypKU5Z-lkp@intel.com/

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 kernel/trace/rethook.c | 2 --
 lib/test_objpool.c     | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 13c8e6773892..6fd7d4ecbbc6 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -8,8 +8,6 @@
 #include <linux/preempt.h>
 #include <linux/rethook.h>
 #include <linux/slab.h>
-#include <linux/sort.h>
-#include <linux/smp.h>
 
 /* Return hook list (shadow stack by list) */
 
diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 98b5b37b6eea..a94078402138 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -6,21 +6,15 @@
  * Copyright: wuqiang.matt@bytedance.com
  */
 
-#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/sched.h>
-#include <linux/cpumask.h>
 #include <linux/completion.h>
 #include <linux/kthread.h>
-#include <linux/cpu.h>
-#include <linux/cpuset.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/hrtimer.h>
-#include <linux/interrupt.h>
 #include <linux/objpool.h>
 
 #define OT_NR_MAX_BULK (16)
-- 
2.40.1

