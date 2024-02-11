Return-Path: <linux-kernel+bounces-60815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1568509D6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB5F1C20E56
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC945B67F;
	Sun, 11 Feb 2024 15:08:03 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641C5B5D0;
	Sun, 11 Feb 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664083; cv=none; b=maRjLFilESvV7KPn2ZYtvG3XwxERojgzP3EiEzRxDEsKNAn5nYXRTZr6nFSc+bldaOqJHyCTLP2CF3gxT6CqPoGaFHhxDw2/eo449mIZDv+X5E/11FFIMrebQfewRHiBrNrbbIoSl+8+icYsH+/lk8XYponEqJixd2Je4yt8EUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664083; c=relaxed/simple;
	bh=sueJpulddtDvnQgZUkdO21U1DNcg8cZRkMNzuFg+1AI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWnCI2Hlz6JYLTjJan/NaFF25ik1SPm6nEqjKlRYUaHzruxowFQ/AknH5XFwiRodE+0EkmVGnkt1Irds5Ry6GeBPkUaCQT7+JLOQxc6KyOIpLPh3xVSA3AmjEHCvXuCiHk6CDrx7G6yYSBtLm314IgpcGKTV4sLPAYob1Jl+gZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Hans Verkuil <hverkuil@xs4all.nl>,
	Takahiro Adachi <tadachi@tadachi-net.com>, Takeru Komoriya
	<komoriya@paken.org>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 17/17] media: upd64031a: Check return value of i2c_master_recv()
Date: Sun, 11 Feb 2024 07:07:48 -0800
Message-ID: <20240211150749.3832-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

i2c_master_recv() may return an error, so add a check
and return 0xff in case it is passed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: add953cecba8 ("V4L/DVB (3665): Add new NEC uPD64031A and uPD64083 i2c drivers")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/media/i2c/upd64031a.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/upd64031a.c b/drivers/media/i2c/upd64031a.c
index ef35c6574785..f51f86f30c73 100644
--- a/drivers/media/i2c/upd64031a.c
+++ b/drivers/media/i2c/upd64031a.c
@@ -73,11 +73,12 @@ static u8 upd64031a_read(struct v4l2_subdev *sd, u8 reg)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	u8 buf[2];
+	int rc;
 
 	if (reg >= sizeof(buf))
 		return 0xff;
-	i2c_master_recv(client, buf, 2);
-	return buf[reg];
+	rc = i2c_master_recv(client, buf, 2);
+	return rc < 0 ? 0xff : buf[reg];
 }
 
 /* ------------------------------------------------------------------------ */
-- 
2.25.1


