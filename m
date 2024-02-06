Return-Path: <linux-kernel+bounces-55520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E984BDA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C942F1F27ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C618EA8;
	Tue,  6 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tii4fEL6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086C13AF0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246035; cv=none; b=ATIGXjB59qklynLx61vZGzmr2C0xq8zwKj1/Te+iiyHixB36p7qkOw+90j23xETxHlLzSNtn1CHBKxNoqZMBMGtuKp11MmAjbVuImeiIWIa7EF5ZHil7w+7nz+2NvGRYd427Hkkx4VZYZpBv5sS0V6YN6O/kLoajw0qBKuAPkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246035; c=relaxed/simple;
	bh=BYgVLfv6v/ttWx32QuJAxOjLWrclNlzBJvovbd6xDjw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XcoQstIpi4mpYM40W8c68ZyQ9EWZ0udyaQ4l4B/JahHafX11cb1s3fE5rH4DP3/Cz6Wf4IlVA7FEikHwO5/cBcF9r5Mf7HPeGpbhDkvowza/+S7CQsYgCtRUhgUKEX+/RDDBaF4xn3RqSjN3hjtn60L9qBHLDBng5skISEwZdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tii4fEL6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ra7EGxeWV8AGneO4cyp0zFD1CrKmCahpgLqv1cR4INo=;
	b=Tii4fEL6HSrqbjLiWgNqB/TZEV5g56FfItQFZ2eaBFJ/q0ZK9DW8ekXUPcuyC60X79Tg0Y
	lQbJrvawTXHVq6NGrFAGvShmTH+gSb2NZEPyzvEouUrzS/6lsFPRLzz9K7MEdGcC0NKWu0
	w4DT2MRQzkGofzUbgfnFVFIho+iDCks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-dMpKcn1bNXyBXxUWz-pMEA-1; Tue,
 06 Feb 2024 14:00:26 -0500
X-MC-Unique: dMpKcn1bNXyBXxUWz-pMEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D0933CBDF69;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DE8F492BC7;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 25B48401E119E; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185709.928420669@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:15 -0300
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
Subject: [patch 04/12] clockevent unbind: use smp_call_func_single_fail
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Convert clockevents_unbind from smp_call_function_single
to smp_call_func_single_fail, which will fail in case
the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/kernel/time/clockevents.c
===================================================================
--- linux-isolation.orig/kernel/time/clockevents.c
+++ linux-isolation/kernel/time/clockevents.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/device.h>
+#include <linux/sched/isolation.h>
 
 #include "tick-internal.h"
 
@@ -416,9 +417,14 @@ static void __clockevents_unbind(void *a
  */
 static int clockevents_unbind(struct clock_event_device *ced, int cpu)
 {
+	int ret, idx;
 	struct ce_unbind cu = { .ce = ced, .res = -ENODEV };
 
-	smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
+	idx = block_interf_srcu_read_lock();
+	ret = smp_call_function_single_fail(cpu, __clockevents_unbind, &cu, 1);
+	block_interf_srcu_read_unlock(idx);
+	if (ret)
+		return ret;
 	return cu.res;
 }
 



