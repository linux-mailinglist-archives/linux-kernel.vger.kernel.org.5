Return-Path: <linux-kernel+bounces-152705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AEC8AC328
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527431C20908
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4B1078B;
	Mon, 22 Apr 2024 03:43:26 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D7325E542;
	Mon, 22 Apr 2024 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757405; cv=none; b=ecB1cGWTpwtvpANL3oG3ihHdBeqnibxO/Uv2ldP6jwzBpp4buYWvUUTLKyV6lLlTxzqZJrflfVan3734JCmYXnBYUMRpatXG/HHsKqxwoven7JaYr2nzQJqM1cahxXY8RTqxl1T2F06s19aR7S5vcK3EePuM7nuUy41xDF/ZnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757405; c=relaxed/simple;
	bh=e+QErZfJ9ClPDRKItQODMeneFwkC3xRbbxekpjzvW0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mmn1w7dsiUxqRqA2RQnN0OS61KS1LGnxAVA+tNg2gxHB88pEzjwQBu2xvGmrWhGoun8GXO+QdIzGlijhDphc8VWaCPP3FsVEZnm+T+GeT45o3oDAYRY+aILquVbJYusFwpR+bwhOmq0VSxU7sRGPe31U8tX8CFauRZAJ51SYV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A504260680957;
	Mon, 22 Apr 2024 11:43:19 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	c_mkenna@qti.qualcomm.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless v2] wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()
Date: Mon, 22 Apr 2024 11:42:44 +0800
Message-Id: <20240422034243.938962-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang Static Checker (scan-build) Warning:
drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
Value stored to 'ret' is never read.

Return 'ret' rather than 'count' when 'ret' stores an error code.
By the way, remove some useless code.

Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - remove the initializer change.

 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 394bf3c32abf..c1198e9027ae 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -432,14 +432,12 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
 
 	ret = ath10k_wmi_peer_set_param(ar, arsta->arvif->vdev_id, sta->addr,
 					ar->wmi.peer_param->debug, peer_debug_trigger);
-	if (ret) {
+	if (ret)
 		ath10k_warn(ar, "failed to set param to trigger peer tid logs for station ret: %d\n",
 			    ret);
-		goto out;
-	}
 out:
 	mutex_unlock(&ar->conf_mutex);
-	return count;
+	return ret ?: count;
 }
 
 static const struct file_operations fops_peer_debug_trigger = {
-- 
2.30.2


