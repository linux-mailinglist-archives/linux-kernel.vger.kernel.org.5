Return-Path: <linux-kernel+bounces-113948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA988878A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776301F25F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C721F0956;
	Sun, 24 Mar 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXPfU2V4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FF14B06E;
	Sun, 24 Mar 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321061; cv=none; b=MyXzWHGl/AtmmnOaCG/5eVU90PbItR5+20M2H8+sWWu46HMLXZmMq94z8LvnF3wypPItqmh0UIf6cEsJiY2WbLFeHQlKto/frS7N1ZXFL/t0QFAG0fbxHH/TsI4f+n3X9Muf+TpxEenVwHj0LXmCPyTHrl0Gfil6EWdXMLukBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321061; c=relaxed/simple;
	bh=xxDvHxkCalMd9F6E6Mmn95dhRe41RK/Aqqey8Y7vTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0Fp0h1LEHNhWR0AwZ5wo11gSwDY2gTXK6PdMh8uBbxULDEXcgYq3KPL+LXywvAkpHYeUYZt1k06cnmOxpaXzSSAMBKa5BFZ9FMKJqXeCQnAfuDrF/FbihcWg5VM0hj2GlcqK3sm7GYsVOPkCRTMEvPIw9TEfiSeICa9xAQ87mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXPfU2V4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A68C433A6;
	Sun, 24 Mar 2024 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321060;
	bh=xxDvHxkCalMd9F6E6Mmn95dhRe41RK/Aqqey8Y7vTkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXPfU2V4wf/rEVhOIHCUE2z+NwEDipG95DsxkBXZJ9TObFr0LWO6x3gGy/2m4z46V
	 cpNi14ITdnpKGBfmSU2HY9XJbweo+H+k7foMdLLIDU1fC6WdJyiJD1uV6rcsT9bWVs
	 gwnEjIdMXgHoSpMPR0tikzjD1RHuUOGuTe86LOVWqXHYKFwPNAQh4R6Gu+QrsAs8FN
	 msgKIxm/My4D4o3MKFc84j3WVu8p5iPz52Xkekaorcd47D2z5xS6jp5vprxYh8i9z8
	 2LsUjxnM5tXnZoPqTlic+dAhh4Y9S+oPjPGoByzrD/98IZGGA7HsUGwjEZC1HdfGYm
	 9BI2kgkYKSepA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 624/713] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 18:45:50 -0400
Message-ID: <20240324224720.1345309-625-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 8ede8c6f474255b2213cccd7997b993272a8e2f9 ]

Replace g with q.

Helpful when grepping thru source code or logs for
"request" keyword.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240118152213.2644269-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 07f7b48bad13d..5aff179bf2978 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1461,7 +1461,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.43.0


