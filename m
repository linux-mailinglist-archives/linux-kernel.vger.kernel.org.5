Return-Path: <linux-kernel+bounces-70043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84F859236
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345801C209B2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0947E588;
	Sat, 17 Feb 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="NBdjA8Hq"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CE1C2AD
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708199780; cv=none; b=lMFtRmIaUNt+93yPfLWvFqxl34nXbeRIptDtk/EMgk755eCWOwfdW89vtu6X5DfmBccf1XhwQQ7zz98uZSRb3JaeH/nU8VogqLQbfI7Y/sAav2LS6fhlZIsf/iafvYGYYcIS4SguwAMUIWZg/b2ENBRRwfvLbPUO7ah8dh6BYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708199780; c=relaxed/simple;
	bh=zlqXtG8c8kfCV6iFFNXHOEa/hykqAwBZgah3P9cL9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJyDcx8PGuHMgnXajGwYBX8dCdesvzci2xp/mGZ6H0sykkHilbHmcmIirWwOfM1TId76d7coHcVZ5uDRTxWYaIlCfZkDELdb2TugiCTkHfYTtQBQqruGrzxuvuKwPC4tJWYwzWE+qgYhoZeJlLLI5CmHDb/Gkj4p7NsAB3jdImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=NBdjA8Hq; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708199776; bh=zlqXtG8c8kfCV6iFFNXHOEa/hykqAwBZgah3P9cL9qs=;
	h=From:To:Cc:Subject:Date:From;
	b=NBdjA8Hq7hFOJ5lnbVc57ln97qz/IIqeRJMu60llLulfrpuRUwYzlkXoaBrw7vKP0
	 KYNCDm+d/UBGakRzpK8wp+41E2kmnBn+/eTjLt5d5+Yik8E/Ww8R7ERByO7QpyklDj
	 7wW/pkRodpUbneQGgRpAA7qYevsMi/3U7su6AJjk=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>
Subject: [RESEND PATCH] mfd: rk8xx-core: Fix interrupt processing order for power key button
Date: Sat, 17 Feb 2024 20:56:13 +0100
Message-ID: <20240217195615.1767907-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

Process rise event last, to avoid stuck keys when multiple interrupts
are coalesced. This can happen typically when resuming from suspend
via power key press and holding the power button for a bit too short,
so that RISE an FALL IRQ flags are set before any interrupt routine
has a chance to run.

Input subsystem will interpret it as holding down a power key for
a long time, which leads to unintended initiation of shutdown UI
on some OSes.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
Sorry, resent without the bogous patch series numbering.

 drivers/mfd/rk8xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index b1ffc3b9e2be..e2261b68b844 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -43,8 +43,8 @@ static struct resource rk806_pwrkey_resources[] = {
 };
 
 static const struct resource rk817_pwrkey_resources[] = {
-	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
+	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
 };
 
 static const struct resource rk817_charger_resources[] = {
-- 
2.43.0


