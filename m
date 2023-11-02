Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24B7DFA7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377214AbjKBTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKBTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D46D182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso1511123276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951629; x=1699556429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCKUp+kYTjUgU6Mz2cf8nQWD88JU2ZTKm40auAGmVFI=;
        b=c/adk68F0D5Pn+goJVSDIB3oevgiTHGWXx/6hKylCvWy7CugmvlHDdES6AyRu4McMj
         xY+BmZyF7iFlB4H1O1ylWmlx68cRCeEQvlO7G5TcXMbqJ0f72VQeJBjWdJeRnex95RXy
         IYVK9SJT3m1A3Ci90GWbOkCmzdD4IDEd9VtBCkdlDHbUnA2ATA4/RrxjH8T5p8iZXiVf
         Qkiv+0Fn9gL7NvaJsiM9LosOrVDMWq7JDehqOHR0bN1DCbRSKeF+NPL1/cV8xIeJnNLH
         PTmClWA9zKn9xZOYv8YWZ0m581eaaidAlBhF+b10zJY/aJTNRWMtsjUDNteYn7i8e+0V
         4Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951629; x=1699556429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCKUp+kYTjUgU6Mz2cf8nQWD88JU2ZTKm40auAGmVFI=;
        b=RUoM7/mKPeEJfCIb6hUjxeiwZ/n6kpq/dIcwlY7jXe+OD2TRfREYNE4sHGYNOGzYe/
         VfBgL36Vsxw07OKt3CWBAKB58jJxeotcklsHHA6IIZSgKSTppteh/GvY3RPCtNCSZyUP
         RHI4Yo/o7hmWCUr6Mn2s6b4pjINhhriDQja7e+G3aGT3D8iROpy4mQ2TkLED5IGleqOs
         FxhGAm+6Mj+mXhsZGz+067WdRBMdFcWDrArJML9vET7Do8Snl7qraVBbuvq/8/nGUKP1
         CargHBm2GU397c68q+Q32fGe/oTb1YJZRzUTr1iLgvX6qIhVwVzosa2U1j1ip8Nl9w/0
         bCqw==
X-Gm-Message-State: AOJu0Yy6TIZrBqTBxj7u5KnKMdiDTzsQZ2eZKRss2dsIHT7i56bM4ZUL
        EJN8IWjbEqKnOQ8UoyycpsS5yWkYPgQFdg==
X-Google-Smtp-Source: AGHT+IEIx2MiTtDOMigrWwuzNG2gonR8PcaWQK/gPrzlBmYPTBVoQigIQqqu5x9ZSRiJY62flwhVeY2cyAhX2g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr463457ybu.7.1698951629488; Thu, 02
 Nov 2023 12:00:29 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-1-cmllamas@google.com>
Subject: [PATCH 00/21] binder: convert alloc->mutex to spinlock
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
to the lock convertion) for issues I found along the way.

Regards,
Carlos Llamas

Cc: Todd Kjos <tkjos@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: John Stultz <jstultz@google.com>
Cc: Suren Baghdasaryan <surenb@google.com> 
Cc: Tim Murray <timmurray@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Carlos Llamas (21):
  binder: use EPOLLERR from eventpoll.h
  binder: fix use-after-free in shinker's callback
  binder: fix race between mmput() and do_exit()
  binder: fix async space check for 0-sized buffers
  binder: fix trivial typo of binder_free_buf_locked()
  binder: fix comment on binder_alloc_new_buf() return value
  binder: remove extern from function prototypes
  binder: keep vma addresses type as unsigned long
  binder: split up binder_update_page_range()
  binder: do unlocked work in binder_alloc_new_buf()
  binder: remove pid param in binder_alloc_new_buf()
  binder: separate the no-space debugging logic
  binder: relocate low space calculation
  binder: do not add pages to LRU in release path
  binder: relocate binder_alloc_clear_buf()
  binder: refactor page range allocation
  binder: malloc new_buffer outside of locks
  binder: initialize lru pages in mmap callback
  binder: perform page allocation outside of locks
  binder: reverse locking order in shrinker callback
  binder: switch alloc->mutex to spinlock_t

 drivers/android/binder.c                |  25 +-
 drivers/android/binder_alloc.c          | 746 ++++++++++++------------
 drivers/android/binder_alloc.h          |  57 +-
 drivers/android/binder_alloc_selftest.c |   8 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 428 insertions(+), 410 deletions(-)


base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
-- 
2.42.0.869.gea05f2083d-goog

