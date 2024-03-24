Return-Path: <linux-kernel+bounces-114414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C2888A52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D428CDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45117176A07;
	Sun, 24 Mar 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEn4jY2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D843155748;
	Sun, 24 Mar 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321833; cv=none; b=WJk9sPJIF1p7PkhwfLoz1IsuruQrcralMeIiG/vYgaMI8uodVWAERXruex2i8G1BM8aF4ddEV8hosQ1CtyvHwnec+u4u/fkRz8lwhw1wwOxkt8UH24rmDqArsV/c+nd8cQk4AOcX0OnSoEsxaZPdU0sB9Tqr/tmslDdH054wtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321833; c=relaxed/simple;
	bh=SUCF8u7CLNbfr3PePBow/YMQQJiB5Z9U+4xSRIYpYWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq1UvlS84JlEE+gjkt+8jYxuXyG4Nx79Bi85PKmNWhCM8rjzQcbhi/a8qOCdxr4yIZGMZIa4R/CDNjc/3//xi+4gs6Qe/N7fgXGMRjdSGkE6HBa+QueVgotmWDFZ4TJ5XLYA/z8PzSHq0vv+FodzSZqGV7l+5bGfS+JAof1IFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEn4jY2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3723C433C7;
	Sun, 24 Mar 2024 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321831;
	bh=SUCF8u7CLNbfr3PePBow/YMQQJiB5Z9U+4xSRIYpYWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEn4jY2JkyMkxNQ2GtRM+myiEQiC8SZRCvjzhIUKo+ZCQ4WDLIuCIyoS3LwmLvKsv
	 NVNBlVg4kJhlV0vdGpK+DHEhtm9UaLcZGc+ny6z1sFrJepW81/SyX8vuMnDM/cGDY9
	 1RC2Ju4+BGhPCdbtv5uQNU7ykaBwIXJ6zhAatGXuVhiHUb0N6ci3DrWBM90Q6+rAJ9
	 ufD/QLCXe51Drpm9T0IPVmYY9Y+W/yq5d7Prix0DTcLRPGpde83gj81f7uiOZ8dIZx
	 uQ00vMXDjTSAwRCjqitP3SQ2060FQweRz14pbsHayYRBkLvnt42jyyjs8gWvoXkTIr
	 Z/fCI5xQ9aNkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 560/638] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 18:59:57 -0400
Message-ID: <20240324230116.1348576-561-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 3865c7f6dba8a..4814aa310dcc5 100644
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


