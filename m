Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6C7A3360
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjIPXa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIPXaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 19:30:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD20CD1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-402d499580dso36058345e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694907007; x=1695511807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1IXi3ynm9dqjmx4LzLlP/fpKYDMXOqkWbXcAvWGPIc=;
        b=DUZDsk7EP/CsDE78p9ChwRhAGI2FPU/6yppBFiHm0LtSowgqRd6c2i+K+AiZillgdU
         qP+DIIhgeZFne9g1sobnIbwdvrgYKsq0/Q5Vc5LCfvFvRkW5NfaT57ZJwMMBE19Cw9Be
         WejirkHahXM+RMzZwTjjNuhurTqUE3FrKTvmEY2ztfgRifalI3pTVWHKkTM2h20Et0Qr
         3t223lHqgnA0Li84evcf1HhqsPhmu2eofIDFSL9DQvVMJBORMdNKnwWVueIHlph/hWlB
         Z85BlsoJMKg4HeUXsQIKV5rWewLLxKEjPCWGO7kXlnLXJigOBjUMIYyuqCQxY16HTXHT
         UntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694907007; x=1695511807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1IXi3ynm9dqjmx4LzLlP/fpKYDMXOqkWbXcAvWGPIc=;
        b=xPW/+I99xbpRMbeO/SKnfZnk/tDMMSsLnDttbioVc42iHy88AjWknqDAd8L5H4dWmZ
         aWsLuHVod2WQpqlzjvXK0wows0zqdWRnTI+Gefyw9eYFLseo6hEV0URRaklLXLXjvALV
         X9wwMD/IcAFX5svpzEWdZsr93aUdi+fkPIduThlnR11RnpPVtgVRpYfivJSL7qIHwMTw
         pHw9vg6sPaaqAtUusFVTVPbEgqIp0aiHExxCcJlE+r3Xs0TuLkRjoWIc7uGoAaZEGspF
         vbM+Mb9DglnoEF9tf4noth+NASbQXnAGbM36z2OPT8QK8055XDdQGzWu0DzooIgdcOtT
         cEtQ==
X-Gm-Message-State: AOJu0YwYBi2wWogNnH4jPE+2SXoRBbzCIZBQCriqyhl8FE9aX5oAGOqM
        Xto6QgClVl1tVfDNiTPs1zs6dw==
X-Google-Smtp-Source: AGHT+IGzPvTVPbOR1QIDXlfpjq4SH+gQjEgRCh3/u3A8oFDPndGI2KB6fIFzVvxIT94MnXpphFDFtw==
X-Received: by 2002:a7b:c858:0:b0:3fb:a102:6d7a with SMTP id c24-20020a7bc858000000b003fba1026d7amr4415542wml.28.1694907006712;
        Sat, 16 Sep 2023 16:30:06 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm11203929wmi.18.2023.09.16.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 16:30:06 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Fix a couple of corner cases in feec() when using uclamp_max
Date:   Sun, 17 Sep 2023 00:29:52 +0100
Message-Id: <20230916232955.2099394-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the reviews so far!

Changes in v5:

	* Added Reviewed-by Dietmar Eggemann.
	* Updated commit messages in patch 1 and 2 as requested by Dietmar.

Changes in v4:

	* Added Reviewed-by Vincent Guittot.
	* Updated sched_compute_energy_tp() to include  max_util and busy_time
	  as requested by Lukasz.

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
v3 link: https://lore.kernel.org/lkml/20230717215717.309174-1-qyousef@layalina.io/
v4 link: https://lore.kernel.org/lkml/20230821224504.710576-1-qyousef@layalina.io/

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
debugging these two problems.

This is based on tip/sched/core.

Qais Yousef (3):
  sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
  sched/uclamp: Ignore (util == 0) optimization in feec() when
    p_util_max = 0
  sched/tp: Add new tracepoint to track compute energy computation

 include/trace/events/sched.h |  5 +++++
 kernel/sched/core.c          |  1 +
 kernel/sched/fair.c          | 36 ++++++++++++------------------------
 3 files changed, 18 insertions(+), 24 deletions(-)

-- 
2.34.1

