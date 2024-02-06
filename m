Return-Path: <linux-kernel+bounces-55516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9E84BDA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFBE1F29AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE011401A;
	Tue,  6 Feb 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBdiyzjH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCA14273
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246034; cv=none; b=nTes2B9+2jOBnkYnTGD+ETwouzdfaxDN255H1weK1Wp7JTImPBUcYAeD221pEVplhcet50uSK3wwOYfSJYpnIraBkKarz+ybOfP4XTG2dv7oi/1QFEgjfS24fvrTSeBNyJhbowhPlC4KGzgHzR/ConMMbRemAPhuQLcDM8mP3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246034; c=relaxed/simple;
	bh=gJcQ6d0CJSjr+e3ebKviNo9PpdJR4HFcHwPuBKfcgzA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=A3jo/VReULWfT21piLrzlHoYQEHj5o4C/ApoQ3OhPAlFfoqFti5m57MVXztAfhZIX0NZYAQyXQtlP1TLN2NC37/3EGT84S35OBzQSAug+IDIB+yOg32fBcHUNrUN/sqwNntQqzaiLzaLWJeDPiTuMHLDS5FccvNq/xNteoJ8PLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBdiyzjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uotV7Dk20V0zYM0ZFkt2nWrKOyUgPWQe516ZJcODW/0=;
	b=eBdiyzjHAQQgP/benxzc8TqtKNJpvcPVOpjzeETAYjKI8WISUF+/jIbivJWR6i9stNBSIZ
	sYIc5+IIwvFACKiXJghciDcUavldQOEDHto5cncPMXt8Ldf6bU4bW6l4sslazPOJWi5QKr
	wqtrOQBQMd3kAABnxkp/zwAUKkfB7yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Eof9qh4EP0ixu8pax6vqJw-1; Tue, 06 Feb 2024 14:00:24 -0500
X-MC-Unique: Eof9qh4EP0ixu8pax6vqJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A5D28489A5;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 381E01C060B2;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 45FE1401E133E; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185710.062560408@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:20 -0300
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
Subject: [patch 09/12] AMD MCE: use smp_call_func_single_fail
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Convert arch/x86/kernel/cpu/mce/amd.c from smp_call_function_single
to smp_call_func_single_fail, which will fail in case
the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/arch/x86/kernel/cpu/mce/amd.c
===================================================================
--- linux-isolation.orig/arch/x86/kernel/cpu/mce/amd.c
+++ linux-isolation/arch/x86/kernel/cpu/mce/amd.c
@@ -19,6 +19,7 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/string.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/amd_nb.h>
 #include <asm/traps.h>
@@ -970,6 +971,7 @@ store_interrupt_enable(struct threshold_
 {
 	struct thresh_restart tr;
 	unsigned long new;
+	int ret, idx;
 
 	if (!b->interrupt_capable)
 		return -EINVAL;
@@ -982,8 +984,15 @@ store_interrupt_enable(struct threshold_
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	idx = block_interf_srcu_read_lock();
+	ret = smp_call_function_single_fail(b->cpu, threshold_restart_bank,
+					    &tr, 1);
+	block_interf_srcu_read_unlock(idx);
+	if (ret) {
+		if (ret == -EPERM)
+			return ret;
 		return -ENODEV;
+	}
 
 	return size;
 }
@@ -993,6 +1002,7 @@ store_threshold_limit(struct threshold_b
 {
 	struct thresh_restart tr;
 	unsigned long new;
+	int ret, idx;
 
 	if (kstrtoul(buf, 0, &new) < 0)
 		return -EINVAL;
@@ -1007,8 +1017,14 @@ store_threshold_limit(struct threshold_b
 	b->threshold_limit = new;
 	tr.b = b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	idx = block_interf_srcu_read_lock();
+	ret = smp_call_function_single_fail(b->cpu, threshold_restart_bank, &tr, 1);
+	block_interf_srcu_read_unlock(idx);
+	if (ret) {
+		if (ret == -EPERM)
+			return ret;
 		return -ENODEV;
+	}
 
 	return size;
 }



