Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629797F47EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjKVNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKVNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:39:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402FD54
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:39:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b344101f2so934375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700660350; x=1701265150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbsclafXVbhvsS395bqo3weKnHOeQwA8LuBg6N0OZoI=;
        b=s9/ogQDn14KWxJpVfgJ8ef3vbg35WtFMAN9FUzrGRWgPxpDpx1RUhyXj5ia4caA5Cd
         UhmYMNHXJQ1LEpSNPFzC7DhaPzdV8dplJzXr19FAMrInGy79uiqQfpotVcEKUVeWehds
         LbG6QtJMzkGKApU4lKD8qo+1UPlQtjrotD3NLhCPqgfLd3DqPT0cRLSARHz0O3Pt09W/
         CZ4KYppzCbOzKUPQZ/73Jvc0ZNbgba6MgLfLBOVu6sfwYU3FGAXkXvXvU5juhsfJS7mv
         X6s1yW1vYzneSCSeIIXrR5dbxksus/jdcqFG+wtiAI4HUiH/j7NKw6ovbQFJxjj6BVPD
         2owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660350; x=1701265150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbsclafXVbhvsS395bqo3weKnHOeQwA8LuBg6N0OZoI=;
        b=TmPPrX3sYGE/dAyWZpnoHe0AmyWQMMa5DbTxqqGxnuNb7ZATtojEp+4a4COOKvMvO2
         +HfEAGNcqk9clw7ZvZqVuSYwgjp8tSVus8gCWCxaubyCYKZ16ozp3Q83nuP9CwP76Go3
         YwdyDMMkltJMVOY5H+8y2rbwgJ5wx0Bfra1s4uDiSSlHzyLD5tyXeHgOV5LialCeRvfJ
         VM5hnKE0ScxRuwuVlepYkHH6oQvIdLGJK6tcsz+STqIqPa1IKeASNH5yxkUNOvMoyhVQ
         NzHaumaLoWiEzlWTkMTw2sq5FQ3oc4//MfzDNBal+vDmhqAXZWNZaoUfDIFqXAIvPhvJ
         9D2w==
X-Gm-Message-State: AOJu0Yziq8TogmIndd1aiDS/4+1OUg0RiFoTouKpESez7T/zKdTRgR30
        zbKRrnL1j/Sb0Xx7q6sbYaq5DQ==
X-Google-Smtp-Source: AGHT+IFgJrbH8nkXN/tv9V8BMOmt2L5BDf/1VsasDQLVsnZ8+pdd1f6xmRFoLb71L9I2UNHbQaCBvQ==
X-Received: by 2002:a05:600c:1503:b0:407:4126:f71c with SMTP id b3-20020a05600c150300b004074126f71cmr5521605wmg.6.1700660350268;
        Wed, 22 Nov 2023 05:39:10 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:3a2e:a7f5:93e6:508b])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b00407752bd834sm2307386wms.1.2023.11.22.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:39:09 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/2] Rework interface between scheduler and schedutil governor
Date:   Wed, 22 Nov 2023 14:39:02 +0100
Message-Id: <20231122133904.446032-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the discussion with Qais [1] about how to handle uclamp
requirements and after syncing with him, we agreed that I should move
forward on the patchset to rework the interface between scheduler and
schedutil governor to provide more information to the latter. Scheduler
(and EAS in particular) doesn't need anymore to guess estimate which
headroom the governor wants to apply and will directly ask for the target
freq. Then the governor directly gets the actual utilization and new
minimum and maximum boundaries to select this target frequency and
doesn't have to deal anymore with scheduler internals like uclamp when
including iowait boost.

[1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/

Changes since v3:
- Fix freq selection with runnable RT

Changes since v2:
- remove useless target variable

Changes since v1:
- fix a bug (always set max even when returning early)
- fix typos
  
Vincent Guittot (2):
  sched/schedutil: Rework performance estimation
  sched/schedutil: Rework iowait boost

 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 90 ++++++++++++++------------------
 kernel/sched/cpufreq_schedutil.c | 64 ++++++++++++++---------
 kernel/sched/fair.c              | 22 ++++++--
 kernel/sched/sched.h             | 84 +++--------------------------
 5 files changed, 103 insertions(+), 158 deletions(-)

-- 
2.34.1

