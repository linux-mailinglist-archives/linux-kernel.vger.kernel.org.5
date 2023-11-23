Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE227F5A48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbjKWIlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:41:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D1D7E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:41:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso550846b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700728886; x=1701333686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awyDGbhYoRPdZVH0aev31LUF7PKhT9Q8DrIpkivvDV8=;
        b=ZBGLIWVhWcFoABspHbvKAt4+lkjqsOjyZPnmGl0FN2UTb0v2IddTr9bKz/1wGfTz/d
         f3mWgJIBACxecHDnu0Lb1xFZXewj4fSKZ4z+n9v2hQ4y/3VDd65OmNjGEIO0DPyuzk3f
         VUt1zA7gNE3j68OmHfaxUTbA+FXeHfbnk3109dhMrkMiPMdz8F8/nutXtBUk/rP6J8JR
         rQzDOaCl0eUTyHRkfDg2xyuh5qM7b1Evq/jsGMOW0PciMq1/D+Z52R9IEOZyIR40jdsw
         MIvwItx81qVhzx+xU00aw30A4IaNQKlxFIliIXq+A2gJC6yy2pCqW2MUxvOAy6izC3vF
         EHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700728886; x=1701333686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awyDGbhYoRPdZVH0aev31LUF7PKhT9Q8DrIpkivvDV8=;
        b=OmrTFH/LwAButAfTt8KAqH477t0mHmEb7VBQeBUmkZ+p5XPmsvnSWRhWbYmBybNa/j
         /cNIJ996TOSVf0xQSx+MMCNKOsSq++WnZfvdM1nXJEN3LhA4mudux4py1jDlRO5vhU05
         iHTUi1i4aXiaDD8qFtq8lcRQH0kqTqL/bo7bHVJ1QcePtaAQTj75oNpvHo6RmLFpfANf
         hDhF6aF2mOd9T4uaaI0Vz3dD1gy9mUodZ+/XEL8UQUEnzZ3XqS3mhvMR1fZMjWUT1lNo
         MvcatEuCDARYm3pHHHANGKkV8lHiQaCd8ndP82K/OW9FinTBq6rlCD8lE96mJOdcf8gr
         2AbQ==
X-Gm-Message-State: AOJu0Yw1CSErPvPDSi7hzgiJ7oZTr0d22d9anoIhIKHVy26R7cwb04wb
        26xXXVrmfobwOIa5jBwkF87KUA==
X-Google-Smtp-Source: AGHT+IGQSOA0PAjcjaqobuKl7FOMr4dcsYV2eqHcm1j6ikiQzdHGM7M4ZEas1bb0eiqUEMbkC/A+0A==
X-Received: by 2002:a05:6a00:1f1a:b0:6cb:a2fa:1e0e with SMTP id be26-20020a056a001f1a00b006cba2fa1e0emr5132705pfb.9.1700728885887;
        Thu, 23 Nov 2023 00:41:25 -0800 (PST)
Received: from localhost.localdomain ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006cbb582fe6csm710578pfd.204.2023.11.23.00.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:41:25 -0800 (PST)
From:   lizhe.67@bytedance.com
To:     dianders@chromium.org, akpm@linux-foundation.org, pmladek@suse.com,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com
Subject: [PATCH v3] softlockup: serialized softlockup's log
Date:   Thu, 23 Nov 2023 16:40:22 +0800
Message-Id: <20231123084022.10302-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

v2->v3:
- define the lock inside the scope of function

 kernel/watchdog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5cd6d4e26915..bf30a6fac665 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -448,6 +448,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
+	static DEFINE_SPINLOCK(watchdog_output_lock);
 
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
@@ -514,6 +515,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
+		spin_lock(&watchdog_output_lock);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -523,6 +525,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			show_regs(regs);
 		else
 			dump_stack();
+		spin_unlock(&watchdog_output_lock);
 
 		if (softlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
-- 
2.20.1

