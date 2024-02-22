Return-Path: <linux-kernel+bounces-75923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8562785F0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F3B1F22401
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AC747F;
	Thu, 22 Feb 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4JhNcyib"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC825244
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578780; cv=none; b=G8rArluaVK6M2Gqd0A5p0yo0ix41UwB5BX1VEjVYB1rAwcv6gFLT02iNQYCEJ52E8UmyCGPhxSdrqsRzgInz0sMs/Kdb/xOriWornwjIgQ7/mDrGp1BhX6q4Ytk46mQ0FlhOIA6fFYbJzL/8lhiUyTmYBT4ry4Kn8braDN+QAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578780; c=relaxed/simple;
	bh=uljDanc9UU50QHRlrmK9CoAThzMmWvf1BubpFOVlAdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DpCH50MKOJTnzOxV5uFJU5q0mLiBIqOZbFWSv/uUc+KIv+noQqtkTsqM6hbHKRxq5+CyMsyjbpgksJvAi2uhwvndWF8ZWjZNt1CC59j/TLBKKBTVEGIFq6NWldQxDIDnpZkdKx+UeH9gkkCLLOUPjV1iwpGbAKGhiXTzyK1Hwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4JhNcyib; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so9726840276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708578778; x=1709183578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cVc/D31XAOhQKHR84dnFM5iH8gvfvYf98A6m7lsxmac=;
        b=4JhNcyibTdSXkup80kHOPA1Yb3nOSbZvmKXWq/G8ug3szor/iJVv6okFwKekUdfADr
         D8+SFybbGufIz6v9kc1lgYvVBfZnolQvjvm/fUzPo20go9R92ihgTUscWBQwwc0dvJbH
         BuCXBma3jATJDPHjLfC4IJF+KL5zcd/GgJ770pVcPi6UjVm11DyNXds4oZPDUT8a6GLZ
         VKNqjumyOkUKBTg0UvvJAIxiAxRwLFoH0yOglk5FW3NTDGL9W2WJPaIBx1N4E6E+/hDx
         LOq/2EyW+84IHjiYVO2wVGltboPoS8RMob3QPl1othv3gL6I5E+JhJh6ZZxDsaFkBbs8
         A0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578778; x=1709183578;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVc/D31XAOhQKHR84dnFM5iH8gvfvYf98A6m7lsxmac=;
        b=SdQZNR224CII1hvzgOEehgxgMK/fRbVs9Iy/cClMDkrNFQHFIr1BwBsLgnZ5DRy1fj
         9OKAAMVBsvUduVHlOkwuSlOgYurDGj2dzR1jHG0hLNxTgexzC4ea8lpzo81xfVcv91Db
         LXNGrZZkGs5vDaC3M7PHu3x5+s1wMlsR0XX8gEG5wueK024BlabbAkhLutGTBighYqOr
         P318Q01F5HpgtPS3sAfuvearCoC7bWF+QHDiGi0CfbXA/zVUoBVzwjNQ8ekyOiJKyXWE
         7GBcZHwGQrOwNjKhubNo7pwdQ1zbV74UUg1PRxlsIdl/HTI3E12xZ3QYKLyILBvR0IyP
         gm2A==
X-Gm-Message-State: AOJu0YxWd+ByRlbSL9mChHTbLavMx2d92zysbsW0YRFPWa2Kw5Lj/Gc1
	qWV7Am1KfLW8E8v5hTHWAjzUya4PGfCkpfRFMTLp11xHNLnhaB66QyNxPZUIRrwcds+XF8pxB+F
	HV+h6a9KyeHfHZoDUuTHUl09CzWiLrqhxNAXoZPcR2mjDEaslqSPj5viT+s9THO0kSI8BTe8hnJ
	hW0LJCDrBIpTTRj2bXm6gjXBsSBqgFyr2FM7AV6cdT0Xqs
X-Google-Smtp-Source: AGHT+IFqtpsYpvLQgClwVqqEvWeWjveWw8WhywwlnybmuM/gw/mkMMNJ7JoXC1PqLt5G+xlUkWRT/ewNpzzj
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1008:b0:dc6:d9eb:6422 with SMTP
 id w8-20020a056902100800b00dc6d9eb6422mr75084ybt.10.1708578778058; Wed, 21
 Feb 2024 21:12:58 -0800 (PST)
Date: Wed, 21 Feb 2024 21:12:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222051253.1361002-1-jstultz@google.com>
Subject: [RFC][PATCH] hrtimer: Use printk_deferred_once for hrtimer_interrupt message
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

