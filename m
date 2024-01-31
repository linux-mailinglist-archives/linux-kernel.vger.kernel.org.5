Return-Path: <linux-kernel+bounces-47016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7498447FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC59A1F255A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C23EA7B;
	Wed, 31 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgp9VHrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB993E479;
	Wed, 31 Jan 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729271; cv=none; b=c/6w+2pkn7kTwyjhVu6DaEMlNrAifovv4xl0ud6Dgaac8seVStfVsQRBCxbKbOeUXx4NjRwsNuBeoaDuY1fS/9+D5/mtI1juqb0HJUPYXzdUMrNQ5dn8bQFQHruxymSvorXa+Ft8LMedgZXQJ+vJZ+WZAj7WoGz/ITSxhmx0zxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729271; c=relaxed/simple;
	bh=EDuhmI0O4HKI+Hk/K0xvaXTNhoWVCeKb8bazGFeIsrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gEklQJjlivsHoGsC0wMJwLPJa0cXOXqq9PMOPpUIQlh23bp5blouCaR1iFSFMIP7yBAQMZplWL9m68ft04crCqU2xgj1KzPmc6Zq9gAtZaTXKujFsrvvKw4tBvfrkJQozuKWP+y6NE+TV0d1ewz1iZVFpi74+TdW8Qb/dQDTivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgp9VHrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A79EC433C7;
	Wed, 31 Jan 2024 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706729270;
	bh=EDuhmI0O4HKI+Hk/K0xvaXTNhoWVCeKb8bazGFeIsrY=;
	h=Date:From:To:Cc:Subject:From;
	b=Tgp9VHrN6LKM6GvEZrSPRBC5wxJOsF44BKQXS9XNqEyNVExa/V/sWlaSefi4zgaKF
	 /2EYpLfhhJa55VjDveZo115kYH88qxKQ/99YksNHlBu8x4JMglVMJtcKj9w4zsOexr
	 v88Rw3FofYDLWUdqypvpfTUfW18SHVGDvTLqYZcPL1duhxzAYqjn/CTfT21URs8e+E
	 veGPTUP8ZKoJqMHtuiz5nFyIOmZQFHvDQIjpYQTIAR3LEf/E165f5UMuOvAPy3tXlP
	 uHaa3baCaDVrzlIrl2zzwH0fFYn4jy35LGGBQo4P6VKgIgOhMUfkxQvqihJRx7AITI
	 a08kKj7htY7oA==
Date: Wed, 31 Jan 2024 20:27:45 +0100
From: Helge Deller <deller@kernel.org>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Subject: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Message-ID: <ZbqfMR_mVLaSCj4Q@carbonx1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When hot-unplugging a 32-bit CPU on the parisc platform with
"chcpu -d 1", I get the following kernel panic. Adding a check
for !pwq prevents the panic.

 Kernel Fault: Code=26 (Data memory access rights trap) at addr 00000000
 CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.8.0-rc1-32bit+ #1291
 Hardware name: 9000/778/B160L
 
 IASQ: 00000000 00000000 IAOQ: 10446db4 10446db8
  IIR: 0f80109c    ISR: 00000000  IOR: 00000000
  CPU:        1   CR30: 11dd1710 CR31: 00000000
  IAOQ[0]: wq_update_pod+0x98/0x14c
  IAOQ[1]: wq_update_pod+0x9c/0x14c
  RP(r2): wq_update_pod+0x80/0x14c
 Backtrace:
  [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
  [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
  [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
  [<10452970>] smpboot_thread_fn+0x284/0x288
  [<1044d8f4>] kthread+0x12c/0x13c
  [<1040201c>] ret_from_kernel_thread+0x1c/0x24
 Kernel panic - not syncing: Kernel Fault

Signed-off-by: Helge Deller <deller@gmx.de>

---

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..dfeee7b7322c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4521,6 +4521,8 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
 	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
 					lockdep_is_held(&wq_pool_mutex));
+	if (!pwq)
+		return;
 	if (wqattrs_equal(target_attrs, pwq->pool->attrs))
 		return;
 

