Return-Path: <linux-kernel+bounces-78443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AFA861393
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D6D283FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E181AD5;
	Fri, 23 Feb 2024 14:05:09 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513B81AB5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697109; cv=none; b=UZ3snf3di+BqtdJOyVS+O2vO9tC1uvOs7cqNvWuBrOy3R2+EkRwPMG6bWgkg4mHHs9fLGGzV+OMBcr24VmUO/S918yCYPnbIYdd/S4Q01EtDSlXH/ykBD41GNT5C3UzGOibXbylceeR95sK0Zx2wBjmLtHkzffcY0oaBO0yXaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697109; c=relaxed/simple;
	bh=3pqc/pxRYqV2lohhwBLkMpVmkZWPaHZgO2ezrk/vsfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mkM0JSd6XuF4wfLE/uiMYH2BbaIwXSi17TJp+otArZ8sgdhpnnkidot3uxt/CtKhAidFemgRdTPs59eZWEXoQbgNSqGNip8ooDTbF7nWjxGhm+TRDlHUGVLmIUHgs2GkopKUU7tnvPxOQdJ3Oeig1IJWnGzNYVN0RM2F8dOgCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4ThBFl05nFz9y3Cc
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:49:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E866A14042B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:04:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.218.207])
	by APP1 (Coremail) with SMTP id LxC2BwC3YBkApthlMxERAw--.25951S2;
	Fri, 23 Feb 2024 15:04:55 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH RESEND 1/1] um: oops on accessing a non-present page in the vmalloc area
Date: Fri, 23 Feb 2024 15:04:35 +0100
Message-Id: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3YBkApthlMxERAw--.25951S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1rCFykWr15ZrW5KFg_yoW8GFy7pF
	sxGa1ktr4S9F12ya9rX3s2vr4xKa4kt3W7CrWDAw1Sva1j9F1fZrWakwn8Aw109rWrGayx
	tFWYyryjyw4DXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0264kExVAvwVAq
	07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUj0JPt
	UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

If a segmentation fault is caused by accessing an address in the vmalloc
area, check that the target page is present.

Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
assumes that the fault is caused by a stale mapping and will be fixed by
flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
a guard page, no mapping is created, and when the faulting instruction is
restarted, it will cause exactly the same fault again, effectively creating
an infinite loop.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/um/kernel/trap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 6d8ae86ae978..d5b85f1bfe33 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	int err;
 	int is_write = FAULT_WRITE(fi);
 	unsigned long address = FAULT_ADDRESS(fi);
+	pte_t *pte;
 
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
 	if (!is_user && (address >= start_vm) && (address < end_vm)) {
+		pte = virt_to_pte(&init_mm, address);
+		if (!pte_present(*pte))
+			page_fault_oops(regs, address, ip);
 		flush_tlb_kernel_vm();
 		goto out;
 	}
-- 
2.34.1


