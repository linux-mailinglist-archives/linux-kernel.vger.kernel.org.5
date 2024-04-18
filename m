Return-Path: <linux-kernel+bounces-149914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068498A97D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892D5B21AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AA15DBB9;
	Thu, 18 Apr 2024 10:50:53 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5015E5C2;
	Thu, 18 Apr 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437452; cv=none; b=iPNiuK8bnI+Db+QrePvZJa/ATiM+hcwKYeGbM7rB3lkQoN/AFlG7uFkN9eafJToojiLYe737CkVDJu7/mpCQkIm+oVq2qdxkTg+smY4F5HKlTfSmw6PoB9rcap43Up8ptHmT7dO7/3117tBQjqh03ovu/kuVEbGG7JdSlC8D1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437452; c=relaxed/simple;
	bh=J3xx7uCwxqDnvOjB2f/TyE777o+chO9jhWnCFlaoiFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohVEQ6wscHn9LCTXkMruryKKIIlEybuJkC6xYlelgRKQHs7WOQbTZwc9cOpH6FL4++3RfKuQiOUD3iEcmwkLz/5yYUYWYrGoRtuLACJVAdGfJRE+shDsXMtrmRrkOhU3QLekQV1JW1ud3PLexEPEztbUHR5flob4qfYvwfo8k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1713437417t2k4rod7
X-QQ-Originating-IP: xKe3o2C9ma2R+1d5dsTNCS/zyXVEzyvuAGXlGycOrdo=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 18:50:15 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: su/QXNoXt7e/p5CGMAB7Jna4tdXuXnqktS4kyE2F+fHRJZoFhysXwhQXOmysx
	2G5xGDRg+plZMZYup/7yt2X+c/jqRbyH6L0zo/X3ebLP/yFpANVoN53w87IXQbodjyQ5oa7
	avhnND3huZSZk2cIIE6pqgkpKGHvrB0JQKZN0UK5TxP3KJQlkrdbbXRRdtPuD3STXjjo09o
	Y0dL284Ff7PMEzjmoQP3dhQT+1YznLv/NbkPxo/1xPvLHDGmHx7spdYLr49OJB8+Jv9tuy7
	MrQFBe2F47XBRcdk7DtL0Sn0bRx4QQPcC+TTWEyizqsrD8DF+sjbTBn1Q0F/cpmZx62c9YM
	0bXte7ShiU+h65aJr5SWpAoHwnQbDL89ERqA3Wfx7gV9rRm/upyNrQhA6S8uy5RI99jq8l+
	WQnbUM/+8wvVcDvoLXL2pg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5834365455261671018
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 3/5] sparc/of: Remove on-stack cpumask var
Date: Thu, 18 Apr 2024 18:49:47 +0800
Message-Id: <20240418104949.3606645-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240418104949.3606645-1-dawei.li@shingroup.cn>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

@cpumask of irq_set_affinity() is read-only and free of change, drop
unneeded cpumask var.

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


