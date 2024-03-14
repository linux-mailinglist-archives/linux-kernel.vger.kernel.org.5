Return-Path: <linux-kernel+bounces-103187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3EB87BC19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8111A285602
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9F6F068;
	Thu, 14 Mar 2024 11:44:08 +0000 (UTC)
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214617588;
	Thu, 14 Mar 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416647; cv=none; b=gCk79OL53kcL+NRC1DNXwyfmFLZQh16hZNYxZaq/0fFskbwUJtq06je2eKX5ofoU2Kh5eNcaf2wYkpp9C0Y3ulJl+DQ0jJqVgKjNBIb3sXsvg6NG7XrT2uUM2rVSaP2hEB9dlR9yjuZiILXMgV3hWA/lK6B+yD6YI3wesrI9KBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416647; c=relaxed/simple;
	bh=vCqx9xc2aCUVJ6wl9bag1zhUxchc7u8nmzyYAREAqNY=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=Z3TMcqu0+Xr7KdjKF1c9oxNmCrjfZLwISIeW027Pfmf8kwDupBk6eFZ+c6FMHpw3evoI7oLR3qYRJWZWRiqNTV+D8nFLRCQdEUYVNfVeugd1gxp6T87pZuBIP6rKSBLAyWtIYtKFoeep8uw35YfMQfn9V9gZ9glwIG3jJybh+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.149] (port=30558 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rkj3j-00077G-Ba;
	Thu, 14 Mar 2024 14:15:40 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1102.mail.hosting.nic.ru (Exim 5.55)
	with id 1rkj3j-006bkS-1f;
	Thu, 14 Mar 2024 14:15:39 +0300
Message-ID: <031a0fe6-79dc-464b-b8d9-946f75971378@ancud.ru>
Date: Thu, 14 Mar 2024 14:15:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH net] net: phy: fix phy_read_poll_timeout argument type in
 genphy_loopback
References: <>
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


read_poll_timeout inside phy_read_poll_timeout can set val negative
in some cases (for example, __mdiobus_read inside phy_read can return
-EOPNOTSUPP).

Supposedly, commit 4ec732951702 ("net: phylib: fix phy_read*_poll_timeout()")
should fix problems with wrong-signed vals, but I do not see how
as val is sent to phy_read as is and __val = phy_read (not val)
is checked for sign.

Change val type for signed to allow better error handling as done in other
phy_read_poll_timeout callers. This will not fix any error handling
by itself, but allows, for example, to modify cond with appropriate
sign check or check resulting val separately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed configuration")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/net/phy/phy_device.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8297ef681bf5..6c6ec9475709 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2831,8 +2831,8 @@ EXPORT_SYMBOL(genphy_resume);
  int genphy_loopback(struct phy_device *phydev, bool enable)
  {
  	if (enable) {
-		u16 val, ctl = BMCR_LOOPBACK;
-		int ret;
+		u16 ctl = BMCR_LOOPBACK;
+		int ret, val;
  
  		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
  
-- 
2.34.1


