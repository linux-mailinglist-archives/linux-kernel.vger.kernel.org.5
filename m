Return-Path: <linux-kernel+bounces-27132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494A082EAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA01EB22874
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693311CBF;
	Tue, 16 Jan 2024 08:39:17 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0D11C8B;
	Tue, 16 Jan 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9e26d15b068842508cea8914b7d8260f-20240116
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c3d94d1a-6232-43f3-9c7d-02add46f3c88,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.35,REQID:c3d94d1a-6232-43f3-9c7d-02add46f3c88,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:5d391d7,CLOUDID:c7ac4d8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240116163853GJBD7274,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 9e26d15b068842508cea8914b7d8260f-20240116
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 222917768; Tue, 16 Jan 2024 16:38:50 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id BF4A2E000EB9;
	Tue, 16 Jan 2024 16:38:50 +0800 (CST)
X-ns-mid: postfix-65A6409A-58652291
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id E5E41E000EB9;
	Tue, 16 Jan 2024 16:38:49 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: dmitry.torokhov@gmail.com,
	aduggan@synaptics.com,
	cheiny@synaptics.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] Input: synaptics-rmi4: Fix NULL pointer dereference in rmi_driver_probe
Date: Tue, 16 Jan 2024 16:38:47 +0800
Message-Id: <20240116083847.89934-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics R=
MI4 devices")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/input/rmi4/rmi_driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
index 258d5fe3d395..d3a601ff51e6 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1197,6 +1197,12 @@ static int rmi_driver_probe(struct device *dev)
 		rmi_driver_set_input_params(rmi_dev, data->input);
 		data->input->phys =3D devm_kasprintf(dev, GFP_KERNEL,
 						"%s/input0", dev_name(dev));
+		if (!data->input->phys) {
+			dev_err(dev, "%s: Failed to allocate memory.\n",
+					__func__);
+			retval =3D -ENOMEM;
+			goto err;
+		}
 	}
=20
 	retval =3D rmi_init_functions(data);
--=20
2.39.2


