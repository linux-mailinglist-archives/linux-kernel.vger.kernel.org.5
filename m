Return-Path: <linux-kernel+bounces-161178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF368B4807
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE34BB22506
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977515B557;
	Sat, 27 Apr 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YmZgHe7y"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022415AD91
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714250196; cv=none; b=c9iqbTHHYSrZ483sgSl9eLX3WM66oWdmk+ufq6B/0uuLeniXUkcLmDOm0TsTwUzJssAcPdvDQXs3vzgshP9xlCRPHcebX3FHmaOC+oCPcOLMJskXmZjLb1yZWB4vrPg2zOOlTEA4XQTQUtsabged54ny040N7TrlNJE8OjWYCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714250196; c=relaxed/simple;
	bh=PQbfVr0szfKuLV1vCwfI/knNOPEEk21YgZvjweSPPWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXv7sYEc+qKcWhYQh9JQCaNP10yhbJfo5XFNfkvvVYZBDh/WLFJXMiVaa7omFM2Bpv2/WUxnHuzWXu/4yO5sorb7J8H80kM0cu0g5nNdxIdVUtcSaM0k+8KZSRIq8p7qYiYcTP5eV7OIwWN2M1Qrp7bXkyK0Wzmnvwhs+XUJ4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YmZgHe7y; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=J5GXIPR6fCe0wVIwusYLH0113fTOigxkr/KOK1nav1s=; b=YmZgHe
	7yYTYd8mRqA590uEXPCeTXuthPUUa4WtfNzpuRFPoBHZ7c46clNLgJo9Mtu8CyZJ
	G9ejf2k6+RBeMI0l4gW3v8PFLfIKub4w/OHEROYkgSRrsMLFnmSOFVRNhc4tD3KQ
	mvsCQSnevfR7VFTIzRUfMenKgNSXuz/aAj1kjIIMtDzOi5UlrnWR2jaTpUPXeU5g
	bkoqo+Y3CZPfhVkioFqoyhr/FimbSUOUqUQG4g7zYzcjSpd9B0mwmQVm9c868Cr7
	W860VfecVpB7nIADJWSSMsAgw9j2ebLU5kGu+TAghroFWrtEOsG/XyyD6yddtHR0
	FnV5DepsZEsxJVzw==
Received: (qmail 1782065 invoked from network); 27 Apr 2024 22:36:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Apr 2024 22:36:23 +0200
X-UD-Smtp-Session: l3s3148p1@B0g3+RkX6s9ehh9l
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] i2c: jz4780: use 'time_left' variable with wait_for_completion_timeout()
Date: Sat, 27 Apr 2024 22:36:03 +0200
Message-ID: <20240427203611.3750-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240427203611.3750-1-wsa+renesas@sang-engineering.com>
References: <20240427203611.3750-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-jz4780.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 55035cca0ae5..7951891d6b97 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -565,7 +565,7 @@ static inline int jz4780_i2c_xfer_read(struct jz4780_i2c *i2c,
 				       int idx)
 {
 	int ret = 0;
-	long timeout;
+	unsigned long time_left;
 	int wait_time = JZ4780_I2C_TIMEOUT * (len + 5);
 	unsigned short tmp;
 	unsigned long flags;
@@ -600,10 +600,10 @@ static inline int jz4780_i2c_xfer_read(struct jz4780_i2c *i2c,
 
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
-	timeout = wait_for_completion_timeout(&i2c->trans_waitq,
-					      msecs_to_jiffies(wait_time));
+	time_left = wait_for_completion_timeout(&i2c->trans_waitq,
+						msecs_to_jiffies(wait_time));
 
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(&i2c->adap.dev, "irq read timeout\n");
 		dev_dbg(&i2c->adap.dev, "send cmd count:%d  %d\n",
 			i2c->cmd, i2c->cmd_buf[i2c->cmd]);
@@ -627,7 +627,7 @@ static inline int jz4780_i2c_xfer_write(struct jz4780_i2c *i2c,
 {
 	int ret = 0;
 	int wait_time = JZ4780_I2C_TIMEOUT * (len + 5);
-	long timeout;
+	unsigned long time_left;
 	unsigned short tmp;
 	unsigned long flags;
 
@@ -655,14 +655,14 @@ static inline int jz4780_i2c_xfer_write(struct jz4780_i2c *i2c,
 
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
-	timeout = wait_for_completion_timeout(&i2c->trans_waitq,
-					      msecs_to_jiffies(wait_time));
-	if (timeout && !i2c->stop_hold) {
+	time_left = wait_for_completion_timeout(&i2c->trans_waitq,
+						msecs_to_jiffies(wait_time));
+	if (time_left && !i2c->stop_hold) {
 		unsigned short i2c_sta;
 		int write_in_process;
 
-		timeout = JZ4780_I2C_TIMEOUT * 100;
-		for (; timeout > 0; timeout--) {
+		time_left = JZ4780_I2C_TIMEOUT * 100;
+		for (; time_left > 0; time_left--) {
 			i2c_sta = jz4780_i2c_readw(i2c, JZ4780_I2C_STA);
 
 			write_in_process = (i2c_sta & JZ4780_I2C_STA_MSTACT) ||
@@ -673,7 +673,7 @@ static inline int jz4780_i2c_xfer_write(struct jz4780_i2c *i2c,
 		}
 	}
 
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(&i2c->adap.dev, "write wait timeout\n");
 		ret = -EIO;
 	}
-- 
2.43.0


