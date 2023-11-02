Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3CE7DF36D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjKBNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjKBNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:14:15 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0E134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:14:04 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SLkpx5hN5zMqJcN;
        Thu,  2 Nov 2023 13:14:01 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SLkpw6ZkyzMpnPm;
        Thu,  2 Nov 2023 14:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698930841;
        bh=JUcQS3TJeMPBK3H6KZcOPpajxJbdHlxklTtQGbSiGVI=;
        h=From:To:Cc:Subject:Date:From;
        b=IovpZL7mVXcmpJ+3fp3aa2YUxDJ4Ag6H8RwR4LbB9iLZ02v2CS3C1TuNyn0XdjzfJ
         oB2517iE8enLFHNChljK2yX4c/Msf9Fqcl8K1PZmGK74B/8Ly0l6jeqS3XwzsGg+zn
         Fm1C5kP5017YSvEaRtJ7Tc1aCBtNF8LHV82B9fro=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        artem.kuzin@huawei.com, yusongping <yusongping@huawei.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.7
Date:   Thu,  2 Nov 2023 14:13:54 +0100
Message-ID: <20231102131354.263678-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This PR adds initial network support for Landlock (TCP bind and connect
access control), contributed by Konstantin Meskhidze [1].  Please pull
these changes for v6.7-rc1 .  These 13 commits merged cleanly with your
master branch and the LSM/dev branch [2].  The kernel code has been
tested in the latest linux-next releases for a month (next-20231003 [3])
but the related patch series has since been updated (while keeping the
same kernel code): extended tests, improved documentation and commit
messages.  I rebased the latest patch series (with some cosmetic fixes)
on v6.6-rc7 and added two more tests.

A Landlock ruleset can now handle two new access rights:
LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP.  When
handled, the related actions are denied unless explicitly allowed by a
Landlock network rule for a specific port.

The related patch series has been reviewed for almost two years, it has
evolved a lot and we now have reached a decent design, code and testing.
The refactored kernel code and the new test helpers also bring the
foundation to support more network protocols.

Test coverage for security/landlock is 92.4% of 710 lines according to
gcc/gcov-13, and it was 93.1% of 597 lines before this series.  The
decrease in coverage is due to code refactoring to make the ruleset
management more generic (i.e. dealing with inodes and ports) that also
added new WARN_ON_ONCE() checks not possible to test from user space.

syzkaller has been updated accordingly [4], and such patched instance
(tailored to Landlock) has been running for a month, covering all the
new network-related code [5].

Link: https://lore.kernel.org/r/20231026014751.414649-1-konstantin.meskhidze@huawei.com [1]
Link: https://lore.kernel.org/r/CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?id=c8dc5ee69d3a [3]
Link: https://github.com/google/syzkaller/pull/4266 [4]
Link: https://storage.googleapis.com/syzbot-assets/82e8608dec36/ci-upstream-linux-next-kasan-gce-root-ab577164.html#security%2flandlock%2fnet.c [5]

Regards,
 Mickaël

--
The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.7-rc1

for you to fetch changes up to f12f8f84509a084399444c4422661345a15cc713:

  selftests/landlock: Add tests for FS topology changes with network rules (2023-10-27 17:53:31 +0200)

----------------------------------------------------------------
Landlock updates for v6.7-rc1

----------------------------------------------------------------
Konstantin Meskhidze (11):
      landlock: Make ruleset's access masks more generic
      landlock: Refactor landlock_find_rule/insert_rule helpers
      landlock: Refactor merge/inherit_ruleset helpers
      landlock: Move and rename layer helpers
      landlock: Refactor layer helpers
      landlock: Refactor landlock_add_rule() syscall
      landlock: Support network rules with TCP bind and connect
      selftests/landlock: Share enforce_ruleset() helper
      selftests/landlock: Add network tests
      samples/landlock: Support TCP restrictions
      landlock: Document network support

Mickaël Salaün (2):
      landlock: Allow FS topology changes for domains without such rule type
      selftests/landlock: Add tests for FS topology changes with network rules

 Documentation/userspace-api/landlock.rst     |   99 +-
 include/uapi/linux/landlock.h                |   55 +
 samples/landlock/sandboxer.c                 |  115 +-
 security/landlock/Kconfig                    |    1 +
 security/landlock/Makefile                   |    2 +
 security/landlock/fs.c                       |  232 ++--
 security/landlock/limits.h                   |    6 +
 security/landlock/net.c                      |  200 +++
 security/landlock/net.h                      |   33 +
 security/landlock/ruleset.c                  |  405 ++++--
 security/landlock/ruleset.h                  |  185 ++-
 security/landlock/setup.c                    |    2 +
 security/landlock/syscalls.c                 |  158 ++-
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/common.h    |   13 +
 tools/testing/selftests/landlock/config      |    4 +
 tools/testing/selftests/landlock/fs_test.c   |   69 +-
 tools/testing/selftests/landlock/net_test.c  | 1738 ++++++++++++++++++++++++++
 18 files changed, 2967 insertions(+), 352 deletions(-)
 create mode 100644 security/landlock/net.c
 create mode 100644 security/landlock/net.h
 create mode 100644 tools/testing/selftests/landlock/net_test.c
