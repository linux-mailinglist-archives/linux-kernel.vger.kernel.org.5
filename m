Return-Path: <linux-kernel+bounces-106157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF02887E9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716E0282BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E254654B;
	Mon, 18 Mar 2024 13:23:29 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88FC45BE0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768208; cv=none; b=tR81v+TeFxhAp3OJ6U+yDBXJSKGKqzLiJBEGYFx/CIrf3CW8rbzTZIFbzLJOw7O1gLgHaOPSkErGwcS1ljaffvMvybD9JJPnwLaXxqr5eaZrTkBTGN/zxivHvLxvNETvz7mLcq3yTAk6ffnKvmgCw5lKL3GCslDjSRMbElGTT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768208; c=relaxed/simple;
	bh=sVMQ2WwTDTCT3C55Gs/Vv2ttOOQ2sw6WqofWzGXj7rw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RN906jNHcxU172dlb1LlcJoyZw2U0pV5du52rdPSztx0XXMAxAitUTfI0iXW9ztlo+MYTa8DruZ90XRUacFPKxcx1IDJi19K/p9Fp3+AUlqQKqDXs1OFPByYIlSLp1rADAtYh9FFk50tofqc2l9GxUzThP7y9XIreTMlb2a3HZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tyvn24Vhyz9xqwm
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:49:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 370C2140121
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:05:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.220.121])
	by APP2 (Coremail) with SMTP id GxC2BwDXECX4O_hl1WCFBA--.53744S2;
	Mon, 18 Mar 2024 14:05:05 +0100 (CET)
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
Subject: [PATCH v2 0/2] swiotlb: allocate padding slots if necessary
Date: Mon, 18 Mar 2024 14:04:45 +0100
Message-Id: <20240318130447.594-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDXECX4O_hl1WCFBA--.53744S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr45JFWkJr4DZr18GrW7Jwb_yoWDCFc_AF
	W8JrWUAw1DZFnYyasagrsrArWvqr4jvr1xCa98XrsxJry3Zw1fZ3Z7KFWjqr1UWan8CFn7
	tr95WryxCr17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v
	6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28Icw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0piG-enUUUUU
	=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
covers some bits in the original address between IO_TLB_SIZE and
alloc_align_mask, preserve these bits by allocating additional padding
slots before the actual swiotlb buffer.

Changes from v1
---------------
* Rename padding to pad_slots.
* Set pad_slots only for the first allocated non-padding slot.
* Do not bother initializing orig_addr to INVALID_PHYS_ADDR.
* Change list and pad_slots to unsigned short to avoid growing
  struct io_tlb_slot on 32-bit targets.
* Add build-time check that list and pad_slots can hold the maximum
  allowed value of IO_TLB_SEGSIZE.

Petr Tesarik (2):
  swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
  bug: introduce ASSERT_VAR_CAN_HOLD()

 include/linux/build_bug.h | 10 ++++++++++
 kernel/dma/swiotlb.c      | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.34.1


