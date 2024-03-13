Return-Path: <linux-kernel+bounces-101943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB3987ACEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1EC1F2748E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEF62801;
	Wed, 13 Mar 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdVz807g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72737627E8;
	Wed, 13 Mar 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348150; cv=none; b=FrkATvDBd3Ppxg5ZJXcbBK+04O1MCXIF2RJOl+YEDCoKybAnUPCpPcmGUfpy0aJz/c9sXEh+Tbl7NVrTI2HWdn+3FgfrL1zvBG1R28t7WbzB5q7pi2L8EsqZBIYMe1WEcdXV/JWs/45UH+jFk+dhZAPgxeRx9C69Ze5zkNX+qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348150; c=relaxed/simple;
	bh=ZnVYI0EVRMPAR8YuEzTHJ8BKEfsGMglMjd5MZe0BcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKlfmIqyZBzvPp/tLoh0OX85Jg9F67GTRWUlZZJgv5v7z4o05cfb7GKl/vDoK+ksWrVbbqWOW1Kfu4jsefQOcq3Mjq3LlnNnNDlelIiiA9uqVYsfFN2gdF+vxuVfASuhAVprUmB52a+9xvuVGD9HfrnR4xiVki4f8mF/gj42n44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdVz807g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D227C433B1;
	Wed, 13 Mar 2024 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348150;
	bh=ZnVYI0EVRMPAR8YuEzTHJ8BKEfsGMglMjd5MZe0BcTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdVz807gDjqumUkrg7+XL1zFfu2v43PCeqQlpbXVHDB/tTzHmGVVqckBY8keOhV0E
	 Jlq7DM/aFgGwnWx0mlDRzHrkBSqbctC2qEL6OXKnaDd59HiH9MBMOSaCS1tFYZofjH
	 22hcdLvbOM6l33Dld5UJg3o5i1vwop7sKTiv0TBwXPqj1aikFueR+d9j52PGMdmn1S
	 1Jkh5B3UbfF2BTzNM0fAPpeUK6uqnzvKQGoGuvMEh7ZzUF8k1EyfBkerPEufy3qMjp
	 ZonZnLHDrTw1e5yXbA7rF/v3OnF6eBOCc9erJKmkzW97erEyj6CDbA1RWBEdEUiqZM
	 RWf/cZa4vcFsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 03/76] net: lan78xx: fix runtime PM count underflow on link stop
Date: Wed, 13 Mar 2024 12:41:10 -0400
Message-ID: <20240313164223.615640-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 1eecc7ab82c42133b748e1895275942a054a7f67 ]

Current driver has some asymmetry in the runtime PM calls. On lan78xx_open()
it will call usb_autopm_get() and unconditionally usb_autopm_put(). And
on lan78xx_stop() it will call only usb_autopm_put(). So far, it was
working only because this driver do not activate autosuspend by default,
so it was visible only by warning "Runtime PM usage count underflow!".

Since, with current driver, we can't use runtime PM with active link,
execute lan78xx_open()->usb_autopm_put() only in error case. Otherwise,
keep ref counting high as long as interface is open.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c8b42892655a1..77cb30259dca7 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2960,7 +2960,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.43.0


