Return-Path: <linux-kernel+bounces-25816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA282D63E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B991C21650
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA81E869;
	Mon, 15 Jan 2024 09:43:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EC1E861
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e4e15a98d98647e5a3b516dd4e08d058-20240115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:06f7089b-bbb1-4f97-aadc-650fd0a90c24,IP:20,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:25
X-CID-INFO: VERSION:1.1.35,REQID:06f7089b-bbb1-4f97-aadc-650fd0a90c24,IP:20,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:a7eb5c7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240115174336TP554N1E,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: e4e15a98d98647e5a3b516dd4e08d058-20240115
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1917306438; Mon, 15 Jan 2024 17:43:36 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C29D3E000EB9;
	Mon, 15 Jan 2024 17:43:35 +0800 (CST)
X-ns-mid: postfix-65A4FE47-62623527
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id D7B87E000EB9;
	Mon, 15 Jan 2024 17:43:31 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: christophe.leroy@csgroup.eu,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Kunwu Chan <kunwu.chan@hotmail.com>
Subject: [PATCH] powerpc/83xx: Add a null pointer check to mcu_gpiochip_add
Date: Mon, 15 Jan 2024 17:43:30 +0800
Message-Id: <20240115094330.33014-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerp=
c/platforms/83xx/mcu_mpc8349emitx.c
index 4d8fa9ed1a67..d1ae66eaa687 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -120,6 +120,8 @@ static int mcu_gpiochip_add(struct mcu *mcu)
=20
 	gc->owner =3D THIS_MODULE;
 	gc->label =3D kasprintf(GFP_KERNEL, "%pfw", dev_fwnode(dev));
+	if (!gc->label)
+		return -ENOMEM;
 	gc->can_sleep =3D 1;
 	gc->ngpio =3D MCU_NUM_GPIO;
 	gc->base =3D -1;
--=20
2.39.2


