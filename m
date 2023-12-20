Return-Path: <linux-kernel+bounces-7437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F781A7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B581C22BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C14A999;
	Wed, 20 Dec 2023 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OyV7ZQac"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12C498AE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3fc184b6dso1202545ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703107028; x=1703711828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmb1hFIok+9eMKNNtq9Gk+/VDYxh0leTwTc9coy3jGk=;
        b=OyV7ZQacnPHW04yoE+2yXbC1IJY3TUmM2UOiubF3/YOK6NtOyys99/puF1N5+Lo6L8
         FVgDqJSlH78X5mJS7H4taC0IFH35E68V3+fz6/C7SggokjrkGG7RCvyhsLLTHy4A6jYW
         rI5/fjae+yg7LRiPRSNzMWLyeLUNuvjgaozZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107028; x=1703711828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmb1hFIok+9eMKNNtq9Gk+/VDYxh0leTwTc9coy3jGk=;
        b=p9b4DmEsshz35mLue9a3FE2dUPzMBKlLd6uAnoQ1WQOkVzMSgbtE2wgL2LOF9ajEdo
         xoSz8KDUdSBsxrBB0FDP7JV392cKs4Ii4mE+mNEVrbF4XUDcFqrHik6gjTd69iheYQIx
         VadGWkWAPmHW2OzGeeVfr4o4hYqFcQoDs+xa7n8L3z1s8DZlhvwCfhlqRy/F72OlV5al
         yHXgYfkr17WuIE8E0XSYt3XNVaEEmsNoXRn7ksJsJ7B4szF64ssxDmDxgirZ2WfWx+8L
         4PNzXV5y5mgae+5j9h56m9PEQbi46JXp+wLeOyES5mj5zaeVDvjWz7BEWjOVLjULVTD5
         wd5A==
X-Gm-Message-State: AOJu0Ywr3TTgoWaMjLu0QZa9GXFCnvyyQ/Yvp9qbLSYV8cbOVMu22w8i
	qKiqGEOzUMFHQojO5DJuAUW6MQ==
X-Google-Smtp-Source: AGHT+IGMzn78qfxYuCyS1ARY45cL6P2MuHjWyw4/lUIp6wjTkKc2tsB9vxOdISIru88jXT2X5qm6jg==
X-Received: by 2002:a17:902:b28b:b0:1d3:f43a:a2d5 with SMTP id u11-20020a170902b28b00b001d3f43aa2d5mr1056238plr.120.1703107028565;
        Wed, 20 Dec 2023 13:17:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5a22:d46c:eec1:e5d4])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001d3dfebc05esm175023plr.21.2023.12.20.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:17:07 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] watchdog/softlockup: Use printk_cpu_sync_get_irqsave() to serialize reporting
Date: Wed, 20 Dec 2023 13:15:35 -0800
Message-ID: <20231220131534.2.Ia5906525d440d8e8383cde31b7c61c2aadc8f907@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220211640.2023645-1-dianders@chromium.org>
References: <20231220211640.2023645-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of introducing a spinlock, use printk_cpu_sync_get_irqsave()
and printk_cpu_sync_put_irqrestore() to serialize softlockup
reporting. Alone this doesn't have any real advantage over the
spinlock, but this will allow us to use the same function in a future
change to also serialize hardlockup crawls.

NOTE: for the most part this serialization is important because we
often end up in the show_regs() path and that has no built-in
serialization if there are multiple callers at once. However, even in
the case where we end up in the dump_stack() path this still has some
advantages because the stack will be guaranteed to be together in the
logs with the lockup message with no interleaving.

NOTE: the fact that printk_cpu_sync_get_irqsave() is allowed to be
called multiple times on the same CPU is important here. Specifically
we hold the "lock" while calling dump_stack() which also gets the same
"lock". This is explicitly documented to be OK and means we don't need
to introduce a variant of dump_stack() that doesn't grab the lock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b4fd2f12137f..526041a1100a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -454,7 +454,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
-	static DEFINE_SPINLOCK(watchdog_output_lock);
+	unsigned long flags;
 
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
@@ -521,7 +521,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
-		spin_lock(&watchdog_output_lock);
+		printk_cpu_sync_get_irqsave(flags);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -531,7 +531,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			show_regs(regs);
 		else
 			dump_stack();
-		spin_unlock(&watchdog_output_lock);
+		printk_cpu_sync_put_irqrestore(flags);
 
 		if (softlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
-- 
2.43.0.472.g3155946c3a-goog


