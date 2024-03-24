Return-Path: <linux-kernel+bounces-116295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BD889E11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364001F36612
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83828ECB9;
	Mon, 25 Mar 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF0xfnIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734E28ECA5;
	Sun, 24 Mar 2024 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324169; cv=none; b=sV7WbPP/vJhz7Z96waArRF9FjyOFys5tCnwbBsZ80vLBcT8CkbmT0Dz+aOo3aDufVZzQ74pDC1iZspoz+NePVHbJUrOwZE6lPQg48rYsaiHGcT4WeJDAjXJlWlwU4bxYv43O3HdBr2nWpifX74V4Ug6dooQf7RDEB6lnG1HkEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324169; c=relaxed/simple;
	bh=xjEeStySw6cG5R87KJGT5mOzpahIShC3/rZ9tuhw6uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQhjGePTFdtJiwAZp9vyTiWFi0Sq5XtF6HEeXwplgamhxxrvvhdn7uq8SzziDSrkDlKtwBib4urY/JbjMXuL8HbZMrft3Ceyl0VCJdW6MRBYMe4/8BSKsS7wJXW6j1TSVHadkC6IlKvXb/BykPVN6PkQcrZyNOxuMn2voXQC2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF0xfnIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6113C43143;
	Sun, 24 Mar 2024 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324169;
	bh=xjEeStySw6cG5R87KJGT5mOzpahIShC3/rZ9tuhw6uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QF0xfnIpqxkiSJdOtWW9EawaJqRzvnIj0sLfhZG2ffQXeiH7gsPA+pRgwB23zWiVG
	 2UO/AEkZvzrgXXq8zcBwRbJQ+JTvESRasmPWjXXtv0FzLmZh472fcaW7w7AlFaLUCm
	 Ytgv8/GTqbVUeL5hiRNwVvwL3f8ByMAz0Xsj73G4dKqreveUFCTSxtK2Vl4sbYYPWp
	 xvWIj/s0axIa00O0ZtyA2ZwFY+Bz1WCzHYYiCNWDiWdAnkDb9jp7+T9yf67h7kGsML
	 8JfjOjAkVrUI8w/1xj/W5uMH/0rt69vVYkNsid/rI+yEANGOf+eIIzvJ7MT5Av25MU
	 6cocPXYGA6AZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 162/183] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 19:46:15 -0400
Message-ID: <20240324234638.1355609-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 2f88eae8a55a1..5570fd3b84e15 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1460,7 +1460,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.43.0


