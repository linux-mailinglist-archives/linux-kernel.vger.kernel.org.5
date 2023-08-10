Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE4777285
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjHJIN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjHJINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80D211B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3efebcc24so503425b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655207; x=1692260007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEx1EuEgk0xV+c+q+3VbaXrWwc7le6laBtvGOnu8wyQ=;
        b=ijsKmiltZmQUhQYUjGd7SHhsVtX8YNhhN6I8sy4n2JiRX3b1y7j5NWS2dVdpykwqCq
         54/qPpSLd1/T1rsZsIbrKz5gpF20u+I21TRZ0+CLmdPrLc/355ivsbhzdaV0baDn8fQr
         PL2D1DNPGuouhWTAZCfNORitelOUxt7AXL2OncZDVwL3dW9ghEu6FHBKVH8RFa+nLjOW
         67DKngKnv43zyUthGq5kwTChsSb3K1AokbfkHXxU+JKBxQ46ZxVTIq3MmdBbwUjFVL9m
         pyoSEJxRcQKKabPqKL94pHarAFDeuFhBIDQkMaNBR2i0yTA3xk/vQ0ydGLBkhWgzN8HU
         DFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655207; x=1692260007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEx1EuEgk0xV+c+q+3VbaXrWwc7le6laBtvGOnu8wyQ=;
        b=eJ20eXZucsY56mZa25TUAHAV+Qfuz1p1CJewZ8yN42h02ZL/8i4Kn1h54ozEf9FwV/
         R0b1wdaUc+oQzeG3L495u/61EDCeHS92vSDdccEZGQkY+tOx3TnWxq7eRySDV9IfiJXQ
         ZuGUWdWddXK5vdNxNmUwnMLvRfJajcTQWzdpQzPqrnpOVI3e6Umd4xmLSCoW2Jg+TnVm
         4KuLAFf/l/MNfwGKpBLsBMjQUmSqQyAdaEMnESmYmODRPZBX4cfeD/Y+bIVreb8DukkJ
         yh4Xj4qzAlDqomdXSYtNV0UiW0e9Sy0GqIANzvOOf9lv5kxxSbZ5grXLG/hoG407m6Yu
         OWIw==
X-Gm-Message-State: AOJu0Yz8ru1V+vunITz+p3rk996hLmjJXgyvDaUz63lsbBc8d20RusCy
        Q7C3ME71jKfmPLc4YburhjrodA==
X-Google-Smtp-Source: AGHT+IE2h63tBYQsvpB8Jxhr0t4pd8l49Xn88nWC57GEvyMlWjF77/7EcfFdg1Yy5bCCML7us+EA5w==
X-Received: by 2002:a05:6808:30a5:b0:3a7:3ab9:e590 with SMTP id bl37-20020a05680830a500b003a73ab9e590mr2629027oib.9.1691655207046;
        Thu, 10 Aug 2023 01:13:27 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:26 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH v2 0/5] mm: Select victim using bpf_oom_evaluate_task
Date:   Thu, 10 Aug 2023 16:13:14 +0800
Message-Id: <20230810081319.65668-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes
-------

This is v2 of the BPF OOM policy patchset.
v1 : https://lore.kernel.org/lkml/20230804093804.47039-1-zhouchuyi@bytedance.com/
v1 -> v2 changes:

- rename bpf_select_task to bpf_oom_evaluate_task and bypass the
tsk_is_oom_victim (and MMF_OOM_SKIP) logic. (Michal)

- add a new hook to set policy's name, so dump_header() can know
what has been the selection policy when reporting messages. (Michal)

- add a tracepoint when select_bad_process() find nothing. (Alan)

- add a doc to to describe how it is all supposed to work. (Alan)

================

This patchset adds a new interface and use it to select victim when OOM
is invoked. The mainly motivation is the need to customizable OOM victim
selection functionality.

The new interface is a bpf hook plugged in oom_evaluate_task. It takes oc
and current task as parameters and return a result indicating which one is
selected by the attached bpf program.

There are several conserns when designing this interface suggested by
Michal:

1. Hooking into oom_evaluate_task can keep the consistency of global and
memcg OOM interface. Besides, it seems the least disruptive to the existing
oom killer implementation.

2. Userspace can handle a lot on its own and provide the input to the BPF
program to make a decision. Since the oom scope iteration will be
implemented already in the kernel so all the BPF program has to do is to
rank processes or memcgs.

3. The new interface should better bypass the current heuristic rules
(e.g., tsk_is_oom_victim, and MMF_OOM_SKIP) to meet an arbitrary oom
policy's need.

Chuyi Zhou (5):
  mm, oom: Introduce bpf_oom_evaluate_task
  mm: Add policy_name to identify OOM policies
  mm: Add a tracepoint when OOM victim selection is failed
  bpf: Add a OOM policy test
  bpf: Add a BPF OOM policy Doc

 Documentation/bpf/oom.rst                     |  70 +++++++++
 include/linux/oom.h                           |   7 +
 include/trace/events/oom.h                    |  18 +++
 mm/oom_kill.c                                 | 100 +++++++++++--
 .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
 .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
 6 files changed, 428 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/bpf/oom.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
 create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c

-- 
2.20.1

