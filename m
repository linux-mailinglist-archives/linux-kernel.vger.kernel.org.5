Return-Path: <linux-kernel+bounces-114666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DF888BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702DC28CE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E22B0A9C;
	Sun, 24 Mar 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiLlDelN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53614F9D1;
	Sun, 24 Mar 2024 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322309; cv=none; b=eONw5hKuENHxNcYsYG6LNKLd5w7fSO3m9+iSUc81EfG2UoFQseAmsuuRSWluPN66gj69Fy75g7HzSG92QckjmfgJs2yKaa2phyhpPDc9wQwzV7TaT5jCGiXE5Edqtr63/0stJjLX0nioL5GE7YepL3V3HOIhCGr22jXqbmv88MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322309; c=relaxed/simple;
	bh=9SWpxpzQwtIq3jgchwVVyBrm77DhjMeluer1oJWu97o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz7OnTCZ7LPwGC2IKIuzFjhAQPnZAIoLwEkDGMPzpShzkCDVXy9OhptxOZSVFn9qNPSewqp8pgh0zKUfKHtIRi0CjpMTc9GDaevrviKLZUbTqo2R8Nz0Iq5pBkescBe3e6uovrBRYMkF42kM89KsiWEhz7jwiiuRJfcYDIvJ2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiLlDelN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768BCC43394;
	Sun, 24 Mar 2024 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322308;
	bh=9SWpxpzQwtIq3jgchwVVyBrm77DhjMeluer1oJWu97o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiLlDelNi2/C5mf2sWrARnUseRKgeATWB9zhDPgN23/NtjtOG2B8FBCVvFKXfhZNM
	 qzTuaoZTckA+rK1WOGDjQHNVx/ThvFnIrWfp9hZ6sLD5sMxiVU1j0m4T8gCRTpTLi5
	 VCwtZjPBe/IP1nI9yE4FtQQVtxq281JQxf6ZwP31evuKrqwThLcVczJo2ZwSolppj8
	 eDsBcBvTRJvCJpE4zxl3RmGDfEoG+dGppeM7Tmt/0E1CAj8IID+Yvn0w7E55pWhikh
	 Jv1QasJrTAMIjfLQN97eQp3vkNB3ZDzrz/RlcKvpdFealI/GF94xjj1PevvYaDSVbh
	 bQP9aGtJB9Y5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 391/451] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 19:11:07 -0400
Message-ID: <20240324231207.1351418-392-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 163a89f84c9c2..444f89eb2d4b7 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1459,7 +1459,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.43.0


