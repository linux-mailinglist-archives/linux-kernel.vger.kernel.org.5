Return-Path: <linux-kernel+bounces-55527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FD84BDAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569221C25E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1B1B811;
	Tue,  6 Feb 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcaL1ltr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51113AE0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246036; cv=none; b=upT2KrnDEMqQV6xEFqdlJZltpNW+6RjitRPL+bWCFRpTSoX+GZVaWsmahCVIibLSZ+HrNQft5GkG6xtp9YSKcvR6rMfnIQOtVm/CGOlMpbCTjPcRXH3bCAWnJftwbytEyvUsBPtkoZQWp4KtS87+5/YjMUSKTLCMVbNX70qxx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246036; c=relaxed/simple;
	bh=icPewUcb2uBXgi4rZb0hGb6xeddJDSC0Pp7yA5HYgmQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a8Xtamo93yjaMuNXLA0H1L3kR73WWfJYD40SflhEeSrtjx+REmpfdZtXRxNwPjiaSr1SYsGg8JNByQu1WhzHdl86YlIFmIuahqgozT32Uf7q0o+teAH9KGoQTmc8lHTOYVRLBjVQGrtI0y3ILJHar+DW+0a+ffZghGmplciheLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcaL1ltr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QzKKL7qGPdseF9/lZMuCLlvRdCnkIvTUaMYeYBwSpPA=;
	b=DcaL1ltr+NIIkSct8kOvbEnVhMC3TIS4fcAc1g0eY3GnZp9hMG7VXoZ0OPEBsEmMAvOvii
	0jjmQA2ayVxOZOy+vGPpf1p0Y03fIeQgzeW08oGNAPHGwDfKcci+xGqXYtQlEVqUfLrd2p
	fgckXG5TTTz7jby4YYrW/4aySpKvCeE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-oKlgPp8xMzy1OkOBzLNl5Q-1; Tue, 06 Feb 2024 14:00:26 -0500
X-MC-Unique: oKlgPp8xMzy1OkOBzLNl5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FDE6101FA2C;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09E071C060B2;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3678E401E12BF; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185710.008903181@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:18 -0300
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
Subject: [patch 07/12] mtrr_add_page/mtrr_del_page: check for block interference CPUs
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Check if any online CPU in the system is tagged as
a block interference CPU, and if so return an error
to mtrr_add_page/mtrr_del_page. 

This can avoid interference to such CPUs (while allowing
userspace to handle the failures).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


Index: linux-isolation/arch/x86/kernel/cpu/mtrr/mtrr.c
===================================================================
--- linux-isolation.orig/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ linux-isolation/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -45,6 +45,7 @@
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
@@ -226,7 +227,7 @@ int mtrr_add_page(unsigned long base, un
 		  unsigned int type, bool increment)
 {
 	unsigned long lbase, lsize;
-	int i, replace, error;
+	int i, replace, error, idx;
 	mtrr_type ltype;
 
 	if (!mtrr_enabled())
@@ -261,6 +262,13 @@ int mtrr_add_page(unsigned long base, un
 	error = -EINVAL;
 	replace = -1;
 
+	idx = block_interf_srcu_read_lock();
+
+	if (cpumask_intersects(block_interf_cpumask, cpu_online_mask)) {
+		block_interf_srcu_read_unlock(idx);
+		return -EPERM;
+	}
+
 	/* No CPU hotplug when we change MTRR entries */
 	cpus_read_lock();
 
@@ -325,6 +333,7 @@ int mtrr_add_page(unsigned long base, un
  out:
 	mutex_unlock(&mtrr_mutex);
 	cpus_read_unlock();
+	block_interf_srcu_read_unlock(idx);
 	return error;
 }
 
@@ -405,11 +414,17 @@ int mtrr_del_page(int reg, unsigned long
 	mtrr_type ltype;
 	unsigned long lbase, lsize;
 	int error = -EINVAL;
+	int idx;
 
 	if (!mtrr_enabled())
 		return -ENODEV;
 
 	max = num_var_ranges;
+	idx = block_interf_srcu_read_lock();
+	if (cpumask_intersects(block_interf_cpumask, cpu_online_mask)) {
+		block_interf_srcu_read_unlock(idx);
+		return -EPERM;
+	}
 	/* No CPU hotplug when we change MTRR entries */
 	cpus_read_lock();
 	mutex_lock(&mtrr_mutex);
@@ -446,6 +461,7 @@ int mtrr_del_page(int reg, unsigned long
  out:
 	mutex_unlock(&mtrr_mutex);
 	cpus_read_unlock();
+	block_interf_srcu_read_unlock(idx);
 	return error;
 }
 



