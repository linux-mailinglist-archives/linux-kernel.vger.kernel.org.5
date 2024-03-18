Return-Path: <linux-kernel+bounces-106144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C564187E9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6685AB22120
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569803BBC7;
	Mon, 18 Mar 2024 13:05:35 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAB3BB35
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767134; cv=none; b=E8563Z+ICv6yvul6EBxxv4sy92p/S3J4+XZDhSen9rfT4aqER1dXROoIuSJCkmM9CN0edwHDrclQ8WuajOFp8XAahg+Rw9JzqsrZ3NPbgdGrV0Rq/lGFBdlVJZjZTwe+S/xrRc4wQkjP502VfvUojuqlgvaH+RNAY3onZhTg0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767134; c=relaxed/simple;
	bh=j+WvT6VY0MWDb1dtFDjX5MTHHdryLEFjoY3E/4msKTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXGIvaTqw3KeYC+iHCZdZWUtNtwAA+ZYQISXyXFWHXUdv5QOh3YkSd0W2FYm67l+tp8Owfd8wetVaYQJAFnfIOYvWPGjuytY+nCnwQXJo2q1sWuhRjbYKdNmGg9ZYWggzKTuvSMYvwCfQWsY6ifSLc8x6pNXY6aqgxpNvfzViSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TyvnW0CPLz9xHvb
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:49:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DAAFB1405A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:05:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.220.121])
	by APP2 (Coremail) with SMTP id GxC2BwDXECX4O_hl1WCFBA--.53744S4;
	Mon, 18 Mar 2024 14:05:20 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH v2 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Date: Mon, 18 Mar 2024 14:04:47 +0100
Message-Id: <20240318130447.594-3-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318130447.594-1-petrtesarik@huaweicloud.com>
References: <20240318130447.594-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDXECX4O_hl1WCFBA--.53744S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1xKw4ktr45GrW8tFb_yoW8WFy7pa
	sxArn5KF4jqFyfZF12934DCF1fK34q9347Cas0gryYvF12qF9aqFWqkrW3WFyvqr4vgF43
	Cw1SgrWYyw1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0piQtxsUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
variable can hold the given value.

Use this macro in swiotlb to make sure that the list and pad_slots fields
of struct io_tlb_slot are big enough to hold the maximum possible value of
IO_TLB_SEGSIZE.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 include/linux/build_bug.h | 10 ++++++++++
 kernel/dma/swiotlb.c      |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 3aa3640f8c18..6e2486508af0 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -86,4 +86,14 @@
 		"Offset of " #field " in " #type " has changed.")
 
 
+/*
+ * Compile time check that a variable can hold the given value
+ */
+#define ASSERT_VAR_CAN_HOLD(var, value) ({		\
+	typeof(value) __val = (value);			\
+	typeof(var) __tmp = __val;			\
+	BUILD_BUG_ON_MSG(__tmp != __val,		\
+		#var " cannot hold " #value ".");	\
+})
+
 #endif	/* _LINUX_BUILD_BUG_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aefb05ff55e7..0737c1283f86 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -285,6 +285,8 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 		mem->areas[i].used = 0;
 	}
 
+	ASSERT_VAR_CAN_HOLD(mem->slots[0].list, IO_TLB_SEGSIZE);
+	ASSERT_VAR_CAN_HOLD(mem->slots[0].pad_slots, IO_TLB_SEGSIZE);
 	for (i = 0; i < mem->nslabs; i++) {
 		mem->slots[i].list = min(IO_TLB_SEGSIZE - io_tlb_offset(i),
 					 mem->nslabs - i);
-- 
2.34.1


