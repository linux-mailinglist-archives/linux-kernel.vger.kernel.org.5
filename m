Return-Path: <linux-kernel+bounces-34625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795FE838503
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917631C2A47D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8867C09B;
	Tue, 23 Jan 2024 02:07:28 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1ED7A737
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975647; cv=none; b=TbNBSmn4PLPBD+2UBAdqu6QSc7bJlynq2qAFd+YvmvRn6Se9k58cpAPvn5fBiULkjMcwZ4Q4iUUmL478LYq0/Z65fobqZm1PVDSacHMVoJxM4lsYoAa4rXzhnlu5qUu/Iv9uBcopx5LPBcz5qoCwz1zgFUeuSDP1ZPHyp8gxVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975647; c=relaxed/simple;
	bh=i8XZbJ81fBFIDUQE1pTnGiBnGeAvnlapZf4vuAhH/i0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sx1SsrDhaHjMwvlbKveASJvI4gdhBqABNhgpJDsC5BDxc4jUAPTekNIR+ZzLnwMyDn61pWPUf0Q8JZZJA9n99qG4DXuFXtGM8oyZK65/m8zAxLfGeJXfn0toHPXeOnhEADRTQYIuTA6oXQXEiz0xThzKarrKLdqVe9MAPkniCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TJr5m3ddyz1gxwK;
	Tue, 23 Jan 2024 10:05:32 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D06A140416;
	Tue, 23 Jan 2024 10:07:15 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:06:00 +0800
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To: <npiggin@gmail.com>, <aneesh.kumar@kernel.org>,
	<naveen.n.rao@linux.ibm.com>, <christophe.leroy@csgroup.eu>,
	<mpe@ellerman.id.au>, <christophe.leroy@c-s.fr>, <xiaojiangfeng@huawei.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<nixiaoming@huawei.com>, <wangbing6@huawei.com>, <douzhaolei@huawei.com>,
	<wangfangpeng1@huawei.com>
Subject: [PING PATCH] powerpc/kasan: Fix addr error caused by page alignment
Date: Tue, 23 Jan 2024 09:45:59 +0800
Message-ID: <1705974359-43790-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


