Return-Path: <linux-kernel+bounces-27931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B882F7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4A4B2341B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81E12B26A;
	Tue, 16 Jan 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTlDOg2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A61DA49;
	Tue, 16 Jan 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434607; cv=none; b=L3t0exmxXgNwhKFQIfT9Ptq0D4QR/BwT5+BuQiQ6DjNa3l8e5xXDf3NCss8qXPssyoedRZhOsNT18eZzbuZR4u53drYCl3tX93hxd84LOqTfrdiJvGAq2HUVpv56FhDFCxio0zyjw6AZd8Mzl8UKVY3I1yPBzTf+h7A71zb5B9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434607; c=relaxed/simple;
	bh=ACQuwnrHOOPZAyDz3qTaDrzWugOxk+sx/8S41lB1OVI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=l6Yqx9foty1Zs+yJWPsTbQBS1S8U5WXcjaPtbpJRY4FLXFZEMtKnVlG6Jcy9Sg9uwXUrSqYN8XNurAe/zLLRllu3bfv+5HInp3km1pPOVFkpOywePzg9s4LkPvULAhWNklfPJyEFt8D48xk32+dwUBgJ+gOhLtzFUmwKYNAeiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTlDOg2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693BBC433A6;
	Tue, 16 Jan 2024 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434606;
	bh=ACQuwnrHOOPZAyDz3qTaDrzWugOxk+sx/8S41lB1OVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTlDOg2l+gpOTvoPYH98fgUGpnL9zW0znDZlKGLkNq7AaEpYjdzOHRwQv7qMUjQPG
	 kvuvlsQWgsEMRWPrtZrPhYYw4bZ/DSVxb9HaH3IfU0hMj+28asLPPNzaGVg/xP2Y1H
	 S6Y40HNsEPr4XvsaOf9SWFbgae4T96f9bckGLpOzYgTtdD4s26Sd92ocpaCExO2Aom
	 nOkUIJGCgrnSroxM9MpjnFXauDCK0qb9febUfRad/rbpfOf5UmNQFCdZKtf/s3smEs
	 Q2fMkEnytNCTDY3spl5Fll0XC0vXH5JdJUMiJrD2Fadf1HZwxXxpEUNWLs4nG2aWgZ
	 2Bfhp5NdSGRxg==
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
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 023/104] net: usb: ax88179_178a: avoid two consecutive device resets
Date: Tue, 16 Jan 2024 14:45:49 -0500
Message-ID: <20240116194908.253437-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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


