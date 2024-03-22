Return-Path: <linux-kernel+bounces-111518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7B886D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4525B265E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F2160899;
	Fri, 22 Mar 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fDvcCs/o"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF862808
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114035; cv=none; b=D0yVlniOChy1iCiXd9mb+qoXx9yJsOcTwDddS2YuywdKrafz6U+IP8C5x17gURfXNs69MOltnufh7rL2D/I/sIQpzGjHLZkCmSdjKQr5kPq9/llPcBUE/5Le6DpoOrh6dI6t/1NG/dQHSHiLN889LMcyVY4o94VGbzH1ZYLbMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114035; c=relaxed/simple;
	bh=sAo9kbPJRiEtE7HLaqvTjdIVANrbDgOoZYHJpbnhpMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjzOFRJb66enwE7+x/wxW51KKJlJ9cU89jtaectfViaSNH6D00IQAn/Y6crIshxYB6n9SihvybcqTOvIq7rzGXDSlOA02hASvK1QDcQP1VYYIRm8NICGcZfNBcembhKRzumXh06gadhP/O//eG1MCF1bbrpcAVro3D+MdzMGzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fDvcCs/o; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=OoNwixtQZ8u2Ylf1U91QXuREyq7/jiz/2k1ymkgoJiw=; b=fDvcCs
	/oGhIMo9aFYcMjZrAhR/c+tbMWgGgXyPtgGOZ0tYU2bOigtIIgp2AGCYqesFvLHo
	oEOxca5UI3fIVov00dTI9sHoNZ6ejLlRSyuWmKFbkua/wdHbuOkdEHjajZh0hRXq
	VyHhqjHjXDPYcnXcY8loQ+cbONbRTnFDkHa4m0KHzeZjPHpNq40jf56BlxPAoApS
	IoDp6jVqYynAsAh1io9sVyRzqCd2nkIiQ0owRRwTdU1t1qSuWdOa/F7qRSOE9QZC
	Q8St+R918q/fnYP69ik9wGxFXLBy66VwvRU5A+juRXsAI5ADTavgpmOhMz4DjEF8
	bI9CkQM0nskXqDZg==
Received: (qmail 3871375 invoked from network); 22 Mar 2024 14:26:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:54 +0100
X-UD-Smtp-Session: l3s3148p1@xUD9xj8UdLBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 40/64] i2c: owl: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:33 +0100
Message-ID: <20240322132619.6389-41-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-owl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 777f1a0278c7..cb90e1b2775c 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -172,7 +172,7 @@ static void owl_i2c_xfer_data(struct owl_i2c_dev *i2c_dev)
 
 	i2c_dev->err = 0;
 
-	/* Handle NACK from slave */
+	/* Handle NACK from client */
 	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
 	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
 		i2c_dev->err = -ENXIO;
@@ -302,7 +302,7 @@ static int owl_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   OWL_I2C_CTL_IRQE, !atomic);
 
 	/*
-	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
+	 * Select: FIFO enable, host mode, Stop enable, Data count enable,
 	 * Send start bit
 	 */
 	i2c_cmd = OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE |
@@ -314,7 +314,7 @@ static int owl_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		i2c_cmd |= OWL_I2C_CMD_AS(msgs[0].len + 1) |
 			   OWL_I2C_CMD_SAS(1) | OWL_I2C_CMD_RBE;
 
-		/* Write slave address */
+		/* Write client address */
 		addr = i2c_8bit_addr_from_msg(&msgs[0]);
 		writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
 
@@ -420,8 +420,8 @@ static int owl_i2c_xfer_atomic(struct i2c_adapter *adap,
 }
 
 static const struct i2c_algorithm owl_i2c_algorithm = {
-	.master_xfer	     = owl_i2c_xfer,
-	.master_xfer_atomic  = owl_i2c_xfer_atomic,
+	.xfer	     = owl_i2c_xfer,
+	.xfer_atomic  = owl_i2c_xfer_atomic,
 	.functionality	     = owl_i2c_func,
 };
 
-- 
2.43.0


