Return-Path: <linux-kernel+bounces-124646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A75891AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D332884C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06516193E;
	Fri, 29 Mar 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcy7+9Gl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E51411E7;
	Fri, 29 Mar 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715621; cv=none; b=ZMQ5gnv7FuC3tkCOXidjT6vkxQRrbPfeHf0hDOXoUuLI3rWDiD2LI0R1ce8gmWvL8dsOgieMXysryzeEF/4RRGztAjR/q/g3hw4X42LDaRqxNJsmw6Ep8WZRjC7/34UINSsMJjViw5CJOUS26nm1LuSP8ijoxtsM5m/tLkzfwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715621; c=relaxed/simple;
	bh=MCkMVDf5Ip4inIH4vZxBsnZ8Qqj5ZERiqhWz/wnMpDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzTSQaeeWze/XmtGS2QGckwUGgA+kK8A0hFy3W+NG0bPSO8x5UULXK4Pj6ZPWOg37C4Yr3NJ7Y1iwt+h2yb+yDqI0RWfiZf6gcwqjuopdHBfCYgKhZwzhz8rsgEx38kMF9Zphi6UOvNaAb+shIGg83zzotPirZb8DTHECMLCkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcy7+9Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A695C433F1;
	Fri, 29 Mar 2024 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715620;
	bh=MCkMVDf5Ip4inIH4vZxBsnZ8Qqj5ZERiqhWz/wnMpDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcy7+9GlVQOaHJNr9aS6qrZLAPbBAKb/aNYg0aaKLSNFy+e6RohPO6Sc2NgpWTida
	 yiVjWzaP3ibqsocxC3u5k4V+adMvEkMxY9kNPipYjWMYAr39qoHmiipQMVuS3Y3WfR
	 CJRYMn5o9UXnGPUaAIdSZI0As/eYRAAT80m4FlG3Ad6/rv5qxn9qtql56Xca3azoPY
	 J+jcWfCoP3KyRCiGD9gz5VaWFrOIXV6uHyFmxXpFETk1ezgpSRSF3Qx/U3k28qDEqD
	 J5Hguh3WQmrG84Q5f54ygRqOzAJB1DeXmul+VZmy0J6B8tUYSxZCC9Vbg1NtY0hOYH
	 7aZaHdg720XBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	Jose.Abreu@synopsys.com,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/20] net: pcs: xpcs: Return EINVAL in the internal methods
Date: Fri, 29 Mar 2024 08:33:00 -0400
Message-ID: <20240329123316.3085691-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit f5151005d379d9ce42e327fd3b2d2aaef61cda81 ]

In particular the xpcs_soft_reset() and xpcs_do_config() functions
currently return -1 if invalid auto-negotiation mode is specified. That
value might be then passed to the generic kernel subsystems which require
a standard kernel errno value. Even though the erroneous conditions are
very specific (memory corruption or buggy driver implementation) using a
hard-coded -1 literal doesn't seem correct anyway especially when it comes
to passing it higher to the network subsystem or printing to the system
log.  Convert the hard-coded error values to -EINVAL then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/pcs/pcs-xpcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 556ca98843565..ab382496c3a83 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -242,7 +242,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
@@ -808,7 +808,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			return ret;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	if (compat->pma_config) {
-- 
2.43.0


