Return-Path: <linux-kernel+bounces-60810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677B8509CB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076671F21DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EE5B668;
	Sun, 11 Feb 2024 15:05:59 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D75BAFE;
	Sun, 11 Feb 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663958; cv=none; b=pcNGWLbo/l5qCn18GlqA3zFBp6xODZKYgErfuG4sopZZ/mzrIkeCxt/4MEL0a8ASgRIIy8vykHNgHbwV7R14j9UhkQhj7dwizb0UG6U4FksfeNFb3x+DRHvsXhgyZ8wsYXp0QeHWfDh0RoQQUR4RloUUxLt1UZjkVJU3whuO5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663958; c=relaxed/simple;
	bh=L2erQr5VOzvtZwSGbBtPRPaYAXK9HLpbI4kvy9KiY1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoprA593RD82lJjfCjkuRn3eEoc2pWbInxT5eA7iHfxolgO/ich9SxPoix9je2v25A0h1uFeFelBVXNDWkxZjv35ICYLt5CPr9mEsEy4s/vlw+WD9Ql1ul/YjyfaGrXdS9pjlKIYMQMdPYB5QNb1RdzAZasrT5JcbbCv5EGzQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Wolfgang Grandegger <wg@grandegger.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
	<linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] can: softing: remove redundant NULL check
Date: Sun, 11 Feb 2024 07:05:35 -0800
Message-ID: <20240211150535.3529-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

In this case dev cannot be NULL, so remove redundant check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/can/softing/softing_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
index bad69a4abec1..5a3f9e4b0b62 100644
--- a/drivers/net/can/softing/softing_fw.c
+++ b/drivers/net/can/softing/softing_fw.c
@@ -436,7 +436,7 @@ int softing_startstop(struct net_device *dev, int up)
 		return ret;
 
 	bus_bitmask_start = 0;
-	if (dev && up)
+	if (up)
 		/* prepare to start this bus as well */
 		bus_bitmask_start |= (1 << priv->index);
 	/* bring netdevs down */
-- 
2.25.1


