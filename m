Return-Path: <linux-kernel+bounces-160253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F38B3AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2EA1C24BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942215574F;
	Fri, 26 Apr 2024 15:11:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2884314900A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144266; cv=none; b=s+P+ZtsPV0zV5a/mts+THdViKlM2iHkSSW7nemidFNXQHbI8wQ4hOeIGucmpIxq4HHzTvGuhSAUQM0S30rCNaw1vIIZ0+yf8IaJeTGyMvfM282iUOcxFuhbTHVcqHrUvTHNlv3GTVmm+/MCHlI5zjpDxgXj0UjuSynDTv1CTne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144266; c=relaxed/simple;
	bh=XzwbygXB1XLTnLy5KTDvuQn0QpU/+Zp/WcuJJpMI2YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fa7I3YatNPL7YYu2164/MIzQY5JGvWwFi2459+O729xxn6LXukGmUoVSjohDVKPI8MCCoZEAdbJsS3YwJJnNrvBRCDwjbAGdxE/mbdDKdnd5UTqwyyQKbiXQafF754o3IhWiTdRujNbK2/u9BO5m7gqxXFGbZT5N1EBo8H0VMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DFF51007;
	Fri, 26 Apr 2024 08:11:32 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF8A3F73F;
	Fri, 26 Apr 2024 08:11:01 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 35/35] [SQUASHME] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Fri, 26 Apr 2024 16:09:04 +0100
Message-Id: <20240426150904.8854-35-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relax asm #includes identified by checkpatch.pl as satisfiable by a
<linux/> include in the destination files of this code move.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

FYI: James Morse (et al.):

 * This patch is kept separate for now so that these changes do not
   get lost when rebuilding the previous code-movement patch.

   It should be folded into the previous patch or dropped once the
   series is final.

Changes in v2:

 * New patch.
---
 fs/resctrl/internal.h    | 2 --
 fs/resctrl/pseudo_lock.c | 4 ++--
 fs/resctrl/rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index f73267762a87..0e0c70d62c40 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -9,8 +9,6 @@
 #include <linux/jump_label.h>
 #include <linux/tick.h>
 
-#include <asm/resctrl.h>
-
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 077c2abb6edd..2a36a2efbd49 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheflush.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -19,11 +20,10 @@
 #include <linux/mman.h>
 #include <linux/perf_event.h>
 #include <linux/pm_qos.h>
+#include <linux/resctrl.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
-#include <asm/cacheflush.h>
-#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "internal.h"
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 8b18224eda35..09f120772c48 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -19,6 +19,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
+#include <linux/resctrl.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
@@ -29,7 +30,6 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl.h>
 #include "internal.h"
 
 /* Mutex to protect rdtgroup access. */
-- 
2.34.1


