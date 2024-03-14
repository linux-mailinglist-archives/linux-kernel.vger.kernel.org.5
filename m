Return-Path: <linux-kernel+bounces-102787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646987B749
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCCA1F2312D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6729B9454;
	Thu, 14 Mar 2024 05:28:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F998F55
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394127; cv=none; b=jVOz8To+pSySzxjqyxsRYny13SAuORLN2mM2KRO+eQYyQYShuV5Fkkh9WTXVSyI7S64mx2xt5gQcVTca/fAozQPI/9nD7+EG31Au/TN/UjKLnD7OsEP80COdPgo0hKvtbTEy8Fv+hGAPlKYuTF7VJfzmUHL9W+6iw8yFa4YilTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394127; c=relaxed/simple;
	bh=/AefSDURd/iYE924k0hdYlGbe6MFO75hbbd6fJusvVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNJ3Ai3Dd2dNrfQ0fPfxujWh1FGQ53Iz1b4HgiRPBkBaQkDV1AVT4NznsR/NAB1v5Mqi60YlGJJehkf5YPYG/nTu0yKv7N807SYaZN9aDF5MEU5zn8OpIQZico7fveluDtotcDq8voxdTv+5QGn3w2CgPRrfYPj2kNX+SIeKBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dbd5edc51dde46b88f366b7d46b59894-20240314
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:524a0ae8-916c-4a51-bac7-58c2790c9869,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.37,REQID:524a0ae8-916c-4a51-bac7-58c2790c9869,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:a31b7c81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2403141328344WTIQMFJ,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: dbd5edc51dde46b88f366b7d46b59894-20240314
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 792691737; Thu, 14 Mar 2024 13:28:30 +0800
From: Ai Chao <aichao@kylinos.cn>
To: bleung@chromium.org,
	tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v1] platform/chrome: use sysfs_emit() instead of sprintf()
Date: Thu, 14 Mar 2024 13:28:28 +0800
Message-Id: <20240314052828.186924-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/chrome/wilco_ec/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 893c59dde32a..d44c43559621 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -192,7 +192,7 @@ static ssize_t usb_charge_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", rs.val);
+	return sysfs_emit(buf, "%d\n", rs.val);
 }
 
 static ssize_t usb_charge_store(struct device *dev,
-- 
2.25.1


