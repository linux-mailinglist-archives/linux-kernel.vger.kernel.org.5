Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEC801180
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjLARW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjLARWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:25 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B78F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:30 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cdeedb755bso2205732b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451350; x=1702056150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X0hnluTx/qG2EHn+RpFAd/ETRXutwQTiMjlCf0oCXNo=;
        b=bLntICSr/8mgtBACoIeqsxhYqS8qGgkXtAQ+7h5NXVY4uro/NE/7u7Y5wN33V+T4Nr
         M/JcJiufTxzwQF9H2N9MAFBOEoadgqOVTaZGMnieC1nSZ5g+g0isFR9Aa1J1N1AxULe4
         gLqLFleBa6cnFI37Om/PemaiSu0JbkoepWWqc0esSlYO2pcmRuQPXTI4Zdbls/zGIxZ/
         FX8oz68Ub+vX9lPq77aW7P/nFSTwF9MBxsUqPtcFBQe2yQQTFm30sC1DSJbeVdwmduuK
         LUyfzMy4Hk1zE4RCw5xqpGta6t2aHAms4xPeTzSr6zVRPO4ELk9SoXwtlHDlAJzUl1Qu
         F59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451350; x=1702056150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0hnluTx/qG2EHn+RpFAd/ETRXutwQTiMjlCf0oCXNo=;
        b=o7fsbL6AsU02NaIvqAMFFu4kwNpVPp7GULndjNmH10GYzN8mstbgwgQCyhPJeU4GO9
         jXO+5AlTXIi1Z//5bSzI0IkPFBAbljEP91q0IFyJSD/v5k3fvz4ppHFZ6rzWInOtCs1+
         dLKMJzef2XvAtAjDsRrm1j4YwYTczoCJRahU3VoPl0A+o8wInozSz9mfxx3exKzS8wWl
         yk0/6rgEN9rsi0LVqj/YfnVdwTR0bxu6w/vGsqiRrwcU0in0KLlSm5K2Cp3nZVs5bh+j
         uoI2lqmh7/jDuBqCA00EPk4Ump3bo7lkm7WI4HVvAthblX+VwSL1pkmZBaE0dHoeftp/
         puAg==
X-Gm-Message-State: AOJu0YzQpFopHTj73s+kn4irnIy1CZdpjivPIZk9rDBMR9bqIxouiP31
        LI2VXiUto5JdJeVAG99DuY22sPVY/5rYbA==
X-Google-Smtp-Source: AGHT+IGsyfkzjsCEu2oPo/ywio5RVNKKeLaXUnTVrP23PL9tAZt7FTITs8r7csgqmbVs60gl7Bct4NKLkeXYLQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:399c:b0:6c0:ec5b:bb2d with SMTP
 id fi28-20020a056a00399c00b006c0ec5bbb2dmr5865061pfb.2.1701451349982; Fri, 01
 Dec 2023 09:22:29 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-1-cmllamas@google.com>
Subject: [PATCH v2 00/28] binder: convert alloc->mutex to spinlock
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Carlos Llamas <cmllamas@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alice Ryhl <aliceryhl@google.com>,
        John Stultz <jstultz@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors the binder buffer allocation space to be able to
convert the alloc->mutex into a spinlock. Doing so decreases the latency
of binder transactions seen under worst-case scenarios.

I attempted to organize and improve readability of things that were
touched during this process. I also include a couple of fixes (unrelated
to the lock conversion) for issues I found along the way.

Regards,
Carlos Llamas

Cc: Todd Kjos <tkjos@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: John Stultz <jstultz@google.com>
Cc: Suren Baghdasaryan <surenb@google.com> 
Cc: Tim Murray <timmurray@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

v2:
 - New fix for wasted alloc->free_sync_space calculation
 - Fix issues pointed out by Alice: incorrect size overflow check, data
   race in buffer->async_transaction, reorder of __free_page(page) and
   new_buffer leak in some error paths.
 - Better naming and comments to accommodate the new scope of things
   e.g. binder_lru_freelist_add() and binder_install_single_page().
 - Dropped patch ("binder: do not add pages to LRU in release path")
   since it is not worth the added complexity.
 - Avoid _new_ logs of unhashed userspace addresses.
 - More minor cosmeting changes.
 - Add Reviewed-by tags.

v1:
   https://lore.kernel.org/all/20231102185934.773885-1-cmllamas@google.com/

Carlos Llamas (28):
  binder: use EPOLLERR from eventpoll.h
  binder: fix use-after-free in shinker's callback
  binder: fix race between mmput() and do_exit()
  binder: fix async space check for 0-sized buffers
  binder: fix unused alloc->free_async_space
  binder: fix trivial typo of binder_free_buf_locked()
  binder: fix comment on binder_alloc_new_buf() return value
  binder: remove extern from function prototypes
  binder: keep vma addresses type as unsigned long
  binder: split up binder_update_page_range()
  binder: do unlocked work in binder_alloc_new_buf()
  binder: remove pid param in binder_alloc_new_buf()
  binder: separate the no-space debugging logic
  binder: relocate low space calculation
  binder: relocate binder_alloc_clear_buf()
  binder: refactor page range allocation
  binder: malloc new_buffer outside of locks
  binder: initialize lru pages in mmap callback
  binder: perform page installation outside of locks
  binder: remove redundant debug log
  binder: make oversized buffer code more readable
  binder: rename lru shrinker utilities
  binder: document the final page calculation
  binder: collapse print_binder_buffer() into caller
  binder: refactor binder_delete_free_buffer()
  binder: avoid user addresses in debug logs
  binder: reverse locking order in shrinker callback
  binder: switch alloc->mutex to spinlock_t

 drivers/android/binder.c                |  27 +-
 drivers/android/binder_alloc.c          | 858 ++++++++++++------------
 drivers/android/binder_alloc.h          |  61 +-
 drivers/android/binder_alloc_selftest.c |  14 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 489 insertions(+), 473 deletions(-)


base-commit: 994d5c58e50e91bb02c7be4a91d5186292a895c8
-- 
2.43.0.rc2.451.g8631bc7472-goog

