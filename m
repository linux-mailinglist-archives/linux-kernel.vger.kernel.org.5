Return-Path: <linux-kernel+bounces-108507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4221B880B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC001B22D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368D2C86A;
	Wed, 20 Mar 2024 06:49:25 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B82C68A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917365; cv=none; b=JJ+0ZuEefV/ldGM+CedwxGoEJh8AR1O/O+kqzFaRwnXtl3PXL11OnicaUCw3n7IOyyolHdgMCHB5DCkJx4uxrjD/0IvizdTFtAKSqPC3qVQC+bddJ31Ed5oRU9kBgIR2JOMfuVuS1cwH0A6Pg591e40BhC8q7Ply4dzTw6Ai43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917365; c=relaxed/simple;
	bh=J87JP8CX4Jo2DMgSu/NbJaDHl2NWz8uYCmpt/5mZC34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TojA3sxACVvMl+o/k9YIsbIV5UmzZoPMe8IGLfEe6PEc8lPuBnPTN64XotrLf5Imzfhi13x+N+nDfg3pYzaUJ6sn5FU7k8gPmYz1d7rWb4srkMeYMY+4tBzGfeqoisLikey/w9wlWVYMQu1PjYVgwEMsmJ/7WMEI7Ha56Skf0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp64t1710917293tzxbl7od
X-QQ-Originating-IP: ohUIX+NpasMm5o4CUkl2cU8VjUo3qXs7Ck8cstz7sb4=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Mar 2024 14:48:12 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0001000
X-QQ-FEAT: 7jw2iSiCazp7OdgV2kHlLVP94HvjWqFTqFF7HjO8HPsCdrjz1HxdrCZMLFDQu
	Bv9LlqAGVSsV55LkGOHaFjJgUFzl/9cZoG9fzy2Ymr6Qk2Pq8nOt+TPtqojYEGG20eJkYBq
	jf4HTiIJGpdJCFjgxXm9ry9InHiIhGxI8QELXyxXP5uKPDk9c3Xxqh5BvX4broJfj9We0l+
	VnEs/hkWSLX4cwzAXufnWVF5N3Q9lwOw8Dgae+WdJuXxdknNjuPtYUBSxING0mpqkAjEy4j
	FyRMYdiiQzOIDFHP+MJyyucGR1xI5nYhrUbKgH/1VWu31IPAKd9Nm2ej+Gs4l/QbEAIWlLR
	q3DHQZ7TfxlCMXXX6i/YvzXJd8xm3BA7PUkRFPXDUCghT3QOmiEV3l1UhBS1OUbVgEE6BvA
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6662747842115867711
From: Dawei Li <dawei.li@shingroup.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alexghiti@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 2/2] riscv: Annotate pgtable_l{4,5}_enabled with __ro_after_init
Date: Wed, 20 Mar 2024 14:47:12 +0800
Message-Id: <20240320064712.442579-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240320064712.442579-1-dawei.li@shingroup.cn>
References: <20240320064712.442579-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

pgtable_l{4,5}_enabled are read only after initialization, make explicit
annotation of __ro_after_init on them.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bab3e9943bb5..204cdf5b829d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -50,8 +50,8 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
 EXPORT_SYMBOL(satp_mode);
 
 #ifdef CONFIG_64BIT
-bool pgtable_l4_enabled = !IS_ENABLED(CONFIG_XIP_KERNEL);
-bool pgtable_l5_enabled = !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
 EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
 #endif
-- 
2.27.0


