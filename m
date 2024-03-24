Return-Path: <linux-kernel+bounces-115037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D1888CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD71F260AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5272EC898;
	Mon, 25 Mar 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CORIApFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13428455C;
	Sun, 24 Mar 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323839; cv=none; b=JOCCwHjaTHtD5pFQ4z8OmvOjLAjdfmGB2wd9fMtSKMLyPFyd/+g1MrcSa/5Ok7690ofjj16TzUQJlztXx5Kb/v1VShvbtP1TscxKEIoW32dPWm3LS+BzUAxtcgqCFq9OtUVzu9Ru12wGNSN0lfDdrWePMAt1hMi9oyHmsDAL0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323839; c=relaxed/simple;
	bh=jrQyLe8X+b3PX9XKbJ3rXz9mHx0HNEtkavhcDzAUs1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcu84twL4PSDpeI42XFwwbDwAemAcauUWIinlnPVCYvzB2hd7BD8/kMc53XrlRj91aiHftqpx9scqKhksq9cZHhTOvHSl9v4WC6lsGU/tfhPDkv3wNty1Ss2baVnhIkVQHEzMdvLNsH8jXNhSH4YB77GcFw/wAiFlr2+1FZ0Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CORIApFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7370C43390;
	Sun, 24 Mar 2024 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323839;
	bh=jrQyLe8X+b3PX9XKbJ3rXz9mHx0HNEtkavhcDzAUs1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CORIApFmzljBMCQzG5s4MNzwPtMaF64aGyEzWMO+u/qeAzjkPg33LtYY+f4SyS0rr
	 qsS44Oanj8XyJ0rD0uILtrvu0cEnw8I+7ZP9WHQZls9QZBw+g/wA823xFduX6jboAW
	 DK9fEaucrtHpBCZSfTNR4gFn1SjUEAAEcQq0g0TfbXLxhN5sP9b35MbT6KwLFukcA7
	 KoGm50DV1IsXuAZuYVWWrKGdzbIKU0nOSHhVuqITNB4lXlFpvvEqhnxHREIf2j+zRh
	 sVElA/48Y577hTlrzIthKXnV8n93hFtoZuz6gDkrW9HdRIgXUX5NuCThYckRE0RhOv
	 96P8Yf68pZxQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 217/238] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 19:40:05 -0400
Message-ID: <20240324234027.1354210-218-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 23a735641c3df..8c56efe6abc49 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2636,7 +2636,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.43.0


