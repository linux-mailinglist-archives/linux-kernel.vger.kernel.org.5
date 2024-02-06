Return-Path: <linux-kernel+bounces-55523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F6084BDA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06098292AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD351AACF;
	Tue,  6 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlRKy6zc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996ED13AE9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246035; cv=none; b=LbiGGkiLDm8L1PZBIK7VHVYHp8RavZNlk+RInT+6E0HPiYLqlyyIKA2WT69comSI0xYU4Vlzk5wdh91XRs9uuX8dyrAUpcUbnKl69FEGw12n8P13j6SpMw3gFqoF92w/bBjmILJ3iRY3zxYcs3N/aFTJu6PEWefesIfc01yj1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246035; c=relaxed/simple;
	bh=0oVR2iX1MWiDWezzOf++9ZQng2r7sLEq/QSolw3KecA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XfwnEfybxd6/ZXjYdAbGA2oQg9oA03Xh6DoiYk8JwFiYYI3ojdf3juGbU1ythBqtzsOIooNQb4XqGzSAkFuUB4glXny83gNcQJWDob3hiFnJwfaaBjQy0utbTPxm4us6/SQNQ9MFsKRtuem4TXaDyccN0lbf1+9YKeD6tx7u408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlRKy6zc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k9Gh7G7xTrMd8YjXBJXK/0OngeF3ZzVghgrC9df1T2I=;
	b=HlRKy6zcw+AyOpNMeSdFy7/yMXCBFJf51XpPnfbKyyMOvfVvvM9/K5SPzX/K+0Go1URlf0
	K0YbuJ4fjVluH6fjVAkg7TGLUPc9I/cqGrZbeoGoxWkfKAvD8vXwkro6t2pPHwQk6g1+yY
	Ow+hQItp3V2PlhotvW0gUWYCygMtFig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259--v_AD5UKOy2ld9z7HOoj2Q-1; Tue, 06 Feb 2024 14:00:24 -0500
X-MC-Unique: -v_AD5UKOy2ld9z7HOoj2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C7DF185A780;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45A581C060B3;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 54400401DED49; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185710.116221062@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:22 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 11/12] x86/resctrl: use smp_call_function_single_fail
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Convert update_task_closid_rmid from smp_call_function_single
to smp_call_func_single_fail, which will fail in case
the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/arch/x86/kernel/cpu/resctrl/rdtgroup.c
===================================================================
--- linux-isolation.orig/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ linux-isolation/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/task_work.h>
 #include <linux/user_namespace.h>
+#include <linux/sched/isolation.h>
 
 #include <uapi/linux/magic.h>
 
@@ -551,12 +552,20 @@ static void _update_task_closid_rmid(voi
 		resctrl_sched_in(task);
 }
 
-static void update_task_closid_rmid(struct task_struct *t)
+static int update_task_closid_rmid(struct task_struct *t)
 {
-	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
-		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
-	else
+	int idx, ret = 0;
+
+	if (IS_ENABLED(CONFIG_SMP) && task_curr(t)) {
+		idx = block_interf_srcu_read_lock();
+		ret = smp_call_function_single_fail(task_cpu(t),
+						    _update_task_closid_rmid,
+						    t, 1);
+		block_interf_srcu_read_unlock(idx);
+	} else
 		_update_task_closid_rmid(t);
+
+	return ret;
 }
 
 static int __rdtgroup_move_task(struct task_struct *tsk,
@@ -604,9 +613,7 @@ static int __rdtgroup_move_task(struct t
 	 * group go into effect. If the task is not current, the MSR will be
 	 * updated when the task is scheduled in.
 	 */
-	update_task_closid_rmid(tsk);
-
-	return 0;
+	return update_task_closid_rmid(tsk);
 }
 
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)



