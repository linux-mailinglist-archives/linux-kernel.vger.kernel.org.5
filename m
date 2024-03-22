Return-Path: <linux-kernel+bounces-111487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1344886CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B181F22E55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052B56B74;
	Fri, 22 Mar 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="h2lJ2/uT"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B7524DD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114007; cv=none; b=Inp8P24MM9P7p0C/++smFkyY/e5sX1gADtbwpqHOk3mb90PCf+M2HeK1M+Crxp0N323Y9cz8M69oYcTrb0jlVAIh8AY2mDx44nBFEBN73Jst4564RsRWahyYSDORiB0jYe/wfbJyyrDWUeT1aYtjE8q/adwGxbvTkUdP424ChqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114007; c=relaxed/simple;
	bh=yjJFdslix4fvxNZnqmJv9g6Ug9JLy7/NmPCFMdQRC4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Em7TOw2tmnUgkh8clCK6QljSxMlrxJDC1v7FYib8O/Uv/dKUo7wOZYJrd31lQi7RsO9EuTm/3sxvk8A6gc7CSlWkOBS0SeYh7nEg8xoV2oDNFPWRJ7Dl0lfo+UnkUsuSduwq7UzLZp4U8R/meEcBr/8hqrqDZ3oUGmZ8qqj+Ehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=h2lJ2/uT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=nPqXdlyyhoVRqPKoOjv5iKVpiVyc/2GvO8xysHtbwCM=; b=h2lJ2/
	uTAJuVBvALeij3E7HhDhVB7/fK2mdO61oqQuQUGso6rFwd3mqai5jyslxoAArUya
	G7AEv1uS4yCFb3QafOciA6sTPiEmxBa1mX7XqE8dQlOT/awHTHrT+9EyD//x77Zi
	xuu0OfvsAte5hCCHxQJd2F+OesgBwu3ifnUzPBi7Z/AU5vL+I5Bl0/rMNvmwZ6Pz
	AyCjlvju3pXnPiHUKYVAp6vcz+V2TfFDm4ABfuRbntk+ySkbOS9pN+bpgLfI9RqV
	kQYXAjgG9Vr0DxjGpR+MBeL5ah3ZlsiSZJxC9Qiv/FuwnI3vL3Pi+XU5xfIF7vR6
	otuCNEvEKwnu6Bpg==
Received: (qmail 3870228 invoked from network); 22 Mar 2024 14:26:28 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:28 +0100
X-UD-Smtp-Session: l3s3148p1@xr1uxT8UgJNehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/64] i2c: bcm2835: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:02 +0100
Message-ID: <20240322132619.6389-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index b92de1944221..62776e7fc586 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * BCM2835 master mode driver
+ * BCM2835 host controller mode driver
  */
 
 #include <linux/clk.h>
@@ -25,7 +25,7 @@
 #define BCM2835_I2C_DEL		0x18
 /*
  * 16-bit field for the number of SCL cycles to wait after rising SCL
- * before deciding the slave is not responding. 0 disables the
+ * before deciding the client is not responding. 0 disables the
  * timeout detection.
  */
 #define BCM2835_I2C_CLKT	0x1c
@@ -223,7 +223,7 @@ static void bcm2835_drain_rxfifo(struct bcm2835_i2c_dev *i2c_dev)
 /*
  * Repeated Start Condition (Sr)
  * The BCM2835 ARM Peripherals datasheet mentions a way to trigger a Sr when it
- * talks about reading from a slave with 10 bit address. This is achieved by
+ * talks about reading from a client with 10 bit address. This is achieved by
  * issuing a write, poll the I2CS.TA flag and wait for it to be set, and then
  * issue a read.
  * A comment in https://github.com/raspberrypi/linux/issues/254 shows how the
@@ -391,7 +391,7 @@ static u32 bcm2835_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm bcm2835_i2c_algo = {
-	.master_xfer	= bcm2835_i2c_xfer,
+	.xfer	= bcm2835_i2c_xfer,
 	.functionality	= bcm2835_i2c_func,
 };
 
-- 
2.43.0


