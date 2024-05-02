Return-Path: <linux-kernel+bounces-166725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052038B9E91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E55284FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FF115E7E5;
	Thu,  2 May 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="I6UL21IF"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0515E21D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667343; cv=none; b=EyP23NT00Swu5MTpXnw7ulZwc/1lrjULxox7CLGRYFILVB17L3GiGoLtJIpa93KTtOa7acrP7kEwMzjhkz+MIbOJbzHIkBAW/KB7iPzM9e7SGg9QkQNzp5mqXkXlaBkYIcYP9rcOVMIWlpI+M46I+W7UtCADQ7HXgr6OrHd+SPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667343; c=relaxed/simple;
	bh=BGWSwT9yiF+j7TOtTdcFLHTYs8xxX0tEDdj13yc+gxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxvCgy2gHaeB+4s+EBOku1UNb/1xG2Vkbb/bmnDNr0gKQz0j670Ak+YHqZntjHTn8JKzhaRhP1eQgCSq1lawakyLvzFJ3F+6K8gi2uM4HuFBgbkYys7lZTE19ytwDtKtfIWwlfa+6qUK5H93NJGq7+Xt5Ux1OFJSq9BjuVABbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=I6UL21IF; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0.intra.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id D0F7A4078513;
	Thu,  2 May 2024 16:18:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D0F7A4078513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714666731;
	bh=P260cdiv+ihyWABy6txYbc6wGpl+ovNNv3lvJc3fgaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6UL21IFhgt4k6VRfCylGP7XwUFuvSQDfKIeNxEN/w85gytbDkFB5R1kJoZHiyxkb
	 J6A4MpYU8ClKz6CLjcMxxPf0m3S7GqTpBkRQ5xOANg9iNygKXADiYjrkJAIdiwu6N+
	 /Kk74v7OJk1431rlvWwU5zcVKWGbJ1SMZJpMiLFA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 1/2] dma-mapping: benchmark: fix up kthread creation error handling
Date: Thu,  2 May 2024 19:18:25 +0300
Message-ID: <20240502161827.403338-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502161827.403338-1-pchelkin@ispras.ru>
References: <20240502161827.403338-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a kthread creation fails for some reason then uninitialized members of
the tasks array will be accessed on the error path since it is allocated
by kmalloc_array().

Limit the bound in such case.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e..ea938bc6c7e3 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -118,6 +118,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		if (IS_ERR(tsk[i])) {
 			pr_err("create dma_map thread failed\n");
 			ret = PTR_ERR(tsk[i]);
+			threads = i;
 			goto out;
 		}
 
-- 
2.45.0


