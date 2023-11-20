Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31C7F21B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjKTXz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTXz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:55:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A88CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:55:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C5C433C8;
        Mon, 20 Nov 2023 23:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700524522;
        bh=a/9neu1tFH+KJoMSs60BVIB0GUVr2b3mTNMGBRScTUk=;
        h=From:Subject:Date:To:Cc:From;
        b=JYAZrAITo3f0CN1qCjUsi9Vrq+8+7jKeIfVoT45KT2zX/2A5Rr2KblHWs9MPX+m8K
         2ez0uqC9h1O5ZcRIbKPiSsohDRTKlLZqeKvIIVZ+EUVeRuq0Zf03qGoh9tXVkyqpaO
         bZC6KDU7ajg0kVbbjANrLhq/knFkoh+eQFgp4R+MLgop8ASueQJm8iSIZpe5CUArnq
         sjGT20Zvyt2OMEj6ovhiW7DKP3G0ykDsgS/OGZ9VUsrHgVLu8zZd7tmUZ+jAWSVA6O
         N6smpgKwib5vO60jvWpsGhasCKZ/+QGbbuNJ3FDNM4Yz++2/AFO2/2Wsh6TaAZctr0
         YnWK/dbZ8X+Kg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH RFT v3 0/5] fork: Support shadow stacks in clone3()
Date:   Mon, 20 Nov 2023 23:54:28 +0000
Message-Id: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXxW2UC/23NQQ7CIBAF0KsY1mIYKFhdufIAxp1x0ZZpS9qAg
 QY1Te8uwYUx6fLPz7w/k4DeYCDHzUw8RhOMsymI7YY0fWU7pEanTDjjAhgcaDM6i4KGvtLuScN
 UNQMFqQumed1KoUj6fHhszSurN3I5X8k9HXsTJuffeSlCrr4oF6toBMqoLtVeszr5mp0G9BbHn
 fNdBiP/IQDFOsITUisQbalKACn/kGVZPoNZvpIBAQAA
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        bsegall@google.com, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4572; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a/9neu1tFH+KJoMSs60BVIB0GUVr2b3mTNMGBRScTUk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlW/He+R9tbOuG3iCWWr+KroLJVc1KteepSJ28g1T0
 o7YadV2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVvx3gAKCRAk1otyXVSH0M9yB/
 4glbrgSuL+qqlZo7pncWnZALQCHVi6bW1l9IilkRhvgdoz8H2MSQ2YP59x56pa0uMUOQoSoHH5l4v+
 Jjd7S3MDqc6TAuYwxmA4Vr6Bu74wm5etkRBbggKZEExxdu270I2gHsdx3CZzJ95ls2v2KsgGIHTOrY
 u9f5Amky+q7z+QcbPk9SJVj33XeKiBJgRFRQg/tK+xrAM/HZ3n/zIth3a+ys/nKNhjDcdLJqt6wYvk
 Z9lBOdYyMXQML24PyXvC6jyy5PRJaXgmo8EhLPcJy2zsUKNbQM+Okb54Kj1rrRZA9J2kJFI6xIxzLH
 zd/ls6HZZDHxG6V4SEu7lAVilp8STa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has recently added support for shadow stacks, currently
x86 only using their CET feature but both arm64 and RISC-V have
equivalent features (GCS and Zicfiss respectively), I am actively
working on GCS[1].  With shadow stacks the hardware maintains an
additional stack containing only the return addresses for branch
instructions which is not generally writeable by userspace and ensures
that any returns are to the recorded addresses.  This provides some
protection against ROP attacks and making it easier to collect call
stacks.  These shadow stacks are allocated in the address space of the
userspace process.

Our API for shadow stacks does not currently offer userspace any
flexiblity for managing the allocation of shadow stacks for newly
created threads, instead the kernel allocates a new shadow stack with
the same size as the normal stack whenever a thread is created with the
feature enabled.  The stacks allocated in this way are freed by the
kernel when the thread exits or shadow stacks are disabled for the
thread.  This lack of flexibility and control isn't ideal, in the vast
majority of cases the shadow stack will be over allocated and the
implicit allocation and deallocation is not consistent with other
interfaces.  As far as I can tell the interface is done in this manner
mainly because the shadow stack patches were in development since before
clone3() was implemented.

Since clone3() is readily extensible let's add support for specifying a
shadow stack when creating a new thread or process in a similar manner
to how the normal stack is specified, keeping the current implicit
allocation behaviour if one is not specified either with clone3() or
through the use of clone().  Unlike normal stacks only the shadow stack
size is specified, similar issues to those that lead to the creation of
map_shadow_stack() apply.

Please note that the x86 portions of this code are build tested only, I
don't appear to have a system that can run CET avaible to me, I have
done testing with an integration into my pending work for GCS.  There is
some possibility that the arm64 implementation may require the use of
clone3() and explicit userspace allocation of shadow stacks, this is
still under discussion.

A new architecture feature Kconfig option for shadow stacks is added as
here, this was suggested as part of the review comments for the arm64
GCS series and since we need to detect if shadow stacks are supported it
seemed sensible to roll it in here.

[1] https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.7-rc2.
- Remove stale shadow_stack in internal kargs.
- If a shadow stack is specified unconditionally use it regardless of
  CLONE_ parameters.
- Force enable shadow stacks in the selftest.
- Update changelogs for RISC-V feature rename.
- Link to v2: https://lore.kernel.org/r/20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org

Changes in v2:
- Rebase onto v6.7-rc1.
- Remove ability to provide preallocated shadow stack, just specify the
  desired size.
- Link to v1: https://lore.kernel.org/r/20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org

---
Mark Brown (5):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      fork: Add shadow stack support to clone3()
      selftests/clone3: Factor more of main loop into test_clone3()
      selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      kselftest/clone3: Test shadow stack support

 arch/x86/Kconfig                                  |   1 +
 arch/x86/include/asm/shstk.h                      |  11 +-
 arch/x86/kernel/process.c                         |   2 +-
 arch/x86/kernel/shstk.c                           |  59 +++++--
 fs/proc/task_mmu.c                                |   2 +-
 include/linux/mm.h                                |   2 +-
 include/linux/sched/task.h                        |   1 +
 include/uapi/linux/sched.h                        |   4 +
 kernel/fork.c                                     |  22 ++-
 mm/Kconfig                                        |   6 +
 tools/testing/selftests/clone3/clone3.c           | 200 +++++++++++++++++-----
 tools/testing/selftests/clone3/clone3_selftests.h |   7 +
 12 files changed, 250 insertions(+), 67 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
-- 
Mark Brown <broonie@kernel.org>

