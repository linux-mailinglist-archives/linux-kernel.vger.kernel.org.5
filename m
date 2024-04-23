Return-Path: <linux-kernel+bounces-154690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6D38ADFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE891C21BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32255C2A;
	Tue, 23 Apr 2024 08:31:57 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5754FAD;
	Tue, 23 Apr 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861117; cv=none; b=Bxd/lc0Q0IWOBMz5qdeessvWvVmsm5XaxnRynVmCYGgHUd387NlXUjgp6YjL9k3YRU1+1/3lU6qEENxil4rMWLr2w8hr4pp341Ad5tPnH+6Nv++AGmiazBhNDysytwBUdLaoZzDeHDBNDzu7AGZiSgxl/mhCJ9hs7t/BLShTQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861117; c=relaxed/simple;
	bh=j26qiSSL/SsQJ3RIDKCP/7AkspKH1HFq2LoNpDQ+AE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mlgjpgmz5drGQoMJaUJLk0T4ZAUtbrwbT4goi5uFVi2ecoONe/fZ89GhmS9lNkgswpPFiDbaXtpGjx9psAf+3s1cnyCavU7QqZj+mRlK2yYhIVhhtVAPqmGB5zr3Q0bbUtFHrezaurlyI+n8cdeLomP5YQGZFS3K3c396FogX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1713861083trzeblda
X-QQ-Originating-IP: kv1ZmXjt1ON8o7UDJCJT8yqN8nFiT1WeTFRAy5VFkDk=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:31:22 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 9GmJvWU2rBxyUWLB+viF7MgQDFd59YNLn9ApIRMx48b6m1Q6ZqTYLN/MTavQH
	ROG5zX6sxbwaPJjPwossOL84vpBqVP0morJV0BjcGnQEMn98GPEdQAzBoP+lHV75KZu6pMk
	GKMTAJSHuDW0GtUzGs2zzRprBgajp+Y4eKF2WXNMnL3Llhf6/2jlqwnIMbWJ3qIF/Q8hFGv
	1dcYyzZuTLyXnbrWMqvoYcaFKxN5FBgDnKksdZfsm8a5Ye98PrQDReFMyrCCVaSqRZrMzXL
	vLOoJyJ+CiJh0YZ3h6QtW/JFREWA9urn3FEHM5BTmlq87iDtxzGBEbsONq4Yfqe8W8oyTSg
	M9wulzBYcUkaK1wJOR/SiZJgz7PXxZTuoiQecSUi0tKhDFz7hJ/FcaOGasKzvh8lVIn6PSw
	caSERtx0552JSpvkDHjB7oUi3vtfQ3HS
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1692039969414298604
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 4/6] sparc/pci_msi: Remove on-stack cpumask var
Date: Tue, 23 Apr 2024 16:30:41 +0800
Message-Id: <20240423083043.3735921-5-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

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


