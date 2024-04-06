Return-Path: <linux-kernel+bounces-133774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BEC89A878
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA210283915
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0768A125DC;
	Sat,  6 Apr 2024 02:27:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474A15EA2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370474; cv=none; b=tq6pzWFIabwgLyNWchYGgkB5JY5ykDz0QG60kRdJ2J8k5PY6tU6aiHaRU+pUEJnqxMqajGjmDskLqIVfeKN5ef8kgYCqlEpGTcAnnuQWZHFd5Ize/njRwi26VUB3FSHGpnE9y0wIx0v5U6+6TcD+lOcxe6EdDbnn9WNZTT60Ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370474; c=relaxed/simple;
	bh=BewQ/T2U4RIeO4jNKmTe2LINmgotCVRugv5rarHB5jQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHuenQfnseoPWfC/gS3z2NprnqWw0Wr/FJPVTH1g7rGIKIKXeOY+0yAj7YwwpburJ1JXjWX/7UrNUJfOWUheSMiq6v5Qj2n0lguBe9IZVDtHr0vxkjNvTS93RuH4LVGDi+bPth2JHQ+JmUxigACyQsnQ2RDahrMMOEEx4crr2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VBK2556Jxz29dNV;
	Sat,  6 Apr 2024 10:25:01 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id C16281A0172;
	Sat,  6 Apr 2024 10:27:49 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 6 Apr 2024 10:27:49 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>, <yuzenghui@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [RESPIN PATCH] irqchip/gic-v4.1:Fix VSYNC referencing an unmapped VPE
Date: Sat, 6 Apr 2024 02:27:37 +0000
Message-ID: <20240406022737.3898763-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500014.china.huawei.com (7.221.188.63)

As per the GICv4.1 spec (Arm IHI 0069H, 5.3.19):

"A VMAPP with {V, Alloc}=={0, x} is self-synchronizing, This means the
ITS command queue does not show the command as consumed until all of
its effects are completed."

Furthermore, VSYNC is allowed to deliver an SError when referencing a
non existent VPE.

By these definitions, a VMAPP followed by a VSYNC is a bug, as the
later references a VPE that has been unmapped by the former.

Fix it by eliding the VSYNC in this scenario.

Fixes: 64edfaa9a234 ("irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP")

Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
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


