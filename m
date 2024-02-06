Return-Path: <linux-kernel+bounces-55515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BE84BD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4742292655
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464B1400B;
	Tue,  6 Feb 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bX2euxKk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00471426E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246034; cv=none; b=n92sx5oWLOolUuGm4aCgOyJ3wAzEiGu0vpSLuwJW1w9/bG+7/2a8sNINNgMQxnXUhn8i8hScuprp1//zshA0HTFPxQ7aWIRcH9k99QnoZIZ2fJF7qiIfpX/URiue0/jvkMpHQdY1ISlbCIy2LBB/eFRhwewSHsAJUhdv1v/o7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246034; c=relaxed/simple;
	bh=j28jEXAQ6BxQAteMhx/bhKW8iMfKVsyg8VIUsodhjeY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T3HqrtYluTOSF/SSdD9fgLX5Yyxx5iOOW09kYybEKg9l3Ns5Vg+i5QaghMDUlMitrZsrdq6Vd4kwjFJz3QqhT0mYN2I5pebkVpX9+DZKQe0lbvLU7GzRVf3d6uK1uFspscS40CoGiuLKXHQdS0eRdbBieVc+7E2lhZ56rL+d1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bX2euxKk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FG1YeQVX9cWWByEmGmyaeyChQB/mxYFgQkxnSBaUu8k=;
	b=bX2euxKkxDEaTxJpT8Zyp/T1k36VPfZOYUHxZzUaWSNRt0lGANQyK99ryIdp2lmirfcuBg
	fR1w6VSpd8Yw9MpnVp2ClNU7dJejrspAFSm8gWzD4YJs8JqfVap2x95fxcAEKS/Voj+/40
	86NxxULdrdL5JimSo2YL8+d14Gr6HfI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-OUyrGmmSPYGPPPCdx93-jw-1; Tue,
 06 Feb 2024 14:00:24 -0500
X-MC-Unique: OUyrGmmSPYGPPPCdx93-jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BEFA3CBDF65;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 56C891121312;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 4DAB6401E134F; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185710.090317205@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:21 -0300
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
Subject: [patch 10/12] x86/mce/inject.c: fail if target cpu is block interference
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

In the codepaths leading to smp_call_function (including rdmsrl_on_cpu),
check for, and fail if, a target cpu is marked as "block interference".

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/arch/x86/kernel/cpu/mce/inject.c
===================================================================
--- linux-isolation.orig/arch/x86/kernel/cpu/mce/inject.c
+++ linux-isolation/arch/x86/kernel/cpu/mce/inject.c
@@ -23,6 +23,7 @@
 #include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/amd_nb.h>
 #include <asm/apic.h>
@@ -584,6 +585,13 @@ static int inj_bank_set(void *data, u64
 	struct mce *m = (struct mce *)data;
 	u8 n_banks;
 	u64 cap;
+	int idx, ret = 0;
+
+	idx = block_interf_srcu_read_lock();
+	if (block_interf_cpu(m->extcpu)) {
+		ret = -EPERM;
+		goto err;
+	}
 
 	/* Get bank count on target CPU so we can handle non-uniform values. */
 	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
@@ -591,7 +599,8 @@ static int inj_bank_set(void *data, u64
 
 	if (val >= n_banks) {
 		pr_err("MCA bank %llu non-existent on CPU%d\n", val, m->extcpu);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	m->bank = val;
@@ -612,12 +621,14 @@ static int inj_bank_set(void *data, u64
 
 		if (rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
 			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 
 		if (!ipid) {
 			pr_err("Cannot inject into unpopulated bank %llu\n", val);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err;
 		}
 	}
 
@@ -627,7 +638,9 @@ inject:
 	/* Reset injection struct */
 	setup_inj_struct(&i_mce);
 
-	return 0;
+err:
+	block_interf_srcu_read_unlock(idx);
+	return ret;
 }
 
 MCE_INJECT_GET(bank);



