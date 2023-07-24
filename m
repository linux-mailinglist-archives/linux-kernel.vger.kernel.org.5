Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70BF75FC22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGXQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGXQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:30:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD63170E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:30:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so5249642276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216213; x=1690821013;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ELz6+MdFAwylMEzq57vnQLUyST7xKxQ3gFrQ4xet5oM=;
        b=BOuKpo28jYR0TEsF3UqCk6b9rkYbObdDcsJIOPy/T5B3QW/fTsV1V8pg6UsKAp4Auo
         tQct2po9F1GYuWOrgrBX78Slhb4boeo9R1H3dcxBBt+xbxgxQufkI15lvoAhW7QJQVNz
         Xgia7i3xcvOY3ceFl81PRkxmOsUXlox/ekcVwcgziBVgmT6X7s5nGzAvmvGIb5dBkCxF
         KeUOX5jQ+XsFJw9zhr7bi9viIsgkG6z0azx3U9Rle9Ndlf94FNikuAu1pMGMlKIE1AZL
         lRX/qFVIc5qxRf67DfVMy4hc5JXkD+OMHwpYJWInYQdyiJByR8eqL45UQemqnuPEN8r/
         TC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216213; x=1690821013;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELz6+MdFAwylMEzq57vnQLUyST7xKxQ3gFrQ4xet5oM=;
        b=KQl82iMYtmMTb/FHA2Xp/LJ5DvkBzSOXdEfnuxwXrJCKfaOEHWG/lhuuL7SJ/oHkhS
         Eu4CqRLIDoXu4Gyu/nR9wd/IT13fS7deU5+klsMcvS44yqGgDpKRf4h3eeAv9SQOAu5R
         gHO7J1sDANU4RGz0x3s1zzpm52cfzNyhN6uyulGaCBg9o1EdeVC1a4q9pkw9WUMHq91/
         29CoQZ2+BJuKMnSyAfu+wlIXhBwsYCGAz3AFJKD5urdDKOwhPXJELvDncwC9yipNLyFo
         oXqCh0ozGAhwgWzbZC4dNPObbXmVRQHLfTYjRqV6MplJDFOi34C4xWTdqeuIoSfi0cdH
         7/pg==
X-Gm-Message-State: ABy/qLbbjUdLew4Pc1uJXGjTrRf+SWMQw01um4hAxlxn0QmzN7pmocSz
        7qc2EmxpSd86dQE0w0SPczKaXn6hOg==
X-Google-Smtp-Source: APBJJlGtp5p2K9FdBn6pyk++nPqX3JkC9EH97uae7sq/bwcn6aiUH2AEtN05a6P4phxsPwUGKKlDDw6pbg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:d887:0:b0:d12:d6e4:a08d with SMTP id
 p129-20020a25d887000000b00d12d6e4a08dmr12086ybg.7.1690216213261; Mon, 24 Jul
 2023 09:30:13 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:28:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724162834.1354164-1-rmoar@google.com>
Subject: [PATCH v2 0/9] kunit: Add test attributes API
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch series adds a test attributes framework to KUnit.

There has been interest in filtering out "slow" KUnit tests. Most notably,
a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude a
particularly slow memcpy test
(https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).

This attributes framework can be used to save and access test associated
data, including whether a test is slow. These attributes are reportable
(via KTAP and command line output) and are also filterable.

This framework is designed to allow for the addition of other attributes in
the future. These attributes could include whether the test can be run
concurrently, test file path, etc.

To try out the framework I suggest running:
"./tools/testing/kunit/kunit.py run --filter speed!=slow"

This patch series was originally sent out as an RFC. Here is a link to the
RFC v2:
https://lore.kernel.org/all/20230707210947.1208717-1-rmoar@google.com/

Thanks!
Rae

Rae Moar (9):
  kunit: Add test attributes API structure
  kunit: Add speed attribute
  kunit: Add module attribute
  kunit: Add ability to filter attributes
  kunit: tool: Add command line interface to filter and report
    attributes
  kunit: memcpy: Mark tests as slow using test attributes
  kunit: time: Mark test as slow using test attributes
  kunit: add tests for filtering attributes
  kunit: Add documentation of KUnit test attributes

 .../dev-tools/kunit/running_tips.rst          | 166 +++++++
 include/kunit/attributes.h                    |  50 +++
 include/kunit/test.h                          |  70 ++-
 kernel/time/time_test.c                       |   2 +-
 lib/Kconfig.debug                             |   3 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/attributes.c                        | 418 ++++++++++++++++++
 lib/kunit/executor.c                          | 115 ++++-
 lib/kunit/executor_test.c                     | 128 +++++-
 lib/kunit/kunit-example-test.c                |   9 +
 lib/kunit/test.c                              |  27 +-
 lib/memcpy_kunit.c                            |   8 +-
 tools/testing/kunit/kunit.py                  |  70 ++-
 tools/testing/kunit/kunit_kernel.py           |   8 +-
 tools/testing/kunit/kunit_parser.py           |  11 +-
 tools/testing/kunit/kunit_tool_test.py        |  39 +-
 16 files changed, 1051 insertions(+), 76 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
-- 
2.41.0.487.g6d72f3e995-goog

