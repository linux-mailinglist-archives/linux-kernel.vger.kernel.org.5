Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B587D7AD67C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIYK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:56:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0558AB8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:55:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27747002244so1640413a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639358; x=1696244158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkXNriz46VJXEH+3D4V7WJ8wWmj95WsD4ruF33VFe6Y=;
        b=dYoGhQZnQTjtT3XNrUjEyMr1KDyxfvm5mJz/dl1SiJkU4kc7dcgCqFwWhhiZzoNQhF
         wGHDGIxgplAzVXDDfO9XD97BeeCHXtQUgwUbJNef0KNmmlPD9qJ4YPi1p8MaV8hnlMSC
         Kf0MXsmGVmruOoM9MvnTPECPOYD32C/sjR2NjcJAkW1OQk1FCXK3D9Nv7TC4VuY5hLtI
         dPGng8a8uVdaXizvLonZEPYZkAED7osb6UNp6zsAAEKOLBVIIlcc/bscAxq+Mb85omyF
         jHt47t1t/gfrCIGBhUf5hsf8VBOOoZVYnwJytLVAc26sRzc1pewYITeNlpYNjDA9wbK8
         93YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639358; x=1696244158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkXNriz46VJXEH+3D4V7WJ8wWmj95WsD4ruF33VFe6Y=;
        b=P77r63Oj1hGn16qVNHZkUxi0P9Hxk6CJNsGUPU3bY9UJ8kW+E8iO9ATpDaABGaklGl
         Spe5pvUnNIvb/Vo6A8RdjvFN3uEUezzoyLQRhiDcuHDcKLaAeVqUq/paQpTZe+s40KrN
         MHA4YH35Mg+ERNHUnDSDfPmzguPTToYe/y4HsDQ9Taeguj6ho1+7lXLkVBnGtFbVhW/v
         IhIhmyLrtCqIwYTujmLRggpzA+by9fZsG/3/HtGkRV2VHQeuOw5wZbehnLtYQCntsnlZ
         IhVveJfwfKvOo7C+PK3+JkVI5+hF0womuBBp9hiqr/niXoODZ051pL5Asmlh6m/KxX5Y
         qTAg==
X-Gm-Message-State: AOJu0YwNdc6rqdg9IL2bEI5u6aBs7YiYFAERKEGIOSsFJx+GxgPYwxT8
        jWlLotW8mSwmWGtaPMJuvAgHGawLX4M95FZQEX4=
X-Google-Smtp-Source: AGHT+IFDBRmBp/V2qDkqnjBuMhMfYRGigwRGdWxy3LdHi+DIiXY8Ukq1z1VBhOcwG83sEcIb9X+nEg==
X-Received: by 2002:a17:90a:a095:b0:26b:e27:8bc2 with SMTP id r21-20020a17090aa09500b0026b0e278bc2mr5663296pjp.45.1695639358348;
        Mon, 25 Sep 2023 03:55:58 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:55:58 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 0/7] Add Open-coded task, css_task and css iters
Date:   Mon, 25 Sep 2023 18:55:45 +0800
Message-Id: <20230925105552.817513-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 3 of task, css_task and css iters support.
Thanks for your review!

--- Changelog ---

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

Chuyi Zhou (7):
  cgroup: Prepare for using css_task_iter_*() in BPF
  bpf: Introduce css_task open-coded iterator kfuncs
  bpf: Introduce task open coded iterator kfuncs
  bpf: Introduce css open-coded iterator kfuncs
  bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
  bpf: Let bpf_iter_task_new accept null task ptr
  selftests/bpf: Add tests for open-coded task and css iter

 include/linux/bpf.h                           |   8 +-
 include/linux/bpf_verifier.h                  |  19 ++-
 include/linux/btf.h                           |   1 +
 include/linux/cgroup.h                        |  12 +-
 kernel/bpf/cgroup_iter.c                      |  57 +++++++
 kernel/bpf/helpers.c                          |   9 +
 kernel/bpf/task_iter.c                        | 152 +++++++++++++++--
 kernel/bpf/verifier.c                         |  84 +++++++--
 kernel/cgroup/cgroup.c                        |  18 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  18 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  18 +-
 .../testing/selftests/bpf/prog_tests/iters.c  | 161 ++++++++++++++++++
 .../{bpf_iter_task.c => bpf_iter_tasks.c}     |   0
 .../testing/selftests/bpf/progs/iters_task.c  | 132 ++++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c  | 103 +++++++++++
 15 files changed, 734 insertions(+), 58 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

-- 
2.20.1

