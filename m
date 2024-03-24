Return-Path: <linux-kernel+bounces-115987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB607889CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9502FB39ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8E238491;
	Mon, 25 Mar 2024 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GySkVJsz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F6237B7E;
	Sun, 24 Mar 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322317; cv=none; b=WceXkxcBS8QRw6WLqIslspYcgYEBLIY7qt3JwlIZKWy7gADqno+fpqM6VpGckEpabuudEvo9fRnwoAi/aGePm3l2gX0opAx3eXBjaL3pqiMi88/89/zxHVTJ5fo48auhN7R995VSp9SwVT7CDcnxchFLG4Yqt50+BpFsI6vChpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322317; c=relaxed/simple;
	bh=5ex7yP4jprfK8YUjgXF5PPPPCNtG9gQ87hwsbntwqpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdMIZXLw6qSQM9A6VcrwNFgN8Rym9uC6K2JCyJX6qe/mgXpNkl0YMCLLJh5QwupagmEJjD4YAKdnsIWGQjB1c14XUFIWHWUAHEmbyVxvHwRwWslz09J9c86RA8L8mK2iiJpXWBNNuD1LdiWlQ2SBiPtbTpJ+uvGI6vcexpT44Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GySkVJsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF02C43390;
	Sun, 24 Mar 2024 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322316;
	bh=5ex7yP4jprfK8YUjgXF5PPPPCNtG9gQ87hwsbntwqpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GySkVJsz+UKX/MnUicxAzfQvPwurgbWaYnlGkBnK+O8NHlWhjJ8TFnK+u4/9wiZGO
	 D2PI9rrcweLAZ8Sb96QNUWS4uobBKl6omg9nUP4h+JjfGVW8iI+J8TCd+9C8XwvjOn
	 IV4HPMec1tfU+Yj7hMsV8WPhwsUvJ0VS5iLHWT9KVwuEy90ZdDcBmp1NozqnVAUVfP
	 vngh0SMyMZwE7VO/CDSC6URmtE0IsoLTpq54jkoK9UXjpfmHkYZ4Qilzoolx+taZcE
	 xwchlT4hGL6g2hFc3mw5JbYgBbSvdSVux2exa+i6Qn92oIXG5J2UxTomrw/62nCgoq
	 1ygsckaOl9vNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 399/451] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 19:11:15 -0400
Message-ID: <20240324231207.1351418-400-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 600556809f04eb3bbccd05218215dcd7b285a9a9 ]

Currently the variable irqflags is being set but is not being used,
it appears it should be used in the call to net2272_probe_fin
rather than IRQF_TRIGGER_LOW being used. Kudos to Uwe Kleine-König
for suggesting the fix.

Cleans up clang scan build warning:
drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
set but not used [-Wunused-but-set-variable]

Fixes: ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20240307181734.2034407-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 538c1b9a28835..c42d5aa99e81a 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.43.0


