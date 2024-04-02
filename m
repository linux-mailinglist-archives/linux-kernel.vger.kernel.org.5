Return-Path: <linux-kernel+bounces-127263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BDF8948E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02339B22D55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6343ED531;
	Tue,  2 Apr 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z+5vbHNN"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C9945A;
	Tue,  2 Apr 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022466; cv=none; b=RpLoklF21/MT+czLM+j/4GSWBN7nxUkL6PoIhow8yqRYuPpbaTaUZJxfmmlcSsAqPRbvlV9nISLDPjlRDAFs3TCgCoCtpPRki7xMf2bLv5uROvKgzxuZBchZCfGqguki6/ncP1qOa+tugoPcDIwEg0laycr0GAnbltkfcN+8M2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022466; c=relaxed/simple;
	bh=E005gBSNtjSCIS2doCc/40wSL13e/DWnm8D1a1Y8FXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jAsVJntG/WQXeU7G0ho54LJQBNTIEfroHa2qwocY3siw/n0dIIor4V9ICZjFgqXPrsqhJH/UAG/YFaBKLKeRzziIKVLp7xPCyjXTZVgvAFSqyhYXT6+IXRgyJ43J+0T7i7gS7B9zdXDADwAZCI8cHfmY/qm4wheCdE3oRTWpkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z+5vbHNN; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712022465; x=1743558465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3vnZ3IHPBXc4ai5YYVkJH/KG1jfBRdDvhLTTJAolhIY=;
  b=Z+5vbHNNl5C/Sq0z+MttQbjysUUZ9/N+5MgNttcfRTbGcBV+r/jaNC/l
   EDcvYti6c1Lwqg+FkOL91kkjCjLHXGv6PbS0Gh/8MQRuhDBGmXSKaFDxw
   1vx9pCPgj82CZCbJXE4ir6pBklXMhTI7470FCTFhrQjFsl79iAJrY68UQ
   o=;
X-IronPort-AV: E=Sophos;i="6.07,173,1708387200"; 
   d="scan'208";a="645020000"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:47:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:1581]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.132:2525] with esmtp (Farcaster)
 id 3851c02f-02ac-4111-8f35-6d8584b37e21; Tue, 2 Apr 2024 01:47:42 +0000 (UTC)
X-Farcaster-Flow-ID: 3851c02f-02ac-4111-8f35-6d8584b37e21
Received: from EX19D001UWA003.ant.amazon.com (10.13.138.211) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 01:47:40 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.252.141.8) by
 EX19D001UWA003.ant.amazon.com (10.13.138.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 2 Apr 2024 01:47:39 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-assembly@vger.kernel.org>
CC: <peterz@infradead.org>, Haris Okanovic <harisokn@amazon.com>
Subject: [PATCH 1/3] arm64: Add TIF_POLLING_NRFLAG
Date: Mon, 1 Apr 2024 20:47:04 -0500
Message-ID: <20240402014706.3969151-1-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA003.ant.amazon.com (10.13.138.211)

TIF_POLLING_NRFLAG was removed from arm64 as there were no polling
idle states. Add back TIF_POLLING_NRFLAG in preparation for an arm64
cpuidle driver which supports polling.

Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 arch/arm64/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e72a3bf9e563..ab22c7d1967e 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -81,6 +81,7 @@ void arch_setup_new_exec(void);
 #define TIF_SME			27	/* SME in use */
 #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
 #define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
+#define TIF_POLLING_NRFLAG	30
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -97,6 +98,7 @@ void arch_setup_new_exec(void);
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-- 
2.34.1


