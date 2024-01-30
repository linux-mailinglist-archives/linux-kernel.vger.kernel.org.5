Return-Path: <linux-kernel+bounces-44156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D88841E11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7241C27A56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D625916B;
	Tue, 30 Jan 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uw6yrSkU"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999DD5645C;
	Tue, 30 Jan 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604058; cv=none; b=Q0VKQqyjlJdoHwjdmkCKDVhRjFtNkTmDHUksBywFHRCYY1lspDV/EwJClZVj0wsm09jbPZAZ+oevXkRu5Az+wBXL1NL08wMACYQf64Dn9VeJIY+NmSdYsf10Ug/ZKnX3zuWUlK5DgbHlkd3SXWbmpE0sUb236qg99A0m62VvuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604058; c=relaxed/simple;
	bh=Y4mTOkugzPKhkBlTmeRYr77COSSEZXPzeIqX8b/CK74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3wQx6KkV0MaFdgmilRlnf52YQQ6rPOUNwYwbImiexJ6zxKFnA9XDptJLKRjMOYtFyLPt83S8Ptt4mFSUJZqkaW/VZHYLjmRkPMPtvIpj1wcGfT8RwFnds6zU3N9NiCHcurEud7OXJUrZt2zJudkIfK6H8aHTxgYc70r0eLHdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uw6yrSkU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D0F3760009;
	Tue, 30 Jan 2024 08:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706604048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ic1ckcjchbcoVTjdKWShBulE5zgYlgBqlicFqMJYpM=;
	b=Uw6yrSkUlrdIS5Zut2e2GX19e5AUteDIck4QirysvTiIcCrPwIu82YRu2a82qBPWCFVNhJ
	R3P3jWrakZ6fKJRC09dzFlszQMUxX4/CF4o+zR/WxVNrU569ZXqu0VJbLy6CxCNXOWh6Vq
	OS1NIhoPZWKoFCD33Dxr6YJHv6dOEjLD4i9Z0h5cAG9u/CL3y6wz5TmPCsZK6OXJ7qtBK4
	UqJCHzDvMdEhkL0UlCHUZLljlJ8xLHjkMuGAvHTwvfuoc0t9UU++d3K9Euo16lySiU1//z
	bmFwSCrIuMVt/F+9cqm5TAHUJ5J6Soeycpy7kU84DrBKS4P4hYfRWmSSpA8URg==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 3/6] bitmap: Make bitmap_onto() available to users
Date: Tue, 30 Jan 2024 09:40:18 +0100
Message-ID: <20240130084035.115086-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130084035.115086-1-herve.codina@bootlin.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
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


