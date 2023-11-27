Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF637FA2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjK0Of7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjK0Of0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:35:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434A3AAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:32:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a29c7eefso5603655e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701095565; x=1701700365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3q1R9G6lEi+npsw/lKpAN9ZaKMnvPi0OuvIH02EHfA=;
        b=ErbuYcjTg94zudsQWK5IjrwDKcvikX6576r5XSjXeZFG9eZ+T3C4gbmr8NE6hiEngx
         ic3yhRkhPkBhxgNXfDFiMsxwt/g6iG6hzpC0W9phMkDD0td59WafayisxLG/XUPiXkJ/
         odS9NWbOryDhjUcPQ0kSBTR1P6rXw+zF6tCBXdD5e2SxSgZjgBlOEc/NVJZBmSaHhVON
         ioNJSzqrh461f32n4gfGnfak41qFJ/9YBXYYuosSrayxftPVfvy3TpH9+771KdGSYQgg
         Vrx4qCyc6f6dKokO/aWDbq7VQAHwaWivunMk+BYkXR+E8VcPmv30NPdm9/GUj6wwOXnd
         HuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095565; x=1701700365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3q1R9G6lEi+npsw/lKpAN9ZaKMnvPi0OuvIH02EHfA=;
        b=hxkynE7hiGTDIaG7KjOMqdtJbusTr6NELkmHt4gIhy+u1sss8ZUcXHsj2zLA/S6053
         YWmO+YChXrWL2Q+6woacr/YCK9iJ0JktPjLuxubNBKleMcO0vafVdAR7NcqI0OH6u1Hz
         aANU79zu+KXxpmtLWfDR8GKpmcuuxjqRA834yVLZ/+rgsjFveo5yiadmOQz3QxtyGi7z
         ikbxUls1WAh1VlF63t/dHHwXGb2vnJwiIls8Er1Uz+yAbL0643cngVkleTxdD00GUt1J
         b3i1IFxWTldHq9mVbX4755uqbYLICf7G1RrijIes1dmdUqh4EYBUf2qTHCLxI5LdS2jv
         20CQ==
X-Gm-Message-State: AOJu0YydWjDQMqvip83904QpLBp7JAjYOQ/0hIcUmeoZ6wVCq+DUAyTE
        TDo6HAHCOwmXkU4J5GJINBvovg==
X-Google-Smtp-Source: AGHT+IEMAUx5BrW7D++3HuEOtz0D8KaYwxeqiB/PU5mG4/gN9yOD+SB4KZf/WRNsSf90SI4Tnl1Nag==
X-Received: by 2002:a05:6512:3996:b0:50a:3c38:778c with SMTP id j22-20020a056512399600b0050a3c38778cmr10150685lfu.12.1701095564776;
        Mon, 27 Nov 2023 06:32:44 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:cc67:4d1a:fe5d:819a])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b0032f7f4089b7sm12174392wrr.43.2023.11.27.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:32:44 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] Simplify Util_est
Date:   Mon, 27 Nov 2023 15:32:36 +0100
Message-Id: <20231127143238.1216582-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following comment in [1], I prepared a patch to remove UTIL_EST_FASTUP.
This enables us to simplify util_est behavior as proposed in patch 2.

[1] https://lore.kernel.org/lkml/CAKfTPtCAZWp7tRgTpwJmyEAkyN65acmYrfu9naEUpBZVWNTcQA@mail.gmail.com/

Vincent Guittot (2):
  sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
  sched/fair: Simplify util_est

 Documentation/scheduler/schedutil.rst |  7 +--
 include/linux/sched.h                 | 35 ++----------
 kernel/sched/debug.c                  |  7 +--
 kernel/sched/fair.c                   | 81 ++++++++++-----------------
 kernel/sched/features.h               |  1 -
 kernel/sched/pelt.h                   |  4 +-
 6 files changed, 43 insertions(+), 92 deletions(-)

-- 
2.34.1

