Return-Path: <linux-kernel+bounces-149114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB18A8BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783DB286E07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33D250EC;
	Wed, 17 Apr 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jiz9GMMY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B764182AF;
	Wed, 17 Apr 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381593; cv=none; b=Hgm0C2B/sQfybCVyYzCkuc63xPiiGAAun3KaWanBC0RhBFDI+g1GGEOaBguQ601sFuUCpLPJl53urpdKPOODm/QJ0uAkvvEbksxvx22tuq1gQ6jvj0LNIE22rg5kKzIL8Pp6tUuQDIgsdCh71RVmLf4kNpItiDHVo1Ed804sVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381593; c=relaxed/simple;
	bh=AeUpsW2kfdTLP8cytZxJnozfmR5aDxkpG7wLSKBxCCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auHbSDcWdToOInAa/O2kGE0zEet7dyzU4g242xe/HehWzPVJA79NzX3/P6Zsf6zTqKoW1p450i1iJApJhxzyaJnk7IeezHSxfJTXBaI8EnN/Be15DpkYbs2VHklPJ8TZUIoqqMT2Ynd7Uk3RYJ7bgWC66Gbl3DnYlp4Au2+CAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jiz9GMMY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 090FA240006;
	Wed, 17 Apr 2024 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713381588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qnegySRP2t/rhTa6N++GcpoVh6UOOmzaniiw8ruo3KU=;
	b=jiz9GMMYydwERXWFLzxGKwFo1BrJj+wOXaf5lzHHANvPOPALLlLe5cDtPEfAoiioIsJR9Q
	bjVdwExgBRaCHztfdrra3HSHixE4BG5bEJxjf15yar53iiLOPiODV3eQYaad09rt8bKcki
	QvvSmHJrKj0TbGR2eYXtmPlHrrgJVs10ufXVJfFnHDXYs+biSLWBJxesJuoVHHPnMOXZFQ
	AeNagQGR4sHwjyNnE47+P9X0t8C62uqO5OvPMETHB/JnAI9MOTkfIo3t39hUxDbKWlxb6I
	uMrgtlAr7umZ0W4DM01wj2x2JiyxOsmyEkELQVXY7MD42UeJqXr6GDgfW5xlJg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: rx8111: demote warnings to debug level
Date: Wed, 17 Apr 2024 21:19:35 +0200
Message-ID: <20240417191937.33790-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The proper way for userspace to react on a read time error is to have a
look at the voltage low information. There is no point in cluttering dmesg
as it is often not even visible to the end user.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8111.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rx8111.c b/drivers/rtc/rtc-rx8111.c
index 62d2352de102..4a35bd921b33 100644
--- a/drivers/rtc/rtc-rx8111.c
+++ b/drivers/rtc/rtc-rx8111.c
@@ -170,14 +170,14 @@ static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	if (FIELD_GET(RX8111_FLAG_XST_BIT, regval)) {
-		dev_warn(data->dev,
-			 "Crystal oscillation stopped, time is not reliable\n");
+		dev_dbg(data->dev,
+			"Crystal oscillation stopped, time is not reliable\n");
 		return -EINVAL;
 	}
 
 	if (FIELD_GET(RX8111_FLAG_VLF_BIT, regval)) {
-		dev_warn(data->dev,
-			 "Low voltage detected, time is not reliable\n");
+		dev_dbg(data->dev,
+			"Low voltage detected, time is not reliable\n");
 		return -EINVAL;
 	}
 
@@ -188,7 +188,7 @@ static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	if (regval) {
-		dev_warn(data->dev, "Clock stopped, time is not reliable\n");
+		dev_dbg(data->dev, "Clock stopped, time is not reliable\n");
 		return -EINVAL;
 	}
 
-- 
2.44.0


