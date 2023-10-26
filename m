Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5707D873F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjJZRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:09:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578D1A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:09:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so15105981fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698340162; x=1698944962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POVE4CZhPu3z3wCufRl7+c+VF4rf3D4o3n4eodjbjik=;
        b=vbrpuc3IfE+I4RRjA0Jl0Mn2iGmuLyzPlg4WyqZww30xc2gkx3RGoVSLgG5hxlAl21
         gRAhvQfbPGdhvMvUbXIQOWBif/fYnnbPPw31pxE6phXxvvDqkUfsvbeL4fTZcrP+ZMaM
         OqudiCzCbAjhS0JijoXs+bVys9zppKx0nZ5qfD1DRK5BbhBckDcSr/raqNVbkCN8xxMZ
         j9SW3cKQYmCJhfBMoQBZW2zsNSSW6F/a/CeiQgjlaCP+MQICti0ui9YDkSijmXRpiyNZ
         dEcH19j8ILtjs7/6ipDNLkP2G10LlU0rKh4BLWwqCQGk5c9LpaEokN8/sMAQJdXGzn6z
         Ye8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340162; x=1698944962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POVE4CZhPu3z3wCufRl7+c+VF4rf3D4o3n4eodjbjik=;
        b=D/qUCvpIXUq5sXWHLam83bfeDhwlcukptrD8RIogQszuRla6ATfJ/MjFG4Agr2Tl79
         uxcjpzI2HzP6dO/+AJDAcnVJfCVz9TSBwcNkJsAQaHSQwp/5sAOiFvnokhSgHTvXf3Fs
         dnmB8Zv532KcQG9dF/G/G8y0v+jdDlYyEmHJH3sO1hIXMhL+oWrP044wzZJqkMkiJaqE
         f/qLzPeCszf7jeJEq/Irs+UOt1iNyZ+q7/ugfSKC4x8MXVmFlFvUHHumeb0gFhtOqKyS
         8FXDAXnXQv4KS9RiagDRTWAX9xqMP5Urddxjs3hYeWfnSA04SV2f03UBGn3TVcFiMmlG
         mGlQ==
X-Gm-Message-State: AOJu0YxwYmXaDiqVsWqWFCY/WPcL3TmZEAt+rsnD7LS8zmcxC99zM9DE
        l9THZe2PX5z9Fp8hUc5v7XlAiIvPWJ1S8yLrAfY=
X-Google-Smtp-Source: AGHT+IGup+qrDI2S3KKi+8v1cxV++QC0c34JU13bDW9IV1J5KXgVsLsueUpy/emskYHOiKvY4Ftbmw==
X-Received: by 2002:a2e:7e04:0:b0:2c5:1122:9712 with SMTP id z4-20020a2e7e04000000b002c511229712mr143156ljc.46.1698340162175;
        Thu, 26 Oct 2023 10:09:22 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0040839fcb217sm3037721wmb.8.2023.10.26.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:09:21 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/2] Rework interface between scheduler and schedutil governor
Date:   Thu, 26 Oct 2023 19:09:11 +0200
Message-Id: <20231026170913.32605-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes since v1
- fix a bug (always set max even when returning early)
- fix typos
  
Vincent Guittot (2):
  sched/schedutil: rework performance estimation
  sched/schedutil: rework iowait boost

 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 82 ++++++++++++-------------------
 kernel/sched/cpufreq_schedutil.c | 72 +++++++++++++++++----------
 kernel/sched/fair.c              | 22 +++++++--
 kernel/sched/sched.h             | 84 +++-----------------------------
 5 files changed, 103 insertions(+), 158 deletions(-)

-- 
2.34.1

