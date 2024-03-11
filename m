Return-Path: <linux-kernel+bounces-98441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F94877A37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CD61C20DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B11C3D;
	Mon, 11 Mar 2024 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZC5RYeg"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0017D2;
	Mon, 11 Mar 2024 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129313; cv=none; b=ddNWc8z0GxIIpOumO+lceLpiC6pty/+k2nHKeQa1WRvueRclr98U3NKTA7VV+PXn0rJsttoYxmVsiQs5lNVnA2CQi8zGUrHKn9Vzfiwy29Nh3TlcpOY+6QmuZfpt2caHtLv+vh5dWyYqZ621A3FNCgpEEOfGNhH9rww6udRNVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129313; c=relaxed/simple;
	bh=XlVLUAFnMhTnMzAZ0BgRW6guB8Dudjd31BG0qzDssXw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PTVKybT/TjePYLtu6fRivtVIicMVZdYpkJwHn1GjpLpuoj+PmIESLFCOa9hzfdbVLC/N14jipJ9cGdZhQ25hZhRMusjwR1KF4R8XihMQc7APWM60bXr0fx/4SM3mua1x+WcdQpAPUbk3rVh3Nk/i4zACd3QXgDpD4KXiwXAwFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZC5RYeg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e55731af5cso1723834b3a.0;
        Sun, 10 Mar 2024 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710129311; x=1710734111; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzQYO0zocHwdPkIxplwem1Q5qAkH8duw54ukX+SzgYo=;
        b=QZC5RYegN+JlGFSjpy+/V47EOlMyFn0dXOS/0xBDIaHL+rVH8cwHVYl2NvfcGXMEA3
         Fbif/MKb+x7c715jRL4j437nMtU1ok4O8w6cPyO9JgvrdlXNwrRA58RfbLlkBNE6j+8J
         19j6hmJtYShO+JFbJ/QDyJOzrVZVn1a1hy4XJ5E9KfivRi56aJMTbR9ROcs8pVeKV7iZ
         AlghA+haVvinFj/iiEYB8xnq02Ng/5Dg1i+2rYuLI56h2UgEzNZcMLEMYj4sdpls1obk
         hl6q57w683Dg1Hk4UxnYKeLt03BmKfSd1mvDzACGp3U10c+9LpwmD0sMZ6NrP4W/UW7W
         pbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710129311; x=1710734111;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzQYO0zocHwdPkIxplwem1Q5qAkH8duw54ukX+SzgYo=;
        b=XIyig6HjonVOWj0S+qT+fUGgEcb9/AsEpuCDBwq+WUQc1cFKnJKsLTp7G/dI62cylk
         hVw/zUPh8fPVEuTHC56vra+kqFDzOWwtto6VLINm0l3edaG7h8VK0foNTnTaHPYKqhw9
         12zeGBwpBLjqJEW5nJRBQ7XBhwp6W0TuY9EQlSECqH6k/eRjvdSH5Zocuxnebj40cqSS
         /Uu8CIVOZQFhzrLy3GuYrtqbCVu3zHyAI/83yHvcWT2DMy5E6ChNg8YvCuoXRa6vzfv/
         /6pQmgnx4iJeceDx4LaHF26UGcug4R4dGx30B4tlvPLhaTcr/0yQ77M9Wyk4Iau4TC18
         QCXA==
X-Forwarded-Encrypted: i=1; AJvYcCX+jDihCafpw02Iv0OF+rP4BIbgveN9dFxZqSJji8GwH2rYLb78gKzaZIjg+Ex3SP53YL1I42rw2q3B+npIBVsFUK+Z9Q5Zi/OBQbDfPJbbOdnYTcE5IhdttGF/pBFjHV7L
X-Gm-Message-State: AOJu0YyzGTgkmQ935yy4S3j6t1R3c4BpOeqPsNQS4ImrpYIUgM3g5Svq
	3Xo91GHyg+OJSVUYlTv1afZ7sL8zq0K0Ybs+w7sv5Ps6AmbuHAKA
X-Google-Smtp-Source: AGHT+IH+zYwezePS7tUOMhon3AnfTvkzd8prVJ3kMNGhQPl3RAJY/X+RnUxEC7EeOhR1o0R4fvb8wA==
X-Received: by 2002:a05:6a00:308f:b0:6e6:864d:75e with SMTP id bh15-20020a056a00308f00b006e6864d075emr3524519pfb.4.1710129310612;
        Sun, 10 Mar 2024 20:55:10 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id o12-20020a62f90c000000b006e053e98e1csm3260740pfh.136.2024.03.10.20.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 20:55:10 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	joel@joelfernandes.org,
	neeraj.upadhyay@kernel.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Avoid rtp_irq_work triggering when the rcu-tasks GP is ongoing
Date: Mon, 11 Mar 2024 11:55:02 +0800
Message-Id: <20240311035502.7112-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit generate rcu_task_gp_in_progress() to check whether
the rcu-tasks GP is ongoing, if is ongoing, avoid trigger
rtp_irq_work to wakeup rcu tasks kthreads in call_rcu_tasks_generic().

The test results are as follows:

echo call_rcu_tasks_iw_wakeup > /sys/kernel/debug/tracing/set_ftrace_filter
echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
sleep 600
rmmod rcutorture.ko
echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
echo > /sys/kernel/debug/tracing/set_ftrace_filter

head /sys/kernel/debug/tracing/trace_stat/function*

original: 56376  apply patch: 33521

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 
original:
==> /sys/kernel/debug/tracing/trace_stat/function0 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup             13217    19292.52 us     1.459 us        8.834 us    

==> /sys/kernel/debug/tracing/trace_stat/function1 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup             15146    22377.01 us     1.477 us        22.873 us   

==> /sys/kernel/debug/tracing/trace_stat/function2 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup             12561    18125.76 us     1.443 us        6.372 us    

==> /sys/kernel/debug/tracing/trace_stat/function3 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup             15452    21770.57 us     1.408 us        6.710 us

apply patch:
==> /sys/kernel/debug/tracing/trace_stat/function0 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup              8334    15121.13 us     1.814 us        4.457 us    

==> /sys/kernel/debug/tracing/trace_stat/function1 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup              8355    15760.51 us     1.886 us        14.775 us   

==> /sys/kernel/debug/tracing/trace_stat/function2 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup              7219    14194.27 us     1.966 us        42.440 us   

==> /sys/kernel/debug/tracing/trace_stat/function3 <==
  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  call_rcu_tasks_iw_wakeup              9613    19850.04 us     2.064 us        91.023 us  

 kernel/rcu/tasks.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 147b5945d67a..36c7e1d441d0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -317,6 +317,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
+static int rcu_task_gp_in_progress(struct rcu_tasks *rtp)
+{
+	return rcu_seq_state(rcu_seq_current(&rtp->tasks_gp_seq));
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -375,7 +380,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	}
 	rcu_read_unlock();
 	/* We can't create the thread unless interrupts are enabled. */
-	if (needwake && READ_ONCE(rtp->kthread_ptr))
+	if (needwake && READ_ONCE(rtp->kthread_ptr) &&
+			!rcu_task_gp_in_progress(rtp))
 		irq_work_queue(&rtpcp->rtp_irq_work);
 }
 
-- 
2.17.1


