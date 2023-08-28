Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D478B719
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjH1SP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjH1SPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:15:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D14012F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:15:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so2576378b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693246550; x=1693851350;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjDal+ixa9ENmQiKo0p9J0ZqWbGwZzR7cpKF1PwAJAg=;
        b=jaekYtqeH6iaIHkJZqUEWrO3m021S2786tp9bZINlUy0z3DcplxuPhme+Am4dqt48q
         3Iaz7OlMZLixvd+HNOoN3Pk+t4E19SN3T//rq415GpBr1XLHFFEj+Aec1m6MSfgYVvDp
         ujvSXv9rY2ZuHAJ5nZ/Cyh2aLUzyRPN8Zm0VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693246550; x=1693851350;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjDal+ixa9ENmQiKo0p9J0ZqWbGwZzR7cpKF1PwAJAg=;
        b=TUVUZcTIaAZJtytc3MSD7cySpPrpWmxpoXVRkBHAhR7mTq3WgpT2oGKHC7TC9v5EoX
         XJxEDYPzMOJqpcFjxVm4ufHTaT3J95unAsSNth77P6HHBigHJHbTCZVHIV9v2KXPPA3A
         nItD73YrA8hj5gu+WKjgImEvNKxS9A4VFzPP8Ak+hPyyN1slonQMLMeOIWDrq7FKJYaE
         qCe+r5L9jpyv8fqoQz/Iy17ryaxDimbu2NTUGmSCwb0lecrsviNVeim9wc93+xYhK/gx
         5e6Xm2ciBWjOtDm7un2okRPhefrN1XcvJfCVQUjjVGP77IEOoHE75G75ZI39chF7UWTW
         tWMw==
X-Gm-Message-State: AOJu0Yxkr5Sy0UMJt8CTv2liK3B2vpIFOYYJuoPgkxMW5MeJPs5YFPIV
        OJECSRHUAKWWI8nXTwWB3CrOl4LZnAJ74Clj/uk=
X-Google-Smtp-Source: AGHT+IES+Jfux6yMWXlCYrJu23EDCfdfCQwtX0UYkSUgBR3ynEIncD4ig8c5LJ6VZlp8nNf/n8Ne8w==
X-Received: by 2002:a05:6a20:1018:b0:14c:3679:a583 with SMTP id gs24-20020a056a20101800b0014c3679a583mr10012908pzc.3.1693246550033;
        Mon, 28 Aug 2023 11:15:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79399000000b0068be4ce33easm7140791pfe.96.2023.08.28.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:15:49 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:15:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp updates for v6.6-rc1
Message-ID: <202308281112.3C1EB9E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v6.6-rc1. These changes touch stuff
that doesn't normally look like things related to seccomp (sched, perf,
arm), but it is intentional. :) Each have been acked by maintainers and
have been in -next for a while.

Thanks!

-Kees

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.6-rc1

for you to fetch changes up to 46822860a5a9a5a558475d323a55c8aab0b54012:

  seccomp: Add missing kerndoc notations (2023-08-17 12:32:15 -0700)

----------------------------------------------------------------
seccomp updates for v6.6-rc1

- Provide USER_NOTIFY flag for synchronous mode (Andrei Vagin, Peter
  Oskolkov). This touches the scheduler and perf but has been Acked by
  Peter Zijlstra.

- Fix regression in syscall skipping and restart tracing on arm32.
  This touches arch/arm/ but has been Acked by Arnd Bergmann.

----------------------------------------------------------------
Andrei Vagin (5):
      seccomp: don't use semaphore and wait_queue together
      sched: add a few helpers to wake up tasks on the current cpu
      seccomp: add the synchronous mode for seccomp_unotify
      selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
      perf/benchmark: add a new benchmark for seccom_unotify

Kees Cook (4):
      selftests/seccomp: Handle arm32 corner cases better
      ARM: ptrace: Restore syscall restart tracing
      ARM: ptrace: Restore syscall skipping for tracers
      seccomp: Add missing kerndoc notations

Peter Oskolkov (1):
      sched: add WF_CURRENT_CPU and externise ttwu

 arch/arm/include/asm/syscall.h                |   3 +
 arch/arm/kernel/entry-common.S                |   1 +
 arch/arm/kernel/ptrace.c                      |   5 +-
 include/linux/completion.h                    |   1 +
 include/linux/swait.h                         |   2 +-
 include/linux/wait.h                          |   3 +
 include/uapi/linux/seccomp.h                  |   4 +
 kernel/sched/completion.c                     |  26 ++--
 kernel/sched/core.c                           |   5 +-
 kernel/sched/fair.c                           |   4 +
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/swait.c                          |   8 +-
 kernel/sched/wait.c                           |   5 +
 kernel/seccomp.c                              |  84 ++++++++++--
 tools/arch/x86/include/uapi/asm/unistd_32.h   |   3 +
 tools/arch/x86/include/uapi/asm/unistd_64.h   |   3 +
 tools/perf/bench/Build                        |   1 +
 tools/perf/bench/bench.h                      |   1 +
 tools/perf/bench/sched-seccomp-notify.c       | 178 ++++++++++++++++++++++++++
 tools/perf/builtin-bench.c                    |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |  67 +++++++++-
 21 files changed, 384 insertions(+), 34 deletions(-)
 create mode 100644 tools/perf/bench/sched-seccomp-notify.c

-- 
Kees Cook
