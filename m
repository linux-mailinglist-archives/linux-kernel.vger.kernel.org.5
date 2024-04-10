Return-Path: <linux-kernel+bounces-138391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822989F09F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6E4B21543
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEF15ADB3;
	Wed, 10 Apr 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bT56KSqE"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF71598F7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748311; cv=none; b=FwTxdSge3uwpYdX0B1yoHC2oql59q6IO2d/+WmUza/tFvtSIz9DZwcAoLnlDmZKzdgG8NzZ74QwOC1CJZUYAeL1ppqk9XKgqHTjlXB7gwBdKM46fvQGxEWe01NfpBmUAub/810JU5au2YMcYaCsBg5L1jiXbfan4DiGf0qg9R6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748311; c=relaxed/simple;
	bh=rML+54KQxwJwfHqQB1Xs1kpoGt4Fp0NfJJiMWEPs+08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV1ZPgwvUkW99SrqWL2aB0OoZy7SSiBorW+hMjr79LmV+kaFlGont1E21q4VlZTJJCMXdCVdSogh7bLxhKxWjqB4s0Yd5qqNEI/IswldIjh3CLwkaGK9xCrgYw6tZGBYwCveCBX6DkD3DDCbeLcKzZMaklQAJOlUiACMJrjrG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bT56KSqE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Q2XuHTnpBIWpyQZNHPcbLppoXDYJ4UpElNhcDdmY5jE=; b=bT56KS
	qE/8jdTPtzKVw2Ql1egR3fsIujU6yyooIfip4LLJuwCIwiFEVnYf4cJk3MF5AgG1
	lViwoGWmMBRNYcFlrDHP8D4F1gA7UiHBIJXqw/xL592owDRZJvvZA6mJnXea7zER
	RU4D3At3BuQwZXPGy/dEhD7KSR8RhtmzgrSEEF5VCgPT5fxIjYjCHXAab+1g71nL
	wkhCFyxZkp9dG0SQNjR5ZsyuYEKtHBZ5xzWufQAhPK7SHvc7noOMJdUrgbDH3otw
	RXKQ0TH9Uw/dKTgvDYtZUDAqliK8B2DgNx2tQq7L3KL4p8YUrgE0rcuTn0CiiyZp
	fRh8SaupDeeDUvng==
Received: (qmail 521390 invoked from network); 10 Apr 2024 13:25:00 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Apr 2024 13:25:00 +0200
X-UD-Smtp-Session: l3s3148p1@xiz9SbwVCgdtKPEL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] i2c: bcm-iproc: remove printout on handled timeouts
Date: Wed, 10 Apr 2024 13:24:16 +0200
Message-ID: <20240410112418.6400-22-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-bcm-iproc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index e905734c26a0..133d02899c6b 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -811,8 +811,6 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
-
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
-- 
2.43.0


