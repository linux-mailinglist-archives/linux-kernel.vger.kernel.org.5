Return-Path: <linux-kernel+bounces-116100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F9889947
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2651C2FD80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527EB28D9B7;
	Mon, 25 Mar 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHE4AfPk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882D178CD2;
	Sun, 24 Mar 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323580; cv=none; b=roxVfdWgetL2kE1ZvymC96wbJOQwV3XEnUwVdZ6O3Tstv/rIHyUrpFE6vTg1GfEVPBs8GALqBb9ahvi7r2Jq1OprrmrCg63cuwPb1FriR/Vtjger/TYFvYIqwSpqtyLCHk8YYOfKWjSKMc8g7Qcs0feynUHWyGrqWoOM7tuHSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323580; c=relaxed/simple;
	bh=vc/T6hVYtGIVMsW+oB8SV7sRd7M5NJFHgkE11Tm4XSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8h87YGkG23QX1FK9ptesnlsjSzRciqOTHeqFwoTscw00wGWaKn2EzLEOxHAafGRTwyisBarB6fqOstVaSMEoB5YNLlQefaUAyjtJoR2Al/1DSrGNj0ZH1/hPxcZEXdJ6su8mK4yN5/yFdxWbtkV9Sji048iSYE1lBdDD3xc68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHE4AfPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBCFC43394;
	Sun, 24 Mar 2024 23:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323580;
	bh=vc/T6hVYtGIVMsW+oB8SV7sRd7M5NJFHgkE11Tm4XSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHE4AfPke2tkA1itZZZh6YfIiXzMQSSvI+PkD0Wa9yo2sfmpHonh1xtRtGfmqmhjn
	 tbwPZq2H3YxJ3O2o9koZII5couLCQELygFnYhiyoNhAKxw51Px9B6vjJP8XcU1PJMk
	 eU3lSiAPj79dvqXRg3A1jMnrxZIoQXQvIVc2EoE0/hYeFrQwbnM7FVjowhg0o0ru+v
	 OQ3JNTwI9oKVSDZn3A1LASDiL0Ct5a+VY8agfg3p6UIhW2Md8B3liGEbhAa8+5IJhr
	 Buu1PuLWpzK9txeNbC/yYbyTJz9eUfSfm3KZ8gpH5foFW3dCczWv7P7drjCfaGA5w1
	 H2dnfoXDGDXug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 286/317] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Sun, 24 Mar 2024 19:34:26 -0400
Message-ID: <20240324233458.1352854-287-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 7c38057dcb4ab..e5402e05e7393 100644
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


