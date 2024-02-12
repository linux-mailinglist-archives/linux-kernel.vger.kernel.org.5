Return-Path: <linux-kernel+bounces-61168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D771C850E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320B6280D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF717996;
	Mon, 12 Feb 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ReLx3Y7H"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFD8BFE;
	Mon, 12 Feb 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724635; cv=none; b=UZ0n6a9Qwt4Ct3G323hEtSZbv2Fy/R61HUYm2iHwaGAPAX1REC8scZd/mCsGMMMebHOi/eVGJWJVrDc5qg5ChhEvMOm7Nl6bg9gmxdU5M9f8/9KAwSZcaq9sEl8Qb9F/R7f4xjEtqeBSuQPJnzywJwITH5ocnSOAKmhcYlCK9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724635; c=relaxed/simple;
	bh=Y4mTOkugzPKhkBlTmeRYr77COSSEZXPzeIqX8b/CK74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtQRm26pTP7z088paoUSaK3HWPctDhDCAo14jXxUaNeAbJGRKd2i46NCMtue2ElB3GeXyl/qr0GFhak77N/5rhoCjoAGVy3FPWDjeHjDJOesAqfFYVQCSCJX5ePnCgWTHAbmiGAu4S2pvVmoJ6X+b3zVhwm9yCgmLNwEKvNkraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ReLx3Y7H; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E37B940002;
	Mon, 12 Feb 2024 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707724624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ic1ckcjchbcoVTjdKWShBulE5zgYlgBqlicFqMJYpM=;
	b=ReLx3Y7H2Z8kXqTURnVOLFHzNHB1i04hX3X050KGh7A+qeS5NOW9IYAQ1yf28bdEnrRcD/
	qusAHp5xbftd5wslkTA9JjgbIluCxh/kgU+AsqDNGTJxhz0rNFXtrnEL8IRstR0JCd8PTj
	5+0Cm5kSw2U4twA4RX3DSJLhcpZhZRwve4BF8OcrVAAxINednQFmM4jiw+Vw+qF2hh44cx
	Re+zYfP6LJzt5mIJCds1eSrI3qgN/tcoXtNpVSRbkKTwq9I3E11Rmz/9PtXlwLEO/nQe69
	ip3Yl2ggq0QVneSuiqSHFRk3Ctoy64CISO8zY1iaipxbsLgoHteNBPMgi8sewQ==
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
Subject: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to users
Date: Mon, 12 Feb 2024 08:56:31 +0100
Message-ID: <20240212075646.19114-4-herve.codina@bootlin.com>
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


