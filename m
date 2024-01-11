Return-Path: <linux-kernel+bounces-23117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87A82A7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B950F1C21FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD163B8;
	Thu, 11 Jan 2024 06:55:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CB63A0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06e8d5df7d514be686305328458a4511-20240111
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:83a6b7f4-26f0-4521-9e96-b36bb32f8909,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:1
X-CID-INFO: VERSION:1.1.35,REQID:83a6b7f4-26f0-4521-9e96-b36bb32f8909,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:1
X-CID-META: VersionHash:5d391d7,CLOUDID:5fec0b2f-1ab8-4133-9780-81938111c800,B
	ulkID:240111143903VJUGI1AE,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|45|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 06e8d5df7d514be686305328458a4511-20240111
X-User: chentao@kylinos.cn
Received: from kernel.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 630914744; Thu, 11 Jan 2024 14:39:00 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: richard@nod.at,
	Artem.Bityutskiy@nokia.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Richard Weinberger <richard.weinberger@gmail.com>
Subject: [PATCH v2] ubifs: Remove unreachable code in dbg_check_ltab_lnum
Date: Thu, 11 Jan 2024 14:36:56 +0800
Message-Id: <20240111063656.68810-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because there is no break statement in the dead loop above,it is
impossible to execute the 'err=0' statement.Delete the code that
will never execute.

Fixes: 6fb324a4b0c3 ("UBIFS: allocate ltab checking buffer on demand")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Suggested-by: Richard Weinberger <richard.weinberger@gmail.com>

---
v2: Remove the initialization of err
---
 fs/ubifs/lpt_commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index c4d079328b92..07351fdce722 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1646,7 +1646,6 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 		len -= node_len;
 	}
 
-	err = 0;
 out:
 	vfree(buf);
 	return err;
-- 
2.39.2


