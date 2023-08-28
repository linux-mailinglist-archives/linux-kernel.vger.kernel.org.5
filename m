Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D578B408
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjH1PJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjH1PJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEBFC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40078c4855fso31256685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235345; x=1693840145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nk67n76bWffKzPFNDlhyIKPeZKFaIzOGb7e8DY77Kug=;
        b=Ps6Ug/MbVZfF1WnG0Xo86FyNGanHGgMs/NWfuk9ZoD9qAa9fCW1q6dFA0DtPKR4v5s
         7aq0RD68DSDxj0UlihZLRvQtJRxW78pPE70183dhmI+j/2y3opUH4XJy3ti7YY50HZTP
         3ozkH0IWk2RTQk88PcNOqGP6K2M1ZvsLH02pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235345; x=1693840145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nk67n76bWffKzPFNDlhyIKPeZKFaIzOGb7e8DY77Kug=;
        b=JN/1PSx6m0I0+ODR0whCRcS0nGDEjFeDL3u12baaoyP3QcMzKihBVCCmRqrSwmMm3d
         GT/CrI8BRiuoQ0+ZtBwqOBegKvwcRXWesSNOr+z5gOLBc33z1K6tsBy2NdOSi7Jh0T7U
         iMr38ec2hw4BOzHFHFDG21xNRf0PRizyfu4a18xswETdiQfAfRUkiOEbrHmQ+ZW4Xnlq
         SqhOGgPwE9UdRqg3Bo1DJnRtn2gLLzCjEPBG4YitcAiSToAjv3HlnFQN+5XrEqBcRU53
         90LVkUXTvYdcMQ/5rm4Gso2EEqG4k3XlmfajuOPbVl5+4lP9XWMx21D/kDkva4WcMlLT
         phNg==
X-Gm-Message-State: AOJu0YzK9kcxWa3HEUqnmOv7I7hI+clxgIEQQu7RBCFPHXCRGME//92A
        /s5Z+umHvJ/qxiiD7POpvnlaw746/ObyDmm6Ju8=
X-Google-Smtp-Source: AGHT+IGoXzzFSUGxduA2rZXXMmGWetii0IG5xXH3CT+sQ+sMZVQLPjQjqM011ItlU52gfoVjsC3YxQ==
X-Received: by 2002:a5d:5308:0:b0:316:f24b:597a with SMTP id e8-20020a5d5308000000b00316f24b597amr18000575wrv.46.1693235344820;
        Mon, 28 Aug 2023 08:09:04 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:03 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>
Subject: [PATCH v4 0/6] MDWE without inheritance
Date:   Mon, 28 Aug 2023 17:08:52 +0200
Message-ID: <20230828150858.393570-1-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prctl which tags
current with a flag that prevents pages that were previously not executable from
becoming executable.
This tag always gets inherited by children tasks. (it's in MMF_INIT_MASK)

At Google, we've been using a somewhat similar downstream patch for a few years
now. To make the adoption of this feature easier, we've had it support a mode in
which the W^X flag does not propagate to children. For example, this is handy if
a C process which wants W^X protection suspects it could start children
processes that would use a JIT.

I'd like to align our features with the upstream prctl. This series proposes a
new NO_INHERIT flag to the MDWE prctl to make this kind of adoption easier. It
sets a different flag in current that is not in MMF_INIT_MASK and which does not
propagate.

As part of looking into MDWE, I also fixed a couple of things in the MDWE test.

This series applies on the mm-everything-2023-08-25-20-06 tag of the mm tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

Diff since v3:
- Added a bunch of Reviewed-by, Acked-by and Tested-by. Thanks everyone!
- Reworded patch 2's description for clarity
- Removed an unnecessary int cast
- Added test coverage for errnos of invalid prctls (EPERM/EINVAL)
- Added test coverage for can_keep_no_flags and can_keep_both_flags

Diff since v2:
- Turned the MMF_INIT_FLAGS macro into a mmf_init_flags function as suggested by
  David Hildenbrand
- Removed the ability to transition from to PR_MDWE_REFUSE_EXEC_GAIN from
  (PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT) which also significantly
  simplifies the prctl_set_mdwe logic
- Cc-ed -stable on patch 3 as suggested by Alexey Izbyshev
- Added a handful of Reviewed-by/Acked-by trailers

Diff since v1:
- MMF_HAS_MDWE_NO_INHERIT clears MMF_HAS_MDWE in the fork path as part of a
  MMF_INIT_FLAGS macro (suggested by Catalin)
- PR_MDWE_* are defined as unsigned long rather than int (suggested by Andrey)

Florent Revest (6):
  kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
  kselftest: vm: Fix mdwe's mmap_FIXED test case
  kselftest: vm: Check errnos in mdwe_test
  mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
  mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
  kselftest: vm: Add tests for no-inherit memory-deny-write-execute

 include/linux/sched/coredump.h         |  10 ++
 include/uapi/linux/prctl.h             |   3 +-
 kernel/fork.c                          |   2 +-
 kernel/sys.c                           |  32 ++++--
 tools/include/uapi/linux/prctl.h       |   3 +-
 tools/testing/selftests/mm/mdwe_test.c | 137 ++++++++++++++++++++++---
 6 files changed, 163 insertions(+), 24 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

