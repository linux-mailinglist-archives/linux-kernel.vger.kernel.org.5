Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB927FE03F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjK2TWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2TWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:22:00 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E61A8;
        Wed, 29 Nov 2023 11:22:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so103063b3a.1;
        Wed, 29 Nov 2023 11:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701285722; x=1701890522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XJAENFh/MmUTKzAnQ+33gujVhhNm0oQkxcdUhTqEisg=;
        b=F+egvpstqBgYoc92Fyn/eeKpj4nvQsREcvs3ObKQ/OIuqtZLJaoI+4Xa9q8sWU5UtS
         R8GeKHY97l6a0/ohjTGlTScT3GrqstR00IlbdlU3QWDIox2E2v/lp3llKetFC+OCvLZy
         pSH1GCvL8NiPPX/bvI6V2Ie20fMvQnHMc+pmMd05lfC7e8Z+/ATywqk0NgvkvWdZMZe6
         TVh+St9lqFiBZvhrl9WH02WXuPK3BbqoMLBb55wjX4izv11Cpq0q5YbNuAwII+pw5n4W
         +icOtATRcoqOUB0BrJmYEBU5DDdXyui6wdsMopMK8VsUzlb2REiuAY8Ad7LRy7CpTgXS
         /GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701285722; x=1701890522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJAENFh/MmUTKzAnQ+33gujVhhNm0oQkxcdUhTqEisg=;
        b=DxgltfwFmJtRvooNkED07XOsSLJ2z0E6FT9EC8dBLDCnXLcS8LyzO6Mxz/rqOjWAQs
         7tlEnQXFFfZT78tbK1mXefreUuiK5U7V1/yY/2ZIpWG9L0GDwn4IqHJRjsPqvG9P+eTo
         Alx/LfdpBA2KzXX8OFZoHMwgOdGMhtfjKg66PkxcPuxkLO1eG4rvtlWgPLMXZdPM6mYP
         3kgPCQZXkD2CW2OZvnY4MD1LTiSvOowlEVrvCIcpqaqtzgxobERUF3chVL8ZssAuct51
         Knj2D1pUmClyZMP+gNC5+0wbvmyVXeJFXsHE9B92SxSls/Bg6FFvSN3kJ0CVGGVYWBR/
         S8/Q==
X-Gm-Message-State: AOJu0YzpiH2XcRvIvIHoQ88VyTCypSHeMApZdmB3UMe7oWvl++eWR8Nz
        Ny4Ee/7qmIJmx6JL89VWynQ=
X-Google-Smtp-Source: AGHT+IEgE9s0HMGzZrE63UWaEvHBNOnpr5Wl7XwgReRkmaQuCOe8bxI6dDd1v6nW3SO5fE/jGZWDFQ==
X-Received: by 2002:a05:6a00:17a1:b0:6cd:dc48:1fff with SMTP id s33-20020a056a0017a100b006cddc481fffmr2613129pfg.0.1701285722116;
        Wed, 29 Nov 2023 11:22:02 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:cd6b:329c:a3c7:d0d0])
        by smtp.gmail.com with ESMTPSA id p6-20020a056a000a0600b006c0685422e0sm11069955pfh.214.2023.11.29.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:22:01 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools fixes for v6.7: 1st batch
Date:   Wed, 29 Nov 2023 11:21:58 -0800
Message-ID: <20231129192158.1026606-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following fixes for the perf tools.

Thanks
Namhyung


The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-1-2023-11-29

for you to fetch changes up to 57686a72da08ae555d93148aa8756b16417a6aff:

  tools: Disable __packed attribute compiler warning due to -Werror=attributes (2023-11-22 12:23:27 -0800)

----------------------------------------------------------------
perf tools fixes for v6.7: 1st batch

Assorted build fixes including:
- fix compile errors in printf() with u64 on 32-bit systesm
- sync kernel headers to the tool copies
- update arm64 sysreg generation for tarballs
- disable compile warnings on __packed attribute

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      tools: Disable __packed attribute compiler warning due to -Werror=attributes

Namhyung Kim (14):
      tools headers UAPI: Update tools's copy of drm headers
      tools headers UAPI: Update tools's copy of fscrypt.h header
      tools headers UAPI: Update tools's copy of kvm.h header
      tools headers UAPI: Update tools's copy of mount.h header
      tools headers UAPI: Update tools's copy of vhost.h header
      tools headers UAPI: Update tools's copy of unistd.h header
      tools headers: Update tools's copy of socket.h header
      tools headers: Update tools's copy of x86/asm headers
      tools headers: Update tools's copy of arm64/asm headers
      tools headers: Update tools's copy of s390/asm headers
      tools/perf: Update tools's copy of x86 syscall table
      tools/perf: Update tools's copy of powerpc syscall table
      tools/perf: Update tools's copy of s390 syscall table
      tools/perf: Update tools's copy of mips syscall table

Oliver Upton (2):
      tools perf: Add arm64 sysreg files to MANIFEST
      perf build: Ensure sysreg-defs Makefile respects output dir

Yang Jihong (2):
      perf kwork: Fix a build error on 32-bit
      perf lock contention: Fix a build error on 32-bit

 tools/arch/arm64/include/asm/cputype.h             |  5 +++-
 tools/arch/arm64/include/uapi/asm/kvm.h            | 32 ++++++++++++++++++++++
 tools/arch/arm64/include/uapi/asm/perf_regs.h      | 10 ++++---
 tools/arch/arm64/tools/Makefile                    |  2 +-
 tools/arch/s390/include/uapi/asm/kvm.h             | 16 +++++++++++
 tools/arch/x86/include/asm/cpufeatures.h           | 16 ++++++++++-
 tools/arch/x86/include/asm/disabled-features.h     | 16 +++++++++--
 tools/arch/x86/include/asm/msr-index.h             | 23 +++++++++++++---
 tools/arch/x86/include/uapi/asm/prctl.h            | 12 ++++++++
 tools/include/asm-generic/unaligned.h              |  1 +
 tools/include/uapi/asm-generic/unistd.h            | 12 ++++++--
 tools/include/uapi/drm/drm.h                       | 20 ++++++++++++++
 tools/include/uapi/drm/i915_drm.h                  |  8 +++---
 tools/include/uapi/linux/fscrypt.h                 |  3 +-
 tools/include/uapi/linux/kvm.h                     | 24 ++++++++++++++--
 tools/include/uapi/linux/mount.h                   |  3 +-
 tools/include/uapi/linux/vhost.h                   |  8 ++++++
 tools/perf/MANIFEST                                |  2 ++
 tools/perf/Makefile.perf                           | 24 ++++++++++------
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  4 +++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  4 +++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  4 +++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  3 ++
 tools/perf/builtin-kwork.c                         |  2 +-
 tools/perf/trace/beauty/include/linux/socket.h     |  1 +
 tools/perf/util/Build                              |  2 +-
 tools/perf/util/bpf_lock_contention.c              |  3 +-
 tools/testing/selftests/kvm/Makefile               |  5 ++--
 28 files changed, 226 insertions(+), 39 deletions(-)
