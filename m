Return-Path: <linux-kernel+bounces-118397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2145188BA44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B69B23BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BB112B142;
	Tue, 26 Mar 2024 06:13:10 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3A48812AAE4;
	Tue, 26 Mar 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433589; cv=none; b=Qi3Hohf7Mxq+BdryyIHUiSxbbLPevkO6Pxa5hjKxiZ999oll8MB0MfXOjESABrbZ5QrY4jc/Dm/Gt/xvxHys9zFPbTuvZucOD01ffyuexRheeXXv8bDh2iF3xa+dSYjDAIIU+OFd2qgX0fvALWHZc/jk1PxhfRYNW8jgcKduB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433589; c=relaxed/simple;
	bh=oTvXLR4vHq2sfi+YR5JibffxIjM6md8D3zQXRx7K1Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArgK2IzkNxLB/ucBkqpHNr0Mky6I77/GpI+K81M0Q/h8xhkVoqsXQi1/ZbPGXnE3McMriQdeIT/ySkicUUL0TMBvMcPvhIOY8SY6zDoAFGaMHtZCR7iyir9zpmzVd0D9QKT8Djo3g579vcoputeI7xAYbnerfctZS3BX2mfQTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 85F886070B0AF;
	Tue, 26 Mar 2024 14:13:00 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	saikrishnag@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net v2 1/2] octeontx2-pf: check negative error code in otx2_open()
Date: Tue, 26 Mar 2024 14:12:34 +0800
Message-Id: <20240326061233.4133148-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

otx2_rxtx_enable() return negative error code such as -EIO,
check -EIO rather than EIO to fix this problem.

Fixes: c926252205c4 ("octeontx2-pf: Disable packet I/O for graceful exit")
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2: add "net" in subject
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b40bd0e46751..3f46d5e0fb2e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1933,7 +1933,7 @@ int otx2_open(struct net_device *netdev)
 	 * mcam entries are enabled to receive the packets. Hence disable the
 	 * packet I/O.
 	 */
-	if (err == EIO)
+	if (err == -EIO)
 		goto err_disable_rxtx;
 	else if (err)
 		goto err_tx_stop_queues;
-- 
2.30.2


