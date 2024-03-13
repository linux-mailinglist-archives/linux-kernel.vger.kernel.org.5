Return-Path: <linux-kernel+bounces-102366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9387B138
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23992282A12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F81612F9;
	Wed, 13 Mar 2024 18:32:03 +0000 (UTC)
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3560EFE;
	Wed, 13 Mar 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354723; cv=none; b=eEVl9CMeQW+RAAsDbKAxHdKej7Cn/3z+nyyUkAf1IfiBmQ5/9GLc0qPts5gDWpE3Xemv6T6zgCSeCK/h3i9PmaUnW9y6JHYgAjJyNn8jg5baF15hB0gQyVl0NgqN2/lT/QO7lHXb+OT2IA2TMZZldgqgoOn6M0OWD52AayapyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354723; c=relaxed/simple;
	bh=Cv2GgfThJXowqzO9/Ak8WteLrkRh2x39/7qWu3AeMVQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=nvqPrlQ7rcePYgMMOL/ZXyBsxLdCTJQxm3v2VcLwSj2GxoIjtKHxGEEXbHYjNUjsQ6YeeALNQ+xyd500Hbov38940azMuNRTiw4fNzUyD28MZoW/4RWtsD6Mfw+mayOSg/7fBcvl/2hIrouufLt6LrMfG4cOh8lxQbIvbuplDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=57140 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rkT6T-0005JQ-7h;
	Wed, 13 Mar 2024 21:13:25 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1rkT6T-005Uld-10;
	Wed, 13 Mar 2024 21:13:25 +0300
Message-ID: <e2ef8067-bac7-45c1-96cf-1160625aef3d@ancud.ru>
Date: Wed, 13 Mar 2024 21:13:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] net: phy: fix phy_read_poll_timeout argument type in
 genphy_loopback
References: <>
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


read_poll_timeout inside phy_read_poll_timeout can set val negative
in some cases (for example, __mdiobus_read inside phy_read can return
-EOPNOTSUPP).

Supposedly, commit 4ec732951702 ("net: phylib: fix 
phy_read*_poll_timeout()")
should fix problems with wrong-signed vals, but I do not see how
as val is sent to phy_read as is and __val = phy_read (not val)
is checked for sign.

Change val type for signed to allow better error handling as done in other
phy_read_poll_timeout callers. This will not fix any error handling
by itself, but allows, for example, to modify cond with appropriate
sign check or check resulting val separately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed 
configuration")
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
  -- 2.34.1


