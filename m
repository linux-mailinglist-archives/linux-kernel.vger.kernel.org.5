Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7167F4313
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjKVKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjKVKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:02:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D210EB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:02:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf6af8588fso18448485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700647341; x=1701252141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=posmgTcCkhlABVGwUF/c8OhraDvnS50EBWdyGitGAYo=;
        b=C7x76kV5ObrCJsqTtty8ziLfNkinXQsqvdbwoYvu1XwRJ/Cqtv6BxEoSwQ5jylWeRM
         xmkVOJigGdPmZ/UB+P9aj2oIQ8tezIF1J+s+QYTq8dp2rfYo6D28tdOMWBRVJgJAS5cA
         3/P8pkvbDiID7s6s4fsKEu0nXpr5+lHwNDeBaNzNHdOKCAkY3sPopqyWqgq+m18TxN4/
         rDOzFTQplD69gKX2obOkyeoFLOPO7PZmCJiA8897n/Hh7D0h8kTeMx8XC19T3xibQEcV
         nrwX9PyLC+zsaZHmBmVK+eLeo510FTS+NtPCygUsOuy2xXlOvHqudfHBQls/4gC4k+Qp
         5H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647341; x=1701252141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=posmgTcCkhlABVGwUF/c8OhraDvnS50EBWdyGitGAYo=;
        b=BE8fNa2t/RavrRyD3DAD/ESbGhTMwhE71w9A3U9HOYJg3qSJ1VpcZ4U08uxGBipx+N
         fBLAlPedzXRxL9wi2xOs/aGuh1QGeMjIzyRiJEBIezAxbWS/LURbW0Mxj51Xf5iT5cAs
         XQso2kx+Pun/hiRaNkcYMvIlvHkAyY8G4I+S83kz7IVB3c7bkqYfPtjIOnJ3Ysxw4lar
         Lk+o7oWls1EBqWs/PyT9c4mk2redPR+yZicepBjv8DoS+hI7cCN6bCaejYrFePXbojRG
         mzL9ewkefx0iKtgKAmdC+2/Csfh3y/RCVpzJBVpXOyfXEmXw3yBjs6JkL845HAA/XnNC
         eBhg==
X-Gm-Message-State: AOJu0Yxl9RYzYtB/oVGrF6GWLcFk6w1L3eW+FngZrMnsoAjWTNXzq23V
        uWPlvVEf+XH/LVnev4tnr28Tzg==
X-Google-Smtp-Source: AGHT+IEhYGGnYMAOYNX00MDa6p9hnwJG53NTnWuNRM5vTBbDuG16bYOc6plNXjTdNYBdTMAKv/D64A==
X-Received: by 2002:a17:903:22d2:b0:1cf:5d59:9323 with SMTP id y18-20020a17090322d200b001cf5d599323mr2245269plg.57.1700647341559;
        Wed, 22 Nov 2023 02:02:21 -0800 (PST)
Received: from localhost.localdomain ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001ce5b6e97b3sm9419742plr.24.2023.11.22.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:02:21 -0800 (PST)
From:   lizhe.67@bytedance.com
To:     dianders@chromium.org, akpm@linux-foundation.org, pmladek@suse.com,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com
Subject: [PATCH v2] softlockup: serialized softlockup's log
Date:   Wed, 22 Nov 2023 18:02:12 +0800
Message-Id: <20231122100212.94327-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
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

From: Li Zhe <lizhe.67@bytedance.com>

If multiple CPUs trigger softlockup at the same time with
'softlockup_all_cpu_backtrace=0', the softlockup's logs will appear
staggeredly in dmesg, which will affect the viewing of the logs for
developer. Since the code path for outputting softlockup logs is not
a kernel hotspot and the performance requirements for the code are
not strict, locks are used to serialize the softlockup log output to
improve the readability of the logs.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
Changelogs:

v1->v2:
- define the lock outside the scope of function
- add precondition 'softlockup_all_cpu_backtrace=0' in commit message

 kernel/watchdog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5cd6d4e26915..6c80dd8ff24b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -28,6 +28,8 @@
 #include <linux/kvm_para.h>
 
 static DEFINE_MUTEX(watchdog_mutex);
+/* This lock is used to prevent concurrent actions of softlockup output logs */
+static DEFINE_SPINLOCK(watchdog_output_lock);
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
 # define WATCHDOG_HARDLOCKUP_DEFAULT	1
@@ -514,6 +516,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
+		spin_lock(&watchdog_output_lock);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -523,6 +526,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			show_regs(regs);
 		else
 			dump_stack();
+		spin_unlock(&watchdog_output_lock);
 
 		if (softlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
-- 
2.20.1

