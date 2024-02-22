Return-Path: <linux-kernel+bounces-76666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224E685FAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3DCB26C96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3F1474A3;
	Thu, 22 Feb 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EWql7fnc"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9914691D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610704; cv=none; b=MUmDAnjJIzS9gCr+IdbGtoE2mu1pcxAxlvnPgaRdkxfatUrfIR0ya3/n2AXwDnz9ojDgeY/crV3BKuH4sXHgJc0snouJSU/mpAUlp6lLeu3lslH5sfHj4fJ/VNEAwPoZ9Cf+8HMj1N2fqx+Cx9ZYWCblJDqSdYKmZY4MbdDfa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610704; c=relaxed/simple;
	bh=tQai8VYTD5u9kmna2i0v3NDlggEePdlk6wRlzITeLz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QU38ab7YDD8SNlGQvhTp+iagjGHdS1muUUjfHjXxfIHPvemrFFJKk4VQLAR3ENbrsKjrM2hHs6hXace8b0eB8XUjwFUjTEAxBspVm0ZTzMf8uT3FufhanKsbn9WYF63VXtxo/4vNO2z3GSWKPOWL70oObWnWPOwhOpYiAbdJPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EWql7fnc; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708610701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5dkM7DuGNd3n4uTkQacavwzunNC39kM4edC7ugWujE=;
	b=EWql7fncR1Nj1MIpD5GRXCTp3WENf4dEY69tv+jJU3JilH4N5PjL/V0Pe5FGwckjEP/Uyc
	TMSelN5Z8oMXIJ4mqBgNDiz4LmUYpAOxzwz8N/sBA/f6cjS1ksHyDB50z50WXk6Wjh9xGP
	vTIbBboABNWUcFmQwXUyWrABeLtlfvs=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v6 5/8] padata: downgrade padata_do_multithreaded to serial execution for non-SMP
Date: Thu, 22 Feb 2024 22:04:18 +0800
Message-Id: <20240222140422.393911-6-gang.li@linux.dev>
In-Reply-To: <20240222140422.393911-1-gang.li@linux.dev>
References: <20240222140422.393911-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

hugetlb parallelization depends on PADATA, and PADATA depends on SMP.

PADATA consists of two distinct functionality: One part is
padata_do_multithreaded which disregards order and simply divides
tasks into several groups for parallel execution. Hugetlb
init parallelization depends on padata_do_multithreaded.

The other part is composed of a set of APIs that, while handling data in
an out-of-order parallel manner, can eventually return the data with
ordered sequence. Currently Only `crypto/pcrypt.c` use them.

All users of PADATA of non-SMP case currently only use
padata_do_multithreaded. It is easy to implement a serial one in
include/linux/padata.h. And it is not necessary to implement another
functionality unless the only user of crypto/pcrypt.c does not depend on
SMP in the future.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/padata.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 8f418711351bc..0146daf344306 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -180,10 +180,6 @@ struct padata_instance {
 
 #ifdef CONFIG_PADATA
 extern void __init padata_init(void);
-#else
-static inline void __init padata_init(void) {}
-#endif
-
 extern struct padata_instance *padata_alloc(const char *name);
 extern void padata_free(struct padata_instance *pinst);
 extern struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
@@ -194,4 +190,12 @@ extern void padata_do_serial(struct padata_priv *padata);
 extern void __init padata_do_multithreaded(struct padata_mt_job *job);
 extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 			      cpumask_var_t cpumask);
+#else
+static inline void __init padata_init(void) {}
+static inline void __init padata_do_multithreaded(struct padata_mt_job *job)
+{
+	job->thread_fn(job->start, job->start + job->size, job->fn_arg);
+}
+#endif
+
 #endif
-- 
2.20.1


