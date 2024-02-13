Return-Path: <linux-kernel+bounces-63404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4B852EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EFD2825E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230B376F3;
	Tue, 13 Feb 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZPI670aF"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32137157
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822848; cv=none; b=h+ajqUy0iEvzgNfFPZTDnh0dttYLJWbTNRR/4TmWBPez7HMy6kL+SuILFhudSdMGbQQ3vQO/6dqV4ik6AfjTE0BG/jUXQDykp2eJfZwWRqtag2HXo2XUdVj5PK314qXvY45FPypORpaH1VDZUWGuG0MIXtpxWQOkpWcWUoLuD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822848; c=relaxed/simple;
	bh=Pp4c82WxUcYPpLVo+HDh/cBM14HTiOMmYLsLLHJOEgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sy7C/M5hAEW7BNSuuCvADwDExniiqkIw1LNJcCp51qGOu6TYUVcfZ731l46Eh6K6kQItXiXYPlL58aCwjC8v0ifLL+u5evprpcK/s133DlYI5JGbmyh1vwc73y8OrK3X/OqSb3apZ0BqMdKpe7MZycKDq/TPsbpsPh7BPL8nQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZPI670aF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707822844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HNW+BWPQLZLSA9Wsdie7SM7+Z9Dq4YTo1Xwh/Ut0N0=;
	b=ZPI670aF7l5C2zzwKvIqmcFcaMTzMQXxlEsYJ10wrPsJHywJ67w1IkzFeJ/ZcwvX7xafSW
	yXfXogGU+DMHmth/vH46c00MhNvLCEPEGGBlvc7AN/c1ZL/3/ha2zPzbUzKY1h4fRsHcas
	pZeE8v64mDTmFPEItAV5JpOFcIUSt4s=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Gang Li <gang.li@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Gang Li <ligang.bdlg@bytedance.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 1/2] padata: downgrade padata_do_multithreaded to serial execution for non-SMP
Date: Tue, 13 Feb 2024 19:13:46 +0800
Message-Id: <20240213111347.3189206-2-gang.li@linux.dev>
In-Reply-To: <20240213111347.3189206-1-gang.li@linux.dev>
References: <20240213111347.3189206-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Randy Dunlap and kernel test robot reported a warning:

```
WARNING: unmet direct dependencies detected for PADATA
  Depends on [n]: SMP [=n]
  Selected by [y]:
  - HUGETLBFS [=y] && (X86 [=y] || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=n] || BROKEN [=n]) && (SYSFS [=y] || SYSCTL [=n])
```

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

Fixes: a2cefb08be66 ("hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/lkml/ec5dc528-2c3c-4444-9e88-d2c48395b433@infradead.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402020454.6EPkP1hi-lkp@intel.com/
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 fs/Kconfig             |  2 +-
 include/linux/padata.h | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 4a51331f172e5..7963939592d70 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,7 +261,7 @@ menuconfig HUGETLBFS
 	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
 	select MEMFD_CREATE
-	select PADATA
+	select PADATA if SMP
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
diff --git a/include/linux/padata.h b/include/linux/padata.h
index 8f418711351bc..7b84eb7d73e7f 100644
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
@@ -194,4 +190,13 @@ extern void padata_do_serial(struct padata_priv *padata);
 extern void __init padata_do_multithreaded(struct padata_mt_job *job);
 extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 			      cpumask_var_t cpumask);
+#else
+static inline void __init padata_init(void) {}
+static inline void __init padata_do_multithreaded(struct padata_mt_job *job)
+{
+	if (job->size)
+		job->thread_fn(job->start, job->start + job->size, job->fn_arg);
+}
+#endif
+
 #endif
-- 
2.20.1


