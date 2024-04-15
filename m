Return-Path: <linux-kernel+bounces-145115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90B38A4FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791351F2260B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180673502;
	Mon, 15 Apr 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltX3/tMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2581AD7;
	Mon, 15 Apr 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185379; cv=none; b=cuIUCTOh47vftoa3E9+UGAKGF/zFyPLTRCzC2B82PGO44RdPw+L/BvlXugUe02DxGuB2xbofudee6WWrdvU604d2Q4YyRWE8LFFHEuA8tkZshlsw6I/KRJ15kF3ePdX7wIA0pkbL6ELzK6srb9xBzCmgbnFjSLvW9db4nKHm/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185379; c=relaxed/simple;
	bh=Zb45CGiimLJ+iCFQbr/1dMX3rg5VTxcd5gnaZe4eH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II7/h/19nPxImflJYB7BUod80sxVsvkYNcHn8uKUnFkAd0hEao+2apeq2jj7RujM/WOl69GORw5+I9ZT6vJjLuIehIDb/qXgPKATCYi05WtcMmrQI6Umt/VXybFLk/S6ASUltXVLaqyfb41wi1J8MoSpE3WIIx8IWvUgiLuvcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltX3/tMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79794C113CC;
	Mon, 15 Apr 2024 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185379;
	bh=Zb45CGiimLJ+iCFQbr/1dMX3rg5VTxcd5gnaZe4eH/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltX3/tMNBM2SC8hqmg1rqmqw/X9SQGQtEdhTy8A5aQrl6bEzVcbLkveA3nbMvomTE
	 ubjRnTJOEY+3OLh9I/jeY6Yfdo0XoMx6NXjIryDhlYVmYWmww8Y1ItBjXZKzWKaKqf
	 FlW/gutuTsBiglHJS3AOmtGFDKhGmNZh7OiE1cbmGBLi9Pa0t2bMxVmlXW3uYyl6nO
	 Ud0XYny68C6Y1bDOTWzCFVBYVOfMGCBK8nSaeQL5/wCmxaz+lML9ERSBxzQ1KBQG0C
	 W7VRglegdY3WbAEGHOxlfdzxg6L0xldNVRUaPDP+QWqpLRkVV37Y+Y8IWQSWOw3Puv
	 LlpQUYh/9nWng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 14/15] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:02:54 -0400
Message-ID: <20240415100311.3126785-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit e85006ae7430aef780cc4f0849692e266a102ec0 ]

The call to clk_enable() in gemini_sata_start_bridge() can fail.
Add a check to detect such failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 400b22ee99c33..4c270999ba3cc 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -200,7 +200,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
 		pclk = sg->sata0_pclk;
 	else
 		pclk = sg->sata1_pclk;
-	clk_enable(pclk);
+	ret = clk_enable(pclk);
+	if (ret)
+		return ret;
+
 	msleep(10);
 
 	/* Do not keep clocking a bridge that is not online */
-- 
2.43.0


