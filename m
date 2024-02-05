Return-Path: <linux-kernel+bounces-53184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512584A1CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581FE1C22FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D047F59;
	Mon,  5 Feb 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHKhYNMD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4DF482DC;
	Mon,  5 Feb 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156456; cv=none; b=TyhpSqgzOpvbCGsn4eCqPurpc+lV4DSaZF+zIqrJDeq5pvmNMaKvzptW6Kef3wDUMzcPzSTr9WbzTvpd9kjabQd3w5wmAH9/pIsQNpuWYXw9gISTF+XIcSuAvHtIveofm/2J2mNsAdxOxBFMKnRkyRchVibHVVxZuQA187cHPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156456; c=relaxed/simple;
	bh=k1qcLeijxsr0TUzQiCRFv8GVbl55Crn0tIFB32o1jw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bh5DwVz3QQekMLChGM37md0HWNxJW33sJWEtcPtrTv/whhTPyp/JmKWxM+9ChWHwsa6OLK2MAzxd3NA4oL13uRdHm1fUnMo74uI8PeWowltGp68TW8qkAsGYYpQSQC4PbmDaEOQDasJuJvGADcex1UffnncGS/49zZ9Tv3vM5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHKhYNMD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707156454; x=1738692454;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=k1qcLeijxsr0TUzQiCRFv8GVbl55Crn0tIFB32o1jw0=;
  b=QHKhYNMDoBdm2rWg0DmcjbvMXdtR7h1IOjHmKNYFvT7TZGcQdbsWgb9K
   4yIXSIWO+j46U6ppGjWS3R/GsoOo+P7zX4l0Q/C8Oy9p7kMVkOlklj5qu
   e+5DLBr+yQJ9UlT6FRWOwNDTNhDn+kn/rbKMnorUB/UJRXJIRJ9Coq6/Q
   q9H8AdrskM8KLn8AhsNY1aZKX8j37hsKODD+ZrBVJM26AkBLvskQ0xrla
   wUes/KKJGymllmBm/BOfvkIONFx8x3eRrhGuri4nl9Nmd5dvxdioPvo/R
   YEJ1NHbOfo4GaXn2ycp16xWqaqbPuNm4dzOowSt4yVcO675IWlijDd/5w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11162297"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11162297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="787460"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.184.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:07:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 05 Feb 2024 10:07:23 -0800
Subject: [PATCH RFC] cleanup/scoped_cond_guard: Fix multiple statements in
 fail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240205-cond_guard-v1-1-b8d597a30cdd@intel.com>
X-B4-Tracking: v=1; b=H4sIANojwWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwND3eT8vJT49NLEohTdxLREA1Mzs+TU5JQ0JaCGgqLUtMwKsGHRSkF
 uzkqxtbUAnA6L72EAAAA=
To: Peter Zijlstra <peterz@infradead.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707156451; l=3867;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=k1qcLeijxsr0TUzQiCRFv8GVbl55Crn0tIFB32o1jw0=;
 b=jnu1mYq6JJk9Q/ignm8LTz9Kjse6U3lYHMBThLkw+KHN2wwANlH53taZLLlIVOybHKefFSKTR
 HQXvaARuZGHAsjL1pwIx+kM50RY8OctjrpuAl3QL47HP3Wy6EJvFwY9
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

In attempting to create a cond_guard() macro[1] Fabio asked me to do
some testing of the macros he was creating.  The model for this macro
was scoped_cond_guard() and the ability to declare a block for the error
path.

A simple test for scoped_cond_guard() was created to learn how it
worked and to model cond_guard() after it.  Specifically compound
statements were tested as suggested to be used in cond_guard().[2]

static int test_scoped_cond_guard(void)
{
        scoped_cond_guard(rwsem_write_try,
                        { printk(KERN_DEBUG "Failed\n"); return -EINVAL; },
                        &my_sem) {
                printk(KERN_DEBUG "Protected\n");
        }
        return 0;
}

This test fails with the current code:

lib/test-cleanup.c: In function ‘test_scoped_cond_guard’:
/include/linux/cleanup.h:190:17: error: ‘else’ without a previous ‘if’
  190 |                 else
      |                 ^~~~
lib/test-cleanup.c:79:9: note: in expansion of macro ‘scoped_cond_guard’
   79 |         scoped_cond_guard(rwsem_write_try,
      |         ^~~~~~~~~~~~~~~~~

This is due to an extra statement between the if and else blocks created
by the ';' in the macro.

Ensure the if block is delineated properly for the use of compound
statements within the macro.

[1] https://lore.kernel.org/all/20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com/
[2] https://lore.kernel.org/all/65b938c1ad435_5cc6f294eb@dwillia2-mobl3.amr.corp.intel.com.notmuch/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
NOTE: There is no user of this syntax yet but this is the way that Dan
and I thought the macro worked.  An alternate syntax would be to require
termination of the statement (ie use ';') in the use of the macro; see
below.  But this change seemed better as the compiler should drop the
extra statements created and allows for a bit more flexibility in the
use of the macro.

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 88af56600325..6cc4bfe61bc7 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -186,7 +186,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define scoped_cond_guard(_name, _fail, args...) \
        for (CLASS(_name, scope)(args), \
             *done = NULL; !done; done = (void *)1) \
-               if (!__guard_ptr(_name)(&scope)) _fail; \
+               if (!__guard_ptr(_name)(&scope)) _fail \
                else

 /*
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2fabd497d659..fae110e8b89f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -441,7 +441,7 @@ static int ptrace_attach(struct task_struct *task, long request,
         * SUID, SGID and LSM creds get determined differently
         * under ptrace.
         */
-       scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
+       scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR;,
                           &task->signal->cred_guard_mutex) {

                scoped_guard (task_lock, task) {
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 88af56600325..d45452ce6222 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -186,7 +186,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define scoped_cond_guard(_name, _fail, args...) \
 	for (CLASS(_name, scope)(args), \
 	     *done = NULL; !done; done = (void *)1) \
-		if (!__guard_ptr(_name)(&scope)) _fail; \
+		if (!__guard_ptr(_name)(&scope)) { _fail; } \
 		else
 
 /*

---
base-commit: 03c972291873663f15c78ff4ca07cbf5025735f8
change-id: 20240201-cond_guard-afa0566cecdf

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


