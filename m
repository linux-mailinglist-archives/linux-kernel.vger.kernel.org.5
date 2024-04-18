Return-Path: <linux-kernel+bounces-149917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993F8A97D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F2FB23B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711715E7EC;
	Thu, 18 Apr 2024 10:51:02 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C915E5CE;
	Thu, 18 Apr 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437462; cv=none; b=hylpwdp5Nmazadiy0OgZjvezRkcTczcn4uaMWnF/kjSgU2QdXoeHi2tN8eSd2zE/dz2dVfWzWubYQ5JUIYj49c+2MmnxHf5xCVgWkkCA8NCzEFMTd0ALezpgolBY9i3Fsb4LycBj8iimo49r5xYOwv7pb9ZccsXke9CSjybAigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437462; c=relaxed/simple;
	bh=WBVRxLIdWKwIhWvkYX40p+kNDCgLtSNi083tiZeIF84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fnRGtYme9OVMocRXu5P/61iDzIDzpyYMKdc05qVxdV/JEflcRHKX4Rih3BUoAIOBoq82/O9r42rEkkUzQJJhkvMS0oHzxfbebZw6XDPiBppb6nzcum53yrE+y/BFzvvbBFWyGu1htL9n06V+SGyNaouJRJF6SmSSorVzGE//ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1713437427tx0r3mqm
X-QQ-Originating-IP: rYl7aVSFMInFEJldnKJN23SbhrmIjafTmB1/3rjQe6U=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 18:50:26 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: W+onFc5Tw4NcMRc6QjsEEEWUHz1Dtd6wntwnHBFMv84a1FNBfmtd9FZStN0R2
	pRuiVh5Lt5J9wTXP4CQmlu//N65YJM560JYcenFgkSZ05ACquRteIQyqZt1kfSIv4ssg1ay
	krqKI7k0wgODYU+qmaUu7fRFfxU1JW/zuD17MH8q1dH++dnPS5aeboX1rlXwNgZjUC5HgvB
	0ulamcokuYP3VI82BzrOpn1EyPKaOOQSyxtZot6ZPtCw4Wzw6e3WRcCT+jMctf2mGslBL58
	WaDY4mt3Zyk+QPpmu9Q3FkB/OcGubiqIxXVxwTrbOpcTeJTKYWc6EH97Xmji9YyYvo77Fdj
	hU/7frTVLIfTSI0j1/j8+gyNXLmO79tUHpXe+HLldtbKd0RQ4P4mPvauZ0x9Q4cS9Yb3Yjh
	giPuUAwE5DZckGRWffT69w==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17361949652161301272
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 5/5] sparc: Remove on-stack cpumask var
Date: Thu, 18 Apr 2024 18:49:49 +0800
Message-Id: <20240418104949.3606645-6-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240418104949.3606645-1-dawei.li@shingroup.cn>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Since the cpumask var resides in __init function, which means it's free
of any concurrenct access, it can be safely marked with static to get
rid of allocation on stack.

while at it, mark it with __initdata to keep it from persistently
consumed memory.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1ca9054d9b97..088d9c103dcc 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1438,7 +1438,7 @@ static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
 static int __init numa_parse_mdesc_group(struct mdesc_handle *md, u64 grp,
 					 int index)
 {
-	cpumask_t mask;
+	static cpumask_t mask __initdata;
 	int cpu;
 
 	numa_parse_mdesc_group_cpus(md, grp, &mask);
-- 
2.27.0


