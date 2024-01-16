Return-Path: <linux-kernel+bounces-28028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E782F94D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2157228538A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9192D058;
	Tue, 16 Jan 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTgVyr8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A505F564;
	Tue, 16 Jan 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434938; cv=none; b=Bpwg4TySq2pZI+97nSmdKK/4hlBYZ/3M/zAwt4oq+J3S7A4JwYbjw1vnCA00BA0d4PEftGHppnYFOAn5yE71wl8CVhAro1FOT9U+fdFeUyNM5gk0lWIs3MDURi4XkXIRq96hpc3EBs4HoQRgb+orJdUsQUyAjnRMjtdI7Mpr3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434938; c=relaxed/simple;
	bh=ACQuwnrHOOPZAyDz3qTaDrzWugOxk+sx/8S41lB1OVI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=O94iolilqGQEj8yT+1diMS2NxCCYL+tTui2IdnhtvpFPRsFkllXVnRWucWYhXzVqy8v/YnKc1Oh91ia1if3RAzmWzeqrknY+rU2Azr3Dl5afEIlmKwszme8nc1zk+gxL+3pNTkJYVGIOx0KiwzjajwQcFB1smCuUsEgTxe5Y1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTgVyr8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D1EC433C7;
	Tue, 16 Jan 2024 19:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434937;
	bh=ACQuwnrHOOPZAyDz3qTaDrzWugOxk+sx/8S41lB1OVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTgVyr8fhhGlG0DE2Pw2XC6ZQg05T6BdVx8mk7MrSlOA8IOnYJ57G8jGqDS1sdnTr
	 SNTwF8iqIyejHIYsZIyKcr+acZUO0wbKawoYbN654I89rI4iD2B40UtfF9voNZskQq
	 QvZiVPv8xQxORhIEvb/JOMc/QHZM30QUYq7W0ZiIkU/zK9L3CtsVIL5rvfcZobFISa
	 aUKiAbkbvWr47cJHoRZS7Hhl58NXmRgUhNsQgEhxhRoicTqNhcLSMa9AXXDFsTrcC1
	 piopBCvbTHFoJbGQm1uknp/4V4rkFxoV0sVR380h6W9V8+ZmHiiwOJocGVuVE+1z7H
	 EwvsqhtNglVjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Herb Wei <weihao.bj@ieisystem.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/68] net: usb: ax88179_178a: avoid two consecutive device resets
Date: Tue, 16 Jan 2024 14:53:10 -0500
Message-ID: <20240116195511.255854-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit d2689b6a86b9d23574bd4b654bf770b6034e2c7e ]

The device is always reset two consecutive times (ax88179_reset is called
twice), one from usbnet_probe during the device binding and the other from
usbnet_open.

Remove the non-necessary reset during the device binding and let the reset
operation from open to keep the normal behavior (tested with generic ASIX
Electronics Corp. AX88179 Gigabit Ethernet device).

Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Link: https://lore.kernel.org/r/20231120121239.54504-1-jtornosm@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88179_178a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 5a1bf42ce156..d837c1887416 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1315,8 +1315,6 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
-	ax88179_reset(dev);
-
 	return 0;
 }
 
-- 
2.43.0


