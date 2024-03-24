Return-Path: <linux-kernel+bounces-115155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA888932A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7164F1F2F77B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97B182F1E;
	Mon, 25 Mar 2024 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNBwz7qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D1182772;
	Sun, 24 Mar 2024 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324178; cv=none; b=SztWidjjufsEP28zRVg+CG+Ptg2/MI87+FZj9ybeA8OIAvNqvinj7R/XzlFXla7ITGk26kaVRWWrML0WNJDMEhoYgk7yZDI5Lfm2rhCk6mxg7gxPMpLUS4McnJIaJQTMjgAhApLh91VhZwkMhqbS5OmHmtnVH/TrrkwIjuHzk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324178; c=relaxed/simple;
	bh=YFZ4xQvZwH2uwtXH7Bh/YBo8b1VqapGkrqaijssyQoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRgJaEw7NlVs+C/e1Bk6PQUAWOWDVLsKnZx9RSz1S1gVFg7zDyVBC5kjWKgohOlGihERY/r7/ZCWQBM9/HNqcht09bJMBtjOQ7reKXkoE5WfgLAuHfe34Bqyom1OP6L74WEfM7/eoqZbYgYBhCAoXpTVAhudLZjtRcC7ETPq6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNBwz7qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABCAC43394;
	Sun, 24 Mar 2024 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324177;
	bh=YFZ4xQvZwH2uwtXH7Bh/YBo8b1VqapGkrqaijssyQoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNBwz7qUgcgNRSPxZiQ4VBylL1pO5p3UPTzW+ErVf1qBVcQouCrDBv4KkjULEvUmH
	 dh7f8DVrgTxL6aPWEwuqOxxlJniYj2Afj5vrE80aHbuffT0SDBK5dSbyn9Lv46M83x
	 jzNrAzR8zMPo8kRbKmZHAFbaEFzzEMbWiHnUYu6em57M9uwXHj+NMQ6HvIO4FipP+z
	 vi4L4NjGrBjheXQh6ofjMUlpSSCy3dpic2s92h/r4kr9rzvehF4oSsiwW9WxhQyiI0
	 +COtj4cbgYcfSUwizRt1teBnY1uLRoy09nlxVoLzvb0DH2jCDFjLA72hV9MDeCLyJQ
	 h65qkRc2FKRiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 168/183] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 19:46:21 -0400
Message-ID: <20240324234638.1355609-169-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 5980540a8fff2..de7757260d6cc 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2632,7 +2632,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.43.0


