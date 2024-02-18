Return-Path: <linux-kernel+bounces-70604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999678599BF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33C31C20CAA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B92745D4;
	Sun, 18 Feb 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="b0Oz+t44"
Received: from shout02.mail.de (shout02.mail.de [62.201.172.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E66F07C;
	Sun, 18 Feb 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294662; cv=none; b=b4M9nXMYSfpFcuXFoLQg5WQSDakEKSCwsXkYMwTXqqA6mmcG425iND8K4yxiX6cozseo+LXt9gpRQlbkSOazjbCBFntyFpgLnkI8NKYXYYROY0HgSElb6KAxyOlKECjqaawhYnpteuJFV4aXoaAX7QM2bWmvALrQg/nQb78NhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294662; c=relaxed/simple;
	bh=N3H39/B4i2sFZWcEBwc/gNTosE/eDkGZGZvxmMONy6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WWHXINPzmG+rBkK8Z1k62nharQZ5rOPR+pge6oHN/ORflkmjt+oyceX4g19bfm/PkcQLs/YKtTkCDd8LLuwruaSpuUfpJ+R38zHaFJ3LPG8niHYgTAj26jWXKrLu8XpIJfXE96UkWoqXqpnCBD1bwUojRo3TJNcTCiIbJjh6GvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=b0Oz+t44; arc=none smtp.client-ip=62.201.172.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id CA911240D76;
	Sun, 18 Feb 2024 23:17:22 +0100 (CET)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix01.mail.de (Postfix) with ESMTP id ABD9480145;
	Sun, 18 Feb 2024 23:17:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1708294642;
	bh=N3H39/B4i2sFZWcEBwc/gNTosE/eDkGZGZvxmMONy6s=;
	h=From:To:Cc:Subject:Date:Message-Id:From:To:CC:Subject:Reply-To;
	b=b0Oz+t444Iy/mMVCQexZJsa1Ia2Us0mQOjygXNPbAUtL0T1Vnku6T40CJffkGJaGz
	 6OgqXvUed2qmuU38ESaV/Eu8UQcWJQzWpZl2f5b2Y2vQERbpDRyH6NRCYu9BJRaldy
	 l+4T4zSOoujJARpo1FOeXKakoqmTGPOP2W4Kc7qAAVvaLjK/RuET9y6Dos2bd/vMth
	 tnXH3FBckSIBKs3ayyn8TyJKdzeMtLFW0L1OdtbRgpTxeme1sfQ9H8hAp3mDZj3geU
	 kctTBYYaFUE6h1C2oz2mOKssrpPbNDkJix5hylwE8LGHKxIN6oZPm0ETupwO2ZdlHT
	 xO9NEBDI2i3iw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 23479240550;
	Sun, 18 Feb 2024 23:17:04 +0100 (CET)
From: Kilian Zinnecker <kilian.zinnecker@mail.de>
To: Corentin Labbe <clabbe@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kilian Zinnecker <kilian.zinnecker@mail.de>
Subject: [PATCH] crypto: rockchip - fix to check return value
Date: Sun, 18 Feb 2024 23:16:58 +0100
Message-Id: <20240218221658.131043-1-kilian.zinnecker@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1095
X-purgate-ID: 154282::1708294642-065BF670-B0B11907/0/0

crypto_engine_alloc_init may fail, e.g., as result of a fail of
devm_kzalloc or kthread_create_worker. Other drivers (e.g.,
amlogic-gxl-core.c, aspeed-acry.c, aspeed-hace.c, jr.c, etc.) check
crypto_engine_alloc_init's return value and return -ENOMEM in case
a NULL pointer is returned. This patch inserts a corresponding
return value check to rk3288_crypto.c.

Signed-off-by: Kilian Zinnecker <kilian.zinnecker@mail.de>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 70edf40bc523..f74b3c81ba6d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -371,6 +371,11 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	}
 
 	crypto_info->engine = crypto_engine_alloc_init(&pdev->dev, true);
+	if (!crypto_info->engine) {
+		err = -ENOMEM;
+		goto err_crypto;
+	}
+
 	crypto_engine_start(crypto_info->engine);
 	init_completion(&crypto_info->complete);
 
-- 
2.34.1


