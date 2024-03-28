Return-Path: <linux-kernel+bounces-122318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E8688F523
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B652D1C2A34F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1502C288DF;
	Thu, 28 Mar 2024 02:07:27 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CBF8524B34;
	Thu, 28 Mar 2024 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591646; cv=none; b=OltYwOaSZWjoIp+lfyVGP2IVE3W/icqz4QFIkSCVVJMuK16Y/mW0Q6xyaBvGtWSlgPXlcvieS9fJUMiz5JcanwvGgjkYWsbDTer4rDs7Onhch0p0xNGeU+Ykv9PNZ2zJnnzMD4zdxi8StNJ/uyNKNw/40iPIkiQErIPv4vf/j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591646; c=relaxed/simple;
	bh=yTwuu2u8c8H/maO1abDOAOXZoUPJjJZpGVG8tk6jnHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOYAkBpwwBFhPhqmxr3D/ts8Dr1xfOwhEqxmAeab6oO/s4nHNIsemXqP0z1pPT2sSTrZK6DUC/sFuvjLXPIEPdDcx9/IYCdDIIjNS6biusFOgECF8LfQOfgk41X/KLV0BkCQTX1WAhJszspU1r6oYNa0w1zD47q7YrJigT2NmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 56BBE609FFAEA;
	Thu, 28 Mar 2024 10:07:12 +0800 (CST)
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
	dan.carpenter@linaro.org,
	saikrishnag@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v3] octeontx2-pf: check negative error code in otx2_open()
Date: Thu, 28 Mar 2024 10:06:21 +0800
Message-Id: <20240328020620.4054692-1-suhui@nfschina.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
v3:
 - split the v2 patchset into individual patches
v2:
 - add "net" in subject

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


