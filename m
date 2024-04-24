Return-Path: <linux-kernel+bounces-156181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C058AFEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9BD28575B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263A84D24;
	Wed, 24 Apr 2024 02:56:48 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AF142E9D;
	Wed, 24 Apr 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927408; cv=none; b=QbSlL/94YhD/RAk0CKA7qpkeRJ3ae7WqFlQPc0wNSSdPZ8zSEARNi7/viVQ3bvQrH/4X1/+GlEFrXBcVPLgDPYyajruuVWTnAY1Ksrm3EkIkEo4itfVqd3ubV9KhGKxNZvUE0JPmMxgHYgW+3U260Yq9mWuvFP1MFwN43p8ZEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927408; c=relaxed/simple;
	bh=j26qiSSL/SsQJ3RIDKCP/7AkspKH1HFq2LoNpDQ+AE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8wdWOfqWebo06HCTqsDu5Jh5S/aOyP4FKsFx4lh52M7Z1FzYo4k3YhpHzSRvuoYwJGUK1L1pz7guqZ+plZFOzP20q9Kfb/W1X4GbOS10eBZzAN6jmxDFlCF68h7PYGs4CVnsQ3GrkpwGmOkuNZP6wAjPPJ+r17idgBLJEJpN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1713927379tfy09bc
X-QQ-Originating-IP: 2Y46ZsfS8TiAWhD15nAchyw47WXrXxioXt00IGlBVCE=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Apr 2024 10:56:17 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: fm3u6yrcHUttQI+skDEKiZYLMDN8WIG5UvAUyFEu1vT01wH8FXRlNDBWALWja
	7TR7LrgwZktkn2IpxneBpS5ysyXVQOjEurCYQCKoPei9H0EHmUq4iATC/5/zb5i8pjgMZE1
	VhCJQBrXh1pqrhcKlGCqi4AWNnYJci7fd1YtFDRYB8ZWOp0M4IvdzSUCgaATAw7rK+ddTY3
	GONiDRfOApPTuLaDTwYK4iLGir4fsQYUZbnGb99eYWpJC5qyltOdNx2ffoOj+uCOf6Io1ro
	PTalqFx8vXyESbXPUWKhNxYTuPPYSh48J6mH8IZmaiQB6509hw6GZIXbDqi+084MfZLytEd
	JVprMiqW8VfXyMXMh7sZrKINJXrUTRtfqYaKs7ArV3h0FAnbqMGD8PfgvnO8+N39aFg76Cd
	f40Exugzedg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4302958687084006626
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v4 4/5] sparc/pci_msi: Remove on-stack cpumask var
Date: Wed, 24 Apr 2024 10:55:47 +0800
Message-Id: <20240424025548.3765250-5-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

@cpumask of irq_set_affinity() is read-only and free of change, drop
unneeded cpumask var.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/pci_msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index fc7402948b7b..acb2f83a1d5c 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -287,10 +287,7 @@ static int bringup_one_msi_queue(struct pci_pbm_info *pbm,
 
 	nid = pbm->numa_node;
 	if (nid != -1) {
-		cpumask_t numa_mask;
-
-		cpumask_copy(&numa_mask, cpumask_of_node(nid));
-		irq_set_affinity(irq, &numa_mask);
+		irq_set_affinity(irq, cpumask_of_node(nid));
 	}
 	err = request_irq(irq, sparc64_msiq_interrupt, 0,
 			  "MSIQ",
-- 
2.27.0


