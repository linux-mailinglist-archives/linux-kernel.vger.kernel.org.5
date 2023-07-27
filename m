Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD776492A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjG0Hoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjG0Hna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44683EC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so383530b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443423; x=1691048223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdW9TKjaVoY8TAoiZ9/Vr1Qx2UudtUG/Q1a9kCBPzGw=;
        b=WJUfha13VzDGQgQyWyKoLGRPd9B2AkAKQKlD7TIy163bJUtKECJHVmywN3s0unJxcA
         AFA1yR4NNxwgvdmCB9kcHHQPMLl9LlV8pAcIGWlF0HUvZLVIlQEbvML2tpREm3u8AD4k
         ZViVO1tm0udVd0TVKE7yJTePILn0TB+bdWzMf3niDZWAHwzWJFTwp+C84Q2j6ViYWC5t
         4N5Am2+2fKfp6XRRZQnrrgjY5wF7mYeeJH4JoDqHPFPB6qrHo39bwgcnuGX6byF15qjx
         ceejVzI8aCT+WIluxObIBO5wrLPWkAdawMcVjKG/3zRwdXvZXxv1sPDUtb817SM3m6vs
         XPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443423; x=1691048223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdW9TKjaVoY8TAoiZ9/Vr1Qx2UudtUG/Q1a9kCBPzGw=;
        b=a/fSoOccBDeP72ZQCBBari5VgNjsc6JgCgKeWxkG4BpHzs1jsAs1rcDjjoib6ZcfMm
         Dxjt/jg6s+q69DMDB18ratBDNqToPwdncZyrlwUya+Y61j+LYzGjWttst2UvEMJspE/X
         9BDGEkPqieqEbETQIGf0vpqfq2Ui6LoCAO10yNzkiLDyak77TCLB9Yba4I6y2u6FJvcY
         ODPk0IRi1j+SauDft1MMmtyzP3SboloRHKI2RNq1QJAmvD/9IPUBaO4hMczy5dM0xAeM
         DvN/gpzhiwm5VIpvsY0Fy53998qspnJ+r9FV04JtS2KpuIyLaprp4ogEHh1ZBJpOnwDi
         6C0g==
X-Gm-Message-State: ABy/qLaeoX8o0lWK/gKzQxbHGuuung9AKjmA3gal1CiAp2i98zHSFmGH
        uUpxxc4iOLCqI5YjRJ9Vy6gwEw==
X-Google-Smtp-Source: APBJJlGxrFogQX0h6qLoImls0/eZEcESwzsR7mUASJnTL6C0r6eTOSp0Rv2425LMPb9lvt4ZknyY3Q==
X-Received: by 2002:a05:6a20:3c8f:b0:123:152d:d46b with SMTP id b15-20020a056a203c8f00b00123152dd46bmr2384597pzj.26.1690443423642;
        Thu, 27 Jul 2023 00:37:03 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:03 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Date:   Thu, 27 Jul 2023 15:36:27 +0800
Message-Id: <20230727073632.44983-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to add a new bpf prog type and use it to select
a victim memcg when global OOM is invoked. The mainly motivation is
the need to customizable OOM victim selection functionality so that
we can protect more important app from OOM killer.

Chuyi Zhou (5):
  bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
  mm: Select victim memcg using bpf prog
  libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
  bpf: Add a new bpf helper to get cgroup ino
  bpf: Sample BPF program to set oom policy

 include/linux/bpf_oom.h        |  22 ++++
 include/linux/bpf_types.h      |   2 +
 include/linux/memcontrol.h     |   6 ++
 include/uapi/linux/bpf.h       |  21 ++++
 kernel/bpf/core.c              |   1 +
 kernel/bpf/helpers.c           |  17 +++
 kernel/bpf/syscall.c           |  10 ++
 mm/memcontrol.c                |  50 +++++++++
 mm/oom_kill.c                  | 185 +++++++++++++++++++++++++++++++++
 samples/bpf/Makefile           |   3 +
 samples/bpf/oom_kern.c         |  42 ++++++++
 samples/bpf/oom_user.c         | 128 +++++++++++++++++++++++
 tools/bpf/bpftool/common.c     |   1 +
 tools/include/uapi/linux/bpf.h |  21 ++++
 tools/lib/bpf/libbpf.c         |   3 +
 tools/lib/bpf/libbpf_probes.c  |   2 +
 16 files changed, 514 insertions(+)
 create mode 100644 include/linux/bpf_oom.h
 create mode 100644 samples/bpf/oom_kern.c
 create mode 100644 samples/bpf/oom_user.c

-- 
2.20.1

