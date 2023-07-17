Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD46756F32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGQV5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:57:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3800E4C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbea147034so46817115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689631052; x=1692223052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bt3oWUXPWPRGTDcrpQcoKUvKcQ6Ve6er6deNsEfs3d0=;
        b=c5ZMcIsYsY8k4i6bEFB051sb1Dni1kfhfjQM3Ae6+Q45PLmuUDIDwtGtoBNy2l3VAL
         PGRGRNuPaEqoQbkE4IGxCenlcOOxuTx5MEnkEQXPDuu8l+8OEYIEKCCmf0oECBl27UoL
         GMADAJpLqy8UwM7amR9Idtz8Hbq7BybPM1DOYaoqTaBVgTjpaRWOMDvErUqJWqEl1XOA
         A/4rc0E+Hrq+fbSpjzyMhTpeJfE+y2G/AV1dPk7qgpFUNLhj8W1Spq1tfyGvNVnM5DPF
         0jVk9NttUNNOo0HdD/bNwjGuGmxVMtGFxutxA+d8eqhc69RwiPMTJOtUpECt/JSJBoT2
         l2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689631052; x=1692223052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bt3oWUXPWPRGTDcrpQcoKUvKcQ6Ve6er6deNsEfs3d0=;
        b=fR+MTeYaQJhMo9kse0PsaE3b62V24ibtp7XsRTsRlXUqJfrbiAr5FqsaN5eMZvi9qc
         +HZzW6163yyCZW6d9ue52cgXynvmah5E54GS8RUBJy1I565JVSaJ4a/jZsMdfw1Paq68
         2gIMqNmPtqmeuiLTdV0Gsbpu1En3jqqBET8XSCyqsc3n3EMftWB+PWbw/0qEpLboiwsm
         dgQGwsOoEwFDxvR0Axa5S05tRDfaq1LxoM5PJzAF54NYNEXHEFsj9P/4SDbzcpmd18wM
         061cdRssHIl2W1T65ViXlGmbHSqSTHPcpwBFC9P3l13qCTfU71Y3PmWybK06zXDI6KWE
         YFZw==
X-Gm-Message-State: ABy/qLaeqD7ice2hOCKu18DIcFYxsydNRcCeLhQbLl0xFd+JKsvfmqLg
        NHPmlb0ZH2CdWcTk41kX8KMfkQ==
X-Google-Smtp-Source: APBJJlEdYeehSMfLAIVPM82vhVJu9DV5FMe0FEcL3fEMssjIGSHOqVivwAprKZuioCAnpQevqPFJtw==
X-Received: by 2002:a05:600c:21d4:b0:3fa:934c:8360 with SMTP id x20-20020a05600c21d400b003fa934c8360mr416236wmj.8.1689631051431;
        Mon, 17 Jul 2023 14:57:31 -0700 (PDT)
Received: from localhost.localdomain (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fbaa2903f4sm671285wmc.19.2023.07.17.14.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:57:31 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 0/3] Fix a couple of corner cases in feec() when using uclamp_max
Date:   Mon, 17 Jul 2023 22:57:14 +0100
Message-Id: <20230717215717.309174-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:

	* Fix sign comparison problem in patch 1 (Thanks Vincent!)
	* Simplify comparison and remove function in patch 2 (Thanks Dietmar!)

Changes in v2:

	* Use long instead of unsigned long to keep the comparison simple
	  in spite of being inconsistent with how capacity type.
	* Fix missing termination parenthesis that caused build error.
	* Rebase on latest tip/sched/core and Vincent v5 of Unlink misift patch.

v1 link: https://lore.kernel.org/lkml/20230129161444.1674958-1-qyousef@layalina.io/
v2 link: https://lore.kernel.org/lkml/20230205224318.2035646-1-qyousef@layalina.io/

In v2 Dietmar has raised concerns about limitation in current EM calculations
that can end up packing more tasks on a cluster. While this is not ideal
situation and we need to fix it, but it is another independent problem that is
not introduced by this fix. I don't see a reason why we should couple them
rather than work on each problem independently. The packing behavior in
practice is actually not bad as if something is capped really hard, there's
a desire to keep them on this less performant clusters.

Patch 1 addresses a bug because forcing a task on a small CPU to honour
uclamp_max hint means we can end up with spare_capacity = 0; but the logic is
constructed such that spare_capacity = 0 leads to ignoring this CPU as
a candidate to compute_energy().

Patch 2 addresses a bug due to an optimization in feec() that could lead to
ignoring tasks whose uclamp_max = 0 but task_util(0) != 0.

Patch 3 adds a new tracepoint in compute_energy() as it was helpful in
debugging analyzing these two problems. It's generally useful to trace down
task placement decision based on EAS.

This is based on tip/sched/core.

Qais Yousef (3):
  sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
  sched/uclamp: Ignore (util == 0) optimization in feec() when
    p_util_max = 0
  sched/tp: Add new tracepoint to track compute energy computation

 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          |  1 +
 kernel/sched/fair.c          | 36 ++++++++++++------------------------
 3 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.25.1

