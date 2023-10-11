Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FC7C5320
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbjJKMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346387AbjJKMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220B98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-69101022969so6029703b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026153; x=1697630953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fNjLclbns4EdbGQa0XXjoLwDUtB1HLz6HRovFTIGlA=;
        b=Uzp2OH/QtbSjWQ1LWEmEoz+NncXdSfWZTo45I+WPBhU5oa8jMxzvv9EJbvEDoZPDS5
         rGtNIhJkZJXfZtvZDQGaamb4dveZRisLS9pAAAuRaVO/yVMTSg4d2uGpEeyz1Jj4F8P+
         NKaAhDPzjW14gdzDVAuTyZt3SIPSuhfpbz3KYVYC0EmLvXnKN0dTVAgGRTRW4PXdL7WX
         bXnpnQreLbEKO9VsuRfK9M9cGcNmuReCoZiYFtFasF4DFAObi86r8zMgfHHkPWqbS4/+
         UGBCWGkZnpSz66Qx9wftruiAuU/178BDfpt1ukGucq6TR8pkO2MHbKK4ETatvOdnTymo
         Hx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026153; x=1697630953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fNjLclbns4EdbGQa0XXjoLwDUtB1HLz6HRovFTIGlA=;
        b=G9bKsxUdRnXqoYjyWz5CHrXSqG0oAXytgYw73+Mz0Odz/T66+tgcJ5l8c+RuhfgHAM
         9eZ00eXSPMJEUyYbR3om+ToSEhanvZdUO+pyDAu+YfpxXi48kApE0ZarLcEF2ODWZBcS
         zq3OxTf+Lt2BRSXdCQ/RTMRgxQmlNdYWtQloCuM08vrgA1C4/jDXfV6zxCMt6bOLALaz
         GKpLOJUP6Vi4npkyUVSIuif7XM9enWjZw3W0hRBPqx8m0cdwQwli4KsJgzaRNvPHPBNY
         T5OSjXkjJ1G2ouckT/Sn44sy5qhzNYoQtFd/VHZFZ3RJ9RFgqEDrT/z4WKMJfDK35D3h
         o8Pg==
X-Gm-Message-State: AOJu0Ywn88tTT89d59SWoz1Bmikz50Qs/WIv0lG5QFqQBVPeTUhkAF1m
        DW5Ow1TljqzNghFJzBozs8gaTg==
X-Google-Smtp-Source: AGHT+IGAFSeGENqjnC/qjGPhAWDtwaziEBACt5mQQ3JUe2BfE3lj34jsuxVAH0+Glorxq8dMOPY63A==
X-Received: by 2002:a05:6a00:2da2:b0:68f:cc47:fcd7 with SMTP id fb34-20020a056a002da200b0068fcc47fcd7mr23933038pfb.28.1697026153154;
        Wed, 11 Oct 2023 05:09:13 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9962769pfh.62.2023.10.11.05.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:12 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v5 0/8] Add Open-coded task, css_task and css iters
Date:   Wed, 11 Oct 2023 20:08:49 +0800
Message-Id: <20231011120857.251943-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 5 of task, css_task and css iters support.

--- Changelog ---

v5 -> v4:

