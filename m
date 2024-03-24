Return-Path: <linux-kernel+bounces-116303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6384889E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8261F2EB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF53CF9A2;
	Mon, 25 Mar 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiufjEYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015728FEA6;
	Sun, 24 Mar 2024 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324195; cv=none; b=VgHXr1d5piLPrzYSsnOqd+rWdyqxOlHmxAec3tdvXdoAxhShy4/cnaLAsql/zCivx9hedH9nfpPP3ok0VMH8OGDLixTcJbPNJrvmGCTrwYwg2tMSmMwCHP/oQkDIGpl7XpxOye2jy7dneelkIveOmHgXMIuC8G20lDjF9jcDfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324195; c=relaxed/simple;
	bh=D6V+Tcu42Mf+jKMEP/afsoO7kJ5dCl76rEfLjOJTwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxANOlpHupTGJT4kB+NtsfPyuyet/qN0oqYvShgAUB2Ke/61v/1PRbsjFm0uwCI6JjGfqBGaJFI7/o5EQqo9yWC3YmnLYcJ4lMEAJstDwrUwvPOzFZ72Zo57bXMIkJ1XrBJ/aPbI7zfbkB319atJpYRbNfGB0y4S13NbwebEoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiufjEYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D28C433C7;
	Sun, 24 Mar 2024 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324193;
	bh=D6V+Tcu42Mf+jKMEP/afsoO7kJ5dCl76rEfLjOJTwlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiufjEYDahfWM3nL0NGMQqp4uQZ118TizhhoXWZvKcSIkZS4NEy1KIZXd5FKDpobo
	 7UrFgwltyM4iDWgwBzXn6hGelYRKtbGq2Nr9Rhc2iZkSL5vR2bHAw26fV64OPpelF2
	 doaJrq6S1/eNmHiviTZYOh9pypQchrDSvwFCPX/26Tjkklyf+NwKHDp/0BLza9MUbZ
	 i6ARSxGobYBRBtEg05aEJ891F/rlfyBqF2qoJo0JbW4jA7CJwSpYh3mocCrZYJrs4O
	 y3YwDYUCKixiCkBCkuILfLSlRpDy5lE6JA0egrO+J2tvfj5XWToJKyTlaa/TaxxjEM
	 oP1GHNuw3rK6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 182/183] regmap: Add missing map->bus check
Date: Sun, 24 Mar 2024 19:46:35 -0400
Message-ID: <20240324234638.1355609-183-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit 5c422f0b970d287efa864b8390a02face404db5d ]

The map->bus can be NULL here, add the missing NULL pointer check.

Fixes: d77e745613680 ("regmap: Add bulk read/write callbacks into regmap_config")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20220509003035.225272-1-marex@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6f580883c1973..aa9c6e0ff878d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1648,7 +1648,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				 map->format.reg_bytes +
 				 map->format.pad_bytes +
 				 val_len);
-	else if (map->bus->gather_write)
+	else if (map->bus && map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
-- 
2.43.0


