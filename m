Return-Path: <linux-kernel+bounces-84747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC486AB00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC9B24096
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC42E832;
	Wed, 28 Feb 2024 09:13:21 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31D2DF87;
	Wed, 28 Feb 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111601; cv=none; b=SxFbnJgIx8zTgvRVRqsxIpr+fhRUlA4IzsFtr/Rl9tkb9Fmj2XmsphbumBf6vU8fG1lcy5WC8kswoastcUmyIoNEW7uNwCZmggJPjhdIyE1BNNV2dqd2Ufzdv48Q2J7x9SVQVJcGEci/Vj7US/U3YOejD1nwU1dFoC6A79u654M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111601; c=relaxed/simple;
	bh=gaACaJ7SEGbNoAdS1kKtOIYeRQlHqJEzNTRFXxGtqWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDwQKiB4ACZIK7i3bVSsqNDPmRvo2ziqCEeY/d/1o1zsePPEjKSlecycRlIyjJOM86dNlVHQRRZ0n8kAZGrdmeoBigwOSHIn+8vXfESBMurt7s1q3BXuH3LMY2zVqErre+kFpwzqW5zNWHZ8ODPSMJFZmvhgCo2FeElBDJkoHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfFzo-001CIB-TT; Wed, 28 Feb 2024 17:13:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Feb 2024 17:13:16 +0800
Date: Wed, 28 Feb 2024 17:13:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH] crypto: rk3288 - Fix use after free in unprepare
Message-ID: <Zd75LLhzlJx4nJiP@gondor.apana.org.au>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226215358.555234-1-andrej.skvortzov@gmail.com>

The unprepare call must be carried out before the finalize call
as the latter can free the request.

Fixes: c66c17a0f69b ("crypto: rk3288 - Remove prepare/unprepare request")
Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 1b13b4aa16ec..a235e6c300f1 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -332,12 +332,12 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 theend:
 	pm_runtime_put_autosuspend(rkc->dev);
 
+	rk_hash_unprepare(engine, breq);
+
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
 
-	rk_hash_unprepare(engine, breq);
-
 	return 0;
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

