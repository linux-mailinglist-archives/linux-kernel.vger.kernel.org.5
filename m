Return-Path: <linux-kernel+bounces-90254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31AE86FC80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003B31C21EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671BD1B59B;
	Mon,  4 Mar 2024 08:55:59 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637371B5B2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542559; cv=none; b=uS0YoDvov8lFkizKqucevE0z1AazaGYGyO4QkCqHaY/a+a9l52PZD8kFecByiTK8eHRqMw49mCkV4911ZTMRx8AwQ3T0KytbFVcVhyiitaenYDe6wTzmQOZ2D9LPnwKIkjKUrOg5zE/OcY3+hEFODDVgsScIxvfW95iz5VyMyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542559; c=relaxed/simple;
	bh=BCVH8caV3eJZnst0zjGp6cLMi/unVfiC59OWDvK3zu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6E735SXoJrreCKvMhamOygU198DxThl4RU0NHwpsgJF3Emu7eC0QSV/Eb35fH4QArAPg9R4TMkYQsFtjL397teO9Q9KEVWhTROL/UZ0GC/L3vYOqvmByEmCpLv3CYgesQMSx8IjGgaAtI34E5CzOPApuK1zjAag6h/6oozObpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp69t1709542507tx60w49v
X-QQ-Originating-IP: j/t1lN4+T/EzHFlHMLaia4UWmdXBjku6RWJFXoUD+6s=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Mar 2024 16:55:05 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: 807rdhwoR6uy/+E3pBfzXZHZy374eWAo5dxa5PXnJBGPu1CMZTVkYdBWZ1Rfn
	WRqfAAXfqNtSoWjBKfW/UauMfOls/5n3cxyhJMpVSLNZEjIoTx0j+9wU8/Vvxi9VWknITPV
	ImI+R4cnzFhLl6gUbp5nL3pHJzR3fLr694h12Jtenim6uPNQWlgb/QRAlj3Kel9oqaQaRjm
	gvr03M1QiRV16oOlxNHUvHLE2r6rpkPlh6x/RfhmBHtCM3pvREXb05qEdDxCGek73M4FkRj
	NNM6c76GRXN/b4awzygIS2psbOwdspDed5M+oPqsdyfcWs++go01Sxghl+0sNzk95CXgxkA
	cbrEecG0CpIxp2gEEiuXSlBkSUoOfcm9MyzUFUiz2+rxPDmba89TDqTDYSA/b99YSCGG8jq
	RzOpGcW/epU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2245615275566401135
From: Dawei Li <dawei.li@shingroup.cn>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] m68k: Calculate THREAD_SIZE from THREAD_SIZE_ORDER
Date: Mon,  4 Mar 2024 16:54:55 +0800
Message-Id: <20240304085455.125063-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Current THREAD_SIZE_OERDER implementatin is not generic for common case.

Improve it by:
- Define THREAD_SIZE_ORDER by specific platform configs.
- Calculate THREAD_SIZE by THREAD_SIZE_ORDER.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---

V1 -> V2:
- Remove ilog2().
- Calculate THREAD_SIZE by THREAD_SIZE_ORDER.

V1:
https://lore.kernel.org/lkml/20240228085824.74639-1-dawei.li@shingroup.cn/

 arch/m68k/include/asm/thread_info.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index 31be2ad999ca..3e31adbddc75 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -12,14 +12,15 @@
  */
 #if PAGE_SHIFT < 13
 #ifdef CONFIG_4KSTACKS
-#define THREAD_SIZE	4096
+#define THREAD_SIZE_ORDER	0
 #else
-#define THREAD_SIZE	8192
+#define THREAD_SIZE_ORDER	1
 #endif
 #else
-#define THREAD_SIZE	PAGE_SIZE
+#define THREAD_SIZE_ORDER	0
 #endif
-#define THREAD_SIZE_ORDER	((THREAD_SIZE / PAGE_SIZE) - 1)
+
+#define THREAD_SIZE	(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 #ifndef __ASSEMBLY__
 
-- 
2.27.0


