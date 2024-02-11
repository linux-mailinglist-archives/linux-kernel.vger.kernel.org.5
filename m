Return-Path: <linux-kernel+bounces-60812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C18509CE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CB61F2127D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B25B669;
	Sun, 11 Feb 2024 15:06:56 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83D5A4C2;
	Sun, 11 Feb 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664016; cv=none; b=HXrMrlAIMO3CbrgsNCgA7vb+vV1R5AE7r+TU1zLHd7/RX1X7Kr5lmgVMBS+9S7kZgVmxKoTKIvELdcLhVTD9blxJmIkUGXxO4LCYf3pqEpByq6VmsIri6RA/l61waU4OFTRnS8EiLqvJm8ymBiNsvMooOcgNjJBeUuynkXXj73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664016; c=relaxed/simple;
	bh=jfXKe5YaiBnAa8P1PhhF6TvpWZj2yZjujLHuQp30l64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tV6rKnh62YmfzMv1MkmjnCrkUSLbvxzgct4e4yUCC/qPFsY5GfdNRBpsF8g8S63t4IFCViR4g9TnWm8u3O9iapnu+YJe7qoJwuKbPkZQXXMYrzivrbzYlruv1/xv3XwSOmpko85UGtUu9hae85WQQBWwCdThGECwsj/PjoolOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Hans Verkuil <hverkuil@xs4all.nl>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] media: cx2341x: Check return value of cx2341x_api()
Date: Sun, 11 Feb 2024 07:06:44 -0800
Message-ID: <20240211150644.3642-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

cx2341x_api() may return an error, so add a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 45ad9f8b44b0 ("V4L/DVB (4202): allow selecting CX2341x port mode")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/media/common/cx2341x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/cx2341x.c b/drivers/media/common/cx2341x.c
index 1f67e021138f..fa888d7c3988 100644
--- a/drivers/media/common/cx2341x.c
+++ b/drivers/media/common/cx2341x.c
@@ -1035,7 +1035,10 @@ int cx2341x_update(void *priv, cx2341x_mbox_func func,
 	};
 	int err;
 
-	cx2341x_api(priv, func, CX2341X_ENC_SET_OUTPUT_PORT, 2, new->port, 0);
+	err = cx2341x_api(priv, func, CX2341X_ENC_SET_OUTPUT_PORT, 2, new->port, 0);
+
+    if (err)
+	    return err;
 
 	if (!old ||
 	    CMP_FIELD(old, new, is_50hz)) {
-- 
2.25.1


