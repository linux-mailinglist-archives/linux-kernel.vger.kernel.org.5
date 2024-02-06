Return-Path: <linux-kernel+bounces-55517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3709C84BDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A41C1C2581C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224771426B;
	Tue,  6 Feb 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUgKMaEz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DF13ADC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246034; cv=none; b=XSouySv2QplC86NpB3UsrPbIW3xqLG6ftjTsIbfbxRVipripn6KPdNxB49VKoGylLy3RJ6LQrUeufMeFpFLl+bKymSZMsOotAHENnBoNcU8gr4pzIHgCEjk6N9aB3dOyi67f/TovyTwm1MrsYyE/QfMNI2ROuMLYewFHZKXYWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246034; c=relaxed/simple;
	bh=fizsrzHxaXU1GtGsg9HdUfQ0mzShdaO7Z2jrr3v2pXo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ERhHzh7m8vi0kXVliKafxlsViA0UML1edFHn+B9QPDwzKjCos33ql0lDeF5rZCa8/BMZfRRwrwIAN1fwqnyEme+eVROBCfAdGweHFou1VwEIFlxq712dmHHWBTc+z3FBAV1Sa2gOD6LkS9tXOnxM8Q1vpYaLmDdpD/O0XLWTlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUgKMaEz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zDeR10fmZO+DbmEW4JtrnK5ENqS+Plr4iUlLvXYdJcA=;
	b=EUgKMaEz9iikaJTKrpimn5CdZlm/17yaJJkySSnxZO6C0Vl0KQ9Z6csfBRj0xor5kIC52A
	5+J96ymVmNoKU0dJir/b375WwJkTwslPTm/0n/qt8NvUJNiFzNjRgixqIQYvEdIrmWnhaK
	o2iFq8btGAaecI8o5du3plCc+y4SuE4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-RLA6xKScNFum7LdxfHlM3g-1; Tue,
 06 Feb 2024 14:00:25 -0500
X-MC-Unique: RLA6xKScNFum7LdxfHlM3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 352B538212C1;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01CF01C060B1;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 30B33401E12AB; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185709.981989497@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:17 -0300
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
Subject: [patch 06/12] perf_event_open: check for block interference CPUs
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

When creating perf events, return an error rather
than interfering with CPUs tagged as block interference.

Note: this patch is incomplete, installation of perf context 
on block interference CPUs via task context is not performed.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/kernel/events/core.c
===================================================================
--- linux-isolation.orig/kernel/events/core.c
+++ linux-isolation/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -12435,6 +12436,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	int err;
 	int f_flags = O_RDWR;
 	int cgroup_fd = -1;
+	int idx;
 
 	/* for future expandability... */
 	if (flags & ~PERF_FLAG_ALL)
@@ -12712,6 +12714,26 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_context;
 	}
 
+	idx = block_interf_srcu_read_lock();
+	if (!task) {
+		if (move_group) {
+			for_each_sibling_event(sibling, group_leader) {
+				if (block_interf_cpu(sibling->cpu)) {
+					err = -EPERM;
+					goto err_block_interf;
+				}
+			}
+			if (block_interf_cpu(group_leader->cpu)) {
+				err = -EPERM;
+				goto err_block_interf;
+			}
+		}
+		if (block_interf_cpu(event->cpu)) {
+			err = -EPERM;
+			goto err_block_interf;
+		}
+	}
+
 	/*
 	 * This is the point on no return; we cannot fail hereafter. This is
 	 * where we start modifying current state.
@@ -12775,6 +12797,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		put_task_struct(task);
 	}
 
+	block_interf_srcu_read_unlock(idx);
+
 	mutex_lock(&current->perf_event_mutex);
 	list_add_tail(&event->owner_entry, &current->perf_event_list);
 	mutex_unlock(&current->perf_event_mutex);
@@ -12789,6 +12813,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	fd_install(event_fd, event_file);
 	return event_fd;
 
+err_block_interf:
+	block_interf_srcu_read_unlock(idx);
 err_context:
 	put_pmu_ctx(event->pmu_ctx);
 	event->pmu_ctx = NULL; /* _free_event() */



