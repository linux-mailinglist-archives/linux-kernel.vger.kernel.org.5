Return-Path: <linux-kernel+bounces-152144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBAF8AB9D0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518411C209E7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846714F65;
	Sat, 20 Apr 2024 05:16:48 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE89E55F;
	Sat, 20 Apr 2024 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590208; cv=none; b=Ofcs3vorNw+3gICfl4iILo8uU0Z5Jbd5DyabAhHsF9U4UeE3TyVpp/OJp/joW2T3IW48sOFLkBQvw9Wfgb/Ex6xbC4JWt7ns5dDRzfDMzdxNxrZ7bMx2yTxxCYcz1BmgOTBmZNLFWK2ehUK+9XHFUxnq1smubneRfBcJDncIVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590208; c=relaxed/simple;
	bh=J3xx7uCwxqDnvOjB2f/TyE777o+chO9jhWnCFlaoiFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNxWQFsUIuS5z9WwhBnO/fg7D0yXvxOVCCdJoZ9onUTH3L4pidKQzqjMY/K3L2RnKt6T/MHzaefrU8mUbcPZiWh2gBMJsjOcC6jDOmtqLsGzAd+OXcWqe1YyYGD8YHGK/rucZjB7Lk+wtFRpQGX6HXYxlA+ZiJW7XCb9KIjhT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1713590173tizhh7rd
X-QQ-Originating-IP: 8MtURKbY14c/8/zzXdbr2mv34MhaCyJmjCscKsCI8Ts=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:16:12 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 7YFKcddXagjUdEvd7pTyWsQ4VLtezgpliaI64kOzXjRCa35JZRCrMEOCTqGhV
	qng8CLtYjSU4vPeW/USn80ZBPzeHD5ntGK/QkI3/6S9881J7o1Sr7qqwipZAPGvAVaN+oDt
	nV3xJ7A/0dPzfaKjQZ379/v77zl5nQmZHQekOCI7hu3vHu622JrM1p3O7AlmMnNzCkwRGd0
	FvyLmQgGhK8b8nhCbcis+qaayFaQOURFPBTQ7M8aYyryM34uJR0VDbpjNXmxjbKfzz5pdv+
	FQ2JVxjwjsRwWJbz53Tsqvs0xQIOEjZkPtuTAYUlM3d9FGu6UWzBrzmXqc0ecBpSrMZtasp
	VBavlsaY+kUu7+IcSbIMKs4afXgfFL/Sd/RkWjRNsMd5JjNVb3dkYi3lVtr/B9jUbESTkJ2
	jz5FYmU3rfc7AT47u3FsPw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15600578157613225618
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 3/7] sparc/of: Remove on-stack cpumask var
Date: Sat, 20 Apr 2024 13:15:43 +0800
Message-Id: <20240420051547.3681642-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240420051547.3681642-1-dawei.li@shingroup.cn>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
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