Patch 3~4:
 * Change the BUILD_BUG_ON check in bpf_iter_task_new and bpf_iter_css_new to avoid
   netdev/build_32bit CI error
   (https://netdev.bots.linux.dev/static/nipa/790929/13412333/build_32bit/stderr)

Patch 8:
 * Initialize skel pointer to fix the LLVM-16 build CI error
 (https://github.com/kernel-patches/bpf/actions/runs/6462875618/job/17545170863)

v3 -> v4:https://lore.kernel.org/all/20230925105552.817513-1-zhouchuyi@bytedance.com/

* Address all the comments from Andrii in patch-3 ~ patch-6
* Collect Tejun's ack
* Add a extra patch to rename bpf_iter_task.c to bpf_iter_tasks.c
* Seperate three BPF program files for selftests (iters_task.c iters_css_task.c iters_css.c)

v2 -> v3:https://lore.kernel.org/lkml/20230912070149.969939-1-zhouchuyi@bytedance.com/

Patch 1 (cgroup: Prepare for using css_task_iter_*() in BPF)
  * Add tj's ack and Alexei's suggest-by.
Patch 2 (bpf: Introduce css_task open-coded iterator kfuncs)
  * Use bpf_mem_alloc/bpf_mem_free rather than kzalloc()
  * Add KF_TRUSTED_ARGS for bpf_iter_css_task_new (Alexei)
  * Move bpf_iter_css_task's definition from uapi/linux/bpf.h to
    kernel/bpf/task_iter.c and we can use it from vmlinux.h
  * Move bpf_iter_css_task_XXX's declaration from bpf_helpers.h to
    bpf_experimental.h
Patch 3 (Introduce task open coded iterator kfuncs)
  * Change th API design keep consistent with SEC("iter/task"), support
    iterating all threads(BPF_TASK_ITERATE_ALL) and threads of a
    specific task (BPF_TASK_ITERATE_THREAD).（Andrii)
  * Move bpf_iter_task's definition from uapi/linux/bpf.h to
    kernel/bpf/task_iter.c and we can use it from vmlinux.h
  * Move bpf_iter_task_XXX's declaration from bpf_helpers.h to
    bpf_experimental.h
Patch 4 (Introduce css open-coded iterator kfuncs)
  * Change th API design keep consistent with cgroup_iters, reuse
    BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST
    /BPF_CGROUP_ITER_ANCESTORS_UP(Andrii)
  * Add KF_TRUSTED_ARGS for bpf_iter_css_new
  * Move bpf_iter_css's definition from uapi/linux/bpf.h to
    kernel/bpf/task_iter.c and we can use it from vmlinux.h
  * Move bpf_iter_css_XXX's declaration from bpf_helpers.h to
    bpf_experimental.h
Patch 5 (teach the verifier to enforce css_iter and task_iter in RCU CS)
  * Add KF flag KF_RCU_PROTECTED to maintain kfuncs which need RCU CS.(Andrii)
  * Consider STACK_ITER when using bpf_for_each_spilled_reg.
Patch 6 (Let bpf_iter_task_new accept null task ptr)
  * Add this extra patch to let bpf_iter_task_new accept a 'nullable'
  * task pointer(Andrii)
Patch 7 (selftests/bpf: Add tests for open-coded task and css iter)
  * Add failure testcase(Alexei)


Changes from v1(https://lore.kernel.org/lkml/20230827072057.1591929-1-zhouchuyi@bytedance.com/):
- Add a pre-patch to make some preparations before supporting css_task
  iters.(Alexei)
- Add an allowlist for css_task iters(Alexei)
- Let bpf progs do explicit bpf_rcu_read_lock() when using process
  iters and css_descendant iters.(Alexei)
---------------------

In some BPF usage scenarios, it will be useful to iterate the process and
css directly in the BPF program. One of the expected scenarios is
customizable OOM victim selection via BPF[1].

Inspired by Dave's task_vma iter[2], this patchset adds three types of
open-coded iterator kfuncs:

1. bpf_task_iters. It can be used to
1) iterate all process in the system, like for_each_forcess() in kernel.
2) iterate all threads in the system.
3) iterate all threads of a specific task

2. bpf_css_iters. It works like css_task_iter_{start, next, end} and would
be used to iterating tasks/threads under a css.

3. css_iters. It works like css_next_descendant_{pre, post} to iterating all
descendant css.

BPF programs can use these kfuncs directly or through bpf_for_each macro.

link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/

Chuyi Zhou (8):
  cgroup: Prepare for using css_task_iter_*() in BPF
  bpf: Introduce css_task open-coded iterator kfuncs
  bpf: Introduce task open coded iterator kfuncs
  bpf: Introduce css open-coded iterator kfuncs
  bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
  bpf: Let bpf_iter_task_new accept null task ptr
  selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
  selftests/bpf: Add tests for open-coded task and css iter

 include/linux/bpf_verifier.h                  |  19 ++-
 include/linux/btf.h                           |   1 +
 include/linux/cgroup.h                        |  12 +-
 kernel/bpf/cgroup_iter.c                      |  59 +++++++
 kernel/bpf/helpers.c                          |   9 +
 kernel/bpf/task_iter.c                        | 138 +++++++++++++++
 kernel/bpf/verifier.c                         |  86 ++++++++--
 kernel/cgroup/cgroup.c                        |  18 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  19 +++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  18 +-
 .../testing/selftests/bpf/prog_tests/iters.c  | 161 ++++++++++++++++++
 .../{bpf_iter_task.c => bpf_iter_tasks.c}     |   0
 tools/testing/selftests/bpf/progs/iters_css.c |  74 ++++++++
 .../selftests/bpf/progs/iters_css_task.c      |  42 +++++
 .../testing/selftests/bpf/progs/iters_task.c  |  41 +++++
 .../selftests/bpf/progs/iters_task_failure.c  | 105 ++++++++++++
 16 files changed, 760 insertions(+), 42 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

-- 
2.20.1

