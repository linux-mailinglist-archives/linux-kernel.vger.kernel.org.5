Return-Path: <linux-kernel+bounces-110408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98796885ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AF5282D49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E1135A7D;
	Thu, 21 Mar 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="e/IoVVTm"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC5135A44
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039667; cv=none; b=GxQ7HBkME02e/abU3rT7oD/5LDBB3sDFydGnvFNtrhT9x8i4bgK2Epjl5zaK5enuHmX5RxqkbvNIXCr1vD52r+j8DdefZu3C4PzOPMNQ3pSOrbdbof4+ADH9Gh8EOSXIq2WBd1PvvTrbdh64Xk6cfdzB/Oydy7MXkwVS7XVfWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039667; c=relaxed/simple;
	bh=/D5CQh4Eg1MhDFUZ7iYEj/DbReP3vFnJJrBiJS67l3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk17+6X9Hq8P/kxPB2lVf7tIjKL9ObNgsnXN7vfyTQSXDEm+XWbN7YRNX5C+tFE9ZN1XIEXzjub1YFvu2F7lVon/uixrIpP8EK22BkOJibG/WbOFoMNI07IyW9APpvPs+oYgA03/N8E53H+otKVe/UO4nBAaz3rdOYGqifb8B3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=e/IoVVTm; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [83.149.199.65])
	by mail.ispras.ru (Postfix) with ESMTPSA id CB3A74076740;
	Thu, 21 Mar 2024 16:47:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CB3A74076740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711039655;
	bh=r2m1IFOo39rYh7Yqg1o38OZbzAZc486wtJtHt6GKQN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/IoVVTmJcjYmoIvO2d8hMVtfnMzisXAIkALho404ABalv/p1MYVojBoqBYofIZCU
	 6OsYZtHgKk26MxAe/VkoFI4rcAY0B0UlTSUPWs+cXZH6nAR7QgVRbtwhpxKZrB1rmh
	 IVgkNjmcazOJjWGj9olJPuX826H8+xk551pjtIgE=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 2/2] phy: marvell: a3700-comphy: Fix hardcoded array size
Date: Thu, 21 Mar 2024 19:47:31 +0300
Message-ID: <20240321164734.49273-2-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321164734.49273-1-m.kobuk@ispras.ru>
References: <20240321164734.49273-1-m.kobuk@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded 'gbe_phy_init' array size by explicit one.

Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native kernel implementation")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 41162d7228c9..15bf10710de0 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -603,7 +603,7 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 	u16 val;
 
 	fix_idx = 0;
-	for (addr = 0; addr < 512; addr++) {
+	for (addr = 0; addr < ARRAY_SIZE(gbe_phy_init); addr++) {
 		/*
 		 * All PHY register values are defined in full for 3.125Gbps
 		 * SERDES speed. The values required for 1.25 Gbps are almost
-- 
2.44.0


