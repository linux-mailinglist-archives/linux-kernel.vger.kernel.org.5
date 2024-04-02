Return-Path: <linux-kernel+bounces-127873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81353895214
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E47B1F24763
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E79679E2;
	Tue,  2 Apr 2024 11:42:15 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8886DD1D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058135; cv=none; b=TNx4Vqp27H/DU+cgrrhw+xKY86+maWzEk/vucSH8gfLVAzy174GV0reNDnjHmXIyQvpNr2OguTblwO1iGOdHgeOr3POMEJGqwlPqnfxhew5dHu/fdgrfGGhL1ePWL/zXxJZaFbAtdRYlc3nu3SYuqxkR88+SA4qEOSw2EGoSNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058135; c=relaxed/simple;
	bh=Ido695F/P70jWK7SlR0yJrevOUkVgDQOpjJYH7Ow7NA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DAtaL5oecJTHuafVTuXO+waGJ7DtGmBecw0f4cHEHp2TM1aCsk1dTMOcd0AGUP+5EsUhxx4jdrkVgglThtJYLN+lzBI/efd1X6VKaXFXS8Y/mUSEmBlD1SBmX2SC9EsT7oHdxAc4+R3XDPUH9LoUv0qJ5ZG6wnJNgdo3jsgFvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V85WW56tpz1h2SR;
	Tue,  2 Apr 2024 19:39:19 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 641441403D5;
	Tue,  2 Apr 2024 19:42:04 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 19:42:03 +0800
From: t00849498 <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Don't need VSYNC if VMAPP with {V, Alloc}=={0, x}
Date: Tue, 2 Apr 2024 11:41:47 +0000
Message-ID: <20240402114147.3788881-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500014.china.huawei.com (7.221.188.63)

From GIC spec, a VMAPP with {V, Alloc}=={0, x} is self-synchronizing,
This means the ITS command queue does not show the command as
consumed until all of its effects are completed. A VSYNC with unmapped
vpeid is not needed.

Signed-off-by: t00849498 <tangnianyao@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..a0ca5dcbb245 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -789,6 +789,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	unsigned long vpt_addr, vconf_addr;
 	u64 target;
 	bool alloc;
+	bool unmap_v4_1 = !desc->its_vmapp_cmd.valid && is_v4_1(its);
 
 	its_encode_cmd(cmd, GITS_CMD_VMAPP);
 	its_encode_vpeid(cmd, desc->its_vmapp_cmd.vpe->vpe_id);
@@ -832,6 +833,9 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 out:
 	its_fixup_cmd(cmd);
 
+	if (unmap_v4_1)
+		return NULL;
+
 	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
 }
 
-- 
2.30.0


