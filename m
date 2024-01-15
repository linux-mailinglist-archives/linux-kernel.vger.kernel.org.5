Return-Path: <linux-kernel+bounces-25663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738082D44D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3952D1F20F64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C763AB;
	Mon, 15 Jan 2024 06:53:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA795C97
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b13c22455a7543f58122e02b9107bdfc-20240115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:de2d3315-cd84-4853-a1bb-18f2e590ddb8,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:de2d3315-cd84-4853-a1bb-18f2e590ddb8,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:c1deda82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401151448309NCJ8U9I,BulkQuantity:1,Recheck:0,SF:66|24|17|42|101|74|
	38|100|19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: b13c22455a7543f58122e02b9107bdfc-20240115
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 2087022929; Mon, 15 Jan 2024 14:53:03 +0800
From: mengfanhui <mengfanhui@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk
Cc: mengfanhui@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH] nvme/auth: optimize code redundancy and provide code quality
Date: Mon, 15 Jan 2024 14:52:31 +0800
Message-Id: <20240115065231.12733-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve code quality. Reduce code redundancy.

Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
---
 drivers/nvme/common/auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a23ab5c968b9..4f9d06afdc38 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -250,9 +250,7 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 	if (key->hash == 0) {
 		key_len = nvme_auth_key_struct_size(key->len);
 		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
-		if (!transformed_key)
-			return ERR_PTR(-ENOMEM);
-		return transformed_key;
+		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
 	}
 	hmac_name = nvme_auth_hmac_name(key->hash);
 	if (!hmac_name) {

base-commit: c29901006179c4c87f9335771e50814ec5707239
-- 
2.25.1


