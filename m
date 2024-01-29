Return-Path: <linux-kernel+bounces-42259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E383FE9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E2E1C22987
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386B4E1DC;
	Mon, 29 Jan 2024 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4t98/Zu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3F4E1C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510389; cv=none; b=pLN0iF7PqU35QLgyS+ps9blBFrW6Vug1a8/oLS+pMxbnxsqJ+y4Nf2/LCcr81rpLpuTj9OGYnMA3ssxJGpoTLSi/uxTyYVIG7cz5ZKh8MVtZgMYrS5KLWZHVZ5J1ZQf9tl57anNCh9enyTeOEWqRohY3k9AA2dpYATBtMfKqbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510389; c=relaxed/simple;
	bh=B5ADz3m5i2u2lMzDcjGq4jF37gAxqS/1AYz26oq+fNc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tvFMhAa8FWUzEVEb2Vk6P7voiHFriHWM2Ifx6avZtjP64mjFngNxyeccRc9wGMwxfGkyP+jKou0eUpD3FdpOL2E2EgZycwi0uxeY+Xg6+F6xEommEYPqdNWpJNg3w0oqr7Xgcr2LB2nQpjfPcnhZ2uBDJgDf4jhjSVskB/iqP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4t98/Zu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706510388; x=1738046388;
  h=from:to:cc:subject:date:message-id;
  bh=B5ADz3m5i2u2lMzDcjGq4jF37gAxqS/1AYz26oq+fNc=;
  b=S4t98/ZuE52IeIp5JZTG8ZZWLWsfLmh8FyKkTYExIO9wORZNlrVs5q+4
   rt3sIqGCJNk8C3fWcFXcxKOm14Uwil+nEfhwA1jPvcgKrOTsvxrOdMxyu
   BC7dM697HFfjJ3KS2Q9vF98CJU+0QMYULtEaBstfN5OIzlwiwiNp+Z4Yg
   8DisZATJp2j0nLndDlUVPhrPe/c+5xwuPxUM/bkeD9NKefk5r1qmzdOUv
   uGituuNNFKubdug1nOEGZdneKbjlj5IopQOtESSDlo6fT6K9Ef4lSSLN/
   wFzXAPFXZ+ttP5maDY1JMt3TRFUu3Yp5pmw/E/BKD1Aojg574RO9leQsY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9977257"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9977257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="36028748"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:39:26 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH 1/1] x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups
Date: Mon, 29 Jan 2024 14:38:42 +0800
Message-Id: <20240129063842.61584-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

During the memory error injection test on kernels >= v6.4, kernel
panics occurred like below. However, this issue couldn't be
reproduced on kernels <= v6.3.

  mce: [Hardware Error]: CPU 296: Machine Check Exception: f Bank 1: bd80000000100134
  mce: [Hardware Error]: RIP 10:<ffffffff821b9776> {__get_user_nocheck_4+0x6/0x20}
  mce: [Hardware Error]: TSC 411a93533ed ADDR 346a8730040 MISC 86
  mce: [Hardware Error]: PROCESSOR 0:a06d0 TIME 1706000767 SOCKET 1 APIC 211 microcode 80001490
  mce: [Hardware Error]: Run the above through 'mcelog --ascii'
  mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
  Kernel panic - not syncing: Fatal local machine check

MCE can recover from an in-kernel #MC if the fixup type is EX_TYPE_UACCESS,
explicitly indicating that the kernel is attempting to access userspace
memory. However, MCE can only panic the kernel for an in-kernel #MC if the
fixup type is EX_TYPE_DEFAULT as it includes various fixup types that MCE
may not recover from.

ex_handler_uaccess() would throw a #GP WARN_ONCE() if users gave
non-canonical addresses (with bit 63 clear) to {get, put}_user(), which was
unexpected. Therefore, the previous commit 'b19b74bc99b1' replaced
_ASM_EXTABLE_UA() with _ASM_EXTABLE() for {get, put}_user() fixups where
the corresponding exception handler ex_handler_default() does not have
a #GP WARN_ONCE(). However, the new fixup type EX_TYPE_DEFAULT resulted
in the mentioned kernel panic.

The subsequent commit '6014bc27561f2' (merged in v6.4) added the check
gp_fault_address_ok() right before #GP WARN_ONCE() in ex_handler_uaccess().
This check can avoid the #GP WARN_ONCE() for a non-canonical address (with
bit63 clear) in ex_handler_uaccess().

So with the subsequent commit '6014bc27561f2', now it's OK to revert to
_ASM_EXTABLE_UA() for {get,put}_user() exception fixups as it can both
avoid the #GP WARN_ONCE() in ex_handler_uaccess() and fix the panic
mentioned above.

Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/lib/getuser.S | 24 ++++++++++++------------
 arch/x86/lib/putuser.S | 20 ++++++++++----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 20ef350a60fb..10d5ed8b5990 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -163,23 +163,23 @@ SYM_CODE_END(__get_user_8_handle_exception)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE(1b, __get_user_handle_exception)
-	_ASM_EXTABLE(2b, __get_user_handle_exception)
-	_ASM_EXTABLE(3b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(2b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(3b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(4b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(4b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(4b, __get_user_8_handle_exception)
-	_ASM_EXTABLE(5b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(4b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(5b, __get_user_8_handle_exception)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE(6b, __get_user_handle_exception)
-	_ASM_EXTABLE(7b, __get_user_handle_exception)
-	_ASM_EXTABLE(8b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(6b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(7b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(9b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(9b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(9b, __get_user_8_handle_exception)
-	_ASM_EXTABLE(10b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(9b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(10b, __get_user_8_handle_exception)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 2877f5934177..975c9c18263d 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -133,15 +133,15 @@ SYM_CODE_START_LOCAL(__put_user_handle_exception)
 	RET
 SYM_CODE_END(__put_user_handle_exception)
 
-	_ASM_EXTABLE(1b, __put_user_handle_exception)
-	_ASM_EXTABLE(2b, __put_user_handle_exception)
-	_ASM_EXTABLE(3b, __put_user_handle_exception)
-	_ASM_EXTABLE(4b, __put_user_handle_exception)
-	_ASM_EXTABLE(5b, __put_user_handle_exception)
-	_ASM_EXTABLE(6b, __put_user_handle_exception)
-	_ASM_EXTABLE(7b, __put_user_handle_exception)
-	_ASM_EXTABLE(9b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(1b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(2b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(3b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(4b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(5b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(6b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(7b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(9b, __put_user_handle_exception)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE(8b, __put_user_handle_exception)
-	_ASM_EXTABLE(10b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(10b, __put_user_handle_exception)
 #endif
-- 
2.17.1


