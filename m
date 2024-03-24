Return-Path: <linux-kernel+bounces-115047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2548892E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F81F30493
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF092EEF95;
	Mon, 25 Mar 2024 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxh7zLqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CFF156C54;
	Sun, 24 Mar 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323833; cv=none; b=CLcfNVSOnmdyhrHXdzWw+5VPv66s5I2ec8+x/OSt5//B/daU2n5l0f3gKalc5LW0B+FGsd9Aqdl+4IuZKtJ9xqJH0DIkk5jzRevJxV6hYdYW5i7jVCU84HH76StIBYyaTkA8nk3W233ql8hSpaLSa4NXg1P85C7Kzblb3wk5c18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323833; c=relaxed/simple;
	bh=xjEeStySw6cG5R87KJGT5mOzpahIShC3/rZ9tuhw6uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvEh8G/4eMDYYIU23ZPHMHKq9sGKLoZVEUHd3OHI7s939vuFwiw4QYWKmVv+uzZ+Ccehr2AbLk5AuZdVWtgQLxziwYwpkdnjsMOGYcYLq/4ImLNDPwDTu5yKBF9F4co9ECej6c663ejAR5eGwXM+WJKQkvIQR18X/x/5xLp9+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxh7zLqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00444C43390;
	Sun, 24 Mar 2024 23:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323832;
	bh=xjEeStySw6cG5R87KJGT5mOzpahIShC3/rZ9tuhw6uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rxh7zLqdn4Rowv3TPhdxVavyF6mXPm21tik+9L75n0c0iTADyR8+UDgFi2MkkcmwY
	 DuX1+g6//tGLqm7psWiDyQXYRFLInBr8wxd6kZknrqJQZQQYWd4Y5WGZCGo5uD55bR
	 l+RsuEe5q86LTGRg8u3633TvfaMB/fW6/44BoJbvSyyrfl8+SQGFOzYLk5wlhLRen8
	 bgGh9f+DumgsK5nAVkKaOyOIQU3/sK/8EkvSkTlomamrGFU1smfX/ue10VMvCBxaoh
	 g1go99yz2z5eazFfUjBWaOIqC3CSDDzY+ZBIHAz+ulKedYwjQdfx+wSrnh1Gz53b7I
	 V6txE9LG1aZ7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 211/238] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 19:39:59 -0400
Message-ID: <20240324234027.1354210-212-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


