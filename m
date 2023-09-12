Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882E279C77D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjILHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjILHCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070AE7C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:01:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so44042165ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502118; x=1695106918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MB3Qkjjlw5hcMhrPR6LeX9MD2h80SkIGJQgP0ux+r7k=;
        b=Y+JY1U7cdDH6+WdhWG+jx92Z1YlgNPiheNE3JQgtfyKVrVkgSnJ511PX5YL5nP8i8o
         nQ3DIlKMMbA2w4TUl2BYnd/eYRH9gdNpW+72v8bxfZzZrO+fbM5lN7AutGEYeAqUN8mL
         vSdHjdPytTw44CodoeZDxcPenvIO94PdLFprc7zNl+q4RYjVF7UCK+FoBPlWQAooj9gu
         TN3jQf/ptIwE220kNWRz4SIolBl65lg8OasEf3ViB9HBbrSeigkBXJSOWzmbBA6qgbKv
         SG9SuS/92OGeJE3WWggBvlizgE9nyM5Oghd9Cw9QvVfZVGoyZ4rAG4rO48PQ0BdVfyFz
         BPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502118; x=1695106918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB3Qkjjlw5hcMhrPR6LeX9MD2h80SkIGJQgP0ux+r7k=;
        b=ZFIdTXA1QT10mGnic+RHmqyc85uNxcfmmqJkTOzee4kI+9e2H4SB6Vv6aVysheWCcI
         c66jume6lupWnaVGjyJJtGodwbb5hX+7HC3JSEpWKFNodR6ybmrrvcC8DPTqWxZqW4V4
         r86xX1mJ3fw1npoQ5/L7t22OteaT3w9Lnr0y1uFqDFgMBcBS1qYfFyHNsTdPHHio94yA
         nursPfFw/lGl5Dr9yKHwxpY6CC5OAGYEV0xVkf2yCXAYLFbeV72AsSFd5BMsVXVFQGLt
         EGFPPWdRj6EQHHHX+3vEkVP2dzBQH7MojLzXNNmDsgTDpeIrTOS4KOv+xKPVpN3oRXoP
         rrXg==
X-Gm-Message-State: AOJu0YxsEyJtIDa49Dg+GwuFe6XsaRl/vyOb+OxZnkafMgky9LvgHHV6
        nfGaL4TSAoUUALtc50DCPDIwEw==
X-Google-Smtp-Source: AGHT+IGVov7oQgYAM90yOHAtqJMtaQjXDBmGz4tHiQIhTOTnMTO1r7bguhmy5c+NjVQAkP9QeQ7JUA==
X-Received: by 2002:a17:903:22c8:b0:1bb:85cd:9190 with SMTP id y8-20020a17090322c800b001bb85cd9190mr2731636plg.18.1694502118654;
        Tue, 12 Sep 2023 00:01:58 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:01:58 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 0/6] Add Open-coded process and css iters
Date:   Tue, 12 Sep 2023 15:01:43 +0800
Message-Id: <20230912070149.969939-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 2 of process and css iters support. All the changes were
suggested by Alexei.

Thanks for your review!

--- Changelog ---
Changes from v1:
- Add a pre-patch to make some preparations before supporting css_task
  iters.
- Add an allowlist for css_task iters
- Let bpf progs do explicit bpf_rcu_read_lock() when using process iters
and css_descendant iters.
---------------------

In some BPF usage scenarios, it will be useful to iterate the process and
css directly in the BPF program. One of the expected scenarios is
customizable OOM victim selection via BPF[1].

Inspired by Dave's task_vma iter[2], this patchset adds three types of
open-coded iterator kfuncs:

1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
itearing all tasks in the system.

2. bpf_for_each(css_task, task, css). It works like
css_task_iter_{start, next, end} and would be used to iterating
tasks/threads under a css.

3. bpf_for_each(css_{post, pre}, pos, root_css). It works like
css_next_descendant_{pre, post} to iterating all descendant css.

BPF programs can use these kfuncs directly or through bpf_for_each macro.

link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/

Chuyi Zhou (6):
  cgroup: Prepare for using css_task_iter_*() in BPF
  bpf: Introduce css_task open-coded iterator kfuncs
  bpf: Introduce process open coded iterator kfuncs
  bpf: Introduce css_descendant open-coded iterator kfuncs
  bpf: teach the verifier to enforce css_iter and process_iter in RCU CS
  selftests/bpf: Add tests for open-coded task and css iter

 include/linux/cgroup.h                        |  12 +-
 include/uapi/linux/bpf.h                      |  16 ++
 kernel/bpf/helpers.c                          |  12 ++
 kernel/bpf/task_iter.c                        | 130 +++++++++++++++++
 kernel/bpf/verifier.c                         |  53 ++++++-
 kernel/cgroup/cgroup.c                        |  18 ++-
 tools/include/uapi/linux/bpf.h                |  16 ++
 tools/lib/bpf/bpf_helpers.h                   |  24 +++
 .../testing/selftests/bpf/prog_tests/iters.c  | 138 ++++++++++++++++++
 .../testing/selftests/bpf/progs/iters_task.c  | 104 +++++++++++++
 10 files changed, 508 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c

-- 
2.20.1

