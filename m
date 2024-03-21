Return-Path: <linux-kernel+bounces-110485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F1885F91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651C7B2626D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F3812C814;
	Thu, 21 Mar 2024 17:19:55 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5685280
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041595; cv=none; b=f0kCg1M2SDPlmCU8uevHr6A4EqkHxGe5hcOg7Zka1AUPRWNlze91O09FzjCAIzePlf9ti0sBu0RTbbeJvX6dj/YUtibwyQBrkSM1TCOdF2m7C0zfuVbDMU3IoOXlNqOEQSr4GtkpbAxSwmxaT9OoLicJbA0PjC2TXF+9vo+Ev1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041595; c=relaxed/simple;
	bh=u1+YL1chG1fDzrnBGltFxRHMEuYiPqoh/58IrrzbAxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ah6xIMvExd8uOwUXZr9VqflCQ0Mm9N0DdzWvCvOhN9L4b6lErBFj2HPGWCHOMYAgnsadPZrkzFcyiTK8/9aDLCiCnKA68+BtlO41ojrBGgbOhS4Wj+FmNl7XD0PqJWNyYyCX9wQ6h5SMnG0M2gQv0DhU0W5/Exb/liHgaZCvLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0sHP02Mtz9xqpf
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:03:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 53797140390
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:19:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.213.73])
	by APP1 (Coremail) with SMTP id LxC2BwAH_BQNbPxlII6+BA--.51964S4;
	Thu, 21 Mar 2024 18:19:38 +0100 (CET)
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
Subject: [PATCH v3 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Date: Thu, 21 Mar 2024 18:19:02 +0100
Message-Id: <20240321171902.85-3-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321171902.85-1-petrtesarik@huaweicloud.com>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAH_BQNbPxlII6+BA--.51964S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1xKw4ktr45GrW8tFb_yoW8WFy7pF
	9xArn5KF4jqFyxZF12k3srCF1fK34v9347Cas0gryYvr17tF9aqFWDKrW3Wa4qqr4vgF4a
	kw1FgrWYyw1UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUzWlgUUUUU=
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
index 3779a48eec9b..8256fcdc0cf6 100644
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


