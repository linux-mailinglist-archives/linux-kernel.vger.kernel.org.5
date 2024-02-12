Return-Path: <linux-kernel+bounces-61171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA6850E54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CE11C214DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0117C6C;
	Mon, 12 Feb 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d+EVX4fX"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8D101C1;
	Mon, 12 Feb 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724636; cv=none; b=GStMY+cLb85ywmk1Kt9RJHuYxv4rS6T2o/hYaw8IMTsdGk1v+9Y0Rn0LRtWHM0CbCcrBn8CaQ8AAyLwlH0Rt6krOfd1OzJumcgJFJ4jCV4jk6GBBBYxEqHYPm5eF7Id74WLcWUI5zWujlw88wT1RWPq+JaszAWZGmJidJiCCxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724636; c=relaxed/simple;
	bh=Y4mTOkugzPKhkBlTmeRYr77COSSEZXPzeIqX8b/CK74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZO8u7D4GFYL7aNBrxbmASSFqpVg31plaBaYWJ7XVTzeez6fiRLo+ymdP/NYha8I3TKPS3qT+/R5FPCHsOw+ZW3zxk0WCmsYV8iOLpydo52j23mKFHbbJb6Bt7+V2cmwt3NHWJknc/k95WTUPtBQgIZNKiwmzpz0nV1fcCWDrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d+EVX4fX; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 99A0040015;
	Mon, 12 Feb 2024 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707724630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ic1ckcjchbcoVTjdKWShBulE5zgYlgBqlicFqMJYpM=;
	b=d+EVX4fXrBpPi5OnvfiAxOR/AVAaZXiiWFWazenSFUiOY7aLN1+aPeicFZxLPbalVnLfqE
	+74n8hb2gXcVk9Jgzgu546dfIMUa/Ay4kFwhx9R8miohZQs5/T/PwK+fP3OlfacqP4imOV
	r6Iw+f9T6LPKWafnO+tzQ5YUbV0FoROupPZEE6ELxRsKotp3J0nf9HkoUeXTBzF4hWhKV5
	7ZlxXuaamjoKiFtV3lSvUsqI9MiTp3jpGNuEM6a3lQ8RpmVNVP+kdbj++EnIWnmPSfC/QO
	OfYf3pd+xBKrznWisCqtQ0y9Sd3pwlM4CJuvaHv0pAlrKg7QGrOYelPJka1/3Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [RESEND PATCH v3 3/6] bitmap: Make bitmap_onto() available to users
Date: Mon, 12 Feb 2024 08:56:38 +0100
Message-ID: <20240212075646.19114-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212075646.19114-1-herve.codina@bootlin.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Currently the bitmap_onto() is available only for CONFIG_NUMA=y case,
while some users may benefit out of it and being independent to NUMA
code.

Make it available to users by moving out of ifdeffery and exporting for
modules.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 lib/bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 09522af227f1..2feccb5047dc 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -547,7 +547,6 @@ int bitmap_bitremap(int oldbit, const unsigned long *old,
 }
 EXPORT_SYMBOL(bitmap_bitremap);
 
-#ifdef CONFIG_NUMA
 /**
  * bitmap_onto - translate one bitmap relative to another
  *	@dst: resulting translated bitmap
@@ -681,7 +680,9 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		m++;
 	}
 }
+EXPORT_SYMBOL(bitmap_onto);
 
+#ifdef CONFIG_NUMA
 /**
  * bitmap_fold - fold larger bitmap into smaller, modulo specified size
  *	@dst: resulting smaller bitmap
-- 
2.43.0


