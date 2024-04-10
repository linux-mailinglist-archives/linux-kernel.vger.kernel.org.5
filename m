Return-Path: <linux-kernel+bounces-138400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716089F0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786401C21817
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3B15ECFA;
	Wed, 10 Apr 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="O35o9sA/"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386915E5D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748320; cv=none; b=KpKnbuYU/yxDm3T3xGBLYawYCUoYLJIvxNwBgyokqxXUTJUOU/BMfgffJpFU7JP+YsvYskegwy3HlzDrvDixyWg4jZJY9nvUykTORTCVCGfr6u/Zdth2VrJZm9L1C6yq0SuzATQsNCtoBvFOXEPeK4x3pSwmQhKu0q77Pz7CA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748320; c=relaxed/simple;
	bh=+pdjM1s6Ki6mrvtt2IV5vM61l9m948tojzNqs2Jkx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfcXxeO+TZRFIXSjBaShoVn3PpNcZ61GWYNmu2djzmdpSUkLjXh+/+spK61GlqYloZkGBnHOVqekDv+4oRFhnlE2292NKR8pvjGnqZQcG3o0Y0OVceH5b8tGdbIQjGoljRLPSGHqUDUnqODxWMOMJDdw2PhAXUV5g+ZFZQRvf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=O35o9sA/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=MIh2Te8HRB16dLWCZQy/u503SxPLZR4I/XrMPIptOnE=; b=O35o9s
	A/QrxQdnKtCJc5CK2Acr3z8X5R8hpnyPciX8LmYASeqN1ZEpbMmFbgFXvLwgE7YN
	kH6BRRwlzqFFXmQwHItosHjSMm/ZqdZXrBq/lG1SckthpkilUm2XBK1MJtP+q/2x
	qXfy62rIR+sHfUj65K7+0R83adECJYhroq9Llm1isGbk3b+0gaM1dKkOORdPbN5a
	05o2Zb78BVnIfGCC/gZIa84AhHuTdo23+0FgxYAsqigAklFoWVFR9IWAn9Hb/tQE
	YUx8UctlUXT1kj5xY5Dcyw0WU8bxD4vZ8yEE41Tg2cbQhrhWGbZg/QZcq7toT0uW
	aVcRr7QRkCZdT/1g==
Received: (qmail 521651 invoked from network); 10 Apr 2024 13:25:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Apr 2024 13:25:10 +0200
X-UD-Smtp-Session: l3s3148p1@A06eSrwVZz1tKPEL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] i2c: qcom-geni: remove printout on handled timeouts
Date: Wed, 10 Apr 2024 13:24:25 +0200
Message-ID: <20240410112418.6400-31-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
References: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2C and SMBus timeouts are not something the user needs to be informed
about on controller level. The client driver may know if that really is
a problem and give more detailed information to the user. The controller
should just pass this information upwards. Remove the printout.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 11dcfcf13d8b..6054c62cd2ff 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -642,11 +642,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 		dma_async_issue_pending(gi2c->tx_c);
 
 		timeout = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
-		if (!timeout) {
-			dev_err(gi2c->se.dev, "I2C timeout gpi flags:%d addr:0x%x\n",
-				gi2c->cur->flags, gi2c->cur->addr);
+		if (!timeout)
 			gi2c->err = -ETIMEDOUT;
-		}
 
 		if (gi2c->err) {
 			ret = gi2c->err;
-- 
2.43.0


