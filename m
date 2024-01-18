Return-Path: <linux-kernel+bounces-30102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A083193C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F065B22B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8624B3A;
	Thu, 18 Jan 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="e+VtO6pX"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E125101;
	Thu, 18 Jan 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581471; cv=none; b=MJsKBB6zXvM1YTFhCuVijhPlwYpoKR/LQtB7UZ5jUsaMCLTkbdOOfma9wTHqALz3EhPXBjJA51pCBJjCWOjHftEIcA3dFpVu7ZDB4pkG0R7yhTAOddfPV2viNqupkYInrIRNZzGnSkcgvt5YF6J2/PAOV/zRxmH4yLcYkx+W0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581471; c=relaxed/simple;
	bh=5YFQLtGOw9hoUhhBssqvlRRHGqh1xTlEvXtlZs5UWYw=;
	h=From:DKIM-Signature:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding; b=uqzRWuxO8+OJ9tvAIWtwH25bK0n+/DjWkl+l6xR3XWFh65IK6kBIUWH/xXYh57kypV+vJuupmtZ8iJiIABBpymPp88KCoYnAZAJ47TbSVCPzvnfd12iPTzj6VHfvkA0aGn7u5r82SDY1e7dTxRggf6pc3aOpK+xSuhfDk8k4lrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=e+VtO6pX; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1705581467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kZPE9ryEyU6uy8bBTyu7cAdOqK0HdSpKBA8+uyMu3OI=;
	b=e+VtO6pX6tMF83Cj/ndwG8AVrAe8X6hPNKzES38olv4MrX2XzUJGQn2DStUV3H2r/ztxvc
	chnaAxV6jVNBbHtbYigEFM4bL8xfUERfSjCo92V6XG9nKyU6qz+2JedP80GoUJlNbs0foN
	5fwAyfRGInlDKB4yzvEu97SFhbJJ9zY=
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression overflow
Date: Thu, 18 Jan 2024 15:37:47 +0300
Message-Id: <20240118123747.45795-1-arefev@swemel.ru>
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

Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
Cc: <stable@vger.kernel.org> # v5.15+ 
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
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


