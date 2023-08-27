Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D1789BC2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH0HVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjH0HVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:21:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3B3123
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:21:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f9521de4cso1071593a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120863; x=1693725663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Didxk1CTE/zuCtDw7bBmVUWH0JktUdKqtxgOWgiwWB8=;
        b=LciGPZGVBtsUw3ARCvntN9CpiaX/D95sE+KiD9oJBqKckEc3wdTeu5SN0Dz2qHHZhj
         iwR+OWA30bCxkjyX0OgSjGPDWPwiEF7wHH9EIavnC0V78Lq+IEQVj8lZbtH7oLZnEK1P
         276KNsw8dzokNBegSZaV+bzP3X892fW6xrxYewi9ugBCPnrmjfhaOwcPOynK71mvOlZy
         jQrYedn5KW+hqapc1L7CjAI07WEhvqEkAAW74BZusBeVeO1cjgxuX1OsJH57axKX4pJt
         isicx0c5wIX7tC5oQCi4C6Ayh/Q7n7DddJxFHuL8mvr1m+H5MMY+phlMkMEG6XKkpPwC
         TGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120863; x=1693725663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Didxk1CTE/zuCtDw7bBmVUWH0JktUdKqtxgOWgiwWB8=;
        b=kHGTSy9TX9ukCoj7i3cyab5liobnwYoAvKEW9yu+jV3wgYOK9bv8RKowZxk4yJFRnd
         sv8wUVO5wzIKalWeVpCXncELDZI4oy1+WI3DqRwihXtpJwVWm90Vc/Mm7QjdCDXSr7Bd
         4n5cPbTPW6Q0E0G5h5lMPocphrWXO1IWsOXlKPzPAdVlWcO5VDn4nCtb0Lu9pIdYMgPc
         wN2BfMlZV2iFCKkNPMlRzfoOH4YSI5VGjRjDtt7Vum99m2Qm+lCRMc0g64+JJytd/+aa
         jSTQHL9gAH4Jqf/qxmokjR0voux6/8P68/zCR0V9BaBLnRe1b8DVJ21uZ8wQh9DxEZWd
         basw==
X-Gm-Message-State: AOJu0Yyr4wkV30g156Ew0uvq4yJPbWt5Uob16uiBZ9p7KwDpeFSc7lxK
        2ArY8wW1cyXa+P1USisjqDx5RQ==
X-Google-Smtp-Source: AGHT+IEVPDK8tYUNEO2MtbjAvPsqgFb+MieMVWYwojeqiaRtppLiIb6zx/WAi0p4qIWTMtrxMuUxOA==
X-Received: by 2002:a17:902:70cc:b0:1bc:9c70:b955 with SMTP id l12-20020a17090270cc00b001bc9c70b955mr18035472plt.28.1693120863043;
        Sun, 27 Aug 2023 00:21:03 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:02 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 0/4] Add Open-coded process and css iters
Date:   Sun, 27 Aug 2023 15:20:53 +0800
Message-Id: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some BPF usage scenarios, it will be useful to iterate the process and
css directly in the BPF program. One of the expected scenarios is
customizable OOM victim selection via BPF[1].

Inspired by Dave's task_vma iter[2], this patchset adds three types of
open-coded iterator kfuncs:

1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
itearing all tasks in the system with rcu_read_lock().

2. bpf_for_each(css_task, task, css). It works like
css_task_iter_{start, next, end} and would be used to iterating
tasks/threads under a css.

3. bpf_for_each(css, pos, root_css, {PRE, POST}). It works like
css_next_descendant_{pre, post} to iterating all descendant css.

BPF programs can use these kfuncs directly or through bpf_for_each macro.

link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/

Chuyi Zhou (4):
  bpf: Introduce css_task open-coded iterator kfuncs
  bpf: Introduce process open coded iterator kfuncs
  bpf: Introduce css_descendant open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded task and css iter

 include/uapi/linux/bpf.h                      |  13 ++
 kernel/bpf/helpers.c                          |   9 ++
 kernel/bpf/task_iter.c                        | 109 ++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  13 ++
 tools/lib/bpf/bpf_helpers.h                   |  18 +++
 .../testing/selftests/bpf/prog_tests/iters.c  | 123 ++++++++++++++++++
 .../testing/selftests/bpf/progs/iters_task.c  |  83 ++++++++++++
 7 files changed, 368 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c

-- 
2.20.1

