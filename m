Return-Path: <linux-kernel+bounces-126519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781A8938FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B31B20DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77148D52B;
	Mon,  1 Apr 2024 08:26:51 +0000 (UTC)
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E308CA4A;
	Mon,  1 Apr 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960011; cv=none; b=OsCfFJc7WHXfT4GUU7XJdkm53fPTvS/dOO6cF64HGhpsj6sBOv5a16bZfsruEUamAm9vR8UR4OenYb47oHPat6HVI0d1LLaqK5ZsKrOkVSMHl8wYv25tCb6YvL3BGOdBrUh16FcluJZHd3Qr9nFe1RIDGSmaYdWG5jt2UouV1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960011; c=relaxed/simple;
	bh=C+J5MpnPgzyL3rxuVaYmd7nFhMJzSzKZIS0KTBM3aXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KO41V+BpjrxDzuMJbBtZ/tB7nn7PmjmcjYVIzBhEHcCP4r/HuIz94yHXPlAU9ktD0QTAk8cZB/RBJl5DXKWO94FS2DJ42xxn5FWOk0YtWew3Zf4K11RvhY84lIUgbt00IZ0LFhB9fNhbR1qVlJrCC2qlolyva5toWgIZatmsDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 04652200BE934873ABF0A2AD45B6DDE0; Mon, 1 Apr 2024 15:26:36 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,Pankaj Gupta <pankaj.gupta@nxp.com>,Gaurav Jain <gaurav.jain@nxp.com>,Herbert Xu <herbert@gondor.apana.org.au>,"David S. Miller" <davem@davemloft.net>,<linux-crypto@vger.kernel.org>,<linux-kernel@vger.kernel.org>,<lvc-project@linuxtesting.org>
Subject: [PATCH] crypto: caam/qi2 - check for 0 rx/tx  queues on setup
Date: Mon, 1 Apr 2024 15:26:20 +0700
Message-ID: <20240401082620.608675-1-aaprelkov@usergate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: A2374E53DB9B4D068A738ABD47F8D0DA
X-MailFileId: 4119093A5F4E48B48CDAFA9493532D4C

If num_rx_queues or num_tx_queues is 0, then division by zero occurs
on j calculation.
Also goto mark "err_get_rx_queue" used for tx queues too.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index a4f6884416a0..07cb1aad758f 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -5049,6 +5049,11 @@ static int __cold dpaa2_dpseci_setup(struct fsl_mc_device *ls_dev)
 
 	priv->num_pairs = min(priv->dpseci_attr.num_rx_queues,
 			      priv->dpseci_attr.num_tx_queues);
+	if (!priv->num_pairs) {
+		err = -EINVAL;
+		dev_err(dev, "one of queues number is 0\n");
+		goto err_get_queues;
+	}
 	if (priv->num_pairs > num_online_cpus()) {
 		dev_warn(dev, "%d queues won't be used\n",
 			 priv->num_pairs - num_online_cpus());
@@ -5060,7 +5065,7 @@ static int __cold dpaa2_dpseci_setup(struct fsl_mc_device *ls_dev)
 					  &priv->rx_queue_attr[i]);
 		if (err) {
 			dev_err(dev, "dpseci_get_rx_queue() failed\n");
-			goto err_get_rx_queue;
+			goto err_get_queues;
 		}
 	}
 
@@ -5069,7 +5074,7 @@ static int __cold dpaa2_dpseci_setup(struct fsl_mc_device *ls_dev)
 					  &priv->tx_queue_attr[i]);
 		if (err) {
 			dev_err(dev, "dpseci_get_tx_queue() failed\n");
-			goto err_get_rx_queue;
+			goto err_get_queues;
 		}
 	}
 
@@ -5105,7 +5110,7 @@ static int __cold dpaa2_dpseci_setup(struct fsl_mc_device *ls_dev)
 
 	return 0;
 
-err_get_rx_queue:
+err_get_queues:
 	dpaa2_dpseci_congestion_free(priv);
 err_get_vers:
 	dpseci_close(priv->mc_io, 0, ls_dev->mc_handle);
-- 
2.34.1


