Return-Path: <linux-kernel+bounces-156184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FB8AFEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E165D1F22E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A37144304;
	Wed, 24 Apr 2024 02:56:59 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F285274;
	Wed, 24 Apr 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927418; cv=none; b=RxZqT6wmoVLavsPSXUVlltUeDQlN8ePkLzhbTYN7C1FrdLO4tW+c8hCVQf70S4EhJMUkHbDw6U73RhWi4UpicFVc3PL/qhlQS1R7wtTMKkUp/waWTYRpqPK/Sk8kzhWnIWk3dYplyWBb77ofhbPlkOd3pT5CGNbldwwEnITRQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927418; c=relaxed/simple;
	bh=3q4wkwdzr6bsl7CdF20gWvsb13iPgTuP0auF/wmr1+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZPZfaRLxKfE/2cKRQKJe7FbARgOKNNaDMNpgbE2YA4vZyEvrQQH7Kh1tlrxhByLqPfgc3HJT+iQlx6IxrKBYwO0cnXZ/TUSDyJPrCPXBtSNeKPGxIGOYVv+GP1GgxI4+IfTd4U+8MDz3Cu5qY1bChN+klToeFwP+Cyot2NcKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1713927373txeesovm
X-QQ-Originating-IP: RafR794jN92WUzpCABktLdB8zk7MggSEa+h1HLA4pRk=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Apr 2024 10:56:12 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 6MxOmYknsnlk+EvuqNPJydCUebOjjfGQngzxgv3iiMZC/5aK751EwP9r+F8i+
	bH9DoKtFsUp/87eM/1WVZzyRE2NN4/1YfQsuiOJUXMdwDslas0+TN0BjT+VlUpBiIqTGE6m
	/dq6tlAV8/cwazZ7Arvv2NsDoxeFDiADlngWQdLr5U5RgI/MpVehjBcakGq0sviZke76/uQ
	VhpWfut99UyslE/Kp2uvK0JNZhC8VPtHnUYrmB4nQ0k0vDQjCF50z0BRII1fyp0zQVNTurk
	PumEGM4FTgnOicwjqBqWFntmiZUVPAf5U7kq51MvgBwz91jX/Ge/3Pr27yOSbRlmLZQAvmO
	XOnBPEhDEKWngvq+vVGMamH1OOO3sbUsz1W5/FCt0VccXivhBgtSDKNnjHSXv8vHTG+/pMU
	xXYaKM56jpkqMm/eMwrf+iZeSOUCT06u
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8021827342633474305
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v4 3/5] sparc/of: Remove on-stack cpumask var
Date: Wed, 24 Apr 2024 10:55:46 +0800
Message-Id: <20240424025548.3765250-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240424025548.3765250-1-dawei.li@shingroup.cn>
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
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


