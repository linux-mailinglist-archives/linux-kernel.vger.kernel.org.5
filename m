Return-Path: <linux-kernel+bounces-90325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23086FDA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC11D1C22045
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D85038DEA;
	Mon,  4 Mar 2024 09:26:32 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FE9381DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544392; cv=none; b=VEVGEVkinmGVC25B3424yNbAumbqqxmilZkc4pBJsQScZKYmXYNO0SGXQdt7ww7IR+URdsqlBIzv43ZnXlmm6DHloWsDnmBBLYTDHo7mfGGapjqt9arWrg97RrF5qCv0py8EWkthzdsDobKsI31NjBKBejTarABYDoSnCfRD1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544392; c=relaxed/simple;
	bh=rA9xcrP1qRp2vmLyo1/NoCl09tOZioaFK+zMV5UQ+a0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aq0A0T4YcNGEKnq0SC4EGZ24HW14zMrntVZs8OITP42lN/H/abIXuyQvNyLncEyXV+DPqA8/ZgtNqnskcDM19RFrhWztzXM2Jdh7PhcNHcJ/+PQJiCIBPaECLSeQHGbXAG88Ce6Dy/gouaCOC6o6cyZTsnw/65Bbtg4dRb6GY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1709544338tbvh7m0l
X-QQ-Originating-IP: /8qetr6ORn/X+N+f2KO84Qws+LjhcD+YICaQ7LCYY1w=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Mar 2024 17:25:37 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: qPPBrXN7Wh+uu+Oshg+pJH+InOcUFIlvm2eJlW3zNBPIzyTLwKQAunGD3FCwb
	zwyMY7CdMV2tZ54TuJOawKbq57h5TE6z3bq9+dKiI2AsgkqwjjDfTVg5lIaoVkDLYq9zDYr
	B+NC4YSSdaexh+v2RbdouhF0KG8MQkHwfvAV9dKQd2ZpKw6mCjxCjr+vxi4lVnO4DffIhy7
	Bp8bES/XvFY32VFOiR49STQmxEgSBPeNzmBJpHKaqsWPOBFUfSoc6ImedCXlvonCQvw/XkC
	ToAlhHse/0shw2Jkgra+fw3FaQQJiDxuxXp4XT6UWxSGLDZ60zcvXXmre+31R0+pdOe9C28
	zxShzXKHft+hSESzzPFzcWabdAqyOZNshksj13TcTCY2nogMtqgP9uLM22wzb+VL3jwi//t
	nBkaCl93UStK79lsqDOIhQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14106722739390484581
From: Dawei Li <dawei.li@shingroup.cn>
To: conor.dooley@microchip.com,
	daire.mcnamara@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Dawei Li <dawei.li@shingroup.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: microchip: Fix over-requested allocation size
Date: Mon,  4 Mar 2024 17:25:32 +0800
Message-Id: <20240304092532.125751-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

cocci warnings: (new ones prefixed by >>)
>> drivers/firmware/microchip/mpfs-auto-update.c:387:72-78:
   ERROR: application of sizeof to pointer
   drivers/firmware/microchip/mpfs-auto-update.c:170:72-78:
   ERROR: application of sizeof to pointer

response_msg is a pointer to u32, so the size of element it points to is
supposed to be a multiple of sizeof(u32), rather than sizeof(u32 *).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403040516.CYxoWTXw-lkp@intel.com/
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 682e417be5a3..7ea3cdb917bc 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -384,7 +384,7 @@ static int mpfs_auto_update_available(struct mpfs_auto_update_priv *priv)
 	u32 *response_msg;
 	int ret;
 
-	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(response_msg),
+	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(u32),
 				    GFP_KERNEL);
 	if (!response_msg)
 		return -ENOMEM;
-- 
2.27.0


