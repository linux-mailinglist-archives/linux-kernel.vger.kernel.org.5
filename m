Return-Path: <linux-kernel+bounces-156136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE28AFE62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2814284CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C5E15EA2;
	Wed, 24 Apr 2024 02:28:33 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6B4F8568A;
	Wed, 24 Apr 2024 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925713; cv=none; b=TEWjPUyozSFDvvW/kgSKGLMnJ3iVSxJZNsU6XXDFZaKdvR+ycFRb3IQzyb/Ne1j4xVh0UdNNY7WMAaEljcTYa6vDFmVUzT3HdA8wz5IKMMCRjualxo7cmOCvm65SQwVGX2yDXFA/Pa8iBuISD/QjBwLsxOq725u/xUeycjMf+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925713; c=relaxed/simple;
	bh=53lcTeRvvpcYAQU46xMUesg77FmlT96Wq1XtqskvJ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tKzYh8lyD7xrhFst3H5fHWwswFVG/TsXEpFysyVcw7maRrVHEDkf77jarZey9vZ3akJSf6W4oMhSXHVjoGjg3FzNoP7RdLM+ksviqbRqA2xcS3XWbBqxyyTurkRoT9Swzopp3itcdJRPVmsOV0LZSoTZrqhYE7ATQh/lFOa58QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A58BD6019C09D;
	Wed, 24 Apr 2024 10:28:12 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	sumang@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] octeontx2-af: fix the double free in rvu_npc_freemem()
Date: Wed, 24 Apr 2024 10:27:25 +0800
Message-Id: <20240424022724.144587-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning：
drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:line 2184, column 2
Attempt to free released memory.

npc_mcam_rsrcs_deinit() has released 'mcam->counters.bmap'. Deleted this
redundant kfree() to fix this double free problem.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index be709f83f331..e8b73b9d75e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2181,7 +2181,6 @@ void rvu_npc_freemem(struct rvu *rvu)
 
 	kfree(pkind->rsrc.bmap);
 	npc_mcam_rsrcs_deinit(rvu);
-	kfree(mcam->counters.bmap);
 	if (rvu->kpu_prfl_addr)
 		iounmap(rvu->kpu_prfl_addr);
 	else
-- 
2.30.2


