Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948837EA8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjKNCQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKNCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:16:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34750D46
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:16:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-282ff1a97dcso3286921a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699928171; x=1700532971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wa4ZJv7rUNTP3/ylhEWG9OF00fr3EHQMVvz1/RJFAQs=;
        b=V3M7T1oASYHMF3z2ucRMZ1JoUPZADqitX6+SFPVgsc4Milxsbrr0doHL1RscCjqzSa
         0//o509iwk5hTpU9P5XwfBq+svSbz/v0kW2tCJs432gXBlp/HLA4jbyAGM4/xXktYcpi
         64ucKSfumnwPR0epd/N5oChkjG4eYKvuT5fSDu21785EJ5shGZvn5cyx7chPK4oPedIr
         kAHw/+u6QKldJ0gtpveau85RD3U2CZ2PFC+QgLm40+jfNa/4rDQGBtYkzIDaRJblHmOU
         oD2A+S2rmKpBBgSfLBfzdxpPYs3b6wNWAa5jl/DFNshCl9FPwhrlCb0l3W6RLaG6zPiR
         IcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699928171; x=1700532971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wa4ZJv7rUNTP3/ylhEWG9OF00fr3EHQMVvz1/RJFAQs=;
        b=V+S6qSQG2JcM3sCSn0PiJqW/4TarV7tTq/x2YRIoFhLIMQzm9cMbojQidoWqIthCyG
         ULFSnWRstQTRm5p3WGLKaxBEqHqlvjQXR7G2RxQYZVb+TBAS6GINWYYFaqUgbx1R5siR
         OYWpk8T7+4tu6PxttUGW7wmiVbtkGkAd30ndh13CZeJke05V8JRLvhoj6cWaROjuGEd4
         SsHm1c18ytq6owFUHrDoGFlhuXKHDNoZmCdMVSAKuZGqJBAcoRGwGw5Bu4ZerzcDmHCH
         x6z9s42U0b0t5B2/keaj6wubqujlIS063gQk4tOMjRDHGyUhahgh1xOJchb+TPNqF/St
         yaew==
X-Gm-Message-State: AOJu0Yz47ylQVhRHPgfESxLdyAsCeDzMly9zrShRNj1fwifvO+eRBRiP
        xxJ+2OtnOLH9BI26trwioW/7WQ==
X-Google-Smtp-Source: AGHT+IEBj1KF283h4A+HrovF6MuviyiqE8BHxWm5uLfavpH7ZSYb+xwKd1830UowN8kVWMA64AVuAA==
X-Received: by 2002:a17:90b:38b:b0:281:691:e58c with SMTP id ga11-20020a17090b038b00b002810691e58cmr6374064pjb.37.1699928171744;
        Mon, 13 Nov 2023 18:16:11 -0800 (PST)
Received: from localhost.localdomain ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a001600b0027ceac90684sm4892726pja.18.2023.11.13.18.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:16:11 -0800 (PST)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org, dianders@chromium.org, pmladek@suse.com,
        kernelfans@gmail.com, lecopzer.chen@mediatek.com
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com
Subject: [RFC] softlockup: serialized softlockup's log
Date:   Tue, 14 Nov 2023 10:15:29 +0800
Message-Id: <20231114021529.1834-1-lizhe.67@bytedance.com>
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

If multiple CPUs trigger softlockup at the same time, the softlockup's
logs will appear staggeredly in dmesg, which will affect the viewing of
the logs for developer. Since the code path for outputting softlockup logs
is not a kernel hotspot and the performance requirements for the code
are not strict, locks are used to serialize the softlockup log output
to improve the readability of the logs.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 kernel/watchdog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5cd6d4e26915..8324ac194d0a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -448,6 +448,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
+	static DEFINE_SPINLOCK(watchdog_timer_lock);
 
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
@@ -514,6 +515,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
+		spin_lock(&watchdog_timer_lock);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -523,6 +525,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			show_regs(regs);
 		else
 			dump_stack();
+		spin_unlock(&watchdog_timer_lock);
 
 		if (softlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
-- 
2.20.1

