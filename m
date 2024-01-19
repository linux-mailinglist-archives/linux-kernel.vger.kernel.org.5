Return-Path: <linux-kernel+bounces-30811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC483248F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2441C2278A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A588539A;
	Fri, 19 Jan 2024 06:25:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD61392
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645542; cv=none; b=g/wM4Q2o8qbBq5VDxrpMUVC9U+1iltAolRfJZ11xQgjT1VQsAf0Ra1lbN2MPzpg9niBoMYKHyGw6CXOdRoAbyPC8fS0gOQRkgWefxRdFfZjBsOCOL0dFxLb0mV3Si1UoAvxjBK16pv1ocOnZkuRE20Si6dPazRvA6afo8v4J63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645542; c=relaxed/simple;
	bh=i8XZbJ81fBFIDUQE1pTnGiBnGeAvnlapZf4vuAhH/i0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X3f7Ho7MMao4QOgVh0ZVIKWlCx3+ljrLzjdVmjn8Rm47EpIWG2MavNhKATpkk1QaSQ5GzNHJqPlFa86Ru9Rp38rjVLYJX9qRPBe1Rvej2ujONB4QJVViw3NqI/epnhtU3uAGnonILz3xe/zyYXs0haTyj6WjzVjJtRElxXf9X6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TGTyl1RKwz1FJX2;
	Fri, 19 Jan 2024 14:21:19 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FA22140684;
	Fri, 19 Jan 2024 14:25:35 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 14:25:01 +0800
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To: <mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<aneesh.kumar@kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<xiaojiangfeng@huawei.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<nixiaoming@huawei.com>, <wangbing6@huawei.com>, <wangfangpeng1@huawei.com>,
	<douzhaolei@huawei.com>
Subject: [PATCH] powerpc/kasan: Fix addr error caused by page alignment
Date: Fri, 19 Jan 2024 14:05:13 +0800
Message-ID: <1705644313-10627-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)

In kasan_init_region, when k_start is not page aligned,
at the begin of for loop, k_cur = k_start & PAGE_MASK
is less than k_start, and then va = block + k_cur - k_start
is less than block, the addr va is invalid, because the
memory address space from va to block is not alloced by
memblock_alloc, which will not be reserved
by memblock_reserve later, it will be used by other places.

As a result, memory overwriting occurs.

for example:
int __init __weak kasan_init_region(void *start, size_t size)
{
[...]
	/* if say block(dcd97000) k_start(feef7400) k_end(feeff3fe) */
	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
	[...]
	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
		/* at the begin of for loop
		 * block(dcd97000) va(dcd96c00) k_cur(feef7000) k_start(feef7400)
		 * va(dcd96c00) is less than block(dcd97000), va is invalid
		 */
		void *va = block + k_cur - k_start;
		[...]
	}
[...]
}

Therefore, page alignment is performed on k_start before
memblock_alloc to ensure the validity of the VA address.

Fixes: 663c0c9496a6 ("powerpc/kasan: Fix shadow area set up for modules.")

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 arch/powerpc/mm/kasan/init_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index a70828a..aa9aa11 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -64,6 +64,7 @@ int __init __weak kasan_init_region(void *start, size_t size)
 	if (ret)
 		return ret;
 
+	k_start = k_start & PAGE_MASK;
 	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
 	if (!block)
 		return -ENOMEM;
-- 
1.8.5.6


