Return-Path: <linux-kernel+bounces-29768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34148831329
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF38C1F2230C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F6DB670;
	Thu, 18 Jan 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="AvT6pznM"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4394B645
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563388; cv=none; b=lvwZ1jJscahz6DIS1sStBljn8ZUm+Q1aewOwIXxHA3HlKVyAiDMmKJjqPuE87O5c/vzKABnDt2bSMWBm1nysfOO3/oILCwAS3eJ3f12ukmCIArvNlec3xXicGPBCHZFNb8dKZJyjIiQ2Ns5OtrAXP8O3mXrsEimlQbYrpRVT76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563388; c=relaxed/simple;
	bh=3p0yab2HKEbLIghYqIUST037bwwznw2PGfCNieqmbb4=;
	h=From:DKIM-Signature:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding; b=KD4Agf6We1qqwKC2pdM0LnVCV43z7OHZApWWEsUubj68LkUZgFR07kh2kMYqdc8vwr5qi5Zrf3ng+2Q3BsfNnFU+XH7dVARtX2vmAR2FBxWLMGAjRxZ1EnatgzbAegTh2EkTKHk5o2x7eKNSBGanVNUqds0tI49sF6Q1KfsXCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=AvT6pznM; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1705563379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w6I24PSFroCRy+qrdhWCnhtKFkiJu5pLtQY++vEovX4=;
	b=AvT6pznMxXNFtWEwYo0uwZOGZnNfvNbKdg6RhlvjiCEOgR7fqcuJiu1L1FNt3br+ImU7rS
	G0SynVdDXXNtm6y/bvQC3uZmPiVAoPTt20IUPgAoDSCC/FpGaeGiANqcIvdPB7lpPhF4NE
	aZA42X8Lpx7D0xH0fwFNpr0GERBkckQ=
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org (open list),
	lvc-project@linuxtesting.org
Subject: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression overflow
Date: Thu, 18 Jan 2024 10:36:19 +0300
Message-Id: <20240118073619.40538-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of an arithmetic expression period_ns * 1000 is subject
to overflow due to a failure to cast operands to a larger data
type before performing arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/comedi/drivers/ni_tio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
index da6826d77e60..acc914903c70 100644
--- a/drivers/comedi/drivers/ni_tio.c
+++ b/drivers/comedi/drivers/ni_tio.c
@@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
 				GI_PRESCALE_X2(counter_dev->variant) |
 				GI_PRESCALE_X8(counter_dev->variant), bits);
 	}
-	counter->clock_period_ps = period_ns * 1000;
+	counter->clock_period_ps = period_ns * 1000UL;
 	ni_tio_set_sync_mode(counter);
 	return 0;
 }
-- 
2.25.1


