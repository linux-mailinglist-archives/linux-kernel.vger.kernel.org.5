Return-Path: <linux-kernel+bounces-44336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E897842066
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D771F2BF47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB882679EC;
	Tue, 30 Jan 2024 09:57:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D466B24
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608660; cv=none; b=LcNAOCj6V9POIsJEGnoDYUQ2qlxQEWRbam8R80JbSZA2e7wNhAIMxp/GrIh1FkgeMbfTN+gFyLqyViGgf0OuqMFGEY+RoDA/Z86yrV1s+B1uf1xFKod0XcI/yUIB040i+m7R/3bLbgUZmd3+6eZ1LmgtG92wFSJ74UjOZDhhtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608660; c=relaxed/simple;
	bh=YD2kWtvkZk3mAOQpGATJUTtc8GxT/nSj+syfnly8mH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m4tJQq/mtwCv54xgik7rJb27ETc/ARQ1yj7Z4ZumAsk2owr2fbAAHiepS9/z2I0Y8PF74HrgtDDQzWkgdwCIO2v6agbWsx+6ieV2VvfDcqBgp1XdeIrlfwrcGmKKxybpCBduIYFk9SBBKgf1KfftpGoX14+Kp4CJd7sZdB3IF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPLF26P6jz4f3nJd
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:57:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5E8C41A0232
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:57:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAHJQ4LyLhlP+O_CQ--.6931S2;
	Tue, 30 Jan 2024 17:57:33 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	revest@chromium.org,
	rostedt@goodmis.org,
	mark.rutland@arm.com,
	arnd@arndb.de,
	pengdonglin@sangfor.com.cn
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com
Subject: [PATCH] arm64: make member of struct pt_regs and it's offset macro in the same order
Date: Wed, 31 Jan 2024 01:55:04 +0800
Message-Id: <20240130175504.106364-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHJQ4LyLhlP+O_CQ--.6931S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1rZw13tr15XF4kur45Jrb_yoWDKrXEyw
	47ta4UGa1fK34Igw18t3yagrs2k3yrK34xurWxtrWkZFykXry0yw1xGrn3Kr1DWw17KrW7
	A3sIqFyYkFy0yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
	k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyU
	JVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x0pRQo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In struct pt_regs, member pstate is after member pc. Move offset macro
of pstate after offset macro of pc to improve readability a little.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 arch/arm64/kernel/asm-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 5ff1942b04fc..865ba901c233 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -75,8 +75,8 @@ int main(void)
   DEFINE(S_FP,			offsetof(struct pt_regs, regs[29]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
-  DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
   DEFINE(S_PC,			offsetof(struct pt_regs, pc));
+  DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_SDEI_TTBR1,		offsetof(struct pt_regs, sdei_ttbr1));
   DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
-- 
2.30.0


