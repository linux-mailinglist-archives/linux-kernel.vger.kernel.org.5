Return-Path: <linux-kernel+bounces-154689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C895D8ADFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80452282C07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201854FA3;
	Tue, 23 Apr 2024 08:31:53 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47858213;
	Tue, 23 Apr 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861112; cv=none; b=Umf6r4k+brUqX0u3w9KQ4gCddWsFu0L0i9jqdY1HP1w2jWYAbjEYiPlOy8g+8KHLWcEN2ZAmbW25khTVrWHdeQWF0q9DjMXywf1GRnwAzAKfhZUxoHiGD6JwaRHDNJCNQJ9KZwnH9Vv9aVs0JPAoqw+BnMd/7tbWInYUTZQS7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861112; c=relaxed/simple;
	bh=3q4wkwdzr6bsl7CdF20gWvsb13iPgTuP0auF/wmr1+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhTcTMEmdJpp0pil0qwgoSL/Cayy9YOsAi0ckVeInmarfg14n4gYBae49Vg8nfoO5cjf8ENL2Wype4G76ywu3MKCeLMzD/EzNuiQFpVPNRFIhONopkvdeguzXq348ZqmVUF+WWv04ffsoXGzggjsHNqX+tt05txf1vv5ZTxUBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1713861078t9g3en
X-QQ-Originating-IP: oo1v9g1UtXxlA5P1iYVb8E7jef9d9GmSEbpxs51XuO8=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:31:16 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: LrCnY+iDm+P5Z9oGsxBC2K7ubRX/nU+qwaMKFow8WcrOZH9Cxb6cg7RaCKgdz
	Sn+IcGtj6G86Ab9NYh1gNqo0GN/ErKrN6fnPUIeun79VC2V19aAOQ4d6frfB4pifDSUTBRG
	uyV1t607EvgqnbBR2gANaRBJ7UxOvUdSXcNlPIj/Gcqe6FANpeyLxo8M2u45bfLb5trB4QG
	uxgEh1CNRjZH4iDM2+TJESzxhgTypEX85EXz0p3nwpr5K9aAVHX+dP1OowLq7LEQQMHhl8I
	2Qta+lMbPEC3QQEbRHhDnRk2+OfzVeEbYjyLe6N4dwoda2683nK6ERpg9VOePwtqSfaH3X/
	84TFHyKe8tuSB5rH7qqNiHBa2Eo1sYUhpp3PE4vwrlfjtFzcgXNK9Ifar23Y9T885evATS1
	jd+7qW3oxKwDHv9GeKPCQB9BSGmnlUa2
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5733590401528816768
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 3/6] sparc/of: Remove on-stack cpumask var
Date: Tue, 23 Apr 2024 16:30:40 +0800
Message-Id: <20240423083043.3735921-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423083043.3735921-1-dawei.li@shingroup.cn>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

@cpumask of irq_set_affinity() is read-only and free of change, drop
unneeded cpumask var.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/of_device_64.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index c350c58c7f69..f98c2901f335 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -624,10 +624,7 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
 out:
 	nid = of_node_to_nid(dp);
 	if (nid != -1) {
-		cpumask_t numa_mask;
-
-		cpumask_copy(&numa_mask, cpumask_of_node(nid));
-		irq_set_affinity(irq, &numa_mask);
+		irq_set_affinity(irq, cpumask_of_node(nid));
 	}
 
 	return irq;
-- 
2.27.0


