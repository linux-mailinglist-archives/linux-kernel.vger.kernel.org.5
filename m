Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B1E8018B9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441956AbjLBAKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjLBAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:09:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049143843
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:09:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF17C433C7;
        Sat,  2 Dec 2023 00:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475689;
        bh=A1C2zs2bNcPgxvWmPkcCx7AYSR8F7j9qABqqkUnLgSo=;
        h=From:To:Cc:Subject:Date:From;
        b=r8GrkEMHKqnkzCBxXV6dk0fxj2hTrFflggLRLPq6CrikzGUQ5hYicqP17L4pqk5NL
         Kvqe9zz5t9W1mV8znjB0kuJ4IkkBiUTPOonMYIk3B+hPQqFdmt9wEd6qBojTO6X6y3
         VaF7fIoMCcnsZ6IuXrbJQ6Q22BzyAY+dfkcgJBrg76baKN3JK/XJx8b+rQimNIWkr2
         FI0XLIJZ9d9eDnKddcwIzMG+PHxfpY8uOfAZBS92pH3kTqaovu87UFYYgPaoOV+2iX
         mUSzyhjCX3Be3paIV1thkachdpMZGQgEWmMK9DDpQFtn8QRq2Oz5CEE4I/GNzG/gyn
         Xg6V2D4b6/Rrw==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] selftests/damon: add Python modules for DAMON control and functionality tests
Date:   Sat,  2 Dec 2023 00:08:01 +0000
Message-Id: <20231202000806.46210-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON provides almost all control to the user via its sysfs interface.
For that, the interface provides plenty of files and hierarchies.  The
interface is simple enough to be controlled by shell commands including
'cat', 'echo', and redirection.  However, due to the number of files and
the hierarchies, doing that repeatedly is quite tedious.  As a result,
DAMON selftests are containing only simple test cases rather than real
functionality tests.  Having a wrapper script that can be reused to
implement more functionality tests could be helpful.  Writing such
wrapper with shell script might be challenging and not easy to further
maintain and extend for future DAMON interface extensions, though.

To this end, implement a Python-written DAMON sysfs interface wrapper
that could be easily managed and extended for future DAMON interface
extensions.  Further implement one simple functionality test and a
corner case regression test for a previously found bug, using the
wrapper module.  In fact, the bug was found by the test this patchset is
introducing.

Note that the Python wrapper is not supporting full features of DAMON
interface, but only some of those that essential for the tests that this
patchset is introducing.  The wrapper would extended to support more
features, but only with essential ones for such future tests.  The
wrapper will hence keep being simple, small, and constrained.  For
convenient and general use cases of DAMON, users should use DAMON
user-space tools for such purpose, like damo[1].

[1] https://github.com/damonitor/damo

Patches Sequence
----------------

This patchset is constructed with five patches.  The first three patches
implement the Python-written DAMON sysfs interface wrapper in small
steps.  The basic data structure (first patch), kdamond startup command
(second patch), and finally DAMOS tried bytes command (third patch).

Then two patches for adding selftests using the wrapper follows.  The
fourth patch implements a basic functionality test of DAMON for working
set estimation accuracy.  Finally, the fifth patch implements a corner
case test for a previously found bug.

SeongJae Park (5):
  selftests/damon: add a DAMON interface wrapper python module
  selftests/damon/_damon: implement sysfs-based kdamonds start function
  selftests/damon/_damon: implement sysfs updat_schemes_tried_bytes
    command
  selftests/damon: add a test for update_schemes_tried_regions sysfs
    command
  selftests/damon: add a test for update_schemes_tried_regions hang bug

 tools/testing/selftests/damon/Makefile        |   3 +
 tools/testing/selftests/damon/_damon.py       | 322 ++++++++++++++++++
 tools/testing/selftests/damon/access_memory.c |  41 +++
 ...sysfs_update_schemes_tried_regions_hang.py |  33 ++
 ...te_schemes_tried_regions_wss_estimation.py |  48 +++
 5 files changed, 447 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon.py
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py


base-commit: 1be383c41197b82cfd51b2edc7ee515c0b786496
-- 
2.34.1