With qemu, I constantly see lockdep warnings after the
hrimter_interrupt message is printed:

[   43.434557] hrtimer: interrupt took 6517564 ns
[   43.435000]
[   43.435000] =============================
[   43.435000] [ BUG: Invalid wait context ]
[   43.435000] 6.8.0-rc5-00002-g28763ef29a5b #3743 Not tainted
[   43.435000] -----------------------------
[   43.435000] lock_torture_wr/605 is trying to lock:
[   43.435000] ffffffffbdcdc6f8 (&port_lock_key){-...}-{3:3}, at: serial8250_console_write+0xdd/0x710
[   43.435000] other info that might help us debug this:
[   43.435000] context-{2:2}
[   43.435000] 4 locks held by lock_torture_wr/605:
[   43.435000]  #0: ffffffffbd6f1de8 (torture_mutex_init#4){+.+.}-{4:4}, at: torture_mutex_nested_lock+0x4b/0x70
[   43.435000]  #1: ffffffffbb557260 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0xd3/0x330
[   43.435000]  #2: ffffffffbb5572d0 (console_srcu){....}-{0:0}, at: console_flush_all+0xd6/0x6b0
[   43.435000]  #3: ffffffffbb396e20 (console_owner){-...}-{0:0}, at: console_flush_all+0x2a0/0x6b0
[   43.435000] stack backtrace:
[   43.435000] CPU: 36 PID: 605 Comm: lock_torture_wr Not tainted 6.8.0-rc5-00002-g28763ef29a5b #3743
[   43.435000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   43.435000] Call Trace:
[   43.435000]  <IRQ>
[   43.435000]  dump_stack_lvl+0x57/0x90
[   43.435000]  __lock_acquire+0xd07/0x3260
[   43.435000]  ? __pfx___lock_acquire+0x10/0x10
[   43.435000]  ? memchr+0x1e/0x50
[   43.435000]  lock_acquire+0x159/0x3b0
[   43.435000]  ? serial8250_console_write+0xdd/0x710
[   43.435000]  ? __pfx_lock_acquire+0x10/0x10
[   43.435000]  ? __pfx___lock_acquire+0x10/0x10
[   43.435000]  _raw_spin_lock_irqsave+0x42/0x60
[   43.435000]  ? serial8250_console_write+0xdd/0x710
[   43.435000]  serial8250_console_write+0xdd/0x710
[   43.435000]  ? __pfx_serial8250_console_write+0x10/0x10
[   43.435000]  ? __pfx_lock_release+0x10/0x10
[   43.435000]  ? do_raw_spin_lock+0x104/0x180
[   43.435000]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   43.435000]  ? console_flush_all+0x2a0/0x6b0
[   43.435000]  console_flush_all+0x2ea/0x6b0
[   43.435000]  ? console_flush_all+0x2a0/0x6b0
[   43.435000]  ? __pfx_console_flush_all+0x10/0x10
[   43.435000]  ? __pfx_lock_acquire+0x10/0x10
[   43.435000]  console_unlock+0x9d/0x150
[   43.435000]  ? __pfx_console_unlock+0x10/0x10
[   43.435000]  ? vprintk_emit+0xd3/0x330
[   43.435000]  ? __down_trylock_console_sem+0x62/0xa0
[   43.435000]  ? vprintk_emit+0xd3/0x330
[   43.435000]  vprintk_emit+0xdc/0x330
[   43.435000]  _printk+0x92/0xb0
[   43.435000]  ? __pfx__printk+0x10/0x10
[   43.435000]  ? hrtimer_interrupt+0x2f0/0x360
[   43.439262]  __sysvec_apic_timer_interrupt+0xb8/0x290
[   43.439345]  sysvec_apic_timer_interrupt+0x8a/0xb0
[   43.439345]  </IRQ>
[   43.439345]  <TASK>
[   43.439345]  asm_sysvec_apic_timer_interrupt+0x16/0x20

I thought the new printk work was going to resolve this, but
apparently not, so to avoid trying to printk in this problematic
context, lets use prink_deferred_once() instead.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/time/hrtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index edb0f821dcea..e6b060403384 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1870,7 +1870,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
+	printk_deferred_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
+			     ktime_to_ns(delta));
 }
 
 /* called with interrupts disabled */
-- 
2.44.0.rc0.258.g7320e95886-goog


