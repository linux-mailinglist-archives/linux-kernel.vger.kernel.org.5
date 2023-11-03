Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8CF7E03B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjKCNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbjKCNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:18:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BAD51
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:18:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40806e4106dso12808765e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699017505; x=1699622305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5A8Puvc3tXgvKjqlI5JohnMI9TNDved82zD5N88oqxk=;
        b=aVlLMIMwxyE03I3unUT1CvYnTjUZcwFksyIVp43s78P8pwBT0SKEvkRMVt3//Xezn1
         RdgiEprMQ1tEQSw2RWo3oKBehTSME6xa3f/TuLDqew0EH2Pfvz4rUQSPqnLBVy6tZTvG
         rD/TnK7RGgWLdPU3JcTBNf2j3K9u0xRfWPK8chSoBj4wybTzYCc1WaAueyN5PSqYb8hY
         RvIspfgMkV3Rz5q8OhH9+rlVWVFUpGX6MyjZunp6oAy+YH9GcYIrl4zg/3TlqDTuXYRf
         yaD1dEcAxF65pvcGxhabyYDvaBWwlDuWeaqxRPvrOqpHjfliaYwgEqRA7fqORyqZtPFg
         oEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017505; x=1699622305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A8Puvc3tXgvKjqlI5JohnMI9TNDved82zD5N88oqxk=;
        b=ip9meyDqhoM35sazqqn2Rlb9xQ/igYaRdKZfXfoMQVY6olj2vCu0enuudICjx6btMg
         4e7JWhFWb1yPhG80Vwmpd4Gi0yxaSCsAHmSxIFMYeCDmmDuoJrSv/M/NIMN6mtUTTfvW
         p2C/Yb/oQnz/K89R9GJschUbezW/uzlsEiw7OmQ0CMJJSMlEc8ZpRtwN9tFpBzFU0Z37
         sM77gYEKhI9Vb5TyFkUwDY7TOYE99VSYwB+TaVjkxfGdrjZGxAjSLI6DuMf4jdyNNq1z
         gH6lXmxllabTcLNJEnWSbh+V5mqlg7IhjQH6e1uqMK1r4/wVz2zpWGSdhrfNPM4YPr3e
         +0pA==
X-Gm-Message-State: AOJu0Yw58DHdb4JiuLw2W77Fd0rkCgTa6JGYrxFBIEGSFGEiR5u3X1A9
        w9sEXYi82LpwEpSvQ7LCQLRQ0w==
X-Google-Smtp-Source: AGHT+IG1kqJfeOvzc/Snj2/C9xmkjqtq0qde9O8tKCR16KEoG4ydWAHxVMWl7YGf0C/DSNjJqaNHvw==
X-Received: by 2002:a05:600c:4f47:b0:405:784a:d53e with SMTP id m7-20020a05600c4f4700b00405784ad53emr2708296wmq.20.1699017504885;
        Fri, 03 Nov 2023 06:18:24 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d68ce000000b0032daf848f68sm1877565wrw.59.2023.11.03.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:18:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/2] Rework interface between scheduler and schedutil governor
Date:   Fri,  3 Nov 2023 14:18:19 +0100
Message-Id: <20231103131821.1176294-1-vincent.guittot@linaro.org>
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

Changes since v2:
- remove useless target variable

Changes since v1:
- fix a bug (always set max even when returning early)
- fix typos
  
Vincent Guittot (2):
  sched/schedutil: Rework performance estimation
  sched/schedutil: Rework iowait boost

 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 82 ++++++++++++-------------------
 kernel/sched/cpufreq_schedutil.c | 69 ++++++++++++++++----------
 kernel/sched/fair.c              | 22 +++++++--
 kernel/sched/sched.h             | 84 +++-----------------------------
 5 files changed, 100 insertions(+), 158 deletions(-)

-- 
2.34.1

