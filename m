Return-Path: <linux-kernel+bounces-28993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1781A830620
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D85C1C23669
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A01EB22;
	Wed, 17 Jan 2024 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="q4Pb8xR2"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0A1EA66
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495933; cv=none; b=J+hVzfwxbskfKK65EstkTY4YZaEpqtg+w/1i7T1lDYiMjRrsozO1NRZMF9Jgm2LCoRhikM/X2xwoS+mx1vcdRNl7096fRcLaBpr/BZmQidk4wkJ7lcd4w9SpykwtpZMDWj5hjPaArP8dD3VFSFmsneAR40kVqtec4gUaSfU3tkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495933; c=relaxed/simple;
	bh=/mrGijzcsXN5iPj8NAqokoHh+7OsAXjyewzktejtc+s=;
	h=From:DKIM-Signature:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding; b=q8wUScNUrmF1QXIs6QD1Bu4DaK33I4KEuKVfGBvG1GQRx7BXOBrhwTCUWvDJiQoZeUNsubAyJ5Q8uCgeX9kokrwuUC+9nq0YmbTEfE1pfELqH8wwb52jIXhF6KcKToqKL2w/8uQYiS+7xH3stooBLbYs3VKiQ/SJMw7KZCVoKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=q4Pb8xR2; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1705495349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pGI0D05eJ+uxsZQGv4OCXwlgzFlgbXKFeDQnZN4BBMo=;
	b=q4Pb8xR2Le7s8FICVd4sbQMgz/ILE1f1a0DMVmUVvDHP0zXmGR6NPKShbe8iKxeBTxYBnH
	m46gkMtMTvSER9wjKevQIn83VBQJxErZmdpuLOLtHyID12dGWwrig48GfnBRwMh5N8vkcg
	jM1ZYPwcuVd8wmhkS+TjDmGKgjcmKFg=
To: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org (open list),
	lvc-project@linuxtesting.org
Subject: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression overflow
Date: Wed, 17 Jan 2024 15:42:29 +0300
Message-Id: <20240117124229.37455-1-arefev@swemel.ru>
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


