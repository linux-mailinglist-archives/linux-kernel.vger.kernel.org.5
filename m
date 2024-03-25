Return-Path: <linux-kernel+bounces-116649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566B88A1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EB62877F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D0134724;
	Mon, 25 Mar 2024 10:20:35 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 394D8127B7F;
	Mon, 25 Mar 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352180; cv=none; b=MSeNy+YRIAwhcQpJc0GHCvLDbFdwnckz/mHKhraZ55HGxoX8FYIMXS8G6SbPdxRtw/AIxOAzhYGxeJu4KYCTAZXg2lp4ruVuSO6X57J7/yB824VRvqV/dzYe0O9GY7G1dU61/EmsEJspcuBKt5bGXSbr3GO684bg0tQxcZJ5g6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352180; c=relaxed/simple;
	bh=LZaq53O1GNO3two+ZlL0W1CK0F15y8eavHKu0/CkY/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TvaUMllQBw8oSCB3jsXU5XkUqz3NvtVeNc+9lTP0t+zytCR+jZh/h1BxHK27q2C9c7pYyFu0bv0IHat/gOsIw1J0p5cmSPhFWGEf03mHK3m34qvnoHz/PEd40x7PEko+q7TTZYMrA/lrhIIIbB+eFTQT3olJdg4o2jG3wuEcg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 5067F602E36D9;
	Mon, 25 Mar 2024 15:36:04 +0800 (CST)
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
Subject: [PATCH 1/2] octeontx2-pf: check negative error code in otx2_open()
Date: Mon, 25 Mar 2024 15:35:49 +0800
Message-Id: <20240325073549.823832-1-suhui@nfschina.com>
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
---
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


