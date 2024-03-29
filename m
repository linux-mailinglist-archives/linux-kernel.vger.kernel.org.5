Return-Path: <linux-kernel+bounces-124530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B711D89196A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E875C1C24C69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E6147C70;
	Fri, 29 Mar 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sok9Uryg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16913958D;
	Fri, 29 Mar 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715316; cv=none; b=X8V4UN1CcnNPaKg+ksF5H1X+lnJNf6kAMyIl7X7oqUyRQSkKqWs/HeEBkKLC1BfLBb+4ifZNiS6vCUznzUa5zKQ9WqjgEQkyGSg4iEMfO2XQK/hOAkiqrRseGfNkjeMh68B/tMRENIRlwPVhISzkQ5VcmK7B3ERTGdDYHGbdIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715316; c=relaxed/simple;
	bh=Q3k/OgdZo/9Bx/kytGVLXE4jqiQfl9GvTBZVOqHujz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtRvij4XSCX1BdD9heW7CshSBl/w+R7wZsOKLthmNWLYCJzH2TXzFb/hQJfnoqEXa02RDzbOYUiLQbHiEFz5tc/iHdeoRvcwlQlkLwVpNc+Ck/4jAEFcySBcPuVt78HAO3HIDkpgJmVfOgXiUQdmXmBXdgyAORoRrd+0Dlu9tCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sok9Uryg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C90CC433F1;
	Fri, 29 Mar 2024 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715316;
	bh=Q3k/OgdZo/9Bx/kytGVLXE4jqiQfl9GvTBZVOqHujz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sok9Uryg1wn8cl6gkqVwC1yiMZCXez0CRz/rnDH8A7wYwaC2O9gv7m3++9rAuNc1/
	 Wm5PCTOAqN9lekpbL7ya/7ZKp1oH/goTW850MmjsfmAWTLSxIyV7qJayC8tx6iFxyM
	 x1C7YTgErdXuxmL9plo7HQmdIE4xIPaKbofLbLYfxtfUny14FRtqcOOsIR1crh4zw7
	 wX/LsOf/jXg03UXW0Vs2dmjoaXfH9i9y408u8WC5GVHVtty5Zs9Lp2f+Uly7vugQPL
	 PeM7FyLJGM3cJxWfe3h7T4+7m5bGk9QGfiLAzPqX9D77OrfsYPOnaMaKBgDjy8nKQY
	 YdP/fP95vWhNg==
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
Subject: [PATCH AUTOSEL 6.8 49/68] net: pcs: xpcs: Return EINVAL in the internal methods
Date: Fri, 29 Mar 2024 08:25:45 -0400
Message-ID: <20240329122652.3082296-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 31f0beba638a2..03d6a6aef77cd 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -293,7 +293,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
@@ -891,7 +891,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			return ret;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	if (compat->pma_config) {
-- 
2.43.0


