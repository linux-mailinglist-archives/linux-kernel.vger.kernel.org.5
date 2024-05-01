Return-Path: <linux-kernel+bounces-164888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85408B8481
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109B7B220DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA122941C;
	Wed,  1 May 2024 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d9/hjdIP"
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3833E1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714535049; cv=none; b=PypHR2C9cfF4KfXPkk2HV4YghTGxy3/f3zbxIyu4mtszkZHxQ1K6YvBphHIpHdTW3pVf+oZN3ejQNd8Sa3jEpyy68M0ncwsC4PA0HiQJO+ops5EAlYwebtB7R5wwmfUoW8kbk4vfYlE1Xalkh0e//noNVQcruEP91svZJMN/GdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714535049; c=relaxed/simple;
	bh=VMECdDoevSZi2gTEGIIaMYMyx2i/AYirE3sFF5i/blo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hcGOqmL1Tx/mrMi51rzvQRn1Q+gd6yscTEcPkFSoRXAYV7/0attnrsyxF0n4zGNq5P0ZmkRj2BiNi8wrblfnBNKMBaGrV/UrHhYTXlCaFNxRb6RmKPhS8yCE5FdD2pWNQCt0D0STXp5Dg+JE7pF+nxgd8+HQIyrUpgWN5a7UiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d9/hjdIP; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714535044; bh=srw6zZpjyd7bfaFwU/LrQvYoyq7KMbt2LYOo6HL6/10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9/hjdIPOW1tp68xWPqNJAFmoTDikfWYyZ7WYcoQwxdPaIg1qJtCGUrjpSNfIkYoo
	 HQ8LcVgtgTg1WXMmLqUbmkT4qKG/xzTmHGRHRzEvIQAjDarEveagjzmeLq/ioW9A7R
	 PFKS4T83igSvK7Uc7n3EKeeuIwfWsCiEOy45T8co=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id B029B249; Wed, 01 May 2024 11:44:02 +0800
X-QQ-mid: xmsmtpt1714535042tlfvcbnqd
Message-ID: <tencent_C006E452DF067C49AD2ED7AED90CAB27CB06@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9+sRo5sukoIcvVWU1miBjLMm8bzAwkdJGH1mbTPAduF7h2+kmeb
	 9sYhMd0kYtWT9KBE5Tw/mqZex4mx5GcEum6859vb+8iPXY7537o1ucqho1Zhq2pHHBVFDx33AKZ4
	 9u54IqhAqQpK26oo5hurwmO/vK1pJMZjn/ToB8hdgNKsODMCmPdoRvcB0UR+gb6S7KElStXvS2iS
	 /XVHBFBd0fbKKV1koFoiFdF0WmFeXCoX0TyWGftiO4E2N2u0h/Ra5Q90DiBEw8TQTYd7bTltFhEC
	 UEYk7zGGI+2bFe+HuFVl1kSHGJg2eQb9apZX1JhRxOsP1lh6NGajsea/C/aavA9pxD2Oh/8SxH3i
	 VjRYq+O+GSLW2C5EsBd7oFbeAjkX3WWs9591vXHNu8VSDAkXeSdbw1gIpQjvHUJ98LwzexSy8Nfv
	 Z+SaywhMkF3mkf+WssFrESYdm6EOyKF/AcCAINLcBtighjiO94NdzCIDpirz/gZmJ496bu2KTrMp
	 wGjQ3OonbmUjXHGJ4tCO0FcjAm99A8/vYkL6R6EJ5EsgyqXthS4D7oBHnjx11al5zGWy8I21CDZj
	 5Z05XrZPTQYGCE9fOyEIckFVP4zwp14GDUy1wTTcMJu5T0pj77AhJ1Lpjmmo7HNeNHcNvWABj+RG
	 G582vuh5h/zcL6Qe0sMibQWXbj+o5JRHGjLzNz73OA7xI1f9zktu/Gi+tYtEFugRGYFxGDnNbk+x
	 et1xCym3Yhe5Z0/sPrymOL7AvXO0lQ1ym12ujHBDkRbhDVF7o+pwGxF7fXCnoqgH34gEDPSG4nqH
	 l6fAHCm2m/y3iZW378xXHOJjilNoXM2SCeQarHsEVZ3Y8GEU/tPVO7bHqjcoWFFB7FSSb7deRU4s
	 V7JYPqqIAz2nvZ02hi1o9mzTm7vdHh09zqBxy+M8ZUR8JHvD99kbR16MVr9Fl3ochKmmqLmAW+Eo
	 giXQBDMW0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
Date: Wed,  1 May 2024 11:44:03 +0800
X-OQ-MSGID: <20240501034402.1222730-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in vhost_task_fn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git bb7a2467e6be

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 48c289947b99..8800f5acc007 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -61,8 +61,8 @@ static int vhost_task_fn(void *data)
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
 		vtsk->handle_sigkill(vtsk->data);
 	}
-	complete(&vtsk->exited);
 	mutex_unlock(&vtsk->exit_mutex);
+	complete(&vtsk->exited);

 	do_exit(0);
 }
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -563,8 +563,7 @@ restart:
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -584,6 +583,11 @@ restart:
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;


