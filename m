Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E1792A77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjIEQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245159AbjIEBxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:53:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B1CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:53:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3e943762so1649324b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693878786; x=1694483586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=et7SVZmA/lkLwp7uaeKPmxJeL3RQa87Ve6JoBbZWATw=;
        b=HaADGH+/Axclgv9vuJP4UqZvz6+nh2Y8hV1tmkTHuz+BXvO8XUh+bFZV1IKIfkqvEP
         fhCmISznxDhV7sXe+qmvaSvHkEZUe0THq4tUWhZ14In/KIUBMLCUQ9kYoHiokcWxUs8Q
         o/WeUsEkiTT3unBsHXyDX5kiLC8d5to251MW2O3BW78gQYswXAYXARixgcfmR9U3mKR2
         95eq2gUEWLm583mpsJtcmvbJx4tzXbUgVVUg8we31Br6LtDsBymEtEFmed0feVKTsxji
         d8KlDmZbh1+JhZCJ1I0l5mWm/FoY7Auv1UR0pOnDH3klFMj7NXwuaXVRbagtE1P4zRLO
         AroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878786; x=1694483586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et7SVZmA/lkLwp7uaeKPmxJeL3RQa87Ve6JoBbZWATw=;
        b=OCyfiHDj0isaPMDdAINDThip+Ymd1PrYMSytwLdNXrwGkvIcTriCo0/qTawVQBT0Ik
         LgurT/EvD3OE1JzWcMe4nfv1J/PpVv11hsh4jW8npl+T1DgZJySYkYH7gPDQ3r2f2sfC
         f4TraR1lxoxUdjEo/z1//KlxCBGPpsuch5xZsgRrfpPSKP7DaWVdEWQybnY94blMlrHu
         FIczQ6kiJgsd7WyiVYf0vADPjhyAaasYa4MHJcJKwMUukH6IMW71ssF2Q9TvCVLyiWsx
         Em/gKlygGxRxdhKgfxtJO7bbAU+RBVWhmLExc4lHsAYztj9Qyrccmn1uz1Z3SUbZPrT8
         RUOA==
X-Gm-Message-State: AOJu0YzxXXc+an0fgxo3rEuSVBbue4k+8dB9HO0sEMZXH0nRhrx/P02u
        nhuVNp/emiObGj86BJOHYb48xQ==
X-Google-Smtp-Source: AGHT+IFzzd5Pf43c6tFiGVQEQmRfu/Fd/DBJi/+PqODcfb+FYiZ25XQC9nwA1rXeNOWLfAscB5nD0w==
X-Received: by 2002:a05:6a00:985:b0:68b:e29c:b5d with SMTP id u5-20020a056a00098500b0068be29c0b5dmr15855959pfg.33.1693878786121;
        Mon, 04 Sep 2023 18:53:06 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm7910483pfm.214.2023.09.04.18.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:53:05 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v9 0/5] lib,kprobes: kretprobe scalability improvement
Date:   Tue,  5 Sep 2023 09:52:50 +0800
Message-Id: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
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

This patch series introduces a scalable and lockless ring-array based
object pool and replaces the original freelist (a LIFO queue based on
singly linked list) to improve scalability of kretprobed routines.

v9:
  1) objpool: raw_local_irq_save/restore added to prevent interruption

     To avoid possible ABA issues, we must ensure objpool_try_add_slot
     and objpool_try_add_slot are uninterruptible. If these operations
     are blocked or interrupted in the middle, other cores could overrun
     the same slot's ages[] of uint32, then after resuming back, the
     interrupted pop() or push() could see same value of ages[], which
     is a typical ABA problem though the possibility is small.

     The pair of pop()/push() costs about 8.53 cpu cycles, measured
     by IACA (Intel Architecture Code Analyzer). That is, on a 4Ghz
     core dedicated for pop() & push(), theoretically it would only
     need 8.53 seconds to overflow a 32bit value. Testings upon Intel
     i7-10700 (2.90GHz) cost 71.88 seconds to overrun a 32bit integer.

  2) codes improvements: thanks to Masami for the thorough inspection

v8:
  1) objpool: refcount added for objpool lifecycle management

wuqiang.matt (5):
  lib: objpool added: ring-array based lockless MPMC
  lib: objpool test module added
  kprobes: kretprobe scalability improvement with objpool
  kprobes: freelist.h removed
  MAINTAINERS: objpool added

 MAINTAINERS              |   7 +
 include/linux/freelist.h | 129 --------
 include/linux/kprobes.h  |  11 +-
 include/linux/objpool.h  | 174 ++++++++++
 include/linux/rethook.h  |  16 +-
 kernel/kprobes.c         |  93 +++---
 kernel/trace/fprobe.c    |  32 +-
 kernel/trace/rethook.c   |  90 +++--
 lib/Kconfig.debug        |  11 +
 lib/Makefile             |   4 +-
 lib/objpool.c            | 338 +++++++++++++++++++
 lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 1320 insertions(+), 274 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.40.1

