Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC27C980B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjJOFdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjJOFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:33:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5FAB7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:07 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57f02eeabcaso2152020eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697347987; x=1697952787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YSbbFplEMGgc8hs9UQZk79UvkhK9cFlSyrmMp8kdAQ=;
        b=AFp308hAuHvw86EaRRO18dsF9leLOyhfadkGtooVYloikOH1Mn2pGwgoIPDSN/WMTy
         od5znADUy/8VOJZqKcrELKOf+txxqgz2TVRDoAsiAXzIjx2OPYbDzphukCfBfoQrRNhV
         +J9ngTNj1C00i3GLNo/j9GVTm7YqwSk/wCNAVLxR89L7AbNtSwccrRjwQPiK9FjZt7mZ
         G+mpZyvGCN+9/485i0pU4e2lIFK6TS2WK/inyUqoVXcPBQEj/wLZa0+wk+CmN69EOrXN
         kuDKm21+sN07O9HBX59p1MlUzf/ysqFb1+r9qV07jvjyZdSDu2ysO+iIph21ypqln+pA
         WHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697347987; x=1697952787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YSbbFplEMGgc8hs9UQZk79UvkhK9cFlSyrmMp8kdAQ=;
        b=hBnOdXaqD/cCpeTKACNdbUtp1fM1w4ADF/Tq8XKihA8qntB5YDNQxFXPS3WFPTx+8Z
         kH9FDxLExheXpQaHZCnc29cM3VomtoglIbr/KRWQrYX1GJHWOPj1/OEUgUzget7ErGH/
         0/Jvx6IBMi6PqiDa3dbL42uSUZ3tiiisiwCmTvD8vALrgNCdQiLkzeNd3+Bxv3HjTt71
         LqTEGUTltlD7krAHr1W7cvm8tMsGT8K9JyQFQBwZWdXHw90/yY3tg5gduOZkx6pnGo84
         pb7LrG5yqlWOakoJsCMZ6MDIh0V7C7nFV0ttatmMzK7UOSnwpkQU035kUeu2lWuH+lZh
         JaAQ==
X-Gm-Message-State: AOJu0YyBj+SBRn8jhD1K4I7VtpNIx0emToyARuQfj/Ns+/YKyPk/TFrH
        +DiGUZF9wnQlQ1aH4K0cOJDheA==
X-Google-Smtp-Source: AGHT+IEcgAokBU5YdThWVcsJQqO8kLV4eAzKTCIPBY/Tl6zvGnQacF65q5XNT2Za/cL93juYS2sNaw==
X-Received: by 2002:a05:6358:33a4:b0:151:ac8d:bfe7 with SMTP id i36-20020a05635833a400b00151ac8dbfe7mr35376152rwd.22.1697347987054;
        Sat, 14 Oct 2023 22:33:07 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u22-20020a62ed16000000b00690fe1c928csm16187368pfh.147.2023.10.14.22.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:33:06 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v10 0/5] lib,kprobes: kretprobe scalability improvement
Date:   Sun, 15 Oct 2023 13:32:46 +0800
Message-Id: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
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

v10:
  *) objpool simplified and improved according to Masami's advices

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

