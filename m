Return-Path: <linux-kernel+bounces-129345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E989693E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B654B2A084
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18715C61A;
	Wed,  3 Apr 2024 08:36:11 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B55B1E8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133371; cv=none; b=StiSiRZjQRL8hMUggIHYmCPnxTitWbKipwdfGFokJbNiQElHhYAni+kDVLt6ZwmlGHRTG9RnWwGeaG0TKjP0hGmCboLCFlAWwGjkEnZlhhVvDnIycCY9RtLjU0J7v4nn7uaTyfXyRuyDefNsTjyk3SVQxkzghRW8GDJKPaUkY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133371; c=relaxed/simple;
	bh=UYJjZUdMiv7TOdiSAawVegp2UojEkhED3yLhhQZSTbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rk1cICRCyDehMBYornT11bGTGxsseDs414TImDpnA0ZzyXw5Ti4Yncrn3cQJcrXFytEkdMlS/65bngd+tw5MQHb5dGyRcxRbm0iJt+V347uro/MrgsaXQw4L/mWX/3WgAeRroaf3gdg2BK94jyF/nkcraZjYwSXQ1lsJE1hxshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V8dLT1QRtz1R9kP;
	Wed,  3 Apr 2024 16:33:21 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C5CE1A0172;
	Wed,  3 Apr 2024 16:36:07 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 16:36:06 +0800
From: t00849498 <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [RESPIN PATCH] irqchip/gic-v3-its:Fix GICv4.1 needless VSYNC after unmap VPE
Date: Wed, 3 Apr 2024 08:35:56 +0000
Message-ID: <20240403083556.3862236-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)

From: Nianyao Tang <tangnianyao@huawei.com>

Quote from GIC spec 5.3.19, a VMAPP with {V, Alloc}=={0, x}
is self-synchronizing, This means the ITS command queue does not
show the command as consumed until all of its effects are completed.

We don't need VSYNC to guarantee unmap finish. And VSYNC after unmap VPE
will reach an invalid vpe table entry, which may trigger exception
like SError or RAS. Let's fix it.

Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..2a537cbfcb07 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -786,6 +786,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 					   struct its_cmd_block *cmd,
 					   struct its_cmd_desc *desc)
 {
+	struct its_vpe *vpe = valid_vpe(its, desc->its_vmapp_cmd.vpe);
 	unsigned long vpt_addr, vconf_addr;
 	u64 target;
 	bool alloc;
@@ -798,6 +799,11 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 		if (is_v4_1(its)) {
 			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 			its_encode_alloc(cmd, alloc);
+			/*
+			 * Unmapping a VPE is self-synchronizing on GICv4.1,
+			 * no need to issue a VSYNC.
+			 */
+			vpe = NULL;
 		}
 
 		goto out;
@@ -832,7 +838,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 out:
 	its_fixup_cmd(cmd);
 
-	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
+	return vpe;
 }
 
 static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
-- 
2.30.0


