Return-Path: <linux-kernel+bounces-134937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC989B90F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D4F283DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A34383A0;
	Mon,  8 Apr 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRuDci2U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CED381B9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562374; cv=none; b=rKTPF4nQ8o7nbbx4sK1CKbHAGHfZi7Mi5isH6+KfkLdxgjETKyUaBKWUWZF49o7ZfDRS9WRVP3RpgF8RpAuQ8zA6jzUHG63B9P1066W3ed1GDGUrDlQaZ8yo7/2U9JQQ7e3Gy3ztmi9Srpo8Lm4tVKtSk0Y/rf2qGm+2Oj0bA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562374; c=relaxed/simple;
	bh=nE3RUWHz5jKp/obOWd69daNJpf1Rs9mZzvPmwp7OE3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eb/ZpEg0N8vlRFKatfco6gYfwR1fXi+f5oGrkcuFWZcfB9WD+Cfd5geQr21KXBNu5JTm3Pdm6qy1ycOJ4G4Ssi24BSo5HiqHf5Y1hBRmlxGUqWpKCD9cDBHGFAWYoKTsafG2xbqklh96xzScX58TyB3X3QfVttl5wzYy9EsK4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRuDci2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A37C433C7;
	Mon,  8 Apr 2024 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562373;
	bh=nE3RUWHz5jKp/obOWd69daNJpf1Rs9mZzvPmwp7OE3M=;
	h=From:To:Cc:Subject:Date:From;
	b=YRuDci2UGxdG7q6KcVU94MjJopJhQkzQaD8IYRfAP+YZBYu7bAWis8xWA+aPQIglJ
	 miR4DaN1/rt/wRf4rdjxA7QE4fCKYHgRLomj9DRoJnKKOfA8ehRK4OfXhRa2zIyz/X
	 T598yrv0Dr4R+7wGcVgF1PwZsQLba3QwsvdAmTBo5yhaqVF6oV/EEKCjWp12as+snq
	 VIWY7olGlKE1hZHSckiIE0iLkS72GD0ATxTby6uiB5VfbCI8IhVgtHueVztSrp3qnV
	 NT6Lz947Ovav8/pKNkGacShmtK/7a5l81nYgyY57YuH4vvnDKT4UkDtQJNfh26Xt8x
	 yFIQw0rHVuSvg==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] irqflags: explicitly ignore lockdep_hrtimer_exit() argument
Date: Mon,  8 Apr 2024 09:46:01 +0200
Message-Id: <20240408074609.3170807-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with 'make W=1' but CONFIG_TRACE_IRQFLAGS=n, the
unused argument to lockdep_hrtimer_exit() causes a warning:

kernel/time/hrtimer.c:1655:14: error: variable 'expires_in_hardirq' set but not used [-Werror=unused-but-set-variable]

This is intentional behavior, so add a cast to void to shut up the warning.

Fixes: 73d20564e0dc ("hrtimer: Don't dereference the hrtimer pointer after the callback")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311191229.55QXHVc6-lkp@intel.com/
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Reposting my patch, please apply this one or the identical one from
https://lore.kernel.org/lkml/20231120153953.kGBSHe5j@linutronix.de/
---
 include/linux/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 147feebd508c..3f003d5fde53 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -114,7 +114,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	do { (void)(__context); } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
-- 
2.39.2


