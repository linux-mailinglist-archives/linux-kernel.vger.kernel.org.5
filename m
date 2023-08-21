Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5BA78268C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHUJuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjHUJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:50:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E5E6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3daf4cf7so532747b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692611379; x=1693216179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YXoiD3hUlpPe/W0JGVZydvXlOqHBAtp4c8EBy9aEmxg=;
        b=YnxAClg4Nwz7cboCLkqPfWKjLrH+YPRJ8BNzZVlzL584Iv8EEmjmNBnE7/5XS7xgM6
         XMlS3EnXvjCzWC4CIYfpPrc9jwdXphpBmBRirLqsQUGgTbd8mGcKUE2qm3uqRbOacFJH
         Oih9PWoM0eMIxXDwJv02nhLDfSkMOuAKJrqyb34VasHC1wTXpOStm2/gmOzu/I+mB9vv
         idr13jFd85NFDntjI8wTnUetyQW+bE292wSZKkV242y+vi6ZqMP0KjMqtSNrLehL2qUo
         EO1Ab7uhKVDAGwZBipfWn9dVLqXWvFEeYDgSnTqEOzBiyar3gF4eNi7XFELih7EBgZO3
         MsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611379; x=1693216179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXoiD3hUlpPe/W0JGVZydvXlOqHBAtp4c8EBy9aEmxg=;
        b=gASni5JYwYJ5LQpu+RbhqvaXbZIaXiZNPPEPVe/PUiTgeyvJH/mzJWr1QtIlargaj9
         NxHA46sNszJ2cgXVpzdPYG3nowhIkDNTwP6MKluhDoUv4DXI14XgehiVm7VszqHqOPCn
         +d5cWfpIGmkvfk1toIpLQ1z8SaXf1iHNrM+T9SYAVlQh3ythmC4oFp3RZe5131bVrF9w
         QI2sGQ2qsWMdMdE+jXIWJpq8i7b5rAXnTYmxv2HicU2uRA1fnSn0ghGA2bg75Kh+H/Wn
         GuHwLEK0g0RT03fgKyCyy4gMqYUeYDQRhZUpLZCsWAZIedkwyrNw9os402q7G6xB7LoF
         hgbw==
X-Gm-Message-State: AOJu0YwdGB/fT9A8d+MEQB9thpqjJiLGwh0z7JEK3/4PNRCNq/AK7E67
        WxMDJKE/K2FLAGYMe6R+UHjc2g==
X-Google-Smtp-Source: AGHT+IGV19gCq2mbVs8DEof2T5eKeQSS3ZTHKJMgOxbCBXmwRC1Ya+DyarzGNtVf9ICS3rAjhTuJkQ==
X-Received: by 2002:a05:6a21:6da6:b0:148:6a9e:143f with SMTP id wl38-20020a056a216da600b001486a9e143fmr3695331pzb.21.1692611379179;
        Mon, 21 Aug 2023 02:49:39 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b0068a4cd8b530sm1674892pfv.139.2023.08.21.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 02:49:38 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pauld@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 0/2] Fix nohz_full vs rt bandwidth
Date:   Mon, 21 Aug 2023 17:49:25 +0800
Message-Id: <20230821094927.51079-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop
when cfs bandwidth in use") was merged, it handles conflicts between
NOHZ full and cfs_bandwidth well, and the scheduler feature HZ_BW
allows us to choose which one to prefer.

This conflict also exists between NOHZ full and rt_bandwidth,
these two patches try to handle it in a similar way.

patch1: Extracts a can_stop_tick() callback function for each
sched_class from sched_can_stop_tick(), it will make things clearer
and also convenient to handle the conflict between NOHZ full
and rt_bandwidth.

patch2: If the HZ_BW scheduler feature is enabled, and the RT task
to be run is constrained by rt_bandwidth runtime. Then it will
prevent NO_HZ full from stopping tick.

Hao Jia (2):
  sched/core: Introduce sched_class::can_stop_tick()
  sched/rt: Block nohz tick_stop when rt bandwidth in use

 kernel/sched/core.c     | 67 +++++--------------------------
 kernel/sched/deadline.c | 16 ++++++++
 kernel/sched/fair.c     | 56 +++++++++++++++++++++++---
 kernel/sched/rt.c       | 89 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h    |  5 ++-
 5 files changed, 168 insertions(+), 65 deletions(-)

-- 
2.39.2

