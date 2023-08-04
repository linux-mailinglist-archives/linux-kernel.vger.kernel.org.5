Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8676FD82
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHDJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjHDJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:38:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACF3A9C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:38:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f25d045cso1429306b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691141892; x=1691746692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9dIV7h+sCekbd6Jiug35Z9Vc/Gl4qYcQsrv76W+vcs=;
        b=X0Kt72ObFXb2AmUvjpljLCJ0/CiK5QQRUOGw5Ygqqx0LHad5xwm7Jo8zkm59JKaXIe
         bl7Py79HnZdLXC4ScPAT2txmPaBBBiTFeLzDnYaZHRmHZumhNNRBYHcv2vosYeDZm/Ot
         kp+AQCVq2QJmxNsDBNMX/iQMj000l05XBv8D32c/j1ftAuMFZUln5xkYzHxXdQAEPXUJ
         DAm3cNsucDXrf1ONWzstwq7va2gdfwlYVFZZGQ/5sDooDwa4M2r7w8fEcZ+n5+gH0dWJ
         LijYxOlIdGXswT3n6+nFjzffC+2cmt9MdTryBYAeUbUsjVq8glbYRs5cB2J4Q3CVgpkN
         J1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141892; x=1691746692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9dIV7h+sCekbd6Jiug35Z9Vc/Gl4qYcQsrv76W+vcs=;
        b=fD0JO0wN9ARewZC9TSuTyrb6eiRmnNXfOB23dy3Yv7wacJHmQRwio/HkFN++LeqNVI
         aA8fy8GPSeMcCQE6fDIHI4HOB6gCSeqmKtV+NTKvOmvG9gItSUXPf7TL05qPrxCWoNUD
         hdNP72V3K20ag+SMMKkFmr7u9wqxw3e8JaJC6OYddxxxCb8ITQd+o0tYCt6edwzK4Kst
         VhWMMUqMSKy06tRN7lesccswQfWggYLfat/h1VzeKEIuCw3ckGPKapfCr560MwVMCdbD
         g+vb8TWdfRwMkX4Dpy2V370R1OCn9HJtacFdQrqmAhojbnLsawOmlBYQjbHcGr+eDF3N
         T2gg==
X-Gm-Message-State: AOJu0YzB210ffDxfmAt3sSUEL7KbLyDPG4NVS2ZIOzD+LhXVIoOb9WwC
        fLmNTLhgsHtWXa0P2bILYUG5vg==
X-Google-Smtp-Source: AGHT+IGpsyV8nAzy3j0aXIanUvxKRza+ZIRtnapG1O2T0h0WF6HVfagRJD4ltE52piSSd9PZUa3plw==
X-Received: by 2002:a05:6a21:8199:b0:134:ad98:fb0c with SMTP id pd25-20020a056a21819900b00134ad98fb0cmr936829pzb.4.1691141892231;
        Fri, 04 Aug 2023 02:38:12 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b00687933946ddsm1214837pfo.23.2023.08.04.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:38:11 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 0/2] mm: Select victim using bpf_select_task
Date:   Fri,  4 Aug 2023 17:38:02 +0800
Message-Id: <20230804093804.47039-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Previous discussion link:
[1]https://lore.kernel.org/lkml/20230727073632.44983-1-zhouchuyi@bytedance.com/

Chuyi Zhou (2):
  mm, oom: Introduce bpf_select_task
  bpf: Add OOM policy test

 mm/oom_kill.c                                 |  57 ++++++-
 .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
 .../testing/selftests/bpf/progs/oom_policy.c  |  77 ++++++++++
 3 files changed, 267 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
 create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c

-- 
2.20.1

