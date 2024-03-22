Return-Path: <linux-kernel+bounces-111008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971808866E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2481F28632E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9611170D;
	Fri, 22 Mar 2024 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uWF/eB8l"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903C1B976
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089612; cv=none; b=tCxjFF7rfe6c8MVggXGAEEWRvHu6mDqoqQziJu4RKOCp3n2d+Fobu93pj4ALkV2T87XLjviQpOtmptuzz36KuOHWKhXoNYAT0j5640mMLmGyvlivuEiHTcDtQumoWFd3Y+xdI7SBh3FEV+49HWfeNPFfz3vciCaffU2btVQVoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089612; c=relaxed/simple;
	bh=OmRl29KzvLBz+OeNInYbQJfNvA+1SWooMoMKCM5qYek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nk9pbFc/RfP1ucLIWWvlCqzcgdMPq50pPf5Tbu7CVP+7JrM9nT9ZoCkysVQtOMJN/3lZhuhzXgBRne5GQq5CLyfoEU+bmd1usT+JU0353g0gkxy0a40wquaI6l7ud9ErzKA5xUBtw8T9MhYvd2CkwImWbFGFCp9jcIiKQttEBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uWF/eB8l; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711089607; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zRQDJgJXoe1TeM1CcHUcSOSMdyyAF8An2Aiv5fBBZMg=;
	b=uWF/eB8l8dBcAOaQGdMfnzbqB1HJiWkorU9sA5FU3Qrfhl73r3kdrDhhEbjCNeuROMKL9/bSPv5lu6lpQyULM57hjI/vut8Vh9/oH/TvvoemQHZk5rvg8BXWMWJjpvo4Io5U+x+ZkHPYjPWNcXhC+XnuGPgNSIVI4zxtUEMCpX0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W3160E1_1711089598;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W3160E1_1711089598)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:40:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jgross@suse.com
Cc: boris.ostrovsky@oracle.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] xen/x86: Remove duplicate include
Date: Fri, 22 Mar 2024 14:39:57 +0800
Message-Id: <20240322063957.94159-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/arch/x86/xen/enlighten.c: linux/memblock.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8610
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/xen/enlighten.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index a01ca255b0c6..5f3a69f6ec34 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
-#include <linux/memblock.h>
-#endif
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/kexec.h>
-- 
2.20.1.7.g153144c


