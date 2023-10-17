Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA67CC54D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbjJQN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjJQN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:57:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F7EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9e95aa02dso36723045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697551029; x=1698155829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2olN8CS4kwWpq+8wsnt0IT2xZ6oZLNjhXVzv2yHZDk=;
        b=Ji2OX7XmG8xiCocwGho/BF41XdMXDsGn/ZaoQK/VaAQyZkv6iGVHAURksq/YnsPJvK
         C5xgBof2NqPgDT5G5NJqUlM9iAeZ0aaKxdY6iosKpo8IBM5NiZGzDCdRMBFFPC8Nr4HQ
         6Yw9FbjG5GOF6WVrjcS/NvwQb7lMkRX0duQJDVrUulI2b8SZSjkzRHkdAGHgCx6co65e
         Xmts18aa+UDvDJYDlnewPEQ7Tl4sW+efz4USjRQ710i5VJDytJoHMUIrn+UcURq/oj0N
         6qpmJnq28klDR1XKU7PGS4I9jmDtS4DmVOJ7I5ZFO/KC1rl9gfF3ngw3boBAT2KqVIiP
         GBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551029; x=1698155829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2olN8CS4kwWpq+8wsnt0IT2xZ6oZLNjhXVzv2yHZDk=;
        b=KTRyl/PuPVplbSKI/YpBeIReeel7OVRNJwoQ0ov70d7MjJOegsAJzumqysL7Y8T9Dm
         xMj0grw3g2XWnLYLOovANnR1Bn6o3eoSMvf8rhfFzft/3crkIVa19p9Sa9Yrgc83A6i/
         VwgIlX0VDfaQYtDaK+RxZ1WPT+g2YaF5xqbH5sU9a1S1gAEISZMyZ52JQgRIDhMMoRGJ
         /+ZDKLGrd7OrHNFLtNURm+azc5/vX7TnadUzsZ0oAXAvtu4bx0TY/bifI1C3ZhDGE0aq
         Lc4xpMqxbMw+mJYzdwYCUsyZR6w4Kry9kCp/a2Kh1Eq+vQ+BwZx4fpHJbVcxNE4r/54L
         IjMQ==
X-Gm-Message-State: AOJu0Yyco2yK2I0h1PQwr0QbnEPxmRHKcl832DjW+sHSHZLHNQrT1vLm
        f+NdDbhr8NOiTRBlSs17l/cxAQ==
X-Google-Smtp-Source: AGHT+IFLNM8lNcY/hN6qn67VtfPlhy8ur20l2NBCOA7If8R9IMQ/DWquPjSMVU92SFEDGGlhnmUFRA==
X-Received: by 2002:a17:902:e887:b0:1c9:ece9:53c6 with SMTP id w7-20020a170902e88700b001c9ece953c6mr2990072plg.29.1697551028775;
        Tue, 17 Oct 2023 06:57:08 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001b9e9edbf43sm1566634plh.171.2023.10.17.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:57:08 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v11 0/5] lib,kprobes: kretprobe scalability improvement
Date:   Tue, 17 Oct 2023 21:56:49 +0800
Message-Id: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a scalable and lockless ring-array based
object pool to improve scalability of kretprobed routines.

v11:
  *) patchset rebased to branch probes/core of linux-trace.git
  *) objpool: objpool_fini optimized for better code readability
  *) test_objpool: asynchronous releasing of objpool now covered

wuqiang.matt (5):
  lib: objpool added: ring-array based lockless MPMC
  lib: objpool test module added
  kprobes: kretprobe scalability improvement with objpool
  kprobes: freelist.h removed
  MAINTAINERS: objpool added

 MAINTAINERS              |   7 +
 include/linux/freelist.h | 129 --------
 include/linux/kprobes.h  |  11 +-
 include/linux/objpool.h  | 176 ++++++++++
 include/linux/rethook.h  |  16 +-
 kernel/kprobes.c         |  93 +++---
 kernel/trace/fprobe.c    |  32 +-
 kernel/trace/rethook.c   |  90 +++--
 lib/Kconfig.debug        |  11 +
 lib/Makefile             |   4 +-
 lib/objpool.c            | 286 ++++++++++++++++
 lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 1270 insertions(+), 274 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.40.1

