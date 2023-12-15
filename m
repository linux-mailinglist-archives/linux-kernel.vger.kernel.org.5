Return-Path: <linux-kernel+bounces-484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274D8141D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96B0284138
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10FD282;
	Fri, 15 Dec 2023 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RRskmm8L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AFD266;
	Fri, 15 Dec 2023 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BpfKy
	eJPlfchN6x6Bi7CxgQ3q2X6uEtwh0vKfZbphgs=; b=RRskmm8LOF6I/56oV30pQ
	OSkJWU6Y6XWHf5X3AXJX7RZ7rPT71Row/D1Iw0piW4IXPVT9N/JnhztiTTn5PBMK
	naaxJjwtyRRhDv3zmAyTNhuDeR1kZLHmJ5TukGuvgEJEflOtk1hEVz+SuocYho5l
	8JwEms5AiPmdyif9LBHZeg=
Received: from localhost.localdomain (unknown [39.156.73.13])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3X0eO83tlvVNYBQ--.3606S2;
	Fri, 15 Dec 2023 14:34:54 +0800 (CST)
From: cuiguoqi <guoqi0226@163.com>
To: wsa@kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	cuiguoqi <cuiguoqi@kylinos.cn>
Subject: [PATCH] i2c: smbus: Fixed uninitialized variable msgbuf in i2c_smbus_xfer_emulated
Date: Fri, 15 Dec 2023 14:34:52 +0800
Message-Id: <20231215063452.3097535-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0eO83tlvVNYBQ--.3606S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1xKFW8CFyfJF47Cr4fuFg_yoWkJFXEkF
	15Zw1xXrn7AF1a9345KF15ZryYya17Xr1UZa4ft34Fk347twn5JFWDZr9Y9r45XF1ktFW3
	Zw1q9w1293ZrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Jl1DUUUUU==
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbBdhJHaGDkqfG-5wABsO

From: cuiguoqi <cuiguoqi@kylinos.cn>

When the slave device is disconnected during i2c transmission, the communication is interrupted because the ACK cannot be received.
However, if the uninitialized msgbuf1 is used by i2c_smbus_xfer_emulated, abnormal random values will be reported.
The test proves that the exception communication using SMBUS after initialization is more reliable.

Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
---
 drivers/i2c/i2c-core-smbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index e3b96fc..f7b0980d 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -351,6 +351,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	bool wants_pec = ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK
 			  && size != I2C_SMBUS_I2C_BLOCK_DATA);
 
+	memset(msgbuf0, 0, sizeof(msgbuf0));
+	memset(msgbuf1, 0, sizeof(msgbuf1));
 	msgbuf0[0] = command;
 	switch (size) {
 	case I2C_SMBUS_QUICK:
-- 
2.7.4


