Return-Path: <linux-kernel+bounces-154692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74328ADFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4BD1F21E77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071A59173;
	Tue, 23 Apr 2024 08:32:03 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24E5914C;
	Tue, 23 Apr 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861123; cv=none; b=iQETiklktwg7RvrvrxEAA5ensJ8HixPfn4VkYQpkEk0++E8vh6q8clRpe+bhAOqVEai2ANXJNuyilfF7ZnhgvG81/xig+xMa4VnEEWAlKGkx9G2XSh90oXASAv1589GqobZMFqq/DnU/4GTo7aecNhhbdKaooMGlvjMlIZsjP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861123; c=relaxed/simple;
	bh=/BNrLKrkj1zztdJw2Le2jc+2s6d9f8gUuEhcw02th40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqqZ93bDJADras4TJCD6Ok0P9G8a6bxOBiQVa1K3ahuECs1c8s1oGB1mPzSEU1djIrOJuJToMjWYQVMnDYfEwXaDmFK6HgSdD1zYIllpFGThZhxHHMKuxwpJyvhRxfBZ2XVQAxZk7ldC8H9lNsV/RPwxTrBIEn14QiPuJpVS/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1713861089t0jhys44
X-QQ-Originating-IP: cUCVoziNrOH0fCzCgaYoM4CE29S8xvLsFE/5E51zYr4=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:31:28 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 3M0okmaRx3gIbRIk2WH2P98KRMGrw6qQIogcjcz+juF05Qy9jWNZ5WfFQNFP+
	Qdg736uGmqd4IulIwzKDwxF/x5o3JLvSNQqZkXdSLDIfEEABzxBYxs3GIKR7tdYbTbIh6VW
	lGjtboHecdALAcVUsLh3e5EPQbJWdoIWRtcEX+nimoHqh3FW5MkRsdrBFi/XoGWIGio7Pw4
	cCExKXTgxcaJkPwjd4BQsS/lRtg3O93DFoz8UQA9DL0wPxVgYjm4U4bfsxls9IZCJi57Uzc
	qASAiXm1mHblBWjweThsDHm6hnslRtaIpU83G1xwkNLsXPgSucX/vuzYvd7bZS+Q+WMANGP
	ElGWHsRJZTUna1M+D3pim5bFsMXPBLNPs0hZXkzXth9kCCWYnsma2sb0z8rknmDX5wXFbg6
	3cDdArJ0vLd2k34QBRBoDm4g3+fgXAh0
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10010987221185693144
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 5/6] sparc/init: Remove on-stack cpumask var
Date: Tue, 23 Apr 2024 16:30:42 +0800
Message-Id: <20240423083043.3735921-6-dawei.li@shingroup.cn>
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

Since the cpumask var resides in __init function, which means it's free
of any concurrenct access, it can be safely marked with static to get
rid of allocation on stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1ca9054d9b97..9edbf57a2c59 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1438,7 +1438,7 @@ static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
 static int __init numa_parse_mdesc_group(struct mdesc_handle *md, u64 grp,
 					 int index)
 {
-	cpumask_t mask;
+	static cpumask_t mask;
 	int cpu;
 
 	numa_parse_mdesc_group_cpus(md, grp, &mask);
-- 
2.27.0


