Return-Path: <linux-kernel+bounces-108506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B031F880B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508C61F23668
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539E224D1;
	Wed, 20 Mar 2024 06:48:57 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214561EB20
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917337; cv=none; b=ZtP5T+8EYE1onFxxIBjPmXf2x1u/opuK6h5lDjoNCh8U9u0SF7g7LnGHIInurx6NerZ/eFUcTRUmN4k5RI2XCkEfNnIhJ+aP6VSnhxurvcPmv5Qm8wJx+4QsMWBhnR2GqGBPrMf2TF9rc7a2KHQ1a3jfyV1M0mDBACQkI8Sxr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917337; c=relaxed/simple;
	bh=ys7N6tSmC5UITFUzitCF73UGxtY4ly7e4P+ltacisAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSefy4LseJLodKu+NPWUBH+8hMm1nuD17hXUUSo8yPdZDrZRZ0QUSl8UmfwRk+h79ukdNF/KI2dCACZz4fhKX1dljAmsUrmYa3uI3id5avDvMGpxwBdS4yXuFJSzX8l3YcJ5V1tUsEzZHsKtZqf9zmaUfPrlqrgTn5h+thFwZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1710917284thnfyjz3
X-QQ-Originating-IP: OJizYU0H9xC2851P0uUCE4B9VvMnFvZLp4NnBXJMqAk=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Mar 2024 14:48:03 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: FwowAM4HOqBGbsidlDrWeFbrU7mQSrccryRonPJnKUAdgGDEvBMlRTq68iM29
	uq2+tdqkrrnYqSmEt+O6L9HTchYkQsHS+2yW6+m0pFY+knIELBlqAhqPPGa2lz3nl8JA2Q0
	0h/+keWpn7HKXPnuC7Yml8Tl1h0T5UF7KAwYxaVPp3IANRi8+VijawpC8469DTIzzCOLnRb
	/oqlJMj/Av1JXjnZYpF9vXF8YzyeXIEXYl3d7OeZNQNxpOk1KqJ/jehf1wui0ObJY3daNH6
	FpLEGUO9QkNFS7xP/k1Oy1dX1EaYeBxtMmWkUp98yOcfOpEDBpCOt6fEfFKivkXrTx2gT+o
	KPTkSTkk6brvPlz5+A/X++JbjAoq6NEvYG/nyvLC2+9qXUSXA6TGnKhqiduiLh+bC8s+M0+
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 553066475430503737
From: Dawei Li <dawei.li@shingroup.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alexghiti@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 1/2] riscv: Remove redundant CONFIG_64BIT from pgtable_l{4,5}_enabled
Date: Wed, 20 Mar 2024 14:47:11 +0800
Message-Id: <20240320064712.442579-2-dawei.li@shingroup.cn>
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

IS_ENABLED(CONFIG_64BIT) in initialization of pgtable_l{4,5}_enabled is
redundant, remove it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..bab3e9943bb5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -50,8 +50,8 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
 EXPORT_SYMBOL(satp_mode);
 
 #ifdef CONFIG_64BIT
-bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
-bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l4_enabled = !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l5_enabled = !IS_ENABLED(CONFIG_XIP_KERNEL);
 EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
 #endif
-- 
2.27.0


