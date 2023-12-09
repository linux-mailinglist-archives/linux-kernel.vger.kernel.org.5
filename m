Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7380B158
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjLIBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:18:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F1DDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:18:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso2235935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702084709; x=1702689509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNtn2YYHJ/gujw3iF8Q22njCO/GKk7CSLq1wmrKmLcA=;
        b=jp26gNEPZlfjzN+Eo/Vn8RCYCpsMPrrdAhum1zimgthoYgU/uigE0aC14TDlDp8Sip
         NiuQ5NSGWi8YhzZ1JvZ9XiqK0/+I5CtvkkoJnE+jVypUX0g+jBnGq0aqlEqXI2W6wwCE
         6m+c0huaB+DVPLz8A+89rqYMK9w/vGtnk6RVsh/16uG/YK9u/tTt/eZrt50UA9AMuZVK
         7cOxpJkUxdjjIy7NGdTC6ue/KADHttKGbjROA/9moexj8eyrjOBrOoHw3IH4IfifBPWc
         eIpOFlc6Qmw7FAzURmENEYXV06VMH/YYKMcxs/Z3WyK84vNHoPVGCmXhdmxCwvNkUtIX
         9VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702084709; x=1702689509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNtn2YYHJ/gujw3iF8Q22njCO/GKk7CSLq1wmrKmLcA=;
        b=lB9okYK6Y3FdN6UUpw6QLXmZ5rtn967SXImhKVpIaKOzIxBxsVf2q0B/i6KWk3L2Ol
         eqb0q2+FB8OPu/A26cgu+PP2hCaMygmEDJVM+FzLYF20JXq1PGPa4hPsip6esr7SETXY
         jtaIWgRDiEc3lLhTeLtYItp2tbTG8TSpVvpgdMbFmJ5G2DnsMFtiTJqLt46TITmptTKv
         83KjEJIA2B00Ic+fSDhQ9rn/I9txDBStinr5ZC5oqVjTKz+qX6N53Yr8jxXoQeC2P4zS
         yJtwSKTTuMeL+EL3dB7M8sl6HZlUFNP0hH0QV61aOPGhF3RSATI1wuVcHpoaPIxYa15o
         jxSA==
X-Gm-Message-State: AOJu0YzGBUCcaGuXkfavAn5ebjmDT6CrxbIKGw+RuloZP7xSkZ7lOovv
        zh8HYPiOrxQ9S19ZK44IyYrHAQ==
X-Google-Smtp-Source: AGHT+IECUYOo8p9T0T+zmKeHXWtNP1y71q8zMJjYx11IoesS8p/4r2exV095uFjzMYZllERCmNNpHQ==
X-Received: by 2002:a05:600c:230e:b0:40c:2cc4:d98b with SMTP id 14-20020a05600c230e00b0040c2cc4d98bmr272574wmo.249.1702084708484;
        Fri, 08 Dec 2023 17:18:28 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm4772125wmq.43.2023.12.08.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 17:18:27 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/3] sched: Generalize misfit load balance
Date:   Sat,  9 Dec 2023 01:17:56 +0000
Message-Id: <20231209011759.398021-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misfit load balance was added to help handle HMP systems where we can make
a wrong decision at wake up thinking a task can run at a smaller core, but its
characteristics change and requires to migrate to a bigger core to meet its
performance demands.

With the addition of uclamp, we can encounter more cases where such wrong
placement decisions can be made and require load balancer to do a corrective
action.

Specifically if a big task capped by uclamp_max was placed on a big core at
wake up because EAS thought it is the most energy efficient core at the time,
the dynamics of the system might change where other uncapped tasks might wake
up on the cluster and there could be a better new more energy efficient
placement for the capped task(s).

We can generalize the misfit load balance to handle different type of misfits
(whatever they may be) by simply giving it a reason. The reason can decide the
type of action required then.

Current misfit implementation is considered MISFIT_PERF. Which means we need to
move a task to a better CPU to meet its performance requirement.

For UCLAMP_MAX I propose MISFIT_POWER, where we need to find a better placement
to control its impact on power.

Once we have an API to annotate latency sensitive tasks, it is anticipated
MISFIT_LATENCY load balance will be required to help handle oversubscribe
situations to help better distribute the latency sensitive tasks to help reduce
their wake up latency.

Patch 1 splits misfit status update from misfit detection by adding a new
function is_misfit_task().

Patch 2 implements the generalization logic by adding a misfit reason and
propagating that correctly and guarding the current misfit code with
MISFIT_PERF reason.

Patch 3 is an RFC on a potential implementation for MISFIT_POWER.

Patch 1 and 2 were tested stand alone and had no regression observed and should
not introduce a functional change and can be considered for merge if they make
sense after addressing any review comments.

Patch 3 was only tested to verify it does what I expected it to do. But no real
power/perf testing was done. Mainly because I was expecting to remove uclamp
max-aggregation [1] and the RFC I currently have (which I wrote many many
months ago) is tied to detecting a task being uncapped by max-aggregation.
I need to rethink the detection mechanism.

Beside that, the logic relies on using find_energy_efficient_cpu() to find the
best potential new placement for the task. To do that though, we need to force
every CPU to do the MISFIT_POWER load balance as we don't know which CPU should
do the pull. But there might be better thoughts on how to handle this. So
feedback and thoughts would be appreciated.

[1] https://lore.kernel.org/lkml/20231208015242.385103-1-qyousef@layalina.io/

Thanks!

--
Qais Yousef

Qais Yousef (3):
  sched/fair: Add is_misfit_task() function
  sched/fair: Generalize misfit lb by adding a misfit reason
  sched/fair: Implement new type of misfit MISFIT_POWER

 kernel/sched/fair.c  | 115 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |   9 ++++
 2 files changed, 110 insertions(+), 14 deletions(-)

-- 
2.34.1

